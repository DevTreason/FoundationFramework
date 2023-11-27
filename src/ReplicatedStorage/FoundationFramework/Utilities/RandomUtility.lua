local module = {}

--/ Services /--
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")

--/ Variables /--
local Server = ServerScriptService.Server

--/ Modules /--
local Modules = {}

--/ Private Variables /--


--/ Private Functions /--


--/ Public Functions /--
function module.NextInteger(min : number, max : number)
    local Random = Random.new()

    return Random:NextInteger(min, max)
end 

function module.NextNumber(min : number, max : number)
    local Random = Random.new()

    return Random:NextNumber(min, max)
end

return module