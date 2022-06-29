--- Пакет для отладки кода.
local debug = {}

local function dumpData(var, level)

    local space = ""

    for _ = 1, level do
        space = space .. "  "
    end

    if type(var) == 'table' then
        local s = '{ \n\t'
        for k, v in pairs(var) do
            if type(k) ~= 'number' then
                k = '"' .. k .. '"'
            end
            s = s .. space .. '[' .. k .. '] = ' .. dumpData(v, level + 1) .. ',\n\t'
        end
        return s .. '} \n'
    else
        return tostring(var)
    end
end

function debug:dump(var)

    local _, type, res = pcall(function()
        return 'Type: ' .. type(var), dumpData(var, 1)
    end)

    log.info(type)
    log.info(res)

end

function debug:dd(var)
    debug:dump(var)
end

function debug:new()
    local obj = {}

    setmetatable(obj, self)

    self.__index = self;

    return obj
end

return debug