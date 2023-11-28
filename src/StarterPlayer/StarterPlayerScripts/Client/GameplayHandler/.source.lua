local module = {}

--/ Services /--
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local StarterPlayer = game:GetService("StarterPlayer")

--/ Modules /--
local Modules = {
    ["Packages"] = {
        ["UIHandler"] = require(StarterPlayer.StarterPlayerScripts.Client.GameplayHandler.Packages.UIHandler),
    }
}

--/ Private Variables /--


--/ Private Functions /--


--/ Public Functions /--
function module:Start()
    for name, module in pairs(Modules) do
        if module.Start then
            print("[C-TFG BOOTSTRAPPER] Starting module " .. name)
            module:Start()
        end
    end
end

return module
