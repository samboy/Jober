-- This is an abstract class for generating maps

MapMeta = {}
MapMeta.__index = GridMeta

function MapMeta:new()
  return setmetatable({DistanceMap = nil, ROOT = nil}, self)
end

function MapMeta:distance()
  -- CODE HERE: Default high memory usage "brute force" distance calculator

  -- This function only fills in the distances one away
  function distanceMapOneNode(node, view, distance) 
    if not self[view] then return false end
    if not self[view]["adjacent"] then return false end    
    for a = 1,#self[view]["adjacent"] do
      if not self.DistanceMap[node][#self[view]["adjacent"][1]] then
        self.DistanceMap[node][#self[view]["adjacent"][1]] = 
            distance + self.DistanceMap[node][#self[view]["adjacent"][2]]
      end
    end
  end -- distanceMapOneNode()

end
