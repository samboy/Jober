-- This library generates a blank X*Y square grid map for JoberGen
-- Each node only has adjacent nodes listed

function createGridMap(sizeX, sizeY, wrap)
  -- Given an X, Y coordinate, return the name we assign this map point
  function nodeName(X, Y)
    return "x" .. tonumber(X) .. "y" .. tonumber(Y)
  end

  -- A semisphere is a special form which is topologically equivalent to
  -- a sphere.  Wraps on the X axis go from far left to far right, and from
  -- far right to far left.  Wraps on the Y axis go from the top square on 
  -- the Y axis to the top square halfway over; ditto with the bottom square
  -- This allows a reasonable simulation of a sphere on a square grid
  -- without making the poles impassible
  -- Note: If this were played in a game, the world would become a vertically
  -- flipped mirror image after going below the south pole or above the 
  -- north pole.
  function handleSemisphere(X, Y, sizeX, sizeY)
    if Y < 0 then 
      Y = 0
      X = X + math.floor(sizeX / 2)
    end
    if Y >= sizeY then
      Y = sizeY
      X = X + math.floor(sizeX / 2)
    end
    if X < 0 then X = X + sizeX end
    if X >= sizeX then X = X - sizeX end
    return X, Y
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
     wrap ~= "WRAPY" and
     wrap ~= "SEMISPHERE" then
    return {ERROR = "Invalid wrap value"}
  end
  sizeX = math.floor(tonumber(sizeX))
  sizeY = math.floor(tonumber(sizeY))
  if wrap == "SEMISPHERE" and sizeX % 2 ~= 0 then
    return {ERROR = "Semisphere maps must have an even X size"}
  end
  if sizeX < 8 then sizeX = 8 end
  if sizeY < 8 then sizeY = 8 end

  -- As a convention, lower case/numeric is node name, UPPER CASE is meta
  -- information about the map
  local newMap = {ROOT = "x0y0", WRAP = wrap}

  for X = 0, (sizeX - 1) do
    for Y = 0, (sizeY - 1) do
      local node = {name = nodeName(X,Y), X = X, Y = Y}
      node.adjacent = {}
      for dirX = -1, 1 do
        for dirY = -1, 1 do
	  if wrap ~= "SEMISPHERE" then
	    placeX = handleWrap(X + dirX, sizeX, "WRAPX", wrap)
	    placeY = handleWrap(Y + dirY, sizeY, "WRAPY", wrap)
	  else
	    placeX, placeY = handleSemisphere(X+dirX, Y+dirY, sizeX, sizeY)
	  end
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
