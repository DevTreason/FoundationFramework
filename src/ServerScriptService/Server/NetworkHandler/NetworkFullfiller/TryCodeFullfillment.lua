local module = {}

--/ Services /--
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")

--/ Variables /--
local Server = ServerScriptService.Server

--/ Modules /--
local Modules = {
    ["CoreModules"] = {
        ["DataService"] = require(Server.DataHandler.DataService),
        ["Utilities"] = {},
    },
}

--/ Private Variables /--


--/ Private Functions /--


--/ Public Functions /--
function module:OnServerEvent(player, event, ...)
    local Data = {...}
    local CodeName = Data[1]
    local PlayerGui = player:WaitForChild("PlayerGui")
    local MainUI = PlayerGui:WaitForChild("MainUI")
    local PlayerCodes = Modules.CoreModules.DataService.GetDataOfSpecificType(player, "Codes")

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
        Modules.CoreModules.DataService.UpdateDataOfSpecificType(player, "Codes", {CodeName, "CLAIMED", true})
        for RewardName, Reward in pairs(Rewards) do
            Modules.CoreModules.DataService.UpdateDataOfSpecificType(player, RewardName, {nil, nil, Reward})
        end
        MainUI.Codes.EnterCode.Text = "CODE CLAIMED"
        task.wait(1)
        MainUI.Codes.EnterCode.Text = ""
    end    
end

return module
