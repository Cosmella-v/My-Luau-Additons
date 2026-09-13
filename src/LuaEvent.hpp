#include <Geode/Geode.hpp>
#include <Geode/loader/Dispatch.hpp>
#include <Geode/loader/ModEvent.hpp>
#include <imes.luauapi/include/LuauAPI.hpp>
#include <Event.hpp>


using namespace geode::prelude;
namespace lua = imes::luauapi;

#define LUAUAPI_REGISTER_OR_RETURN(expression)                                \
    do {                                                                      \
        auto result = (expression);                                           \
        if (result.isErr()) {                                                 \
            log::error("native registration failed: {}", result.unwrapErr()); \
            return;                                                           \
        }                                                                     \
    } while (false)

static std::string_view DispatchLuaEvent(std::string_view string, std::string_view extraData) {
    LuaEvent(0).send(string, extraData);
	return string;
};

static void DispatchCPlusPlusEvent(std::string_view string, std::string_view extraData) {
    LUAUAPI_REGISTER_OR_RETURN(lua::registerValue("dispatch_LUA", string));
    LUAUAPI_REGISTER_OR_RETURN(lua::registerValue("dispatch_LUA2", extraData));
    auto result = lua::runFile(Mod::get()->getResourcesDir(), "workAround.luau");
    if (result.isErr()) {
        log::error("Event failed to spawn: {}", result.unwrapErr());
    }
}

#undef LUAUAPI_REGISTER_OR_RETURN