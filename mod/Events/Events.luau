--!nocheck
local module = {}
local hidden = {
    Hooks = {};
}

module.init = function(CPP, MODID)
    hidden.modID = MODID
    hidden.CPP = CPP
    return false
end

module.call = function(details : string, extraDetail : string)
    extraDetail = extraDetail or ""
    details = hidden.CPP.dispatchEvent(details, extraDetail);
    return details
end

module._onCall = function(details : string, extraDetail : string)
    extraDetail = extraDetail or ""
    if not hidden.Hooks then hidden.Hooks = {} end
    for i,v in pairs(hidden.Hooks) do
        if (v.Callback) then v.Callback(details, extraDetail) end
    end
end

function module.create(callback)
    local hook = {}

    hook.Callback = callback
    hook.Connected = true

    table.insert(hidden.Hooks, hook)

    function hook:Disconnect()
        if not self.Connected then
            return
        end

        self.Connected = false

        local index = table.find(hidden.Hooks, self)
        if index then
            table.remove(hidden.Hooks, index)
        end
    end


    return hook
end
return module