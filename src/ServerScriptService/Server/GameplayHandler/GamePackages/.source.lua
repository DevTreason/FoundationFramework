local module = {}

module.Modules = {}

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
function module:Start()
    for name, module in pairs(Modules) do
        if module.Start and module.Enabled then
            print("[S-TFG BOOTSTRAPPER] Starting module "..name)
            module:Start()
        end
        self.Modules[name] = module
    end
end

return module
