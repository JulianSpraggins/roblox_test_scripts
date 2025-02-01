-- This is your first Roblox script! 🎮
-- We're going to make a part that changes colors when you touch it

-- First, let's get the part we want to change
local part = script.Parent -- This tells the script to control the part it's inside

-- This function will run when a player touches the part
local function onTouch()
	-- Pick a random color for the part
	local r = math.random() -- Random number for red
	local g = math.random() -- Random number for green
	local b = math.random() -- Random number for blue
	
	-- Change the part's color to our random color
	part.Color = Color3.new(r, g, b)
end

-- This tells the part to run our function when someone touches it
part.Touched:Connect(onTouch)
