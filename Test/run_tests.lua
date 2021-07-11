#!/usr/bin/env lunacy
-- Wrapper to run the various tests for Jober

-- Soft warnings; if these do not pass, we can still run the generator, but
-- it will be unsupported.

-- Libs
require("random_test")

-- Scaffolding
function softWarning(test,name)
  local result = test()
  if result then
    print(name .. " WARNING: " .. result)
  else
    print("testRandom() PASS")
  end
  return false
end

-- non-fatal tests
softWarning(testRandom,"testRandom()")

