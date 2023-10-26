local Modules = {}
for _, module in pairs(script:GetChildren()) do
    Modules[module.Name] = require(module)
end

return {
    ["Money"] = 0,
    ["Level"] = 1,
    ["Experience"] = 0,
    ["Codes"] = Modules.Codes,
    ["Settings"] = Modules.Settings,
    ["Inventory"] = Modules.Inventory,
    ["Quests"] = Modules.Quests
}