local module = {}
module.__index = module

function module.new()
    local self = setmetatable({}, module)

    self.LogObject = {
        Prefix = nil,
        Log = function(self, ...)
            local args = {...}
            local message = ""
            for _, v in pairs(args) do
                message = message .. tostring(v) .. " "
            end
            print(self.Prefix, message)
        end,
        Warn = function(self, ...)
            local args = {...}
            local message = ""
            for _, v in pairs(args) do
                message = message .. tostring(v) .. " "
            end
            warn(self.Prefix, message)
        end
    }

    return self.LogObject
end

return module