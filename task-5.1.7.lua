
-- 1Xbet! Ставки на спорт! (c) Реклама

local ser = require "lib.serialization"
local lru = require "lib.LRU-cache"

local arg_check = true
local cache_size = 0
local use_big = false
local print_result = false

if arg[1] == nil then arg_check = false end
if arg_check then
  cache_size = math.floor(tonumber(arg[1]))
  if cache_size < 1 then arg_check = false end
end

if not arg_check then
  print("LRU cache on hash table. [Interactive]")
  print("Usage: "..arg[0].." <size>")
  os.exit()
end


local cache = lru.new(cache_size)

local exit = false
while not exit do -- Interactive!
  local command = io.read()
  if string.find(command, "print") == 1 then
    print(cache)
  elseif string.find(command, "add ") == 1 then
    local key, value = command:sub(5):gmatch("(%S+)%s(%S+)")()
    -- print("Debug: "..ser.pack({key, value}, true))
    if key ~= nil and value ~= nil then
      local ok, err = cache:set(key, value)
      if not ok then print(err) end
    end
  elseif string.find(command, "rm ") == 1 then
    local key = command:sub(4)
    local ok, err = cache:remove(key)
    if not ok then print(err) end
  elseif string.find(command, "get ") == 1 then
    local key = command:sub(5)
    local ok, err = cache:get(key)
    if not ok then print(err) else print(ok) end
  elseif string.find(command, "help") == 1 then
    print([[
  add <key> <data>    Add something to cache
  rm <key>            Remove from cache
  get <key>           Access something in cache (+bump)
  print               Print cache contents
  help                This
  exit                Exit (deleting cache)    ]])
  elseif string.find(command, "exit") == 1 then
    exit = true
  end
end

print("Bye!")
