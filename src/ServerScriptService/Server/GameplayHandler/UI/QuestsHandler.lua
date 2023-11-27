local module = {}

--/ Services /--
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")

--/ Variables /--
local Server = ServerScriptService.Server

--/ Modules /--
local Modules = {
    ["CoreModules"] = {
        ["DataService"] = require(Server.DataHandler.DataService),
        ["Utilities"] = {},
    },
}

--/ Private Variables /--


--/ Private Functions /--
local function PopulateQuestList()
    Players.PlayerAdded:Connect(function(player)
        local Profile = Modules.CoreModules.DataService.GetProfile(player)
        local Quests = Profile.Data.Quests
        --Modules.DataHandler.UpdateDataOfSpecificType(player, "Money", {nil, nil, 1000})
        local QuestTemplate = ReplicatedStorage.UIElements.QuestTemplate
        for QuestName, QuestData in pairs(Quests) do
            local QuestClone = QuestTemplate:Clone()
            QuestClone.Name = QuestName
            local ProgressBar = QuestClone.ProgressBar
            local ActualBar = ProgressBar.Bar
            local ProgressText = ProgressBar.ProgressText
            local QuestNameFrame = QuestClone.QuestName
            local NameText = QuestNameFrame.QuestName
            local QuestDescription = QuestClone.TaskText
            local Text = QuestDescription.ProgressText

            if QuestData.COMPLETED then
                NameText.Text = QuestName
                Text.Text = "COMPLETED"
                ProgressText.Text = "COMPLETED"
                ActualBar.Size = UDim2.new(1, 0, 1, 0)
                QuestClone.LayoutOrder = QuestData.LAYOUTORDER
                QuestClone.Parent = player.PlayerGui:WaitForChild("MainUI").Quests.QuestHolder
                continue
            elseif QuestData.UNLOCKED and not QuestData.COMPLETED then
                local FirstNotCompletedTask = nil
                for ID, Task in ipairs(QuestData.TASKS) do
                    if not Task.COMPLETED then
                        FirstNotCompletedTask = Task
                        break
                    end
                end

                local AmountCompleted = 0
                for _, Task in ipairs(QuestData.TASKS) do
                    if Task.COMPLETED then
                        AmountCompleted += 1
                    end
                end

                local REQUIREMENT_NAME = FirstNotCompletedTask.REQUIREMENTS[1].NAME
                local REQUIREMENT_AMOUNT = FirstNotCompletedTask.REQUIREMENTS[1].AMOUNT
                local REQUIREMENT_TYPE = FirstNotCompletedTask.TASK
                if REQUIREMENT_TYPE == "ELIMINATE" then
                    Text.Text = string.format(FirstNotCompletedTask.DESCRIPTION, REQUIREMENT_AMOUNT, REQUIREMENT_NAME)
                elseif REQUIREMENT_TYPE == "OBTAIN" then
                    Text.Text = string.format(FirstNotCompletedTask.DESCRIPTION, REQUIREMENT_AMOUNT, REQUIREMENT_NAME)
                elseif REQUIREMENT_TYPE == "REACH" then
                    Text.Text = string.format(FirstNotCompletedTask.DESCRIPTION, REQUIREMENT_NAME)
                end
                NameText.Text = QuestName
                ProgressText.Text = string.format("%s/%s", AmountCompleted, #QuestData.TASKS)
                ActualBar.Size = UDim2.new(AmountCompleted / #QuestData.TASKS, 0, 1, 0)
            elseif not QuestData.UNLOCKED then
                NameText.Text = "???"
                Text.Text = "???"
                ProgressText.Text = "???"
                ActualBar.Size = UDim2.new(0, 0, 1, 0)
            end
            if QuestData.COMPLETED then
                QuestClone.LayoutOrder = 100
            else
                QuestClone.LayoutOrder = QuestData.LAYOUTORDER
            end
            QuestClone.Parent = player.PlayerGui:WaitForChild("MainUI").Quests.QuestHolder
        end
    end)
end

--/ Public Functions /--
function module:Start()
    PopulateQuestList()
end

return module