-- This is an abstract class for generating maps

MapMeta = {}
MapMeta.__index = GridMeta

function MapMeta:new()
  return setmetatable({DistanceMap = nil, ROOT = nil}, self)
end

function MapMeta:distance()
  -- CODE HERE: Default high memory usage "brute force" distance calculator

  -- This function only fills in the distances one away, but it returns
  -- a list of nodes to fill out next
  function distanceMapOneAway(node, view, distance) 
    local out = {}
    if not self[view] then return false end
    if not self[view]["adjacent"] then return false end    
    for a = 1,#self[view]["adjacent"] do
      local neighbor = self[view]["adjacent"][a][1]
      if not self.DistanceMap[node][neighbor] then
        self.DistanceMap[node][neighbor] = 
            distance + self.DistanceMap[node][self[view]["adjacent"][a][2]]
	out[#out + 1] = neighbor
      end
    end
    return out
  end -- distanceMapOneNode()

end
