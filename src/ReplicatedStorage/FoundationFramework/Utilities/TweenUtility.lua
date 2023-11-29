local module = {}
module.__index = module

local TweenService = game:GetService("TweenService")

function module.new(instance, tweenInfo, properties)
    local self = setmetatable({}, module)

    self.TweenObject = {
        instance = instance,
        tweenInfo = tweenInfo,
        properties = properties,
        tween = nil,
        Play = function(self)
            self.tween = TweenService:Create(self.instance, self.tweenInfo, self.properties)
            self.tween:Play()
            return self
        end,
        Cancel = function(self)
            self.tween:Cancel()
            return self
        end,
        Pause = function(self)
            self.tween:Pause()
            return self
        end,
        Completed = function(self, callback)
            self.tween.Completed:Connect(callback)
            return self
        end,
        WaitForCompleted = function(self)
            self.tween.Completed:Wait()
            return self
        end,
    }

    return self.TweenObject
end

return module