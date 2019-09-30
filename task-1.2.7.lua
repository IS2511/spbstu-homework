
-- 1Xbet! Ставки на спорт! (c) Реклама

local ser = require "lib.serialization"
local deepcopy = require "lib.deepcopy"
require "lib.BigRat"

if not ( (type(tonumber(arg[1])) == "number") or (type(tonumber(arg[2])) == "number") ) then
  print("Calculating factorial of a number FAST (using factorization).")
  print("Usage: "..arg[0].." [--big] <number>")
  os.exit()
end

local num = 0
local use_big = false

if (type(tonumber(arg[1])) == "number") then
  num = math.floor(tonumber(arg[1]))
else
  num = math.floor(tonumber(arg[2]))
end

if #arg > 1 then
  use_big = ( (arg[1] == "--big") or (arg[2] == "--big") )
end

-- if use_big then
--   num = BigRat.new(num)
-- end

function gen_primes(up)
  local _primes = {}
  for i=2,up do
    _primes[i] = true
  end
  for i=2,up do
    if _primes[i] then
      for j=i+1,up do
        _primes[j] = (j%i ~= 0) and _primes[j] -- Faster. Because GC?
        -- _primes[j] = ((j%i ~= 0) and _primes[j]) or nil
      end
    end
  end
  return _primes
end

function factorize (x, prime)
  local _factors = {}
  for i=2,num do
    if prime[i] then
      _factors[i] = 0
      while (x%i == 0) do
        x = x/i
        _factors[i] = _factors[i] + 1
      end
      if _factors[i] == 0 then
        _factors[i] = nil -- Faster. Why though? Less memory?
      end
    end
  end
  return _factors
end

function factorial (x, factor, prime)
  local f = 1
  if use_big then
    f = BigRat.new(1)
  end
  for i=2,num do
    if prime[i] then
      f = f * math.pow(i, factor[i])
      -- print("["..i.."] "..factor[i].." | "..f)
    end
  end
  return f
end

local timer1 = os.clock()
local primes = gen_primes(num)
timer1 = os.clock() - timer1

print("Generated prime list to "..(num).." in "..timer1.." seconds")
-- print(ser.pack(primes, num)

local timer2 = os.clock()
local factors = {}
for i=2,num do
  if (not primes[i]) then
    local f = factorize(i, primes)
    -- print("["..i.."] "..ser.pack(f))
    for j=2,i do
      if f[j] then
        factors[j] = factors[j] + f[j]
      end
    end
  else
    factors[i] = 1
  end
  -- factors[num] = 1
end
-- local factors = factorize(num, primes)
timer2 = os.clock() - timer2

print("Factorized from 2 to "..num.." in "..timer2.." seconds")
-- print(ser.pack(factors, num))

local timer3 = os.clock()
local result1 = factorial(num, factors, primes)
timer3 = os.clock() - timer3

print("Calculated factorial of "..num.." in "..timer3.." seconds")
print("Total time taken (not including prime generation): "..(timer2+timer3).." seconds")
print("Result: "..tostring(result1))


local result2 = 1
if use_big then
  result2 = BigRat.new(1)
end
local timer4 = os.clock()
for i=2,num do
  result2 = result2 * i
end
timer4 = os.clock() - timer4

print("\nCalculated factorial (the dumb way) of "..num.." in "..timer4.." seconds")
print("Result: "..tostring(result2))

local diff = (result1 == result2)
print("\nAre results equal? `"..ser.pack(diff).."`")
if not diff then
  local diff_str = ">"
  if (result1 < result2) then
    diff_str = "<"
  end
  print("result1 "..diff_str.." result2")
  -- local diff_num = result1 - result2
  -- local zero = 0
  -- if use_big then
  --   zero = BigRat.new(0)
  -- end
  -- if diff_num < zero then
  --   diff_num = diff_num * (-1)
  -- end
  -- diff_num = ( diff_num / (result1 + result2) )
  -- BigRat.simplify(diff_num)
  -- diff_num = diff_num * 100
  -- print("Difference: "..tostring(diff_num).." %")
end
