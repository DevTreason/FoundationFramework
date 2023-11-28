local module = {}

--/ Services /--
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local StarterPlayer = game:GetService("StarterPlayer")

--/ Modules /--
local Modules = {
    ["CoreModules"] = {
        ["NetworkHandler"] = require(StarterPlayer.StarterPlayerScripts.Client.Network.NetworkHandler),
    }
}

--/ Private Variables /--
local Player = Players.LocalPlayer
local CodeFrame = Player.PlayerGui:WaitForChild("MainUI"):WaitForChild("Codes")

--/ Private Functions /--
local function TryCode(Code)
    Modules.CoreModules.NetworkHandler.InvokeServer("TryCode", Code)
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
