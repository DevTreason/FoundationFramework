local module = {}

--/ Services /--
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

--/ Modules /--
local Modules = {}
for _, module in pairs(script:GetChildren()) do
    Modules[module.Name] = require(module)
end

for _, global in pairs(script.Parent.Parent.Parent:GetChildren()) do
    if global:IsA("PackageLink") then continue end
    if global.Name == "GameplayHandler" then continue end
    if global.Name == script.Parent.Parent.Name then continue end
    Modules[global.Name] = require(global)
end

--/ Private Variables /--


--/ Private Functions /--


--/ Public Functions /--
function module:OnServerEvent(player, event, ...)
    local Data = {...}
    local CodeName = Data[1]
    local PlayerGui = player:WaitForChild("PlayerGui")
    local MainUI = PlayerGui:WaitForChild("MainUI")
    local PlayerCodes = Modules.DataHandler.GetDataOfSpecificType(player, "Codes")

    if not PlayerCodes[CodeName] then
        MainUI.Codes.EnterCode.Text = "INVALID CODE"
        task.wait(1)
        MainUI.Codes.EnterCode.Text = ""
        return false
    end

    local IsCodeClaimed = PlayerCodes[CodeName]["CLAIMED"]
    local IsCodeActive = PlayerCodes[CodeName]["ACTIVE"]
    local Rewards = PlayerCodes[CodeName]["REWARDS"]

    if IsCodeClaimed and IsCodeActive then
        MainUI.Codes.EnterCode.Text = "CODE ALREADY CLAIMED"
        task.wait(1)
        MainUI.Codes.EnterCode.Text = ""
    elseif not IsCodeActive then
        MainUI.Codes.EnterCode.Text = "CODE EXPIRED"
        task.wait(1)
        MainUI.Codes.EnterCode.Text = ""
    else
        Modules.DataHandler.UpdateDataOfSpecificType(player, "Codes", {CodeName, "CLAIMED", true})
        for RewardName, Reward in pairs(Rewards) do
            Modules.DataHandler.UpdateDataOfSpecificType(player, RewardName, {nil, nil, Reward})
        end
        MainUI.Codes.EnterCode.Text = "CODE CLAIMED"
        task.wait(1)
        MainUI.Codes.EnterCode.Text = ""
    end    
end

return module
