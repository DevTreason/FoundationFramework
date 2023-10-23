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


--/ Private Functions /--


--/ Public Functions /--
function module.OnServerEvent(player, event, ...)
    -- Find the module with string.match
    for name, module in pairs(Modules) do
        if string.find(name, event.Name) then
            
            module:OnServerEvent(player, event, ...)
        end
    end
end

return module
