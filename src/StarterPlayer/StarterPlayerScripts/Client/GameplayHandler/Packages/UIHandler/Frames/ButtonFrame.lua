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
local GUISounds = ReplicatedStorage:WaitForChild("Sounds"):WaitForChild("GUISounds")
local DefaultUI = {}

--/ Private Functions /--
local function ButtonListener()
    local Buttons = MainUI.ButtonFrame:GetChildren()
    local Blur = Lighting:FindFirstChild("Blur")
    for _, ButtonFrame in pairs(Buttons) do
        if not ButtonFrame:IsA("Frame") then continue end
        ButtonFrame.Button.MouseButton1Click:Connect(function()
            GUISounds.ClickSound:Play()
            local FrameToOpen = ButtonFrame.Name
            local OriginalSize = MainUI[FrameToOpen].Size
            if MainUI[FrameToOpen].Visible == true then
                local Tween = TweenService:Create(MainUI[FrameToOpen], TweenInfo.new(0.2), {Size = UDim2.new(0, 0, 0, 0)})
                Tween:Play()
                Tween.Completed:Wait()
                MainUI[FrameToOpen].Size = OriginalSize
            end

            MainUI[FrameToOpen].Visible = not MainUI[FrameToOpen].Visible
            if MainUI[FrameToOpen].Visible then
                local OriginalSize = MainUI[FrameToOpen].Size
                MainUI[FrameToOpen].Size = UDim2.new(0, 0, 0, 0)
                local Tween = TweenService:Create(MainUI[FrameToOpen], TweenInfo.new(0.2), {Size = OriginalSize})
                Tween:Play()
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
        if not ButtonFrame:IsA("Frame") then continue end
        ButtonFrame.Button.MouseEnter:Connect(function()
            GUISounds.HoverSound:Play()
            local Tween = TweenService:Create(ButtonFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 0, 0), Size = UDim2.new(1.2, 0, .2, 0)})
            Tween:Play()
        end)
        ButtonFrame.Button.MouseLeave:Connect(function()
            local Tween = TweenService:Create(ButtonFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(55, 55, 55), Size = UDim2.new(1, 0, .16, 0)})
            Tween:Play()
        end)
    end
end

--/ Public Functions /--
function module:Start()
    ButtonListener()
    ButtonHoverEffect() 
end

return module
