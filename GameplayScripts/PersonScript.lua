-------------------------------------------------------------------------------------------------------------------------------------------
-- PersonScript
-- Scripted by Clockwork, Modified by shloid
-------------------------------------------------------------------------------------------------------------------------------------------

-- Variables
local Players = game:GetService("Players")
local Character = script.Parent
local Player = (Players:GetPlayerFromCharacter(Character) or nil)

-------------------------------------------------------------------------------------------------------------------------------------------
if Player == nil then 
	print("[Server] PersonScript has detected that the object, known as",Character.Name,"is not a valid Character")
	print("[Server] Disabling this script instance...")
	script.Disabled = true
end
-------------------------------------------------------------------------------------------------------------------------------------------

local Status = Player:WaitForChild("Status")
Status.Text = "Nothing."
local Backpack = Player:WaitForChild("Backpack")

-------------------------------------------------------------------------------------------------------------------------------------------
-- Master Function
-------------------------------------------------------------------------------------------------------------------------------------------

function updateBuffs()
	local buffs = Character.Buffs:GetChildren()
	local names = {}
	for i,v in ipairs(buffs) do
		table.insert(names, v.Name)
	end
	if (#names > 0) then
		Status.Text = table.concat(names, ", ")
	else
		Status.Text = "Nothing."
	end
end

Character.Buffs.ChildAdded:connect(updateBuffs)
Character.Buffs.ChildRemoved:connect(updateBuffs)
