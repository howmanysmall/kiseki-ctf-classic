local Players = game:GetService("Players")
local Character = script.Parent

if Players:GetPlayerFromCharacter(Character) == nil then
	print("[Server] PersonScript has detected that the object, known as",Character.Name,"is not a valid Character")
	print("[Server] Disabling this script instance...")
	script.Disabled = true
end

local Player = Players:GetPlayerFromCharacter(Character)
local Status = Player:WaitForChild("Status")
local Backpack = Player:WaitForChild("Backpack")

local function updateBuffs()
	local buffs = Character.Buffs:GetChildren()
	local names = {}
	for i,v in ipairs(buffs) do
		table.insert(names, v.Name)
	end
	if (#names > 0) then
		Status.Text = "You are under the effect of:",Status.Text .. table.concat(names, ", ")
	else
		Status.Text = ""
	end
end

Character.Buffs.ChildAdded:connect(updateBuffs)
Character.Buffs.ChildRemoved:connect(updateBuffs)