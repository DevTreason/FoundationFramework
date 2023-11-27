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
local FoundationFramework = ReplicatedStorage:WaitForChild("FoundationFramework")
local Network = FoundationFramework:WaitForChild("Network")
local NetworkIndex = Network:GetChildren()

--/ Private Functions /--


--/ Public Functions /--
function module.InvokeClient(player, event, ...)
    Network[event]:FireClient(player, ...)
end

function module.InvokedListener()
    for _, event in ipairs(NetworkIndex) do
        if event:IsA("RemoteEvent") then
            event.OnServerEvent:Connect(function(player, ...)
                Modules.NetworkFullfiller.OnServerEvent(player, event, ...)
            end)
        elseif event:IsA("RemoteFunction") then
            event.OnServerInvoke = function(player, ...)
                return 
            end
        end
    end
end

function module:Start()
    module.InvokedListener()
end

return module

--[[ Example of Client Invoke
        Players.PlayerAdded:Connect(function(player)
            module.InvokeClient(player, "Example", {
                ["RealName"] = "Example",
                ["Data"] = {
                    ["Health"] = 50,
                    ["Money"] = 25
                }
            })
        end)
]]