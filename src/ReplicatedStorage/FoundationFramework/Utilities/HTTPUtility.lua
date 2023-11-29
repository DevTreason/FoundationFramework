local module = {}
module.__index = module

local HttpService = game:GetService("HttpService")

function module.new()
    local self = setmetatable({}, module)

    self.HTTPObject = {
        GenerateGUID = function(self, bool)
            return HttpService:GenerateGUID(bool)
        end,
        JSONEncode = function(self, data)
            return HttpService:JSONEncode(data)
        end,
        JSONDecode = function(self, data)
            return HttpService:JSONDecode(data)
        end,
        UrlEncode = function(self, data)
            return HttpService:UrlEncode(data)
        end,
        GetAsync = function(self, url, nocache, headers)
            return HttpService:GetAsync(url, nocache, headers)
        end,
        PostAsync = function(self, url, data, contentType, compress, headers)
            return HttpService:PostAsync(url, data, contentType, compress, headers)
        end,
        RequestAsync = function(self, request)
            return HttpService:RequestAsync(request)
        end,
    }

    return self.HTTPObject
end

return module