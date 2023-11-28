--/ Services /--
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local StarterPlayer = game:GetService("StarterPlayer")

--/ Modules /--
local Modules = {
    ["GameplayHandler"] = require(StarterPlayer.StarterPlayerScripts.Client.GameplayHandler),
    ["NetworkHandler"] = require(StarterPlayer.StarterPlayerScripts.Client.Network.NetworkHandler),
}

--/ Private Variables /--


--/ Private Functions /--


--/ Public Functions /--
for name, module in pairs(Modules) do
    if module.Start then
        print("[C-TFG BOOTSTRAPPER] Starting module " .. name)
        module:Start()
    end
end