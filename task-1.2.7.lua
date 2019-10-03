
-- 1Xbet! Ставки на спорт! (c) Реклама

local ser = require "lib.serialization"
local deepcopy = require "lib.deepcopy"
require "lib.BigRat"

local arg_check = true
local num = 0
local use_big = false
local print_result = false

for i,v in ipairs(arg) do
  if type(tonumber(v)) == "number" then
    if num ~= 0 then arg_check = false end
    num = math.floor(tonumber(v))
  elseif v == "--big" then
    use_big = true
  elseif v == "--result" then
    print_result = true
  else
    arg_check = false
  end
end

if num == 0 then arg_check = false end

if not arg_check then
  print("Calculating factorial of a number FAST (using factorization).")
  print("Usage: "..arg[0].." [--result] [--big] <number>")
  os.exit()
end


function sieve_Eratosthenes(up)
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
  local i = 2
  while x ~= 1 do
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
    i = i + 1
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
      if use_big then
        f = f * (BigRat.new(i)^BigRat.new(factor[i]))
      else
        f = f * math.pow(i, factor[i])
      end
      -- print("["..i.."] "..factor[i].." | "..f)
    end
  end
  return f
end

local timer1 = os.clock()
-- We can save some time on prime generation with some clever math
-- We only need to check up to sqrt(num) (if we don't need factors)
-- local primes = gen_primes(math.ceil(math.sqrt(num)))
local primes = gen_primes(num)
timer1 = os.clock() - timer1

print("Generated prime list to "..num.." in "..timer1.." seconds")
-- print(ser.pack(primes, num))

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
if print_result then
  print("Result: "..tostring(result1))
end


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
if print_result then
  print("Result: "..tostring(result2))
end

local diff = (result1 == result2)
print("\nAre results equal? `"..ser.pack(diff).."`")
if not diff then
  local diff_str = ">"
  if (result1 < result2) then
    diff_str = "<"
  end
  print("result1 "..diff_str.." result2")
end

if print_result then
  print("\n\nTime results again:\n")
  print("Generated prime list to "..num.." in "..timer1.." seconds")
  print("Factorized from 2 to "..num.." in "..timer2.." seconds")
  print("Calculated factorial of "..num.." in "..timer3.." seconds")
  print("Total time taken (not including prime generation): "..(timer2+timer3).." seconds")
  print("\nCalculated factorial (the dumb way) of "..num.." in "..timer4.." seconds")
end
