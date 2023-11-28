local module = {}

--/ Services /--
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local StarterPlayer = game:GetService("StarterPlayer")

--/ Modules /--
local Modules =  {
    ["NetworkFullfiller"] = require(StarterPlayer.StarterPlayerScripts.Client.Network.Fullfiller.NetworkFullfiller),
}

--/ Private Variables /--
local Player = Players.LocalPlayer
local FoundationFramework = ReplicatedStorage:WaitForChild("FoundationFramework")
local Network = FoundationFramework:WaitForChild("Network")
local NetworkIndex = Network:GetChildren()
local StoredNetwork = {}
for _, event in pairs(NetworkIndex) do
    StoredNetwork[event.Name] = event
end

--/ Private Functions /--
local function ObfuscateNetwork()
    task.spawn(function()
        while true do
            for _, event in pairs(Network:GetChildren()) do
                if event:IsA("RemoteEvent") then
                    event.Name = HttpService:GenerateGUID(false)
                elseif event:IsA("RemoteFunction") then
                    event.Name = HttpService:GenerateGUID(false)
                end
            end
            task.wait(5)
        end
    end)
end

--/ Public Functions /--
function module.InvokedListener()
    for _, event in ipairs(NetworkIndex) do
        if event:IsA("RemoteEvent") then
            event.OnClientEvent:Connect(function(...)
                Modules.NetworkFullfiller.OnClientEvent(Player, event, ...)
            end)
        elseif event:IsA("RemoteFunction") then
            event.OnClientInvoke = function(data)
                print("Received event " .. event.Name)
                return 
            end
        end
    end
end

function module.InvokeServer(event, ...)
    StoredNetwork[event]:FireServer(...)
end

function module:Start()
    module.InvokedListener()
    ObfuscateNetwork()
end

return module
