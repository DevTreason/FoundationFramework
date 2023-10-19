--/ Services /--
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
for name, module in pairs(Modules) do
    if module.Start then
        print("[C-TFG BOOTSTRAPPER] Starting module " .. name)
        module:Start()
    end
end