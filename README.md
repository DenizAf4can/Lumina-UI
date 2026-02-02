# LuminaUI v3.1 - Complete Usage Guide

LuminaUI is a modern, modular UI library for Roblox, featuring a grid system, glassmorphism design, and full customization via Props.

## 1. Initialization
```lua
local Lumina = require(path.to.LuminaUI)

local Window = Lumina:New({
    Name = "My Hub | v3.1",
    Config = {
        Theme = Lumina.Themes.Midnight, -- or .Serenity, .Ocean
        OpenKey = Enum.KeyCode.RightControl
    }
})
```

## 2. Structure
The hierarchy is: **Window -> Tab -> Section -> Elements**.

```lua
local Tab = Window:AddTab("Main")
local Section = Tab:AddSection("Player Settings", {ColSpan = 6}) -- Width: 6/12
```

## 3. Adding Elements
All elements support a final optional argument `{Props}` to override visual properties (Size, Color, TextSize, etc.).

### Basic Elements
```lua
-- Label
local lbl = Section:AddLabel("Welcome User", {TextSize = 18, TextColor3 = Color3.new(1,0,0)})
lbl:SetText("New Text")

-- Button
local btn = Section:AddButton("Click Me", function()
    print("Clicked!")
end, {BackgroundColor3 = Color3.fromRGB(0, 170, 255)}) -- Custom Color

-- Toggle
Section:AddToggle("Infinite Health", "godmode", false, function(state)
    print("Godmode:", state)
end)

-- Slider
Section:AddSlider("WalkSpeed", "ws", 16, 100, 16, function(val)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = val
end)
```

### Advanced Elements
```lua
-- Dropdown (Single, Multi, Search)
-- AddDropdown(Text, Flag, List, Default, Callback, Multi, Props)
local drop = Section:AddDropdown("Weapons", "wep", {"AK47", "M4A1", "AWP"}, "AK47", function(v)
    print(v)
end, false)

drop:AddItem("Deagle") -- Dynamic Management

-- Multi-Select
Section:AddDropdown("Mods", "mods", {"Aimbot", "ESP", "Tracer"}, {}, function(t) end, true)

-- Input
Section:AddInput("Webhook", "link", "https://discord...", function(text) end)

-- Color Picker
Section:AddColorPicker("Accent", "col", Color3.new(1,1,1), function(c) end)

-- Keybind
Section:AddKeybind("Toggle Menu", "bind", Enum.KeyCode.RightControl, function(k) end)
```

## 4. Customization (Props)
You can pass a standard Roblox property table as the last argument to any element to customize its main visual frame/button.

```lua
Section:AddButton("Stylish Button", func, {
    BackgroundColor3 = Color3.fromRGB(255, 0, 100),
    Font = Enum.Font.Arcade,
    TextSize = 20
})
```

## 5. Object Control (Methods)
Most elements return a control object:
*   **All**: `:SetValue(val)`, `:GetValue()`
*   **Label/Button**: `:SetText(txt)`
*   **Dropdown**: `:AddItem(x)`, `:RemoveItem(x)`, `:Clear()`
*   **ProgressBar**: `:Set(0-100)`
*   **Table**: Dynamic cell updates via configuration.

## 6. Grid System
Sections automatically arrange themselves. Use `ColSpan` (1-12) to control width.
*   **12**: Full Width
*   **6**: Half Width (2 per row)
*   **4**: Third Width (3 per row)

```lua
Tab:AddSection("Left", {ColSpan = 6})
Tab:AddSection("Right", {ColSpan = 6})
```

## 7. Data Views
### Tables
Supports interactive cells (Buttons/Inputs).
```lua
Section:AddTable(
    {"User", "Action", "Value"}, -- Headers
    {
        {"Player1", {Type="Button", Text="Kick", Callback=kickFunc}, "100"},
        {"Player2", {Type="Input", Placeholder="Reason", OnChanged=func}, "50"}
    }
)
```
