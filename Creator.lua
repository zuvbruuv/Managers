-- // Creator Class
local Creator = {}
Creator.__index = Creator

local TweenService = game:GetService('TweenService')
do
    -- // Constructor
    function Creator.new()
        local self = setmetatable({}, Creator)
        return self
    end

    -- // Create a ROBLOX instance
    function Creator.CreateInstance(self, ClassName, Props)
        local Instance = Instance.new(ClassName)

        for Property, Value in pairs(Props) do
            if Property ~= 'Parent' and Property ~= 'Children' then
                Instance[Property] = Value
            end
        end

        if Props.Children then
            for _, ChildData in pairs(Props.Children) do
                local ChildClassName = ChildData[1]
                local ChildProps = ChildData[2]

                local ChildInstance = Creator.CreateInstance(Creator, ChildClassName, ChildProps)
                ChildInstance.Parent = Instance
            end
        end

        if Props.Parent then
            Instance.Parent = Props.Parent
        end

        if Props.Tween then
            self:TweenInstance(Instance, Props.Tween)
        end

        return Instance
    end

    -- // Tween an Instance
    function Creator:TweenInstance(Instance, TweenProps)
        local TweenInfoProps = TweenInfo.new(
            TweenProps.Time or 1,
            TweenProps.EasingStyle or Enum.EasingStyle.Linear,
            TweenProps.EasingDirection or Enum.EasingDirection.Out,
            TweenProps.RepeatCount or 0,
            TweenProps.Reverses or false,
            TweenProps.DelayTime or 0
        )
        local Goals = TweenProps.Goals

        if Goals then
            local Tween = TweenService:Create(Instance, TweenInfoProps, Goals)
            Tween:Play()
            return Tween
        else
            return nil
        end
    end
end

-- // Return
return Creator
