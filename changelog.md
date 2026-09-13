# Changelog

## 1.0.0
- task.updateNode which is a task.every but wraps around a node
- casting.tonumber which makes casting.tonumber("NaN") return nil instead of NaN (fixes local a = tonumber("NaN") or 5 where it would give you NaN instead of 5)
- BetterGame:HttpGet(url) Just like roblox's luau one
- sending strings to c plus plus and vice visa using a small event system