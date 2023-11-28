local module = {}

--/ Services /--
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local StarterPlayer = game:GetService("StarterPlayer")

--/ Modules /--
local Modules = {}
for _, fullfillmentModule in StarterPlayer.StarterPlayerScripts.Client.Network.Fullfillments:GetChildren() do
    Modules[fullfillmentModule.Name] = require(fullfillmentModule)
end

--/ Private Variables /--
local player = Players.LocalPlayer

--/ Private Functions /--


--/ Public Functions /--
function module.OnClientEvent(event, ...)
    local Data = {...}
    local RealName = Data[2]["RealName"]
    for name, module in pairs(Modules) do
        if string.find(name, RealName) then
            module:OnClientEvent(event, Data)
        end
    end
end

return module
