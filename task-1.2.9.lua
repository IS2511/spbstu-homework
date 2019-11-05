
local bit = require "bit" -- LuaJIT bit operations library

local arg_check = true
local num1, num2 = 0, 0

if arg[1] == nil or arg[2] == nil then
  arg_check = false
else
  num1 = tonumber(arg[1])
  num2 = tonumber(arg[2])
  if num1 < 0 or num2 < 0 then arg_check = false end
  if num1%1 ~= 0 or num2%1 ~= 0 then arg_check = false end
end

if not arg_check then
  print("Comparing 2 positive integer numbers without the compare operator.")
  print("Usage: "..arg[0].." <player-ATK> <enemy-ATK>")
  os.exit()
end

local enemy_attack = bit.rshift((num1 - num2), 31)
local player_attack = bit.rshift((num2 - num1), 31)

local atk1, atk2 = 0, 0
for i=0,31 do
  atk1 = atk1 + bit.band(num1, bit.lshift(player_attack, i))
  atk2 = atk2 + bit.band(num2, bit.lshift(enemy_attack, i))
end

local result = atk1 + atk2

print(result)
