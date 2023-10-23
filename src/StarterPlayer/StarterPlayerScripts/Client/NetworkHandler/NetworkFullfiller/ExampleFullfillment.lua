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
local player = Players.LocalPlayer

--/ Private Functions /--


--/ Public Functions /--
function module:OnClientEvent(event, ...)
    -- Implement Client Logic here
end

return module