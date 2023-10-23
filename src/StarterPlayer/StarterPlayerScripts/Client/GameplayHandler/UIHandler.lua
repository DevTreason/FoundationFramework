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
local Player = Players.LocalPlayer
local MainUI = Player.PlayerGui:WaitForChild("MainUI")
local DefaultUI = {}

--/ Private Functions /--
local function ButtonListener()
    local Buttons = MainUI.ButtonFrame:GetChildren()
    local Blur = Lighting:FindFirstChild("Blur")
    for _, ButtonFrame in pairs(Buttons) do
        if ButtonFrame:IsA("UIListLayout") then continue end
        ButtonFrame.Button.MouseButton1Click:Connect(function()
            local FrameToOpen = ButtonFrame.Name
            MainUI[FrameToOpen].Visible = not MainUI[FrameToOpen].Visible
            if MainUI[FrameToOpen].Visible then
                Blur.Enabled = true
                for _, Frame in pairs(MainUI:GetChildren()) do
                    if Frame:IsA("Frame") and Frame.Name ~= FrameToOpen and Frame.Name ~= "ButtonFrame" then
                        Frame.Visible = false
                    end
                end
            else
                Blur.Enabled = false
                for _, Frame in pairs(MainUI:GetChildren()) do
                    if Frame:IsA("Frame") and table.find(DefaultUI, Frame.Name) then
                        Frame.Visible = true
                    end
                end
            end
        end)
    end 
end

local function ButtonHoverEffect()
    local Buttons = MainUI.ButtonFrame:GetChildren()
    for _, ButtonFrame in pairs(Buttons) do
        if ButtonFrame:IsA("UIListLayout") then continue end
        ButtonFrame.Button.MouseEnter:Connect(function()
            local Tween = TweenService:Create(ButtonFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 0, 0), Size = UDim2.new(1.2, 0, .2, 0)})
            Tween:Play()
            --ButtonFrame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        end)
        ButtonFrame.Button.MouseLeave:Connect(function()
            local Tween = TweenService:Create(ButtonFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(55, 55, 55), Size = UDim2.new(1, 0, .16, 0)})
            Tween:Play()
        end)
    end
end

--/ Public Functions /--
function module:Start()
    ButtonHoverEffect()
    ButtonListener()
end

return module
