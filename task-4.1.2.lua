
-- *router noises* (c) year 2000

require "lib.string-index"

local arg_check = true
local string = arg[1]

if type(arg[1]) ~= "string" then arg_check = false end
if arg[1] == "" then arg_check = false end

if not arg_check then
  print("Finding longest substring in linear time.")
  print("Usage: "..arg[0].." <string>")
  os.exit()
end

function find (str)
  local sub, biggest = "", ""
  for i=1,#str-1 do
    if str[i] == str[i+1] then
      -- End the substring
      if #sub > #biggest then
        biggest = sub
      end
      sub = ""
    else
      -- Continue the substring
      sub = sub..str[i]
    end
  end
  if #sub > #biggest then
    return sub
  end
  return biggest
end

local timer = os.clock()
local result = find(string)
timer = os.clock() - timer
print("Biggest substring: "..result)
print("Substring length: "..#result)
print("Time taken: "..timer.." seconds")
