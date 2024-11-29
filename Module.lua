-- // Module Manager
local Module = {}
Module.cache = {}
Module.__index = Module

-- // Load a module with caching
function Module.Load(Path)
    -- // Check if the module is already cached
    if Module.cache[Path] then
        return Module.cache[Path]
    end
    local module

    -- // Require the module if not cached
    local success, err = pcall(function()
        module = require(Path)
    end)

    -- // Check if the module fails to load
    if not success then
        warn(("Failed to load module at path: %s. Error: %s"):format(Path, err))
        return nil
    end

    -- // Cache the module
    Module.cache[Path] = module

    return module
end

-- // Return module
return Module
