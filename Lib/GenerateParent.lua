-- This is an abstract class for generating maps

MapMeta = {}
MapMeta.__index = GridMeta

function MapMeta:new()
  return setmetatable({DistanceMap = false, ROOT = false, NODES = false}, 
                      self)
end

function MapMeta:distance()
  -- CODE HERE: Default high memory usage "brute force" distance calculator

  -- This function only fills in the distances one away, but it returns
  -- a list of nodes to fill out next
  -- Note: This alters the list of adjacent nodes by sorting them by
  -- the distance they have from a neighbor.
  -- Namespace: MapMeta:distance()
  function distanceMapOneAway(node, view, distance, firstNeighbor) 
    local out = {}
    local dmap = {}
    if not self[view] then return false end
    if not self[view]["adjacent"] then return false end    

    -- Make sure we add closer neighbors before adding further neighbors
    table.sort(self[view]["adjacent"], function(y,z) return y[2] < z[2] end)

    for a = 1,#self[view]["adjacent"] do
      local neighbor = self[view]["adjacent"][a][1]
      local first = firstNeighbor
      if not first then first = neighbor end

      -- Note the distance from one node to another
      dmap[neighbor] = self[view]["adjacent"][a][2]

      if not self.DistanceMap[node][neighbor] then
        self.DistanceMap[node][neighbor] = {}
	-- Element 1: Distance
        self.DistanceMap[node][neighbor][1] = distance + 
	    self.DistanceMap[node][neighbor]
	-- Element 2: First step on path to destination node
        self.DistanceMap[node][neighbor][2] = first
	out[#out + 1] = neighbor
      end
    end

    -- To avoid longer "zig zag" paths, we want to have the shortest paths
    -- first in the output table
    table.sort(out, function(y,z) return dmap[y] < dmap[z] end)

    return out
  end -- distanceMapOneAway()

end
