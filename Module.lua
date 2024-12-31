-- // Module Manager
local Module = {}
Module.Modules = {}
Module.__index = Module
do
    -- // Create a new module
    function Module.Create(Name, Load)
        if Module.Modules[Name] then
            return
        end
        Load(Module)

        Module.Modules[Name] = Module
    end

    -- // Get an existing module
    function Module.Get(Name)
        return Module.Modules[Name] or nil
    end
end

-- // Return
return Module
