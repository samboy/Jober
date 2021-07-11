-- This library generates a blank X*Y square grid map for JoberGen
-- Each node only has adjacent nodes listed

function createGridMap(sizeX, sizeY, wrap)
  -- Given an X, Y coordinate, return the name we assign this map point
  function nodeName(X, Y)
    return "x" .. tonumber(X) .. "y" .. tonumber(Y)
  end

  -- When deciding an adjacent square, handle underflow and overflow
  function handleWrap(V, sizeV, goodWrap, wrap)
    if V < 0 then
      if wrap == "TORIC" or wrap == goodWrap then
        return V + sizeV
      else
        return nil
      end
    elseif V >= sizeV then
      if wrap == "TORIC" or wrap == goodWrap then
        return V - sizeV
      else
	return nil
      end
    end
    return V
  end

  -- Parse args: Default values
  if sizeX == nil then sizeX = 144 end
  if sizeY == nil then sizeY = 96 end
  if wrap == nil then wrap = "NONE" end

  if wrap ~= "NONE" and 
     wrap ~= "TORIC" and 
     wrap ~= "WRAPX" and 
     wrap ~= "WRAPY" then
    return {ERROR = "Invalid wrap value"}
  end
  sizeX = math.floor(tonumber(sizeX))
  sizeY = math.floor(tonumber(sizeY))
  if sizeX < 8 then sizeX = 8 end
  if sizeY < 8 then sizeY = 8 end

  local newMap = {ROOT = "x0y0"}

  for X = 0, (sizeX - 1) do
    for Y = 0, (sizeY - 1) do
      local node = {name = nodeName(X,Y)}
      node.adjacent = {}
      for dirX = -1, 1 do
        for dirY = -1, 1 do
	  placeX = handleWrap(X + dirX, sizeX, "WRAPX", wrap)
	  placeY = handleWrap(Y + dirY, sizeY, "WRAPY", wrap)
	  if placeX and placeY and (dirX ~= 0 or dirY ~= 0) then
	    node.adjacent[#node.adjacent + 1] = nodeName(placeX,placeY)
	  end
	end
      end
      newMap[nodeName(X,Y)] = node
    end
  end
  return newMap
end
