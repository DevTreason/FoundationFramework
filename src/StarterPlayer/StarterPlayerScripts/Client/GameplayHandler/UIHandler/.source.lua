local module = {}

--/ Services /--
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")

--/ Modules /--
local Modules = {}
for _, module in pairs(script:GetChildren()) do
    Modules[module.Name] = require(module)
end

--/ Private Variables /--

--/ Private Functions /--

--/ Public Functions /--
function module:Start()
    for name, module in pairs(Modules) do
        if module:Start() then
            module:Start()
        end
    end
end

return module
