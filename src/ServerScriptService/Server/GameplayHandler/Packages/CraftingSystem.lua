local module = {}

module.Enabled = false

--/ Services /--
local ServerStorage = game:GetService("ServerStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

--/ Variables /--
local Server = ServerScriptService.Server

--/ Modules /--
local Modules = {
    ["CoreModules"] = {
        ["DataService"] = require(Server.DataHandler.DataService),
    },
    ["Utilites"] = {
        ["ExampleUtlitiy"] = require(Server.GameplayHandler.Utilities.ExampleUtility),
    }
}

--/ Private Variables /--


--/ Private Functions /--


--/ Public Functions /--
function module:Start()

end

return module