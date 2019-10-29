
local bit = require "bit"

local arg_check = true
local num1, num2 = 0, 0

if type(tonumber(arg[1])) ~= "number" or type(tonumber(arg[2])) ~= "number" then
  arg_check = false
end

num1 = tonumber(arg[1])
num2 = tonumber(arg[2])

if num1%1 ~= 0 or num2%1 ~= 0 then arg_check = false end

if not arg_check then
  print("Comparing 2 integer numbers without the compare operator.")
  print("Usage: "..arg[0].." <player-ATK> <enemy-ATK>")
  os.exit()
end

local enemy_bit = bit.rshift((num1 - num2), 31) == 1
local player_bit = bit.rshift((num2 - num1), 31) == 1
if (not enemy_bit) and (not player_bit) then
  print("It's a draw")
elseif enemy_bit then
  print("Enemy deals damage to the player")
elseif player_bit then
  print("Player deals damage to the enemy")
end
