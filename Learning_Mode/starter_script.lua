-- This is your name detector script! 🎮
-- Put this in a Script object inside ServerScriptService

game.Players.PlayerAdded:Connect(function(player)
    -- This runs when a player joins
    local playerName = player.Name:lower()  -- Get your name in lowercase
    
    player.Chatted:Connect(function(message)
        -- This runs when the player chats
        
        -- Check if your name is mentioned anywhere in the message
        if message:lower():find(playerName) then
            -- When someone mentions your name, make a message appear!
            local character = player.Character
            if character then
                local head = character:WaitForChild("Head")
                local floatingText = Instance.new("BillboardGui")
                local textLabel = Instance.new("TextLabel")
                
                floatingText.Parent = head
                floatingText.Size = UDim2.new(0, 100, 0, 50)
                floatingText.StudsOffset = Vector3.new(0, 3, 0)  -- Float above head
                
                textLabel.Parent = floatingText
                textLabel.Size = UDim2.new(1, 0, 1, 0)
                textLabel.Text = "😎 Someone mentioned me!"
                textLabel.TextScaled = true
                textLabel.BackgroundTransparency = 1
                
                -- Make the message disappear after 3 seconds
                wait(3)
                floatingText:Destroy()
            end
        end
    end)
end)
