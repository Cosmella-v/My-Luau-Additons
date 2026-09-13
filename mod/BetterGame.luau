local module = {}
local Hidden = {}

module.init = function(CPP, MODID)
    Hidden.modID = MODID
    return false
end

module.create = function(Game, config)
        config = config or {}
        local function readConfig(id, defaultname)
            if config[id] then
                return config[id]
            end
            return defaultname
        end;
        local BGame = table.clone(Game)
        BGame[readConfig("BetterGame.HttpGet", "HttpGet")] = function(self, url, TotalResponse)
            local finished = false
            local result, err

            geode.utils.web.get(url, function(response, responseErr)
                if response then
                    result = TotalResponse and response or response:text()
                else
                    err = responseErr
                end
                finished = true
            end)

            repeat
                task.wait(1)
            until finished

            if err then
                error(err, 2)
            end

            return result
        end
        return BGame
    end
    
return module
