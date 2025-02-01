-- Caesar Cipher for Roblox (Executor Version)
local function caesar_cipher(s, shift)
    if type(s) ~= "string" then
        error("First argument must be a string")
    end
    if type(shift) ~= "number" then
        error("Second argument must be a number")
    end

    shift = shift % 26
    local result = ''

    for i = 1, #s do
        local charCode = string.byte(s:sub(i,i))

        if (charCode >= 97 and charCode <= 122) then
            local shiftedCharCode = (charCode - 97 + shift) % 26 + 97
            result = result .. string.char(shiftedCharCode)
        elseif (charCode >= 65 and charCode <= 90) then
            local shiftedCharCode = (charCode - 65 + shift) % 26 + 65
            result = result .. string.char(shiftedCharCode)
        else
            result = result .. string.sub(s, i, i)
        end
    end

    return result
end

-- Character mapping tables for different styles
local style1_map = {
    a = "Α", b = "Β", c = "С", d = "Đ", e = "Ε", f = "Ƒ", g = "Ĝ", h = "Ή", i = "İ",
    j = "Ј", k = "Κ", l = "Ĺ", m = "Μ", n = "Ν", o = "Ø", p = "Ρ", q = "Ꝗ", r = "Ř",
    s = "Š", t = "Τ", u = "Џ", v = "Ṿ", w = "Ш", x = "Χ", y = "Ύ", z = "Ζ"
}

local style2_map = {
    a = "α", b = "β", c = "¢", d = "∂", e = "є", f = "ƒ", g = "g", h = "н", i = "ι",
    j = "נ", k = "к", l = "ℓ", m = "м", n = "η", o = "σ", p = "ρ", q = "q", r = "я",
    s = "$", t = "т", u = "υ", v = "ν", w = "ω", x = "χ", y = "γ", z = "z"
}

local style3_map = {
    a = "ᗩ", b = "ᗷ", c = "ᑕ", d = "ᗪ", e = "E", f = "ᖴ", g = "G", h = "ᕼ", i = "I",
    j = "ᒍ", k = "K", l = "ᒪ", m = "ᗰ", n = "ᑎ", o = "O", p = "ᑭ", q = "ᑫ", r = "ᖇ",
    s = "ᔕ", t = "T", u = "ᑌ", v = "ᐯ", w = "ᗯ", x = "᙭", y = "Y", z = "ᘔ"
}

local style4_map = {
    a = "卂", b = "乃", c = "匚", d = "ᗪ", e = "乇", f = "千", g = "Ꮆ", h = "卄", i = "丨",
    j = "ﾌ", k = "Ҝ", l = "ㄥ", m = "爪", n = "几", o = "ㄖ", p = "卩", q = "Ɋ", r = "尺",
    s = "丂", t = "ㄒ", u = "ㄩ", v = "ᐯ", w = "山", x = "乂", y = "ㄚ", z = "乙"
}

local style5_map = {
    a = "𝔞", b = "𝔟", c = "𝔠", d = "𝔡", e = "𝔢", f = "𝔣", g = "𝔤", h = "𝔥", i = "𝔦",
    j = "𝔧", k = "𝔨", l = "𝔩", m = "𝔪", n = "𝔫", o = "𝔬", p = "𝔭", q = "𝔮", r = "𝔯",
    s = "𝔰", t = "𝔱", u = "𝔲", v = "𝔳", w = "𝔴", x = "𝔵", y = "𝔶", z = "𝔷"
}

-- Function to transform text using specified style
local function transformText(text, style)
    local style_maps = {
        style1_map,
        style2_map,
        style3_map,
        style4_map,
        style5_map
    }

    local map = style_maps[style] or style1_map
    local result = ""
    text = text:lower()

    for i = 1, #text do
        local char = text:sub(i,i)
        result = result .. (map[char] or char)
    end

    return result
end

-- Create simple UI using Roblox Instance API
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TextStylerGui"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Try different parent locations depending on context
local success, error = pcall(function()
    screenGui.Parent = game:GetService("CoreGui")
end)

if not success then
    local player = game:GetService("Players").LocalPlayer
    if player then
        screenGui.Parent = player:WaitForChild("PlayerGui")
    else
        warn("Could not find appropriate parent for ScreenGui")
    end
end

-- Create UICorner instance for reuse
local function createCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(radius or 0.1, 0)
    corner.Parent = parent
    return corner
end

-- Create gradient for reuse
local function createGradient(parent, color1, color2)
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, color1),
        ColorSequenceKeypoint.new(1, color2)
    })
    gradient.Rotation = 45
    gradient.Parent = parent
    return gradient
end

-- Main frame with enhanced modern styling
local frame = Instance.new("Frame")
frame.Name = "MainFrame"
frame.Size = UDim2.new(0, 400, 0, 500)
frame.Position = UDim2.new(0.5, -200, 0.5, -250)
frame.BackgroundColor3 = Color3.fromRGB(26, 27, 30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
createCorner(frame, 0.03)
frame.Parent = screenGui

-- Enhanced shadow
local shadow = Instance.new("ImageLabel")
shadow.Name = "Shadow"
shadow.AnchorPoint = Vector2.new(0.5, 0.5)
shadow.BackgroundTransparency = 1
shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
shadow.Size = UDim2.new(1, 40, 1, 40)
shadow.ZIndex = -1
shadow.Image = "rbxassetid://5554236805"
shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
shadow.ImageTransparency = 0.5
shadow.Parent = frame

-- Enhanced title with gradient
local titleContainer = Instance.new("Frame")
titleContainer.Size = UDim2.new(1, 0, 0.15, 0)
titleContainer.Position = UDim2.new(0, 0, 0, 0)
titleContainer.BackgroundColor3 = Color3.fromRGB(32, 34, 37)
titleContainer.BorderSizePixel = 0
titleContainer.Parent = frame

local titleGradient = createGradient(titleContainer,
    Color3.fromRGB(32, 34, 37),
    Color3.fromRGB(26, 27, 30)
)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0.9, 0, 0.8, 0)
title.Position = UDim2.new(0.05, 0, 0.1, 0)
title.BackgroundTransparency = 1
title.Text = "Text Styler"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 28
title.Font = Enum.Font.GothamBold
title.Parent = titleContainer

-- Enhanced input box
local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(0.9, 0, 0.15, 0)
textBox.Position = UDim2.new(0.05, 0, 0.2, 0)
textBox.Text = ""
textBox.PlaceholderText = "Enter your text here..."
textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox.PlaceholderColor3 = Color3.fromRGB(128, 132, 142)
textBox.BackgroundColor3 = Color3.fromRGB(47, 49, 54)
textBox.Font = Enum.Font.GothamSemibold
textBox.TextSize = 20
textBox.ClearTextOnFocus = true
createCorner(textBox, 0.1)
textBox.Parent = frame

-- Style button with enhanced gradient
local styleButton = Instance.new("TextButton")
styleButton.Size = UDim2.new(0.9, 0, 0.12, 0)
styleButton.Position = UDim2.new(0.05, 0, 0.4, 0)
styleButton.Text = "Style 1"
styleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
styleButton.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
styleButton.Font = Enum.Font.GothamBold
styleButton.TextSize = 20
createCorner(styleButton, 0.15)
createGradient(styleButton,
    Color3.fromRGB(88, 101, 242),
    Color3.fromRGB(73, 84, 201)
)
styleButton.Parent = frame

-- Enhanced result box
local resultBox = Instance.new("TextBox")
resultBox.Size = UDim2.new(0.9, 0, 0.15, 0)
resultBox.Position = UDim2.new(0.05, 0, 0.57, 0)
resultBox.Text = ""
resultBox.TextColor3 = Color3.fromRGB(255, 255, 255)
resultBox.BackgroundColor3 = Color3.fromRGB(47, 49, 54)
resultBox.Font = Enum.Font.GothamSemibold
resultBox.TextSize = 20
resultBox.TextEditable = false
resultBox.ClearTextOnFocus = false
createCorner(resultBox, 0.1)
resultBox.Parent = frame

-- Enhanced chat button with gradient
local chatButton = Instance.new("TextButton")
chatButton.Size = UDim2.new(0.9, 0, 0.12, 0)
chatButton.Position = UDim2.new(0.05, 0, 0.77, 0)
chatButton.Text = "Send to Chat"
chatButton.TextColor3 = Color3.fromRGB(255, 255, 255)
chatButton.BackgroundColor3 = Color3.fromRGB(67, 181, 129)
chatButton.Font = Enum.Font.GothamBold
chatButton.TextSize = 20
createCorner(chatButton, 0.15)
createGradient(chatButton,
    Color3.fromRGB(67, 181, 129),
    Color3.fromRGB(56, 158, 112)
)
chatButton.Parent = frame

-- Enhanced preview labels
local function createStylePreview(text, yPos)
    local preview = Instance.new("TextLabel")
    preview.Size = UDim2.new(0.9, 0, 0.06, 0)
    preview.Position = UDim2.new(0.05, 0, yPos, 0)
    preview.BackgroundTransparency = 1
    preview.Text = text
    preview.TextColor3 = Color3.fromRGB(185, 187, 190)
    preview.TextSize = 16
    preview.Font = Enum.Font.GothamMedium
    preview.Parent = frame
    return preview
end

local stylePreview1 = createStylePreview("Preview 1: " .. transformText("Sample Text", 1), 0.92)
local stylePreview2 = createStylePreview("Preview 2: " .. transformText("Sample Text", 2), 0.96)

-- Enhanced hover effects
local function addEnhancedHoverEffect(button)
    local originalColor = button.BackgroundColor3
    local hoverColor = Color3.new(
        math.min(originalColor.R * 1.1, 1),
        math.min(originalColor.G * 1.1, 1),
        math.min(originalColor.B * 1.1, 1)
    )

    button.MouseEnter:Connect(function()
        game:GetService("TweenService"):Create(button, TweenInfo.new(0.3), {
            BackgroundColor3 = hoverColor
        }):Play()
    end)

    button.MouseLeave:Connect(function()
        game:GetService("TweenService"):Create(button, TweenInfo.new(0.3), {
            BackgroundColor3 = originalColor
        }):Play()
    end)

    -- Add click animation
    button.MouseButton1Down:Connect(function()
        game:GetService("TweenService"):Create(button, TweenInfo.new(0.1), {
            Size = UDim2.new(button.Size.X.Scale * 0.95, 0, button.Size.Y.Scale * 0.95, 0)
        }):Play()
    end)

    button.MouseButton1Up:Connect(function()
        game:GetService("TweenService"):Create(button, TweenInfo.new(0.1), {
            Size = UDim2.new(button.Size.X.Scale / 0.95, 0, button.Size.Y.Scale / 0.95, 0)
        }):Play()
    end)
end

addEnhancedHoverEffect(styleButton)
addEnhancedHoverEffect(chatButton)

-- Current style tracking
local currentStyle = 1
local totalStyles = 5  -- Updated to match new number of styles

-- Add functionality
styleButton.MouseButton1Click:Connect(function()
    currentStyle = (currentStyle % totalStyles) + 1
    styleButton.Text = "Style " .. currentStyle
    resultBox.Text = transformText(textBox.Text, currentStyle)

    -- Update previews
    stylePreview1.Text = "Preview " .. ((currentStyle % totalStyles) + 1) .. ": " .. transformText("Sample Text", (currentStyle % totalStyles) + 1)
    stylePreview2.Text = "Preview " .. ((currentStyle + 1) % totalStyles + 1) .. ": " .. transformText("Sample Text", (currentStyle + 1) % totalStyles + 1)
end)

textBox:GetPropertyChangedSignal("Text"):Connect(function()
    resultBox.Text = transformText(textBox.Text, currentStyle)
end)

-- Function to send message to chat (simplified version)
local function sendToChat(message)
    local success = pcall(function()
        -- Method 1: Using StarterGui:SetCore
        game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
            Text = message,
            Color = Color3.fromRGB(255, 255, 255),
            Font = Enum.Font.SourceSansBold,
            TextSize = 18
        })
    end)

    if not success then
        -- Method 2: Using TextChatService
        pcall(function()
            game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(message)
        end)
    end
end

-- Add chat button functionality
chatButton.MouseButton1Click:Connect(function()
    if resultBox.Text ~= "" then
        sendToChat(resultBox.Text)
    end
end)

-- Add dragging functionality
local UserInputService = game:GetService("UserInputService")
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Alternative chat method
local function sendToChat2(message)
    local replicatedStorage = game:GetService("ReplicatedStorage")
    local chatRemote = replicatedStorage:FindFirstChild("SayMessageRequest", true)

    if chatRemote then
        chatRemote:FireServer(message, "All")
    else
        warn("Could not find chat remote")
    end
end