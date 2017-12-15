-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Global Module v2.0
-- Created by shloid (da man!!!)
-------------------------------------------------------------------------------------------------------------------------------------------------------------

local Services = {
	Debris = game:GetService("Debris"),
	Players = game:GetService("Players"),
	Lighting = game:GetService("Lighting"),
	ContentProvider = game:GetService("ContentProvider")
}

local RbxAssetId = "rbxassetid://"

local Gv2 = {
	debug = false,
	DemonPeople = {
		["Vampire"] = true, 
		["Golem"] = true, 
		["Warlock"] = true, 
		["Butcher"] = true, 
		["Phantom"] = true, 
		["Nightmare"] = true, 
		["Morphling"] = true,
	},
	
	weaponGrid = {
		--[[ 
			SpawnWeapons - weapons that are given to the player when they spawn
			Pool - weapons that are available to the class
			
			example:
			["Barbarian"] = {
				["SpawnWeapons"] = {
					["Spas-12"] = true, 
					["HK5"] = true,
				},
			 
				["Pool"] = {
					["Deagles"] = true, 
					["AK-74"] = true, 
					["Socom"] = true, 
					["M79"] = true, 
					["Throwing Knives"] = true,
				}
			},
		]]--
		["Barbarian"] = {
			["SpawnWeapons"] = {
				["Spas-12"] = true, 
				["HK5"] = true,
			},
			 
			["Pool"] = {
				["Deagles"] = true, 
				["AK-74"] = true, 
				["Socom"] = true, 
				["M79"] = true, 
				["Throwing Knives"] = true,
			}
		},
		
		["Phantom"] = {
			["SpawnWeapons"] = {
				["Ruger"] = true, 
				["HK5"] = true,  
			},
			
			["Pool"] = {
				["Spas-12"] = true, 
				["Deagles"] = true,  
				["Steyr AUG"] = true,  
				["M-15"] = true, 
				["Socom"] = true, 
				["Throwing Knives"] = true, 
			}
		},
		
		["Tinkerer"] = {			
			["SpawnWeapons"] = {
				["AK-74"] = true,
				["Socom"] = true,
			},			
			
			["Pool"] = {
				["Spas-12"] = true,  
				["Deagles"] = true,  
				["Steyr AUG"] = true,  
				["Ruger"] = true, 
				["M-15"] = true,   
				["M79"] = true,   
				["HK5"] = true,  
				["Barrett"] = true,  
				["LAW"] = true,
			} 
		},
		
		["Wellwisher"] = {
			["SpawnWeapons"] = {
				["Steyr AUG"] = true,  
				["HK5"] = true, 
			},
			
			
			["Pool"] = {
				["Socom"] = true, 
				["AK-74"] = true,
				["Ruger"] = true,
				["M-15"] = true, 
				["Barrett"] = true,
			}  
		},	
		
		["Faerie Knight"] = {
			["SpawnWeapons"] = {
				["Steyr AUG"] = true,
				["Socom"] = true,
			},		
			
			["Pool"] = {	
				["Ruger"] = true, 
				["Deagles"] = true, 
				["AK-74"] = true,
				["M-15"] = true, 
				["Barrett"] = true,  
				["Throwing Knives"] = true,
			}
		},
		
		["Butcher"] = {
			["SpawnWeapons"] = {
				["Chainsaw"] = true,
			},
			
			["Pool"] = { }
		},
		
		["Machinist"] = {
			["SpawnWeapons"] = {
				["AK-74"] = true,
				["Spas-12"] = true,
			},
			
			["Pool"] = {
				["HK5"] = true,
				["Deagles"] = true, 
				["Steyr AUG"] = true,
				["Ruger"] = true,
				["M-15"] = true,
				["Socom"] = true,  
				["M79"] = true,
				["Barrett"] = true,  
				["LAW"] = true, 
			}
		},
		
		["Exorcist"] = {
			["SpawnWeapons"] = {
				["Barrett"] = true, 
				["HK5"] = true, 
			},
			
			["Pool"] = {
				["Spas-12"] = true,
				["Deagles"] = true, 
				["Ruger"] = true,
				["M-15"] = true,
				["Socom"] = true,
				["Throwing Knives"] = true,
			}
		},
		
		["Apprentice"] = {
			["SpawnWeapons"] = {
				["Steyr AUG"] = true,
				["Socom"] = true,
			},
			

			["Pool"] = {	
				["HK5"] = true,
				["Deagles"] = true, 
				["AK-74"] = true,
				["M-15"] = true,  
				["M79"] = true,
			}
		},
		
		["Witch Doctor"] =  {
			["SpawnWeapons"] = {
				["Steyr AUG"] = true,
				["Socom"] = true,
			},
			
			["Pool"] = {
				["AK-74"] = true,
				["Barrett"] = true,  
				["Spas-12"] = true,
				["Ruger"] = true,
			}
		},
		
		["Sensational Man"] = {			
			["SpawnWeapons"] = {
				["Chainsaw"] = true,
				["LAW"] = true, 
			},
			
			["Pool"] = { }			
		},
		
		["Shinobi"] = {
			["SpawnWeapons"] = {
				["HK5"] = true, 
			},
			
			["Pool"] = { }
		},
		
		["Vampire"] = {
			["SpawnWeapons"] = {
				["Ruger"] = true,
				["HK5"] = true, 
			},
			
			["Pool"] = {
				["Deagles"] = true,   
				["M79"] = true,
				["Throwing Knives"] = true,
				["AK-74"] = true,
				["Spas-12"] = true,
			}
		},
	},
	
	personalityGrid = {
		["Adamant"] = { -10, 0, -10, 0 },   
		["Affable"] = { -10, -20, 10, 0 },  
		["Bashful"] = { -3, 3, 3, 3 },
		["Bold"] = { 20, 20, 0, 10 },   
		["Brave"] = { -25, 10, -10, -15 },   
		["Bulky"] = { -30, 50, -50, -60 },  
		["Calm"] = { -10, 0, -20, 10 },   
		["Careful"] = { -15, 5, 10, -30 },   
		["Docile"] = { 10, -10, 10, 10 }, 
		["Gentle"] = { -40, -30, 0, 0 }, 
		["Hardy"] = { -20, -20, -10, 20 },   
		["Hasty"] = { 30, -20, 80, -15 }, 
		["Impish"] = { 20, -10, 10, 10 },  
		["Jolly"] = { 40, 20, 0, 80 },
		["Lax"] = { 20, 10, 0, 10 },
		["Lonely"] = { -15, -20, 20, -5 },   
		["Mild"] = { -20, 0, -10, 0 },
		["Modest"] = { -10, -5, 15, -20 },   
		["Naive"] = { 30, 30, 15, -20 },
		["Naughty"] = { 15, 10, 20, -10 },   
		["Quiet"] = { 5, 15, 15, -30 },
		["Quirky"] = { -10, -10, -10, 20 },   
		["Rash"] = { 40, 25, 40, -95 },
		["Relaxed"] = { -40, 0, -30, -30 },   
		["Sassy"] = { 0, 20, -25, -10 },
		["Serious"] = { 10, 0, 15, 15 },  
		["Timid"] = { 15, 5, 0, 15 },
	},
	
	charGrid = {
		-- offensive classes: butcher, barbarian, faerie knight, apprentice, pyromaniac
		-- defensive classes: machinist, vampire, sensational man, witch doctor, golem
		-- supportive classes: wellwisher, tinkerer, shinobi, exorcist, phantom
		["Phantom"] = RbxAssetId .. "2729205", 
		["Barbarian"] = RbxAssetId .. "2729207", 
		["Wellwisher"] = RbxAssetId .. "2729212", 
		["Tinkerer"] = RbxAssetId .. "2729217",
		["Faerie Knight"] = RbxAssetId .. "2749266",
		["Butcher"] = RbxAssetId .. "2749268", 
		["Machinist"] = RbxAssetId .. "2749263", 
		["Exorcist"] = RbxAssetId .. "2801405", 
		["Apprentice"] = RbxAssetId .. "2801397", 
		["Witch Doctor"] = RbxAssetId .. "2902054", 
		["Sensational Man"] = RbxAssetId .. "4843677", 
		["Vampire"] = RbxAssetId .. "6334561",
		["Shinobi"] = RbxAssetId .. "6334559",
	},
	
	pantsGrid = {
		[RbxAssetId .. "3894762"] = "Adamant",
		[RbxAssetId .. "3894764"] = "Affable", 
		[RbxAssetId .. "3894767"] = "Bashful",  
		[RbxAssetId .. "3894769"] = "Bold",  
		[RbxAssetId .. "3894773"] = "Brave",  
		[RbxAssetId .. "3894771"] = "Bulky",  
		[RbxAssetId .. "3894776"] = "Calm",  
		[RbxAssetId .. "3894778"] = "Careful",  
		[RbxAssetId .. "3894781"] = "Docile",  
		[RbxAssetId .. "3894783"] = "Gentle",  
		[RbxAssetId .. "894786"] = "Hardy",  
		[RbxAssetId .. "3894788"] = "Hasty",  
		[RbxAssetId .. "3894790"] = "Impish",  
		[RbxAssetId .. "3894793"] = "Jolly",  
		[RbxAssetId .. "3894795"] = "Lax",  
		[RbxAssetId .. "3894797"] = "Lonely",  
		[RbxAssetId .. "3894801"] = "Mild",  
		[RbxAssetId .. "3894804"] = "Modest",  
		[RbxAssetId .. "3894808"] = "Naive",  
		[RbxAssetId .. "3894806"] = "Naughty",  
		[RbxAssetId .. "3894810"] = "Quiet",  
		[RbxAssetId .. "3894812"] = "Quirky",  
		[RbxAssetId .. "3894814"] = "Rash",  
		[RbxAssetId .. "3894816"] = "Relaxed",  
		[RbxAssetId .. "3894820"] = "Sassy",  
		[RbxAssetId .. "3894822"] = "Serious",  
		[RbxAssetId .. "894824"] = "Timid",  
	},
}

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Functions / Methods
-------------------------------------------------------------------------------------------------------------------------------------------------------------

local function DamageBillboard(pos, text, rate, time, color)
	local pos = pos or Vector3.new(0, 0, 0)
	local time = time or 2
	local color = color or Color3.new(1, 0, 0)
	local pos = pos + Vector3.new(0, 5, 0)
	local ep = Instance.new("Part")
	ep.Name = "Effect"
	ep.Size = Vector3.new(1, 1, 1)
	ep.TopSurface = Enum.SurfaceType.Smooth
	ep.BottomSurface = Enum.SurfaceType.Smooth
	ep.CFrame = CFrame.new(pos)
	ep.Anchored = true
	ep.CanCollide = false
	ep.Transparency = 1
	local bb = Instance.new("BillboardGui")
	bb.Size = UDim2.new(3, 0, 3, 0)
	bb.Adornee = ep
	bb.Parent = ep
	local tl = Instance.new("TextLabel")
	tl.BackgroundTransparency = 1
	tl.Size = UDim2.new(1, 0, 1, 0)
	tl.Text = text
	tl.TextColor3 = color
	tl.TextScaled = true
	tl.Font = Enum.Font.SourceSans
	tl.Parent = bb
	Services.Debris:AddItem(ep, time + 0.1)
	ep.Parent = workspace
	delay(0, function()
		local frames = time / rate
		for frame = 1, frames do
			wait(rate)
			local percent = frame / frames
			ep.CFrame = CFrame.new(pos) + Vector3.new(0, 5 * percent, 0)
			tl.TextTransparency = percent
		end
		ep:Destroy()
	end)
end

function Gv2:GenerateLightning(pos, pos2, radius, numParts, model)
	radius = radius or 0.2
	numParts = numParts or 10
	model = model or workspace
	local lv = CFrame.new(pos, pos2).lookVector
	local dist = (pos - pos2).magnitude
	local dbp = dist / numParts
	local last = pos
	for i = 1, numParts do
		local p = Instance.new("Part")
		p.Size = Vector3.new(1, 1, 1)
		p.CanCollide = false
		p.Anchored = true
		p.Material = Enum.Material.Neon
		p.BrickColor = BrickColor.new("Bright yellow")
		p.Parent = model
		local x = math.random(-100, 100) * 0.01 * dbp * 0.5
		local y = math.random(-100, 100) * 0.01 * dbp * 0.5
		local p2 = CFrame.new(pos + lv * (i * dbp), pos2 + lv) * CFrame.new(x, y, 0)
		local dist2 = (p2.p - last).magnitude
		local mid = (p2.p + last) * 0.5
		local m = Instance.new("BlockMesh")
		m.Scale = Vector3.new(radius, radius, dist2)
		m.Parent = p
		p.CFrame = CFrame.new(mid, p2.p)
		last = p2.p
		Services.Debris:AddItem(p, math.random(40, 100) * 0.001)
	end
end

function Gv2:LoadAssets(AssetList)
	-- Takes an asset list and preloads it. Will not wait for them to load. 
	for _, AssetId in pairs(AssetList) do
		local succ = pcall(function()
			Services.ContentProvider:Preload(RbxAssetId..AssetId)
		end)
		if succ then
			print("[LoadAssets] Asset " .. RbxAssetId..AssetId .. " has been loaded successfully.")
		else
			print("[LoadAssets] Asset " .. RbxAssetId..AssetId .. " failed to load properly.")
		end
	end
end

function Gv2:FindFirstEnemy(name, team_color)
	for i, v in pairs(game.Players:GetPlayers()) do --ipairs
		if v.TeamColor ~= team_color and v.Name == name then
			return v
		end
	end
	return nil
end

function Gv2:GetBlood(startPos)
	local blood = Instance.new("Part")
	blood.Name = "Blood"
	blood.Size = Vector3.new(1, 0.2, 1)
	blood.BrickColor = BrickColor.new("Bright red")
	blood.Position = startPos + Vector3.new(math.random(-5, 5), math.random(-5, 5), math.random(-5, 5))
	blood.Velocity = Vector3.new(math.random(-10, 10), math.random(-10, 10), math.random(-10, 10))
	blood.RotVelocity = Vector3.new(math.random(-3, 3), math.random(-3, 3), math.random(-3, 3))
	return blood
end

local function GetBloodLocal(startPos)
	local blood = Instance.new("Part")
	blood.Name = "Blood"
	blood.Size = Vector3.new(1, 0.2, 1)
	blood.BrickColor = BrickColor.new("Bright red")
	blood.Position = startPos + Vector3.new(math.random(-5, 5), math.random(-5, 5), math.random(-5, 5))
	blood.Velocity = Vector3.new(math.random(-10, 10), math.random(-10, 10), math.random(-10, 10))
	blood.RotVelocity = Vector3.new(math.random(-3, 3), math.random(-3, 3), math.random(-3, 3))
	return blood
end

function Gv2:Stun(targetChar, time)
	if targetChar:FindFirstChild("Torso") == nil then print("[Server] Stun: Cannot find targetChar's Torso.") return end
	local time = time or math.random(2, 3)
	local bodyVel = Instance.new("BodyVelocity")
	bodyVel.velocity = Vector3.new(0, -50, 0)
	bodyVel.maxForce = Vector3.new(1e+008, 1e+004, 1e+008)
	bodyVel.Parent = targetChar.Torso
	Services.Debris:AddItem(bodyVel, time)
end

function Gv2:DealDamage(source, target, damage, stun, ignoreDef)
	if source and target and damage then
		print("[Server] Source, Target, and Damage exist.")
		if stun == nil then stun = false end
		if ignoreDef == nil then ignoreDef = false end
		
		local sourcePlayer = Services.Players:GetPlayerFromCharacter(source)
		local targetPlayer = Services.Players:GetPlayerFromCharacter(target) or nil
		print("[Server] Both players exist.")
		if targetPlayer then 
			if sourcePlayer.TeamColor == targetPlayer.TeamColor then 
				return
			end 
		end
		
		
		if target:FindFirstChild("ForceField") or source == target then print("[Server] Target might have a forcefield on or the source is the target.") return end
		if source:FindFirstChild("Humanoid") == nil or target:FindFirstChild("Humanoid") == nil or source:FindFirstChild("Torso") == nil or target:FindFirstChild("Torso") == nil then return end
		if target:FindFirstChild("StoneShield") then return end
		
		local sourceHum = source:FindFirstChild("Humanoid")
		local targetHum = target:FindFirstChild("Humanoid")
		local sourceTorso = source:FindFirstChild("Torso")
		local targetTorso = target:FindFirstChild("Torso")
		print("[Server] Humanoid and Torso for both source and target exist.")
		
		if sourceHum.Health <= 0 or targetHum.Health <= 0 then return end
		
		print("[Server] Unmodified Damage:", damage)
		local newDamage = damage
		local sourceClass = sourcePlayer:FindFirstChild("Class") or nil
		local targetClass = nil
		if targetPlayer then
			targetClass = targetPlayer:FindFirstChild("Class")
		end
		Gv2:tagHumanoid(sourcePlayer, targetHum)
		
		if sourceClass then
			print("[Server] Source class is not nil.")
			if sourceClass.Value == "Barbarian" then
				-- CLOSE COMBAT MASTERY
				-- QUOTE: devastating damage to foes that come within 18 meters of range. Max bonus damage is 90%.
				-- 18 studs: formula => damage +% = (18 - dist) * 6
				local dist = (sourceTorso.Position - targetTorso.Position).magnitude
				local mod = (18 - dist) * 6
				if mod < 0 then mod = 0 end
				if mod > 90 then mod = 90 end
				newDamage = newDamage * (1 + mod * 0.01)
			elseif sourceClass.Value == "Phantom" then
				-- ANNIHILATE
				-- deals 4x damage
				if source:FindFirstChild("Annihilate") then
					local sourceAnnihilate = source:FindFirstChild("Annihilate")
					if math.random(0, 100) <= sourceAnnihilate.Value then
						print("Phantom: Annihilate: Trigger")
						if sourceTorso:FindFirstChild("Annihilation") then
							sourceTorso.Annihilation:Play()
						end
					
						for i = 1, 4 do
							local blood = Gv2:GetBloodLocal(targetTorso.Position)
							blood.Parent = workspace
							Services.Debris:AddItem(blood, 3)
						end

						newDamage = newDamage * 4 -- o snap!!!!
						sourceAnnihilate.Value = 4.7 -- reset it
					end
				end
			elseif sourceClass.Value == "Faerie Knight" then
				-- DEATH FROM ABOVE
				-- 1 studs above = 33% more damage
	
				if sourceTorso.Position.y > targetTorso.Position.y then
					newDamage = newDamage * 1.33
				end
			end
			
			if targetClass then
				print("[Server] Target class is not nil.")
				if sourceClass.Value ~= "Exorcist" and targetClass.Value == "Exorcist" and newDamage >= 5 then
					-- EYE FOR EYE
					-- deals 20% of damage back to source
					-- no infinite recursion plz
					Gv2:DealDamage(target, source, newDamage * 0.2, false)
					Gv2:tagHumanoid(sourcePlayer, target.Humanoid)
				elseif sourceClass.Value == "Exorcist" and Gv2.DemonPeople[targetClass.Value] == true then
					-- XENOPHOBIA
					-- 33% more damage to demon people
					newDamage = newDamage * 1.333
				end
			end
		end
		
		if source:FindFirstChild("DamageMod") and target:FindFirstChild("ArmorMod") then
			print("[Server] DamageMod and ArmorMod exist!")
			local classDamageMod = source:FindFirstChild("DamageMod")
			local targetArmorMod = target:FindFirstChild("ArmorMod")
			if ignoreDef then
				targetArmorMod.Value = 100
			end
			newDamage = newDamage * 0.01 * classDamageMod.Value * 0.01 * targetArmorMod.Value
		end
		
		if targetClass then
			print("[Server] Target class is not nil.")
			if targetClass.Value == "Barbarian" and target:FindFirstChild("ThickSkin") then
				-- THICK SKIN
				if target.ThickSkin.Value > 0 then
					target.ThickSkin.Value = target.ThickSkin.Value - newDamage
					newDamage = newDamage * 0.5
					print("[Server] Barbarian: Skin Trigger")
				end
			elseif targetClass.Value == "Phantom" then
				-- IRREALITY
				if math.random(0, 100) < 30 then
					newDamage = 0
					print("[Server] Phantom Irreality Trigger")
				end
				for i, v in pairs(target:GetChildren()) do
					if v:IsA("Part") or v:IsA("UnionOperation") then
						v.Transparency = 0
					end
				end
			end
		end
		
		if sourceClass ~= nil and source:FindFirstChild("Buffs") then
			print("[Server] Source class and source buffs are not nil.")
			local sourceClass = sourcePlayer:FindFirstChild("Class")
			local sourceBuffs = source:FindFirstChild("Buffs")
			
			if sourceClass.Value == "Vampire" then
				-- BLOODTHIRST
				sourceHum.Health = sourceHum.Health + newDamage * 0.25
			elseif sourceBuffs:FindFirstChild("Feeding Frenzy") then
				-- FEEDING FRENZY
				sourceHum.Health = sourceHum.Health + newDamage * 0.2
			end
		end
		
		print("[Server] Modified Damage:", newDamage)
		DamageBillboard(target:FindFirstChild("Head").Position, "-" .. tostring(damage), 0.333)
		targetHum:TakeDamage(newDamage)
		
		-- hitstun
		if stun and newDamage > 2 and target:FindFirstChild("LeftArm1") == nil then -- we only hitstun for larger damage and when the guy isn't in a heavy suit
			Gv2:Stun(target, 0.2)
		end
		
		-- blood
		local bloodCount = math.ceil(damage * 0.1)
		if bloodCount > 10 then bloodCount = 10 end
		for i = 1, bloodCount do
			local blood = GetBloodLocal(targetTorso.Position)
			blood.Parent = workspace
			Services.Debris:AddItem(blood, 3)
		end
	end
end

function Gv2:GetClosestPlayer(startChar)
	if startChar:FindFirstChild("Torso") == nil then return nil end
	local minPlayer = nil
	local minDist = 1000
	local sourceTorso = startChar:FindFirstChild("Torso")
	
	for i, v in pairs(Services.Players:GetPlayers()) do --ipairs
		if v.Character then
			local vChar = v.Character
			if vChar ~= startChar and vChar:FindFirstChild("Torso") then
				local vTorso = vChar:FindFirstChild("Torso")
				local vsMag = (vTorso.Position - sourceTorso.Position).magnitude < minDist
				if vsMag < minDist then
					minPlayer = v
					minDist = vsMag
				end
			end
		end
	end
	
	return minPlayer
end

function Gv2:GetClosestEnemy(player, dist)
	if player.Character == nil or player.Character:FindFirstChild("Torso") == nil then return end
	local minPlayer = nil
	local minDist = 1000
	local pChar = player.Character
	for i, v in pairs(Services.Players:GetPlayers()) do --ipairs
		if v.Character then
			if v.TeamColor ~= player.TeamColor and v.Character:FindFirstChild("Torso") then
				if (v.Character.Torso.Position - player.Character.Torso.Position).magnitude < minDist then
					minPlayer = v
					minDist = (v.Character.Torso.Position - player.Character.Torso.Position).magnitude
				end
			end
		end
	end
	
	return minPlayer
end

function Gv2:tagHumanoid(targ, humanoid)
	if targ and humanoid then
		local new_tag = Instance.new("ObjectValue")
		new_tag.Name = "creator"
		new_tag.Value = targ
		new_tag.Parent = humanoid
		Services.Debris:AddItem(new_tag, 2)
		return
	end
end

function Gv2:GiveGun(player, properties)
	if properties.Name == "Chainsaw" or properties.Name == "Combat Knife" then
		-- the chainsaw and knife are ready to go already
		properties:Clone().Parent = player.Backpack
		return
	end

	local gun = Services.Lighting.GunTemplate:Clone()
	
	for i, v in pairs(properties:GetChildren()) do --ipairs
		v:Clone().Parent = gun
	end
	
	local settingsMod = require(properties.SettingsModule)
	
	gun.Name = properties.Name
	gun.GripPos = settingsMod.GripPos
	gun.Parent = player.Backpack
	gun.GunScript.Disabled = false
end

return Gv2
