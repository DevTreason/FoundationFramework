local module = {}

--/ Services /--
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")

--/ Variables /--
local Server = ServerScriptService.Server

--/ Modules /--
local Modules = {
    ["CoreModules"] = {
        ["DataHandler"] = require(Server.DataHandler),
    },
}

--/ Private Variables /--


--/ Private Functions /--


--/ Public Functions /--
function module:Start()
    
end

return module