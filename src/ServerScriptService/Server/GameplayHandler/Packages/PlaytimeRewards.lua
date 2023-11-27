local module = {}

module.Enabled = false

--/ Services /--
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")

--/ Variables /--
local Server = ServerScriptService.Server
local FoundationFramework = ReplicatedStorage:WaitForChild("FoundationFramework")

--/ Modules /--
local Modules = {
    ["CoreModules"] = {
        ["DataService"] = require(Server.DataHandler.DataService),
    },
    ["Utilities"] = {
        ["RandomUtility"] = require(FoundationFramework.Utilities.RandomUtility),
    }

}

--/ Private Variables /--


--/ Private Functions /--


--/ Public Functions /--
function module:Start()
    
end

return module