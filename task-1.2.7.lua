
-- 1Xbet! Ставки на спорт! (c) Реклама

local ser = require "lib.serialization"
local deepcopy = require "lib.deepcopy"

if (type(tonumber(arg[1])) ~= "number") then
  print("Calculating factorial of a number FAST (using factorization).")
  print("Usage: "..arg[0].." <number>")
  os.exit()
end

local num = math.floor(tonumber(arg[1]))

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
print("Result: "..result1)


local result2 = 1
local timer4 = os.clock()
for i=2,num do
  result2 = result2 * i
end
timer4 = os.clock() - timer4

print("\nCalculated factorial (the dumb way) of "..num.." in "..timer4.." seconds")
print("Result: "..result2)
