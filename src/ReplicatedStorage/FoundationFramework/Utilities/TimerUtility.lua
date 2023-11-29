local module = {}
module.__index = module

function module.new(timeToWait, timePerTick)
    if not timeToWait then
        timeToWait = 0
    end
    if not timePerTick then
        timePerTick = 1
    end
    local self = setmetatable({}, module)

    self.TimerObject = {
        time = timeToWait,
        callback = nil,
        connection = nil,
        onTick = nil,
        running = false,
        ended = false,
        AndThen = function(self, callback)
            self.callback = callback
            return self 
        end,
        Start = function(self)
            self.running = true
            return self
        end,
        Stop = function(self)
            self.running = false
            return self
        end,
        IsRunning = function(self)
            return self.running
        end,
        Connect = function(self, connection)
            self.connection = connection
            return self
        end,
        OnTick = function(self, onTick)
            self.onTick = onTick
            return self
        end,
    }

    task.spawn(function()
        while self.TimerObject.connection == nil do
            task.wait()
            if self.TimerObject.ended then
                break
            end
        end

        if self.TimerObject.connection then
            self.TimerObject.connection()
        end
    end)

    task.spawn(function()
        while true do
            if self.TimerObject.running and self.TimerObject.time > 0 then
                if self.TimerObject.onTick then
                    self.TimerObject.onTick()
                end
                self.TimerObject.time -= 1
                if self.TimerObject.time <= 0 then
                    self.TimerObject.ended = true
                    break
                end
                task.wait(timePerTick)
            else
                task.wait()
                if self.TimerObject.time <= 0 then
                    self.TimerObject.ended = true
                    break
                end
            end
        end

        if self.TimerObject.callback then
            self.TimerObject.callback()
        end
    end)

    return self.TimerObject
end

return module