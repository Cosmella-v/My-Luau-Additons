--[[
    This file is the file used to require the module,
    either use getAsync or getSynchronous to require it
]]

local module = {
    modID = "cosmella.myluauadditions",
    baseTimeout = 100
}

function module:get(async, ...)
    if async then
        return module:getAsync(...)
    else
        return module:getSynchronous(...)
    end
end

function module:getSynchronous(timeout)
    timeout = timeout or module.baseTimeout
    local tries = 0
    local api = nil
    repeat
        tries += 1
        task.wait(1)
        local mod = _G[module.modID]
        if mod and mod["Inited"] then
            api = mod
        end
    until tries > timeout or api
    if (api) then
        return api
    else
        error("timed out waiting for " .. module.modID)
    end
end
--[[
Based on https://github.com/ItMe12s/LuauAPI/blob/master/docs/reference/lua/sharing-apis.md#handling-load-order
]]
function module:getAsync(timeout, callback)
    timeout = timeout or module.baseTimeout
    local api = _G[module.modID]
    local handle
    local tries = 0
    if api then
        if api["Inited"] then
            callback(api)
        else
            handle = task.every(0.1, function()
                tries += 1
                if tries >= timeout then
                    handle:cancel()
                    error("timed out waiting for " .. module.modID)
                end
                 if _G[module.modID]["Inited"] then
                    handle:cancel()
                    return callback(api)
                 end
            end)
        end
        return
    end
    handle = task.every(0.1, function()
        tries += 1
        if tries >= timeout then
            handle:cancel()
            error("timed out waiting for " .. module.modID)
        end
        local found = _G[module.modID]
        if found then
            tries = 0
            if found["Inited"] then
                handle:cancel()
                callback(found)
            end
        end
    end)
end

return module

