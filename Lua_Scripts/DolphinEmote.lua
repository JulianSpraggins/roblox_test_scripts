-- Service imports
local Players = game:GetService("Players")
local Vector3 = Vector3
local CFrame = CFrame
local task = task

-- Configuration settings
local FORCED_EMOTE = "wave"    -- The emote to use (e.g., "sit", "dance")
local DESTINATION = CFrame.new(0, 100, 0)  -- Destination point along Y-axis
local EMOTE_DURATION = 2         -- Time in seconds for the emote effect

-- Main functions
local function teleportPlayer(player)
    local character = player.Character or player.CharacterAdded:Wait()
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    
    if rootPart then
        print(player.Name, "teleported to destination")  -- Prints in console
        rootPart.CFrame = DESTINATION + Vector3.new(0, 5, 0)  -- Moves the main part
    end
end

local function forceEmoteAndTeleport(player)
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    
    if humanoid:PlayEmote(FORCED_EMOTE) then  -- Play the emote
        task.wait(EMOTE_DURATION)               -- Wait before teleporting
        teleportPlayer(player)
    else
        warn(player.Name, "Failed to play emote")  -- Warns in console
    end
end

-- Trigger setup when new player joins
Players.PlayerAdded:Connect(function(player)
    forceEmoteAndTeleport(player)             -- Play and teleport the emote
    if player.Character then                 -- If there's a character already
        forceEmoteAndTeleport(player)         -- Teleport it again?
    end
end)

-- Alternative touch trigger (uncomment to test)
--[[
local triggerPart = workspace.TeleportPad
triggerPart.Touched:Connect(function(hit)
    local player = Players:GetPlayerFromCharacter(hit.Parent)
    if player then
        forceEmoteAndTeleport(player)  -- Play and teleport the emote
    end
end)
]]
