
-- local export = {}

local smt = getmetatable("")
smt.__index = function (this, index)
  return string.sub(this, index, index)
end
