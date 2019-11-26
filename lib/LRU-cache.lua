
local _dir = (...):match("(.-)[^%.]+$")
local deepcopy = require(_dir .. "deepcopy")
local ser = require(_dir .. "serialization")

local cache = { -- ~in seconds, floating point number
  cache = {},
  keys = {},
  size = 0
}
-- If time is -1, then just count

local mt = {} -- Metatable

function cache.new (size)
  if size == nil then return nil end
  local obj = deepcopy(cache)
  obj.size = size
  return obj
end

function cache:clone ()
  return (deepcopy(self) or nil)
end

function cache:set (key, value)
  if key == nil then return false, "Error: Invalid key" end
  if value == nil then return false, "Error: Invalid value" end
  local exists = false
  for i,v in ipairs(self.keys) do
    if key == v then
      exists = true
      self.cache[key] = value
    end
  end
  if not exists then
    if #self.keys >= self.size then
      self.cache[self.keys[self.size]] = nil
      self.keys[self.size] = nil
    end
    table.insert(self.keys, 1, key)
    self.cache[key] = value
  end
  return true
end

function cache:get (key)
  if key == nil then return false, "Error: Invalid key" end
  local exists = false
  local value = ""
  for i,v in ipairs(self.keys) do
    if key == v then
      exists = true
      value = self.cache[key]
      table.remove(self.keys, i)
      table.insert(self.keys, 1, key)
    end
  end
  if not exists then
    return nil, "Error: Invalid key"
  end
  return value
end

function cache:remove (key)
  if key == nil then return false, "Error: Invalid key" end
  local exists = false
  for i,v in ipairs(self.keys) do
    if key == v then
      exists = true
      table.remove(self.keys, i) -- Moves everything else
      self.cache[key] = nil
    end
  end
  if not exists then
    return false
  end
  return true
end


mt.__tostring = function (this)
  local s = ""
  for i,v in ipairs(this.keys) do
    s = s.."["..ser.pack(v).."] "..ser.pack(this.cache[v]).."\n"
  end
  return s:sub(1, -2)
end

mt.__len = function (this)
  return #this.keys
end

-- mt.__call = function (this)
--   return this.cache
-- end



cache = setmetatable(cache, mt)

return cache
