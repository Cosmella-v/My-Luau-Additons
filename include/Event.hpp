#pragma once
#include <Geode/Geode.hpp>
#include <Geode/loader/Dispatch.hpp>

class LuaEvent : public geode::GlobalEvent<LuaEvent, bool(std::string_view, std::string_view), bool> {
  public:
	using GlobalEvent::GlobalEvent;
};
