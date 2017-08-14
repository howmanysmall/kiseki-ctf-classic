----------------------------------------------------------------------------------------------------------------------------------------
-- Global System
-- Scripted by shloid
-- just to reitterate what i've said, I hate the legacy coding from Kiseki. 
-- it's very messy and ugly. so I had to rescript the GlobalSystem for
-- the "Shinobi Update".
----------------------------------------------------------------------------------------------------------------------------------------

-- Services
local Rep = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")


-- Variables
local _Gv2 = require(Rep:FindFirstChild("_Gv2"))

local ClassContainer = Lighting:WaitForChild("ClassContainer")
local WeaponContainer = Lighting:WaitForChild("WeaponContainer")
local DebugWeapons = Lighting:WaitForChild("DebugWeapons")
local PersonScript = Lighting:WaitForChild("PersonScript")

local guns = WeaponContainer:GetChildren()
local container = ClassContainer:GetChildren()
local implementedWeapons = {}
local classes = {
	["Butcher"] = true,
	["Barbarian"] = true,
	["Faerie Knight"] = true,
	["Apprentice"] = true,
	["Phantom"] = true,
	
	["Machinist"] = true,
	["Vampire"] = true,
	["Sensational Man"] = true,
	["Witch Doctor"] = true,
	
	["Wellwisher"] = true,
	["Tinkerer"] = true,
	["Shinobi"] = true,
	[""] = true,	
}

----------------------------------------------------------------------------------------------------------------------------------------
-- Functions / Methods
----------------------------------------------------------------------------------------------------------------------------------------

-- a list of implemented weapons
for i,v in pairs(WeaponContainer:GetChildren()) do
	table.insert(implementedWeapons, v.Name)
end

print("[Server] Implemented weapons: " .. table.concat(implementedWeapons, ", "))

function changeAppearance(play,char)
	for _,v in pairs(char:GetChildren()) do
		if v:IsA("Part") then
			v.BrickColor = BrickColor.new("Black")
			if v.Name == "Head" or v.Name == "Torso" then
				v.BrickColor = play.TeamColor
			end
		elseif v:IsA("Shirt") or v:IsA("Hat") or v:IsA("Accessory") then
				v:Destroy()
			elseif v:IsA("Pants") then
			if _Gv2.pantsGrid[v.PantsTemplate] == nil then
				v:Destroy()
			end
		end
	end
end

function setupClass(class,play,char,hum,tors,back,cvalue)
	if (class or play or char or hum or tors or back) == nil then return end
	if _Gv2.charGrid[class] == nil and class ~= "None" then return end
	
	-- variables
	local selClass = class
	if class == "None" then 
		local mdr = math.random(1,13)
		local selectedC = container[mdr].Name
		selClass = selectedC
		cvalue.Value = selClass
	end
	
	local cShirt = _Gv2.charGrid[selClass]
	local cWeapons = _Gv2.weaponGrid[selClass]
	local cContainer = ClassContainer:FindFirstChild(selClass)
	if cContainer == nil then return end
	
	if _Gv2.debug == false then
		--print("[GlobalSystem] Primary weapona for "..class.." : "..table.concat(cWeapons["SpawnWeapons"],", "))
		--print("[GlobalSystem] Available weapons for "..class.." : "..table.concat(cWeapons["Pool"], ", "))
	
		for i,v in pairs(WeaponContainer:GetChildren()) do
			if cWeapons["SpawnWeapons"][v.Name] ~= nil  then
				print("[GlobalSystem] Giving "..play.Name.." "..v.Name..".")
				_Gv2:GiveGun(play,v)
			end
		end
	else
		for i,v in pairs(DebugWeapons:GetChildren()) do
			v:Clone().Parent = back
		end
		for i,v in pairs(WeaponContainer:GetChildren()) do
			_Gv2:GiveGun(play,v)
		end
	end
	
	for i,v in ipairs(cContainer:GetChildren()) do
		if v:IsA("HopperBin") or v:IsA("Tool") then
			v:Clone().Parent = back
		elseif v.className == "Sound" then
			v:Clone().Parent = tors
		else
			v:Clone().Parent = char
		end
	end
	
	local newPScript = PersonScript:Clone()
	newPScript.Parent = char
	newPScript.Disabled = false
	
	if cContainer:FindFirstChild("WalkSpeed") then
		hum.WalkSpeed = cContainer:WaitForChild("WalkSpeed").Value
	end
	print("[GlobalSystem] Successfully implimented "..play.Name.."'s class: "..class)
end

function onPlayerRespawn(property,player)
	while player.Character == nil do wait(1) end
	if property == "Character" and player.Character ~= nil then
		print("[GlobalSystem] Setting up player.")
		
		-- Character
		local pChar = player.Character
		local pClass = player:FindFirstChild("Class") or nil
		local pTorso = pChar:WaitForChild("Torso")
		local pBackpack = player:WaitForChild("Backpack")
		local pHumanoid = pChar:WaitForChild("Humanoid")
		
		-- Instances
		local buffs = Instance.new("Model",pChar)
		buffs.Name = "Buffs"
		
		-- Master Function
		changeAppearance(player,pChar)
		if _Gv2.debug == true then
			pClass = Instance.new("StringValue",player)
			pClass.Name = "Class"
			pClass.Value = "Shinobi" -- this is just a default debug class because fuck it
			setupClass(pClass.Value,player,pChar,pHumanoid,pTorso,pBackpack,pClass)
		else
			if pClass ~= nil then
				setupClass(pClass.Value,player,pChar,pHumanoid,pTorso,pBackpack,pClass)
			else
				pClass = Instance.new("StringValue",player)
				pClass.Name = "Class"
				pClass.Value = "None"
				setupClass(pClass.Value,player,pChar,pHumanoid,pTorso,pBackpack,pClass)
			end
			
			-------------------------------------------------------------------------------------
			--[[
			if pChar:FindFirstChild("Pants") then
				local pPants = pChar:FindFirstChild("Pants")
				if _Gv2.pantsGrid[pPants.PantsTemplate] == nil then return end
					
				local personality = _Gv2.pantsGrid[pPants.PantsTemplate]
				print("[Server] Personality: ", personality)
				local properties = _Gv2.personalityGrid[personality]
				local pArmorMod = (pChar:FindFirstChild("ArmorMod") or nil)
				local pDamageMod = (pChar:FindFirstChild("DamageMod") or nil)
				if (pArmorMod or pDamageMod) == nil then return end
					
				pArmorMod.Value = pArmorMod.Value * (1 + properties[1] / 100.0)
				pDamageMod.Value = pDamageMod.Value * (1 + properties[2] / 100.0)
				pHumanoid.WalkSpeed = pHumanoid.WalkSpeed * (1 + properties[3] / 100.0)
					
				local bForce = Instance.new("BodyForce") 
				local gravityForce = 9.8 * 20 * 14 
				bForce.force = Vector3.new(0, properties[4] / 100.0 * gravityForce * .6, 0) 
				
				if pClass.Value == "Faerie Knight" then 
					local cap = .4 
					if bForce.force.y > gravityForce * cap then  
						bForce.force = Vector3.new(0, gravityForce * cap, 0) 
					end 
				end 
				
				if bForce.force.y ~= 0 then
					bForce.Parent = pTorso
				else
					bForce:Destroy()
				end
			end
			]]--
			-------------------------------------------------------------------------------------
		end
	end
end

Players.PlayerAdded:connect(function(player)
	local statusMsg = Instance.new("Hint",player)
	statusMsg.Name = "Status"
	statusMsg.Text = "Nothing."

	local ammoHud = Instance.new("Message",player)
	ammoHud.Name = "AmmoHUD"
	ammoHud.Text = ""
	
	local classValue = Instance.new("StringValue",player)
	classValue.Name = "Class"
	classValue.Value = "None"

	player.Changed:connect(function(property) onPlayerRespawn(property, player) end)
end)
