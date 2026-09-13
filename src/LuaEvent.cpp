#include <Geode/Geode.hpp>
#include <Geode/loader/Dispatch.hpp>
#include <Event.hpp>
#include "LuaEvent.hpp"
using namespace geode::prelude;


$on_mod(Loaded) {
    LuaEvent().listen([](std::string_view detail, std::string_view Extradetail) {
        log::debug("dispatched string to cpp, {} with {}", detail, Extradetail);
        DispatchCPlusPlusEvent(detail, Extradetail);
    }).leak();
}
