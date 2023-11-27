local module = {}

--/ Services /--
local ServerStorage = game:GetService("ServerStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

--/ Variables /--
local Server = ServerScriptService.Server

--/ Modules /--
local Modules = {
    ["HandlerCore"] = {
        ["DataService"] = require(Server.DataHandler.DataService),
    }
}

--/ Private Variables /--


--/ Private Functions /--


--/ Public Functions /--
function module:Start()
    Modules.HandlerCore.DataService:Start()
end

return module
