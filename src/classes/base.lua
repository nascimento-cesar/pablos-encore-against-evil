Base = {}

function Base:new()
  local obj = {}
  setmetatable(obj, self)
  self.__index = self

  return obj
end