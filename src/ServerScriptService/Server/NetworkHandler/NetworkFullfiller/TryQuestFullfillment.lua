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


--/ Public Functions /--
function module:OnServerEvent(player, event, ...)
    local Data = {...}
    local Profile = Modules.CoreModules.DataService.GetProfile(player)
    local Quests = Profile.Data.Quests
    local MainUI = player.PlayerGui:WaitForChild("MainUI")
    local QuestUI = MainUI:WaitForChild("Quests")
    local QuestList = QuestUI:WaitForChild("QuestHolder")
    for _, QuestData in pairs(Quests) do

        if not QuestData.Unlocked then 
            local QUEST_REQUIREMENTS = nil
            if QuestData.QUESTREQUIREMENTS ~= false then
                QUEST_REQUIREMENTS = QuestData.QUESTREQUIREMENTS
            else
                continue
            end
            local AmountOfQuests = #QUEST_REQUIREMENTS
            local AmountOfCompletedQuests = 0
            for _, QuestName in ipairs(QUEST_REQUIREMENTS) do
                local Quest = Quests[QuestName]
                if Quest.COMPLETED then
                    AmountOfCompletedQuests += 1
                end
                if AmountOfCompletedQuests == AmountOfQuests then
                    QuestData.UNLOCKED = true
                    QuestData.ACTIVE = true
                else
                    continue
                end
            end 
        end
        if QuestData.COMPLETED then continue end
        if not QuestData.ACTIVE then continue end
        for ID, Task in pairs(QuestData.TASKS) do
            if ID > 1 then
                local PreviousTask = QuestData.TASKS[ID - 1]
                if not PreviousTask.COMPLETED then continue end
            end
            if Task.COMPLETED then continue end
            if Task.TASK == Data[1]["PROGRESS_TYPE"] and typeof(Data[1]["AMOUNT"]) == "number" then
                Task.REQUIREMENTS[1].AMOUNT -= Data[1]["AMOUNT"]
                if Task.REQUIREMENTS[1].AMOUNT <= 0 then
                    Task.COMPLETED = true
                end
                break
            elseif Task.TASK == Data[1]["PROGRESS_TYPE"] and typeof(Data[1]["AMOUNT"]) == "boolean" then
                Task.COMPLETED = true
                break
            end
        end
    end

    for _, Quest in ipairs(QuestList:GetChildren()) do
        if not Quest:IsA("Frame") then continue end
        local QuestName = Quest.QuestName.QuestName.Text
        if string.match(QuestName, "???") then continue end
        local QuestData = Quests[QuestName]
        if QuestData.COMPLETED then continue end
        if not QuestData.UNLOCKED then continue end
        if not QuestData.ACTIVE then continue end
        local AmountCompleted = 0
        local FirstNotCompletedTask = nil
        local TotalAmountOfTasks = #QuestData.TASKS
        local TaskText = Quest.TaskText
        local ProgressBar = Quest.ProgressBar
        local ActualBar = Quest.ProgressBar.Bar

        for _, Task in ipairs(QuestData.TASKS) do
            if Task.COMPLETED then
                AmountCompleted += 1
            else
                if not FirstNotCompletedTask then
                    FirstNotCompletedTask = Task
                end
            end
        end
        if AmountCompleted == TotalAmountOfTasks then
            FirstNotCompletedTask = "QUEST COMPLETED"
            QuestData.COMPLETED = true
            QuestData.ACTIVE = false
            Quest.LayoutOrder = 100
            if not QuestData.REWARDS_CLAIMED then
                QuestData.REWARDS_CLAIMED = true
                for RewardName, Reward in pairs(QuestData.REWARDS) do
                    Modules.CoreModules.DataService.AddDataToSpecificType(player, RewardName, Reward)
                end
            end
        end

        local REQUIREMENT_NAME = FirstNotCompletedTask.REQUIREMENTS[1].NAME
        local REQUIREMENT_AMOUNT = FirstNotCompletedTask.REQUIREMENTS[1].AMOUNT
        local REQUIREMENT_TYPE = FirstNotCompletedTask.TASK
        if REQUIREMENT_TYPE == "ELIMINATE" then
            TaskText.ProgressText.Text = string.format(FirstNotCompletedTask.DESCRIPTION, REQUIREMENT_AMOUNT, REQUIREMENT_NAME)
        elseif REQUIREMENT_TYPE == "OBTAIN" then
            TaskText.ProgressText.Text = string.format(FirstNotCompletedTask.DESCRIPTION, REQUIREMENT_AMOUNT, REQUIREMENT_NAME)
        elseif REQUIREMENT_TYPE == "REACH" then
            TaskText.ProgressText.Text = string.format(FirstNotCompletedTask.DESCRIPTION, REQUIREMENT_NAME)
        end

        ProgressBar.ProgressText.Text = AmountCompleted .. "/" .. TotalAmountOfTasks
        ActualBar.Size = UDim2.new(AmountCompleted / TotalAmountOfTasks, 0, 1, 0)
    end
end

return module
