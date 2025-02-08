local Test = {}

Test.tests = {}

-- ANSI escape codes for colors
local GREEN = "\27[32m"
local RED = "\27[31m"
local RESET = "\27[0m"

function Test.assertEquals(actual, expected, message)
    if actual ~= expected then
        error(message or ("Expected: " .. tostring(expected) .. ", but got: " .. tostring(actual)), 2)
    end
end

function Test.assertTrue(value, message)
    if not value then
        error(message or "Expected true but got false", 2)
    end
end

function Test.assertFalse(value, message)
    if value then
        error(message or "Expected false but got true", 2)
    end
end

function Test.add(name, func)
    table.insert(Test.tests, { name = name, func = func })
end

function Test.run()
    local passed, failed = 0, 0
    for _, test in ipairs(Test.tests) do
        io.write("Running: " .. test.name .. " ... ")
        local success, err = pcall(test.func)
        if success then
            passed = passed + 1
            print(GREEN .. "✔ Passed" .. RESET)
        else
            failed = failed + 1
            print(RED .. "✘ Failed" .. RESET .. "\n   " .. err)
        end
    end
    print("\nTests run: " .. (passed + failed))
    print(GREEN .. "Passed: " .. passed .. RESET)
    print(RED .. "Failed: " .. failed .. RESET)
end

return Test
