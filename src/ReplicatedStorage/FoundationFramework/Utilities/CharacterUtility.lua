local module = {}
module.__index = module

function module.retrieve(player : Player)
    local self = setmetatable({}, module)
    repeat task.wait() until player.Character
    local Character = player.Character
    
    self.CharacterObject = {
        Player = player,
        Character = Character,
        Humanoid = Character:WaitForChild("Humanoid"),
        UpdateMaxHealth = function(self, newHealth)
            self.Humanoid.MaxHealth = newHealth
            return self
        end,
        OnDeath = function(self, callback)
            self.Humanoid.Died:Connect(callback)
            return self
        end,
        ReloadCharacter = function(self)
            local CurrentLocation = player.Character:GetPivot()
            self.Player:LoadCharacter()
            self.Character = player.Character
            self.Humanoid = Character:WaitForChild("Humanoid")
            self.Character:PivotTo(CurrentLocation)
            return self
        end,
        RespawnCharacter = function(self)
            self.Player:LoadCharacter()
            self.Character = player.Character
            self.Humanoid = Character:WaitForChild("Humanoid")
            return self
        end,
        GetHealth = function(self)
            return self.Humanoid.Health
        end,
        GetMaxHealth = function(self)
            return self.Humanoid.MaxHealth
        end,
        SetHealth = function(self, newHealth)
            self.Humanoid.Health = newHealth
            return self
        end,
    }

    return self.CharacterObject
end

return module