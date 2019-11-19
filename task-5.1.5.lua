
local ser = require "lib.serialization"
require "lib.string-index"

local arg_check = true
local filenameIn, filenameOut = "", "output.lua"
local modeDecompress = false

if #arg > 0 then
  for i,v in ipairs(arg) do
    if v == "-d" then
      modeDecompress = true
    else
      arg_check = false
    end
  end
end

if not arg_check then
  print("LRE 'file' [de]compression.")
  print("Usage: "..arg[0].." [-d]")
  print("  Uses stdin and stdout, -d for decompression")
  os.exit()
end

local data = io.read("*all")
local result = ""

if modeDecompress then

  for count, char in string.gmatch(data, "(%d+)(.)") do
    for i=1,tonumber(count),1 do
      result = result..char
    end
  end

else

  local counter = 1
  local char = data[1]
  for i=2, #data do

    if char == data[i] then
      counter = counter + 1
    else
      result = result..tostring(counter)..char
      if data[i+1] ~= nil then
        char = data[i+1]
        counter = 1
      end
    end

  end -- for

end -- if

io.write(result)
