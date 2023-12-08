local module = {}

--/ Services /--
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

--/ Modules /--
local Modules = {
    ["Utilities"] = {
        ["TimerUtility"] = require(ReplicatedStorage.FoundationFramework.Utilities.TimerUtility),
        ["TweenUtility"] = require(ReplicatedStorage.FoundationFramework.Utilities.TweenUtility),
        ["HTTPUtility"] = require(ReplicatedStorage.FoundationFramework.Utilities.HTTPUtility),
        ["CharacterUtility"] = require(ReplicatedStorage.FoundationFramework.Utilities.CharacterUtility),
        ["LogUtility"] = require(ReplicatedStorage.FoundationFramework.Utilities.LogUtility),
    }
}

--/ Private Variables /--


--/ Private Functions /--


--/ Public Functions /--


return module