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

--/ Private Variables /--
local Prefix = "DEVELOPMENT_01"
local ProfileTemplate = Modules.DefaultData
local ProfileStore = Modules.ProfileService.GetProfileStore("PlayerData", ProfileTemplate)
local Profiles = {}

--/ Private Functions /--
local function PlayerAdded(player)
    local Profile = ProfileStore:LoadProfileAsync(Prefix..player.UserId)
    if Profile ~= nil then
        Profile:AddUserId(player.UserId)
        Profile:Reconcile()
        Profile:ListenToRelease(function()
            Profiles[player] = nil
            player:Kick("The profile might have been loaded on another server.")
        end)
        if player:IsDescendantOf(Players) then
            Profiles[player] = Profile
        else
            Profile:Release()
        end
    else
        player:Kick("Roblox couldn't load your data. Please rejoin the game.")
    end
end

local function PlayerRemoving(player)
    local Profile = Profiles[player]
    if Profile then
        Profile:Release()
    end
end

--/ Public Functions /--
function module.GetProfile(player)
    while not Profiles[player] do task.wait() end
    return Profiles[player]
end

function module.GetDataOfSpecificType(player, dataType)
    repeat task.wait() until Profiles[player]
    local Profile = Profiles[player]
    if Profile then
        return Profile.Data[dataType]
    end
end

function module.UpdateDataOfSpecificType(player, dataType, data)
    local Profile = Profiles[player]
    local Name = data[1]
    local Type = data[2]
    local Amount = data[3]
    if Profile then
        if typeof(Amount) == "number" and not Type and not Name then
            Profile.Data[dataType] += Amount
        elseif typeof(Amount) == "number" and Type then
            Profile.Data[dataType][Type] += Amount
        elseif typeof(Amount) == "boolean" then
            Profile.Data[dataType][Name][Type] = Amount
        end
    end
end

function module:Start()
    Players.PlayerAdded:Connect(PlayerAdded)
    Players.PlayerRemoving:Connect(PlayerRemoving)
end



return module
