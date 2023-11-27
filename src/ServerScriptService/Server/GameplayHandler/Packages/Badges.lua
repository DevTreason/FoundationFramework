local module = {}

--/ Services /--
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local BadgeService = game:GetService("BadgeService")
local Players = game:GetService("Players")

--/ Variables /--
local Server = ServerScriptService.Server

--/ Modules /--
local Modules = {
    ["CoreModules"] = {
        ["DataService"] = require(Server.DataHandler.DataService),
    },
}

--/ Private Variables /--
local Badges = {
    ["FirstTimePlaying"] = {
        ["ID"] = 123456789,
    },
}

--/ Private Functions /--
local function CheckBadgeOwnership(Player, BadgeName)
    local BadgeID = Badges[BadgeName].ID

    if BadgeService:UserHasBadgeAsync(Player.UserId, BadgeID) then
        return true
    else
        return false
    end
end

--/ Public Functions /--
function module.AwardBadge(Player, BadgeName)
    local BadgeOwnership = CheckBadgeOwnership(Player, BadgeName)

    if not BadgeOwnership then
        local ID = Badges[BadgeName].ID
        BadgeService:AwardBadge(Player.UserId, ID)
    end
end

return module