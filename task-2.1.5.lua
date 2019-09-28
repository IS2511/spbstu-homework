
if (type(tonumber(arg[1])) ~= "number" or type(tonumber(arg[2])) ~= "number") then
  print("Usage: "..arg[0].." <number> <accuracy>")
  os.exit()
end
if tonumber(arg[1]) <= 0 then
  print("Error: "..arg[1].." is not positive or zero")
  os.exit()
end

local num = tonumber(arg[1])
local accuracy = tonumber(arg[2])

local sqrt = num
local up, down = num, 0
if num > 4 then
  up, down = num/2, 1
else
  up, down = 2, 0
end

local precise, rounds = false, accuracy
local timer1 = os.clock()
for i=1,accuracy do
  local mid = (up+down)/2
  if (mid*mid) < num then
    down = mid
  else
    up = mid
  end
  sqrt = mid
  if (sqrt*sqrt) == num then
    precise = true
    rounds = i
    break
  end
end
timer1 = os.clock() - timer1

if precise then
  print("Square root of "..num.." is precisely "..sqrt.." ("..rounds.." rounds)")
else
  print("Square root of "..num.." is approximately "..sqrt.." ("..accuracy.." rounds)")
end
print("Took "..timer1.." seconds")
