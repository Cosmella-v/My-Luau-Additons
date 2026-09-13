local module = {}
local Hidden = {}

module.init = function(CPP, MODID)
    Hidden.modID = MODID
    return false
end

module.create = function(Task, config)
        config = config or {}
        local function readConfig(id, defaultname)
            if config[id] then
                return config[id]
            end
            return defaultname
        end;
        local BTask = table.clone(Task)
        BTask[readConfig("BetterTask.updateNode","updateNode")] = function(Node : CCNode, delay, fun, ...)
            local newTask = nil :: TaskHandle?
            newTask = task.every(delay,function(...)
                local s,r = pcall(function(...)
                    Node:isRunning()
                    return true 
                end)
                if (s and r == true) then
                    fun(Node, ...)
                else
                    if (newTask) then
                        newTask:cancel()
                        newTask = nil
                    end
                end
            end, ...)
            return newTask
        end
        return BTask
    end
    
return module