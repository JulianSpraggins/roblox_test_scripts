-- Load required services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

-- Overwrite chat function
local function sendMessage(message)
    local remote = ReplicatedStorage:WaitForChild("DefaultChatSystemChatEvents"):FindFirstChild("SayMessageRequest")
    if remote then
        remote:FireServer(message, "All")
    else
        warn("Chat Remote not found!")
    end
end

-- Use message bypass
local function bypassChat(message)
    local filteredMessage = string.gsub(message, "[%a%d]", function(c)
        return c .. "\204\128\141" -- Unicode trick to avoid filtering
    end)
    sendMessage(filteredMessage)
end