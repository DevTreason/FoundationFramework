local module = {}

module.Enabled = true

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
    if global.Name == script.Parent.Name or global.Name == script.Parent.Parent.Name or global:IsA("PackageLink") then continue end
    Modules[global.Name] = require(global)
end

--/ Private Variables /--
local MinimumExperience = 100

--/ Private Functions /--

--/ Public Functions /--
function module.GetRequiredExperience(LEVEL)
    return ( LEVEL^2 ) * MinimumExperience * 0.5 + LEVEL * MinimumExperience + MinimumExperience
end

function module.UpdatePlayersExperience(PLAYER, AMOUNT)
    local PLAYER_LEVEL = Modules.DataHandler.GetDataOfSpecificType(PLAYER, "LEVEL")
    local PLAYER_EXPERIENCE = Modules.DataHandler.GetDataOfSpecificType(PLAYER, "EXPERIENCE")
    local REQUIRED_EXPERIENCE = module.GetRequiredExperience(PLAYER_LEVEL)
    Modules.DataHandler.UpdateDataOfSpecificType(PLAYER, "EXPERIENCE", AMOUNT)
    if PLAYER_EXPERIENCE + AMOUNT >= REQUIRED_EXPERIENCE then
        Modules.DataHandler.UpdateDataOfSpecificType(PLAYER, "LEVEL", 1)
        Modules.DataHandler.UpdateDataOfSpecificType(PLAYER, "EXPERIENCE", PLAYER_EXPERIENCE + AMOUNT - REQUIRED_EXPERIENCE)
    end
end

function module:Start()

end

return module