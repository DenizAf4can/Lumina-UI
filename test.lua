local Lumina = require(game:GetService("ReplicatedStorage"):WaitForChild("LuminaUI"))
local Window = Lumina:New({ Name = "LuminaUI v3.1 | Full Demo" })

-- ============================================================================
-- TAB 1: SHOWCASE & CUSTOMIZATION
-- ============================================================================
local TabShowcase = Window:AddTab("Showcase")

-- Section 1: Props Customization (New Feature)
local SecProps = TabShowcase:AddSection("Customization (Props)", {ColSpan = 12})
SecProps:AddLabel("These elements use the 'Props' argument for custom styling overrides.")

-- Red Button with Custom Font
SecProps:AddButton("Custom Red Button", function() 
    print("Clicked Red Button") 
end, {
    BackgroundColor3 = Color3.fromRGB(255, 50, 50),
    Font = Enum.Font.Arcade,
    TextSize = 18
})

-- Massive Input with Custom Text Color
SecProps:AddInput("Massive Input", "big_input", "TYPE HERE", function(t) 
    print("Big Input:", t) 
end, {
    Size = UDim2.new(1, 0, 0, 50),
    TextSize = 24,
    TextColor3 = Color3.fromRGB(0, 255, 100),
    PlaceholderColor3 = Color3.fromRGB(0, 150, 50)
})

-- Section 2: Interactive Objects & Methods
local SecInteract = TabShowcase:AddSection("Object Control", {ColSpan = 6})
local Progress = SecInteract:AddProgressBar("Loading Task", "prog", 0)
local DynLabel = SecInteract:AddLabel("Status: Idle")

SecInteract:AddButton("Start Simulation", function()
    DynLabel:SetText("Status: Processing...")
    for i = 0, 100, 10 do
        Progress:Set(i)
        task.wait(0.1)
    end
    DynLabel:SetText("Status: Complete!")
    Progress:Set(100)
    task.wait(1)
    Progress:Set(0)
    DynLabel:SetText("Status: Idle")
end)

-- Section 3: Value Control
local SecControl = TabShowcase:AddSection("Value Manipulation", {ColSpan = 6})
local Slider = SecControl:AddSlider("Main Value", "val", 0, 100, 50, function(v) print("Val:", v) end)
SecControl:AddButton("Set to 100", function() Slider:SetValue(100) end)
SecControl:AddButton("Set to 0", function() Slider:SetValue(0) end)
SecControl:AddButton("Set to Random", function() Slider:SetValue(math.random(0,100)) end)


-- ============================================================================
-- TAB 2: ADVANCED INPUTS
-- ============================================================================
local TabAdv = Window:AddTab("Advanced")

local SecDrop = TabAdv:AddSection("Dropdown System", {ColSpan = 6})

-- Dynamic Dropdown Management
local DynamicDrop = SecDrop:AddDropdown("Dynamic List", "dyn_drop", {"Default Items"}, "Default Items", function(v) print("Selected:", v) end)

local InputItem = SecDrop:AddInput("Item Name", "add_item_txt", "Type item name...", function() end)

SecDrop:AddButton("Add Item", function() 
    local txt = Lumina.Flags["add_item_txt"]
    if txt and txt ~= "" then 
        DynamicDrop:AddItem(txt) 
        Lumina:Toast("Added: " .. txt, "success")
    end
end)

SecDrop:AddButton("Clear List", function() 
    DynamicDrop:Clear() 
    Lumina:Toast("List Cleared", "error")
end)

-- Multi & Search Dropdowns
local SecMulti = TabAdv:AddSection("Multi & Search", {ColSpan = 6})

-- Generating Large List for Search Demo
local BigList = {}
for i=1, 50 do table.insert(BigList, "Element #"..i) end

SecMulti:AddDropdown("Searchable (50 Items)", "search_drop", BigList, "Element #1", function(v) 
    print("Search Selection:", v) 
end)

SecMulti:AddDropdown("Multi-Select", "multi_drop", {"Option A", "Option B", "Option C", "Option D"}, {}, function(t) 
    print("Multi Selection:", table.concat(t, ", "))
end, true) -- 'true' enables Multi-Select


-- Section: Misc Inputs
local SecMisc = TabAdv:AddSection("Color & Keybinds", {ColSpan = 12})

SecMisc:AddColorPicker("Theme Accent", "accent", Color3.fromRGB(0, 120, 215), function(c) 
    print("New Color:", c)
    -- Visualizing the color change
    Lumina:Toast("Color Picked", "info")
end)

SecMisc:AddKeybind("Toggle UI Key", "bind", Enum.KeyCode.RightControl, function(k) 
    print("New Bind:", k.Name) 
end)


-- ============================================================================
-- TAB 3: DATA & LAYOUTS
-- ============================================================================
local TabData = Window:AddTab("Data & Grid")

local SecTable = TabData:AddSection("Interactive Table", {ColSpan = 12})
SecTable:AddParagraph("Advanced Tables", "Tables now support Buttons and Inputs as cells.")

SecTable:AddTable(
    {"User", "Role", "Actions", "Notes"}, -- Headers
    {
        {"Admin", "Owner", {Type="Button", Text="Message", Callback=function() print("Msg Admin") end}, "---"},
        {"Guest", "Visitor", {Type="Button", Text="Kick", Callback=function() print("Kick Guest") end}, "New"},
        {"Bot", "System", {Type="Input", Placeholder="Command...", OnChanged=function(t) print("Bot Cmd:", t) end}, "Auto"}
    }
)

local SecGrid = TabData:AddSection("Grid Layout Demo", {ColSpan = 12})
SecGrid:AddLabel("This tab demonstrates data views. The sections above use ColSpan logic.")
SecGrid:AddAccordion({
    {Title = "Grid System Info", Content = function(frame) 
        local l = Instance.new("TextLabel", frame)
        l.Size = UDim2.new(1,0,0,50)
        l.BackgroundTransparency=1
        l.TextColor3 = Color3.new(1,1,1)
        l.Text = "Lumina uses a 12-column grid system.\nColSpan=12 is full width.\nColSpan=6 is half width."
        l.TextSize=14
        l.Font=Enum.Font.Gotham
    end}
})


Lumina:Notify("Full Demo Loaded!", "success")
