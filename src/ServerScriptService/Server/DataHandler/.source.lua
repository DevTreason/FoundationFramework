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
function module:Start()
    Players.PlayerAdded:Connect(PlayerAdded)
    Players.PlayerRemoving:Connect(PlayerRemoving)
    for _, player in pairs(Players:GetPlayers()) do
        coroutine.wrap(PlayerAdded)(player)
    end
end



return module
