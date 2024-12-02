-- // Creator Class
local Creator = {}
Creator.__index = Creator
do
    -- // Constructor
    function Creator.new()
        local self = setmetatable({}, Creator)
        return self
    end

    -- // Create a ROBLOX instance
    function Creator.CreateInstance(ClassName, Props)
        local Instance = Instance.new(ClassName)

        if not Instance.Children then
            Instance.Children = {}
        end

        for Property, Value in pairs(Props) do
            if Property ~= 'Parent' and Property ~= 'Children' then
                Instance[Property] = Value
            end
        end

        if Props.Children then
            for _, ChildData in pairs(Props.Children) do
                local ChildClassName = ChildData[1]
                local ChildProps = ChildData[2]

                local ChildInstance = Creator.CreateInstance(ChildClassName, ChildProps)
                ChildInstance.Parent = Instance

                local ChildName = ChildProps.Name or ChildClassName
                Instance.Children[ChildName] = ChildInstance
            end
        end

        if Props.Parent then
            Instance.Parent = Props.Parent
        end

        return Instance
    end
end

-- // Return
return Creator
