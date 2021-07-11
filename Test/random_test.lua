#!/usr/bin/env lunacy
-- This script sees if we are using the lunacy random number generator

math.randomseed(1234)
-- Endian swapped version of the low 16 bits of each 32-bit RadioGatun[32]
-- generated number
good = {"4fd2", "7993", "6aac", "2635"}
print("Test: Using RadioGatun[32] random numbers")
for b = 1,4 do
   test = string.format("%04x",math.random(0,32767))
   if good[b] ~= test then
     print("Test #" .. tostring(b) .. " failure.  Should be "
           .. good[b] .. " but is " .. test)
     os.exit(1)
   end
end

print("All math.random() tests pass")
os.exit(0)
