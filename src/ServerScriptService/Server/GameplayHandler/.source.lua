local module = {}

module.Modules = {}

--/ Services /--
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

--/ Modules /--
local Modules = {}
for _, module in script.Packages:GetChildren() do
    Modules[module.Name] = require(module)
end
for _, module in script.UI:GetChildren() do
    Modules[module.Name] = require(module)
end

--/ Private Variables /--


--/ Private Functions /--


--/ Public Functions /--
function module:Start()
    for name, module in pairs(Modules) do
        if module.Start then
            print("[S-TFG BOOTSTRAPPER] Starting module "..name)
            module:Start()
        end
        self.Modules[name] = module
    end
end

return module
