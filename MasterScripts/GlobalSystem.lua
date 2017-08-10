----------------------------------------------------------------------------------------------------------------------------------------
-- Global System Script for Kiseki CTF: Classic Edition
-- Created by Conix and Clockwork, Modified by shloid (da man!!!)
----------------------------------------------------------------------------------------------------------------------------------------

-- Services
local Services = {
	Players = game:GetService("Players"),
	Lighting = game:GetService("Lighting"),
	R_Storage = game:GetService("ReplicatedStorage"),	
}

local GVarModule = Services.R_Storage:WaitForChild("_Gv2")
local _Gv2 = require(GVarModule)

-- Variables
local implementedWeapons = {}
local class_weapons = {}
local shirtGrid,pantsGrid = _Gv2.shirtGrid,_Gv2.pantsGrid

----------------------------------------------------------------------------------------------------------------------------------------
-- Functions / Methods
----------------------------------------------------------------------------------------------------------------------------------------

function objContains(needle, haystack)
	for i,v in ipairs(haystack) do
		if string.lower(v) == string.lower(needle) then
			return true
		end
	end
	return false
end

-- a list of implemented weapons
for i,v in ipairs(Services.Lighting.WeaponContainer:children()) do
	table.insert(implementedWeapons, v.Name)
end

print("[Server] Implemented weapons: " .. table.concat(implementedWeapons, ", "))

-- remove weapons that aren't implemented
for class,weapons in pairs(_Gv2.weapon_grid) do
	for i,name in ipairs(weapons) do
		if objContains(name,implementedWeapons) then
			table.insert(class_weapons, name)
		end
	end
	_Gv2.weapon_grid[class] = class_weapons
end

Services.Players.PlayerAdded:connect(function(newPlayer)
	local statusMsg = Instance.new("Hint")
	statusMsg.Name = "Status"
	statusMsg.Text = "Nothing."
	statusMsg.Parent = newPlayer

	local ammoHud = Instance.new("Message")
	ammoHud.Name = "AmmoHUD"
	ammoHud.Text = "0/0"
	ammoHud.Parent = newPlayer

	newPlayer.Changed:connect(function(property) onPlayerRespawn(property, newPlayer) end)
end)

function onPlayerRespawn(property,player)
	while player.Character == nil do wait(1) end
	if property == "Character" and player.Character ~= nil then
		-- Variables
		local pChar = player.Character
		local pHumanoid = pChar:WaitForChild("Humanoid")
		local pBackpack = player:WaitForChild("Backpack")
		local pTorso = pChar:WaitForChild("Torso")
		
		local buffs = Instance.new("Model",pChar)
		buffs.Name = "Buffs"

		local class = nil
		
		-- Functions / Methods
		if _Gv2.debug == true then
			class = "Butcher" -- this is just a default debug class because fuck it
		else
			for i = 1, 10, 1 do
				wait(.5)
				if player.Character:FindFirstChild("Shirt Graphic") then print("[Server] Found Shirt Graphic!") break end
			end

			if not player.Character:FindFirstChild("Shirt Graphic") then
				class = Services.Lighting.ClassContainer:GetChildren()
				class = class[math.random(1,#class)].Name
				local pClassIdentifier = Instance.new("ShirtGraphic",pChar)
				--pClassIdentifier.Graphic = shirtGrid[class]
			else
				if shirtGrid[pChar["Shirt Graphic"].Graphic] == nil then  
					print("[Server] ..but sadly it's not the Shirt Graphic we're looking for :<")
				else
					print("Shirt:", player.Character["Shirt Graphic"].Graphic)
					class = shirtGrid[player.Character["Shirt Graphic"].Graphic]
				end
			end

			if class == "Sensation Man" then
				print("[Server] Sensation Shirt Detected")
				if not objContains(player.Name, _Gv2.sensational_man) then
					print("[Server] This boy is not sensational enough!")
					class = nil
				end
			end
			
			if class == "Sensation Man 2" then
				class = "Sensation Man"
			end
		end

		if class == nil then
			class = Services.Lighting.ClassContainer:GetChildren()
			class = class[math.random(1,13)].Name
		end
		
		local pClassIdentifier = Instance.new("ShirtGraphic",pChar)
		pClassIdentifier.Graphic = _Gv2.charGrid[class]
		
		class = Services.Lighting.ClassContainer:FindFirstChild(class)
		local guns = Services.Lighting.WeaponContainer:GetChildren()
		
		if _Gv2.debug == true then
			for i,v in pairs(Services.Lighting.DebugWeapons:GetChildren()) do
				v:Clone().Parent = player.Backpack
			end
			for i,v in ipairs(guns) do
				_Gv2:GiveGun(player,v)
			end
		else
			local class_weapons = _Gv2.weapon_grid[class.Name]
			if class_weapons then
				print("[Server] Primary weapon for", class.Name, ":",class_weapons[1])
				print("[Server] Available weapons for", class.Name, ":", table.concat(class_weapons, ", "))
				_Gv2:GiveGun(player, Services.Lighting.WeaponContainer:FindFirstChild(class_weapons[1]))
				if #class_weapons > 1 then
					local weapon_name = class_weapons[math.random(2, #class_weapons)]
					_Gv2:GiveGun(player, Services.Lighting.WeaponContainer:findFirstChild(weapon_name))
				end
			else
				print("[Server] No weapons found for class:", class.Name)
			end
		end

		local classTag = Instance.new("StringValue",pChar)
		classTag.Name = "Class"
		classTag.Value = class.Name

		if not class:FindFirstChild("PersonScript") then
			Services.Lighting.PersonScript:Clone().Parent = pChar
		end

		for i,v in ipairs(class:GetChildren()) do
			if v:IsA("HopperBin") or v:IsA("Tool") then
				v:Clone().Parent = pBackpack
			elseif v.className == "Sound" then
				v:Clone().Parent = pTorso
			else
				v:Clone().Parent = pChar
			end
			wait()
		end

		-- Changing player's apperance.
		for _,v in pairs(pChar:GetChildren()) do
			if v:IsA("Part") then
				v.BrickColor = BrickColor.new("Black")
				if v.Name == "Head" or v.Name == "Torso" then
					v.BrickColor = player.TeamColor
				end
			elseif v:IsA("Shirt") or v:IsA("Hat") or v:IsA("Accessory") then
				v:Destroy()
			elseif v:IsA("Pants") then
				if pantsGrid[v.PantsTemplate] == nil then
					v:Destroy()
				end
			end
		end

		-- Changing Player's Walkspeed.
		if class:FindFirstChild("WalkSpeed") then
			pChar.Humanoid.WalkSpeed = class.WalkSpeed.Value
		end

		wait(.1)
		
		-- Applying personality.
		if player.Character:FindFirstChild("Pants") then
			if pantsGrid[pChar.Pants.PantsTemplate] == nil then return end
			
			print("[Server] Pants:", pChar.Pants.PantsTemplate)
			local personality = pantsGrid[pChar.Pants.PantsTemplate]
			print("[Server] Personality: ", personality)
			
			if _Gv2.personality_grid[personality] then
				local properties = _Gv2.personality_grid[personality]
				
				local pArmorMod = pChar:FindFirstChild("ArmorMod")
				if pArmorMod == nil then repeat wait() until pChar:FindFirstChild("ArmorMod") end
				pArmorMod = pChar:FindFirstChild("ArmorMod")
				
				local pDamageMod = pChar:FindFirstChild("DamageMod")
				if pDamageMod == nil then repeat wait() until pChar:FindFirstChild("DamageMod") end
				pDamageMod = pChar:FindFirstChild("DamageMod")
				
				pArmorMod.Value = pArmorMod.Value * (1 + properties[1] / 100.0)
				pDamageMod.Value = pDamageMod.Value * (1 + properties[2] / 100.0)
				pHumanoid.WalkSpeed = pHumanoid.WalkSpeed * (1 + properties[3] / 100.0)

				local bForce = Instance.new("BodyForce") 
				local gravityForce = 9.8 * 20 * 14 
				bForce.force = Vector3.new(0, properties[4] / 100.0 * gravityForce * .6, 0) 
				if class.Name == "Faerie Knight" then 
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
		end
	end
end

workspace.ChildAdded:connect(function(child)
	if child.className == "Tool" or child.className == "Hat" then
		child:Destroy()
	end
end)
