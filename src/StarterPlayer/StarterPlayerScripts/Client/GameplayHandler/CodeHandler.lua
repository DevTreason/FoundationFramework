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

for _, global in pairs(script.Parent.Parent:GetChildren()) do
    if global.Name == script.Parent.Name then continue end
    if global:IsA("PackageLink") then continue end
    Modules[global.Name] = require(global)
end

--/ Private Variables /--
local Player = Players.LocalPlayer
local CodeFrame = Player.PlayerGui:WaitForChild("MainUI"):WaitForChild("Codes")

--/ Private Functions /--
local function TryCode(Code)
    Modules.NetworkHandler.InvokeServer("TryCode", Code)
end

local function CodeInputListener()
    CodeFrame.EnterCode.FocusLost:Connect(function(EnterPressed)
        if EnterPressed then
            local Code = CodeFrame.EnterCode.Text
            TryCode(Code)
        end        
    end)
end

--/ Public Functions /--
function module:Start()
    CodeInputListener()
end

return module
