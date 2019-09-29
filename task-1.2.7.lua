
-- 1Xbet! Ставки на спорт! (c) Реклама

local ser = require "lib.serialization"

if (type(tonumber(arg[1])) ~= "number") then
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

  return _factors
end

function factorial (x, factor)
  local f = 0

  return f
end

local timer1 = os.clock()
local primes = gen_primes(math.floor(num/2)+2)
timer1 = os.clock() - timer1

print("Generated prime list to "..(math.floor(num/2)+2).." in "..timer1.." seconds")
-- print(ser.pack(primes, math.floor(num/2)+2))

local timer2 = os.clock()
local factors = factorize(num, primes)
timer2 = os.clock() - timer2

print("Factorized "..num.." in "..timer2.." seconds")

local timer3 = os.clock()
local result = factorial(num, factors)
timer3 = os.clock() - timer3

print("Calculated factorial of "..num.." in "..timer3.." seconds")

print("Result: "..result)
