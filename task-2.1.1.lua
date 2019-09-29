
if (type(tonumber(arg[1])) ~= "number") then
  print("Deduping a random generated table of numbers.")
  print("Usage: "..arg[0].." <count>")
  os.exit()
end

local list_size = tonumber(arg[1])
local list = {}

local timer1 = os.clock()
for i=1,list_size do
  table.insert(list, math.floor(math.random(1000)))
end
timer1 = os.clock() - timer1

print("Generated table of size "..list_size.." in "..timer1.." seconds")

-- Assuming sorted from beginning?

local timer2 = os.clock()
table.sort(list)
timer2 = os.clock() - timer2

print("Sorted table of size "..list_size.." in "..timer2.." seconds")

-- Assuming optimal memory usage needed

local removed = list_size
local timer3 = os.clock()
for i=2,list_size do
  if list[i] == list[i-1] then
    -- print("["..i.."] = "..table.remove(list, i)) -- DEBUG
    table.remove(list, i)
    i = i - 1
  end
  if list[i] == nil then
    break
  end
end
timer3 = os.clock() - timer3
removed = removed - #list

print("Deduped table of size "..list_size.." (removed "..removed..") in "..timer3.." seconds")
