
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
  local _primes = {2}
  for i=3,up do
    local prime = true
    for j,v in ipairs(_primes) do
      if i%v == 0 then
        prime = false
      end
    end
    if prime then
      table.insert(_primes, i)
    end
  end
  return _primes
end

-- function sieve_Sundaram(up) -- Slower
--   local _up = math.ceil((up - 2)/2)
--   local _primes = {2}
--   local pre_primes = {}
--   for i=1,_up do
--     pre_primes[i] = true
--   end
--   for i=1,_up do
--     for j=1,i do
-- 			if (i + j + 2*i*j <= up) then
--         pre_primes[ i + j + 2*i*j ] = false
--         -- print("["..(i + j + 2*i*j).."] "..((i+j+2*i*j)*2+1))
--         -- table.insert(_primes, (i+j+2*i*j)*2+1)
--       end
--     end
--   end
--   for k,v in pairs(pre_primes) do
--     if v then
--       table.insert(_primes, k*2+1)
--     end
--   end
--   return _primes
-- end

function factorize (x, prime)
  local _factors = {}
  local i = 1
  while x ~= 1 do
    _factors[prime[i]] = 0
    while (x%prime[i] == 0) do
      x = x/prime[i]
      _factors[prime[i]] = _factors[prime[i]] + 1
    end
    if _factors[prime[i]] == 0 then
      _factors[prime[i]] = nil -- Faster. Why though? Less memory?
    end
    i = i + 1
  end
  return _factors
end

function factorial (x, factor)
  local f = 1
  if use_big then
    f = BigRat.new(1)
  end
  for k,v in pairs(factor) do
    if use_big then
      f = f * (BigRat.new(k)^BigRat.new(v))
    else
      f = f * math.pow(k, v)
    end
    -- print("["..i.."] "..factor[i].." | "..f)
  end
  return f
end

local timer1 = os.clock()
-- We can save some time on prime generation with some clever math
-- We only need to check up to sqrt(num) (if we don't need factors)
-- local primes = gen_primes(math.ceil(math.sqrt(num)))
local primes = sieve_Eratosthenes(num)
-- local primes = sieve_Sundaram(num) -- Slower, ~O(n^2)?
timer1 = os.clock() - timer1

print("Generated prime list to "..num.." in "..timer1.." seconds")
-- print(ser.pack(primes, num))

local timer2 = os.clock()
local factors = {}
table.insert(primes, num+1) -- Quick workaround, works well, not planning fixinig
for i=2,#primes do
  factors[primes[i-1]] = 1
  for j=(primes[i-1]+1),(primes[i]-1) do
    local f = factorize(j, primes)
    -- print("["..j.."] "..ser.pack(f))
    for k,v in pairs(f) do
      factors[k] = factors[k] + v
    end
  end
end
table.remove(primes, #primes) -- Cleaning workaround, just in case

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
