-- This is an abstract class for generating maps

MapMeta = {}
MapMeta.__index = GridMeta

function MapMeta:new()
  return setmetatable({distanceMap = nil, ROOT = nil}, self)
end

function MapMeta:distance()
  -- CODE HERE: Default high memory usage "brute force" distance calculator

end
