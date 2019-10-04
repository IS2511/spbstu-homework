
-- Repeat after me: Lisp is not popular.

local ser = require "lib.serialization"

local arg_check = true
local string = arg[1]
local balance = {
  ["("] = 0,
  [")"] = 0,
  ["{"] = 0,
  ["}"] = 0,
  ["["] = 0,
  ["]"] = 0
}
local balanced = true

if not (type(arg[1]) == "string") then arg_check = false end

if not arg_check then
  print("Checking for mismatching brackets/parenthesis")
  print("Usage: "..arg[0].." <string>")
  os.exit()
end


function inverse (char)
  if char == ")" then
    return "("
  elseif char == "}" then
    return "{"
  elseif char == "]" then
    return "["
  elseif char == "(" then
    return ")"
  elseif char == "{" then
    return "}"
  elseif char == "[" then
    return "]"
  else
    return error("No")
  end
end

for i=1,#string do
  local char = string:sub(i, i)
  if (char == "(") or (char == ")") or (char == "{") or (char == "}") or (char == "[") or (char == "]") then
    balance[char] = balance[char] + 1
    if (char == ")") or (char == "}") or (char == "]") then
      if balance[char] > balance[inverse(char)] then
        balanced = false
      end
    end
  end
end

if balanced and (balance["("] == balance[")"]) and (balance["{"] == balance["}"]) and (balance["["] == balance["]"]) then
  print("Perfectly balanced, as all things should be.")
else
  print("This ain't working, sorry")
end
