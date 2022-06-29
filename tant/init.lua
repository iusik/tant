local app = {
    namespace = ""
}

local function reloadPackages(namespace)
    for module_name, _ in pairs(package.loaded) do
        -- reload all tant files
        if
        string.find(module_name, "^tant") or
                string.find(module_name, "^" .. namespace)
        then
            print(module_name)
            package.loaded[module_name] = nil
        end

    end
end

function app:reload()
    reloadPackages(self.namespace)
end

function app:include(name)
    local module = require(self.namespace .. '.' .. name)

    return module
end

function app:new(t)
    local instance = t or {}
    setmetatable(instance, self)

    self.__index = self

    return instance
end

return app