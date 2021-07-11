#!/usr/bin/env lunacy
-- Wrapper to run the various tests for Jober

-- Soft warnings; if these do not pass, we can still run the generator, but
-- it will be unsupported.

-- Libs
require("random_test")

-- Scaffolding
function softWarning(test,name)
  local result = test()
  local out = ""
  local isWarning = false
  if result then
    out = name .. " WARNING: " .. result
    isError = true
  else
    out = "testRandom() PASS"
  end
  return {out, isWarning}
end

-- non-fatal tests
print(softWarning(testRandom,"testRandom()")[1])

