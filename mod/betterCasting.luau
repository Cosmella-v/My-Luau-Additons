local module = {}
local Hidden = {}

module.init = function(CPP, MODID)
    Hidden.modID = MODID
    return false
end

module.create = function()
    local unsafeToNumber = tonumber
    return {
        tonumber = function(...) : number?
            local normal = unsafeToNumber(...)
            if normal ~= normal then
                return nil --// number is NaN so return nil instead of NaN
            else
                return normal;
            end
        end
    }
end

return module