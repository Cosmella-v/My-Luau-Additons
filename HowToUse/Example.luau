--[[
    You need CosmellaLuaAdditions.luau!
]]
local CosmellaLuaAdditions = require("./CosmellaLuaAdditions.luau")
--[[ 
local API = CosmellaLuaAdditions:getSynchronous(100) -- this version will block the thread until the timeout!

this will not block the thread when used
]]
CosmellaLuaAdditions:getAsync(100, function(API)
    --[[
        -- this adds game:HttpGet
        local game = API.task.create(game or {})
        -- this works like the roblox HttpGet which will block the thread until it finishes
        game:HttpGet(url, ReturnResponseObject)
    ]]
    
    --[[
        -- this adds task.updateNode
        local task = API.task.create(task or {})

        -- Node, Time, function(Node)
        task.updateNode(node, .5, function(node)

        end)
    ]]

    --[[
        -- this creates a casting 
        local casting = API.casting.create()
        currently has
        casting.tonumber(number, base) -- this replaces the return of NaN to nil instead of nan

        -- you can replace tonumber with the safe cast version
        local tonumber = casting.tonumber
    ]]

    --[[
        API.Events.call("cosmella.test","Bombs!"); -- this calls cosmella.test with Bombs! to c++
    ]]
end)