
-- xxx: Today I will generate random numbers
-- yyy: But LCG is pseudo-random
-- zzz: It is?!
-- zzz: I'm re-generating all my SSH keys

if (type(tonumber(arg[1])) ~= "number") or (type(tonumber(arg[2])) ~= "number") then
  print("Usage: "..arg[0].." <seed> <count>")
  os.exit()
end

-- C++11 constants are used for reference
local lcg_config = {a = 48271, c = 0, m = math.pow(2, 31)-1}

local seed = tonumber(arg[1]) -- Used as a starting point for LCG
local length = tonumber(arg[2]) -- How many to generate
print("Generating "..length.." numbers using seed "..seed.."...")

function lcg(x)
  return ( lcg_config.a*x + lcg_config.c ) % lcg_config.m
end

local x = seed

for i=1,length do
  x = lcg(x)
  print(x)
end
