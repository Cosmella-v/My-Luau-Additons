local modID = geode.Mod.getID();
local Event = _G[modID];
if (Event["dispatch_LUA"]) then
    -- event has dispatch_LUA
    local str = Event["dispatch_LUA"];
    local str2 = Event["dispatch_LUA2"];
    Event["dispatch_LUA"] = nil
    Event["dispatch_LUA2"] = nil
    return Event.Events._onCall(str, str2);
end