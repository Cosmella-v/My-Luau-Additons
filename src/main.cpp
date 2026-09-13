#include <Geode/Geode.hpp>
#include <Geode/loader/ModEvent.hpp>
#include <imes.luauapi/include/LuauAPI.hpp>
#include "LuaEvent.hpp"

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


$on_mod(Loaded) {	
	LUAUAPI_REGISTER_OR_RETURN(lua::registerFunction("dispatchEvent", &DispatchLuaEvent));
	auto result = lua::runFile(Mod::get()->getResourcesDir(), "Bootstrap.luau");
	if (result.isErr()) {
		log::error("script failed: {}", result.unwrapErr());
	}
}
