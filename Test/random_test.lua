#!/usr/bin/env lunacy
-- This script sees if we are using the lunacy random number generator
-- The reason why we have this test is because, before Lua 5.4, Lua's
-- math.random() function would use an OS-dependent function which
-- frequently generated low-quality random numbers.  While Lua 5.4 has
-- high quality random numbers, Lua 5.1 is still widely used (e.g LuaJIT
-- is still at Lua 5.1), and we need to test to make sure we're using the
-- right random numbers

function testRandom() 
  math.randomseed(1234)
  -- Endian swapped version of the low 16 bits of each 32-bit RadioGatun[32]
  -- generated number
  local good = {"4fd2", "7993", "6aac", "2635"}
  -- Lua 5.4 finally implemented a decent built-in PRNG
  local lua54 = {"5b42", "3e26", "73cd", "45d0"}
  local is54 = false
  for b = 1,4 do
    test = string.format("%04x",math.random(0,32767))
    if lua54[b] == test then
      is54 = "Looks like we are using Lua 5.4 random numbers"
    elseif good[b] ~= test then
      return "Test #" .. tostring(b) .. " failure.  Should be "
             .. good[b] .. " but is " .. test
    end
  end
  if is54 then
    return is54
  end
  return false
end

result = testRandom()
if result then
  print("testRandom() FAIL: ",result)
else
  print("testRandom() PASS")
end

