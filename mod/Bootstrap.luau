--!nocheck
local modID = geode.Mod.getID();
local function TClone(t)
    local newt = table.clone(t)
    newt = table.freeze(newt)
    return newt;
end
--// take C plus plus functions
local CPlusPlus = TClone(_G[modID] or {})
--//

local API = {
    ["Inited"] = true;
}

local modules = {
    ["casting"] = "./betterCasting.luau",
    ["Events"] = "./Events.luau",
    ["task"] = "./betterTask.luau",
    ["game"] = "./BetterGame.luau"
}

for i,v in pairs(modules) do
    local module = require(v);
    if (module.new) then
        API[i] = module.new(CPlusPlus, modID);
    elseif (module.init) then
        local keep = module.init(CPlusPlus, modID);
        if (not keep) then module.init = nil end
        API[i] = module
    else
        if type(module) == "function" then
             API[i] = module(CPlusPlus, modID)
        else
            API[i] = module
        end
    end
end
_G[modID] = API
--[[
local Tests = {
    ["casting"] = function(self : MenuLayer)
        local casting = API.casting.create()
        local SafeCast = casting.tonumber("NaN")
        local NaN = tonumber("NaN")
        if (NaN ~= NaN) then
            return SafeCast == nil
        else
            return true
        end
    end,
    ["UpdateNode"] = function(node : MenuLayer)
            local task = API.task.create(task)
            local attchment = true
            task.updateNode(node, .5, function(node)
                if (attchment) then 
                    print("Sucessful task.updateNode(node, .5, function) Is Working!") 
                    attchment = false;
                end
                local s,_r = pcall(function(...)
                    return node:isRunning()
                end)
                if (not s) then
                    error("task.updateNode(node,.5,function) is Leaking!")
                end
        end)
        return ""
    end,
    ["event"] = function(node : MenuLayer)
         API.Events.call("cosmella.test","Bombs!");
         return ""
    end
}

geode.hook("geode.gd.MenuLayer:init/0", {
        after = function(self : MenuLayer, arg1 : boolean)
        for i,v in pairs(Tests) do
            task.spawn(function()
                local sucess = v(self)
                if sucess == true then
                    print("Sucessful", i)
                else
                    if (sucess == false) then
                         error(i)
                    else
                        if (sucess ~= "") then
                            print(sucess)
                        end
                    end
                end
            end)
        end
        
        return arg1;
    end
})
]]