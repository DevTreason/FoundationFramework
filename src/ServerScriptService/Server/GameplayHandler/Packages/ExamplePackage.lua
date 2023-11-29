local module = {}

--/ Services /--
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

--/ Modules /--
local Modules = {
    ["Utilities"] = {
        ["TimerUtility"] = require(ReplicatedStorage.FoundationFramework.Utilities.TimerUtility),
        ["TweenUtility"] = require(ReplicatedStorage.FoundationFramework.Utilities.TweenUtility),
        ["HTTPUtility"] = require(ReplicatedStorage.FoundationFramework.Utilities.HTTPUtility)
    }
}

--/ Private Variables /--


--/ Private Functions /--


--/ Public Functions /--
local Timer = Modules.Utilities.TimerUtility.new(5)
Timer:Connect(function()
    print("Timer has been connected!")
end)
Timer:Start()
Timer:OnTick(function()
    print("Timer is ticking!", Timer.time)
end)
Timer:AndThen(function()
    print("Timer has ended!")
end)

Players.PlayerAdded:Connect(function(player)
    local PlayerGui = player:WaitForChild("PlayerGui")
    local Frame = PlayerGui:WaitForChild("MainUI"):WaitForChild("Frame")
    local Tween = Modules.Utilities.TweenUtility.new(Frame, TweenInfo.new(5), {Position = UDim2.new(0.5, 0, 0.5, 0)})
    Tween:Play()
    Tween:Completed(function()
        print("Tween has completed!")
    end)
end)

local GUID = Modules.Utilities.HTTPUtility.new():GenerateGUID()
print(GUID)



return module