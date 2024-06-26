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
    ["ServiceRequirements"] = {
        ["ProfileService"] = require(Server.DataHandler.ProfileService),
        ["DefaultData"] = require(Server.DataHandler.DefaultData),
    }
}

--/ Private Variables /--
local Prefix = "DEVELOPMENT_01"
local ProfileTemplate = Modules.ServiceRequirements.DefaultData
local ProfileStore = Modules.ServiceRequirements.ProfileService.GetProfileStore("PlayerData", ProfileTemplate)
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

function module.AddDataToSpecificType(player: Player, dataType : string, data : any)
    local Profile = Profiles[player]
    if Profile then
        Profile.Data[dataType] += data
    end
end

function module.SetDataOfSpecificType(player : Player, dataType : string, data : any)
    local Profile = Profiles[player]
    if Profile then
        Profile.Data[dataType] = data
    end
end

function module.UpdateSubDataOfSpecificType(player : Player, dataType : string, subDataType : string, valueToUpdate : string, data : any)
    local Profile = Profiles[player]
    if Profile then
        Profile.Data[dataType][subDataType][valueToUpdate] = data
    end
end

function module:Start()
    Players.PlayerAdded:Connect(PlayerAdded)
    Players.PlayerRemoving:Connect(PlayerRemoving)
end

return module