
# xxx: Today I will generate random numbers
# yyy: But LCG is pseudo-random
# zzz: It is?!
# zzz: I'm re-generating all my SSH keys

# if (type(tonumber(arg[1])) ~= "number") or (type(tonumber(arg[2])) ~= "number") then
#   print("Usage: "..arg[0].." <seed> <count>")
#   os.exit()
# end

# C++11 constants are used for reference
lcg_config = {"a":48271, "c":0, "m":((2**31)-1)}

seed = 123 # Used as a starting point for LCG
length = 10 # How many to generate
print("Generating "+str(length)+" numbers using seed "+str(seed)+"...")

def lcg(x):
  return ( lcg_config["a"]*x + lcg_config["c"] ) % lcg_config["m"]

x = seed

for i in range(length):
  x = lcg(x)
  print(x)
