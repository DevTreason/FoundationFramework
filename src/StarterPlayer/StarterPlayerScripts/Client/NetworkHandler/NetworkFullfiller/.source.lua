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
function module.OnClientEvent(event, ...)
    local Data = {...}
    local RealName = Data[2]["RealName"]
    -- Find the module with string.match
    for name, module in pairs(Modules) do
        if string.find(name, RealName) then
            module:OnClientEvent(event, Data)
        end
    end
end

return module
