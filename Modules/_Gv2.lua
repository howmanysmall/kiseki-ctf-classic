-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Global Module v2.0
-- Created by shloid (da man!!!)
-------------------------------------------------------------------------------------------------------------------------------------------------------------

local Services = {
	Players = game:GetService("Players"),
	Debris = game:GetService("Debris")
}

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
	
	weapon_grid = {
		["Barbarian"] = {"Spas-12", "HK5", "Deagles", "AK-74", "Socom", "M79", "Throwing Knives"},
		["Phantom"] = {"Ruger", "HK5",  "Spas-12", "Deagles", "Steyr AUG", "M-15", "Socom", "Throwing Knives"},
		["Tinkerer"] = {"AK-74", "HK5",  "Spas-12", "Deagles", "Steyr AUG", "Ruger", "M-15", "Socom", "M79", "Barrett", "LAW"},
		["Wellwisher"] = {"Steyr AUG",  "AK-74", "Ruger", "M-15", "Socom","Barrett", "LAW"},	
		["Faerie Knight"] = {"Ruger", "Deagles", "Steyr AUG", "AK-74", "M-15", "Socom", "Barrett", "Throwing Knives"},
		["Butcher"] = {"Chainsaw"},
		["Machinist"] = {"AK-74", "HK5",  "Spas-12", "Deagles", "Steyr AUG", "Ruger", "M-15", "Socom", "M79", "Barrett", "LAW"},
		["Exorcist"] = {"HK5",  "Spas-12", "Deagles", "Ruger", "M-15", "Socom", "Barrett", "Throwing Knives"},
		["Apprentice"] = {"Steyr AUG", "HK5",  "Deagles", "AK-74", "M-15", "Socom", "M79"},
		["Witch Doctor"] =  {"Steyr AUG", "AK-74", "Barrett", "Spas-12", "Ruger"},
		["Sensation Man"] = {"Chainsaw", "LAW"},
		["Shinobi"] = {"HK5"},
		["Vampire"] = {"HK5", "Deagles", "M79", "Throwing Knives", "AK-74", "Spas-12", "Ruger"},
	},
	
	personality_grid = {
		["Adamant"] = {-10, 0, -10, 0},   
		["Affable"] = {-10, -20, 10, 0},  
		["Bashful"] = {-3, 3, 3, 3},
		["Bold"] = {20, 20, 0, 10},   
		["Brave"] = {-25, 10, -10, -15},   
		["Bulky"] = {-30, 50, -50, -60},  
		["Calm"] = {-10, 0, -20, 10},   
		["Careful"] = {-15, 5, 10, -30},   
		["Docile"] = {10, -10, 10, 10}, 
		["Gentle"] = {-40, -30, 0, 0}, 
		["Hardy"] = {-20, -20, -10, 20},   
		["Hasty"] = {30, -20, 80, -15}, 
		["Impish"] = {20, -10, 10, 10},  
		["Jolly"] = {40, 20, 0, 80},
		["Lax"] = {20, 10, 0, 10},
		["Lonely"] = {-15, -20, 20, -5},   
		["Mild"] = {-20, 0, -10, 0},
		["Modest"] = {-10, -5, 15, -20},   
		["Naive"] = {30, 30, 15, -20},
		["Naughty"] = {15, 10, 20, -10},   
		["Quiet"] = {5, 15, 15, -30},
		["Quirky"] = {-10, -10, -10, 20},   
		["Rash"] = {40, 25, 40, -95},
		["Relaxed"] = {-40, 0, -30, -30},   
		["Sassy"] = {0, 20, -25, -10},
		["Serious"] = {10, 0, 15, 15},  
		["Timid"] = {15, 5, 0, 15},
	},
	
	sensational_man = {
		"clockwork", 
		"conix", 
		"Deathmask390",
		"Noobertuber",
		"Akhenderson",
		"Drazil29",
		"Armydude123",
		"bob10110",
		"Telamon",
		"Ultracool234",
		"Toasteh",
		"Briguy9876",
		"Blazinhusky",
		"Kaicui",
		"Player",
		"Giik",
		"Qu4ch",
		"YUKI.N",
		"Flamerider64",
		"bob10110",
		"Minish",
		"OzJB",
		"MetalYoshi",
		"LuigiFan",
		"HellMage501",
		"Byndley",
		"NintendoBoy",
		"smashbi121",
		"UmbrellaCorps",
		"polobowz",
		"MrWillyWonnka",
		"frzntear",
		"Intile",
		"astrosimi",
		"HoolyRocket",
		"TheShotgun",
		"JMud",
		"Samacado",
		"mmk6288",
		"Darthnoob",
		"Erith",
		"gemerl20",
		"mustyoshi",
		"supermario444",
		"shloid",
	},
	
	shirtGrid = {
		["http://www.roblox.com/asset/?id=2729205"]  = "Phantom",
		["http://www.roblox.com/asset/?id=2729207"]  = "Barbarian",
		["http://www.roblox.com/asset/?id=2729212"]  = "Wellwisher",
		["http://www.roblox.com/asset/?id=2729217"]  = "Tinkerer",
		["http://www.roblox.com/asset/?id=2749266"]  = "Faerie Knight",
		["http://www.roblox.com/asset/?id=2749268"]  = "Butcher",
		["http://www.roblox.com/asset/?id=2749263"]  = "Machinist",
		["http://www.roblox.com/asset/?id=2801405"]  = "Exorcist",
		["http://www.roblox.com/asset/?id=2801397"]  = "Apprentice",
		["http://www.roblox.com/asset/?id=2902054"]  = "Witch Doctor",
		["http://www.roblox.com/asset/?id=4843677"]  = "Sensation Man",
		["http://www.roblox.com/asset/?id=6334561"]  = "Vampire",
		["http://www.roblox.com/asset/?id=6334559"]  = "Shinobi",
		["http://www.roblox.com/asset/?id=13837268"] = "Sensation Man 2",
	},
	
	charGrid = {
		["Phantom"]           = "http://www.roblox.com/asset/?id=2729205",
		["Barbarian"]         = "http://www.roblox.com/asset/?id=2729207",
		["Wellwisher"]        = "http://www.roblox.com/asset/?id=2729212",
		["Tinkerer"]          = "http://www.roblox.com/asset/?id=2729217",
		["Faerie Knight"]     = "http://www.roblox.com/asset/?id=2749266",
		["Butcher"]           = "http://www.roblox.com/asset/?id=2749268",
		["Machinist"]         = "http://www.roblox.com/asset/?id=2749263",
		["Exorcist"]          = "http://www.roblox.com/asset/?id=2801405",
		["Apprentice"]        = "http://www.roblox.com/asset/?id=2801397",
		["Witch Doctor"]      = "http://www.roblox.com/asset/?id=2902054",
		["Sensational Man"]   = "http://www.roblox.com/asset/?id=4843677",
		["Vampire"]           = "http://www.roblox.com/asset/?id=6334561",
		["Shinobi"]           = "http://www.roblox.com/asset/?id=6334559",
		["Sensational Man 2"] = "http://www.roblox.com/asset/?id=13837268",
	},
	
	pantsGrid = {
		["http://www.roblox.com/asset/?id=3894762"] = "Adamant",
		["http://www.roblox.com/asset/?id=3894764"] = "Affable", 
		["http://www.roblox.com/asset/?id=3894767"] = "Bashful",  
		["http://www.roblox.com/asset/?id=3894769"] = "Bold",  
		["http://www.roblox.com/asset/?id=3894773"] = "Brave",  
		["http://www.roblox.com/asset/?id=3894771"] = "Bulky",  
		["http://www.roblox.com/asset/?id=3894776"] = "Calm",  
		["http://www.roblox.com/asset/?id=3894778"] = "Careful",  
		["http://www.roblox.com/asset/?id=3894781"] = "Docile",  
		["http://www.roblox.com/asset/?id=3894783"] = "Gentle",  
		["http://www.roblox.com/asset/?id=3894786"] = "Hardy",  
		["http://www.roblox.com/asset/?id=3894788"] = "Hasty",  
		["http://www.roblox.com/asset/?id=3894790"] = "Impish",  
		["http://www.roblox.com/asset/?id=3894793"] = "Jolly",  
		["http://www.roblox.com/asset/?id=3894795"] = "Lax",  
		["http://www.roblox.com/asset/?id=3894797"] = "Lonely",  
		["http://www.roblox.com/asset/?id=3894801"] = "Mild",  
		["http://www.roblox.com/asset/?id=3894804"] = "Modest",  
		["http://www.roblox.com/asset/?id=3894808"] = "Naive",  
		["http://www.roblox.com/asset/?id=3894806"] = "Naughty",  
		["http://www.roblox.com/asset/?id=3894810"] = "Quiet",  
		["http://www.roblox.com/asset/?id=3894812"] = "Quirky",  
		["http://www.roblox.com/asset/?id=3894814"] = "Rash",  
		["http://www.roblox.com/asset/?id=3894816"] = "Relaxed",  
		["http://www.roblox.com/asset/?id=3894820"] = "Sassy",  
		["http://www.roblox.com/asset/?id=3894822"] = "Serious",  
		["http://www.roblox.com/asset/?id=3894824"] = "Timid",  
	},
}

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Functions / Methods
-------------------------------------------------------------------------------------------------------------------------------------------------------------

function Gv2:FindFirstEnemy(name, team_color)
	for i,v in ipairs(game.Players:children()) do
		if v.TeamColor ~= team_color and v.Name == name then
			return v
		end
	end
	return nil
end

function Gv2:GetBlood(startPos)
	local blood = Instance.new("Part")
	blood.FormFactor = 2
	blood.Size = Vector3.new(1, .2, 1)
	blood.BrickColor = BrickColor.Red()
	blood.Position = startPos + Vector3.new(math.random(-5,5), math.random(-5,5), math.random(-5,5))
	blood.Velocity = Vector3.new(math.random(-10,10), math.random(-10,10), math.random(-10,10))
	blood.RotVelocity = Vector3.new(math.random(-3,3), math.random(-3,3), math.random(-3,3))
	return blood
end

local function GetBloodLocal(startPos)
	local blood = Instance.new("Part")
	blood.FormFactor = 2
	blood.Size = Vector3.new(1, .2, 1)
	blood.BrickColor = BrickColor.Red()
	blood.Position = startPos + Vector3.new(math.random(-5,5), math.random(-5,5), math.random(-5,5))
	blood.Velocity = Vector3.new(math.random(-10,10), math.random(-10,10), math.random(-10,10))
	blood.RotVelocity = Vector3.new(math.random(-3,3), math.random(-3,3), math.random(-3,3))
	return blood
end

function Gv2:Stun(target_char, time)
	local bodyVel = Instance.new("BodyVelocity")
	bodyVel.velocity = Vector3.new(0, -50, 0)
	bodyVel.maxForce = Vector3.new(1e+008, 1e+004, 1e+008)
	bodyVel.Parent = target_char.Torso
	Services.Debris:AddItem(bodyVel, time)
end

function Gv2:DealDamage(source_char, target_char, damage, stun, ignoreDef)
	if stun == nil then stun = true end
	if ignoreDef == nil then ignoreDef = false end

	if source_char == nil or target_char == nil then return  end
	if target_char:findFirstChild("ForceField") ~= nil then return end
	if source_char.Humanoid.Health == 0 or target_char.Humanoid.Health == 0 then return end
	if source_char == target_char then return end

	local source_player = Services.Players:GetPlayerFromCharacter(source_char)
	local target_player = Services.Players:GetPlayerFromCharacter(target_char)

	if source_player == nil or target_player == nil then return end
	if source_player.TeamColor == target_player.TeamColor then return end

	if source_char:findFirstChild("Torso") == nil then return end
	if target_char:findFirstChild("Torso") == nil then return end

	print("Damage: Unmodified:", damage)

	if source_char.Class.Value == "Barbarian" then
		-- CLOSE COMBAT MASTERY
		-- QUOTE: devastating damage to foes that come within 18 meters of range. Max bonus damage is 90%.
		-- 18 studs: formula => damage +% = (18 - dist) * 6
		local dist = (source_char.Torso.Position - target_char.Torso.Position).magnitude
		local mod = (18 - dist) * 6
		if mod < 0 then mod = 0 end
		if mod > 90 then mod = 90 end
		damage = damage * (1 + mod / 100)
	end

	if source_char.Class.Value == "Phantom" then
		-- ANNIHILATE
		-- deals 4x damage
		if math.random(0,100) <= source_char.Annihilate.Value then

			print("Phantom: Annihilate: Trigger")

			-- awsum fx
			source_char.Torso.Annihilation:play()
			for i=1,4 do
				local blood = GetBloodLocal(target_char.Torso.Position)
				blood.Parent = game.Workspace
				game:service("Debris"):AddItem(blood, 3)
			end

			damage = damage * 4 -- o snap!!!!

			source_char.Annihilate.Value = 4.7 -- reset it
		end
	end
 
	if source_char.Class.Value == "Faerie Knight" then
		-- DEATH FROM ABOVE
		-- 1 studs above = 33% more damage
	
		if source_char.Torso.Position.y > target_char.Torso.Position.y then
			damage = damage * 1.33
		end
	end

	if source_char.Class.Value ~= "Exorcist" and target_char.Class.Value == "Exorcist" and damage >= 5 then
		-- EYE FOR EYE
		-- deals 20% of damage back to source
		-- no infinite recursion plz
		Gv2:DealDamage(target_char, source_char, damage / 5, false)
		Gv2:tagHumanoid(source_player, target_char.Humanoid)
	end

	if source_char.Class.Value == "Exorcist" and Gv2.DemonPeople[target_char.Class.Value] == true then
		-- XENOPHOBIA
		-- 33% more damage to demon people
		damage = damage * 1.333
	end

	local classDamageMod = source_char.DamageMod
	local targetArmorMod = target_char.ArmorMod

	if ignoreDef then
		targetArmorMod.Value = 100
	end
	damage = damage / 100.0 * classDamageMod.Value / 100.0 * targetArmorMod.Value

	-- THICK SKIN
	if target_char.Class.Value == "Barbarian" then
		if target_char.ThickSkin.Value > 0 then
			target_char.ThickSkin.Value = target_char.ThickSkin.Value - damage
			damage = damage / 2
			print("Barbarian: 	 Skin Trigger")
		end
	end

	-- IRREALITY
	if target_char.Class.Value == "Phantom" then
		if math.random(0, 100) < 30 then
			damage = 0
			print("Phantom Irreality Trigger")
		end
	end

	-- BLOODTHIRST
	if source_char.Class.Value == "Vampire" then
		source_char.Humanoid.Health = source_char.Humanoid.Health + damage * .25
	end

	-- FEEDING FRENZY
	if source_char.Buffs:findFirstChild("Feeding Frenzy") ~= nil then
		source_char.Humanoid.Health = source_char.Humanoid.Health + damage * .2
	end
	
	print("Damage: Modified:", damage)

	target_char.Humanoid:TakeDamage(damage)

	-- reveal phantoms
	if target_char.Class.Value == "Phantom" then
		if target_char.Humanoid.Health <= 0 then
			target_char.Head.Transparency = 0
			target_char["Left Arm"].Transparency = 0
			target_char["Right Arm"].Transparency = 0
			target_char["Left Leg"].Transparency = 0
			target_char["Right Leg"].Transparency = 0
			target_char["Torso"].Transparency = 0			
		end
	end

	-- hitstun
	if stun and damage > 2 and target_char:findFirstChild("LeftArm1") == nil then -- we only hitstun for larger damage and when the guy isn't in a heavy suit
		Stun(target_char, .2)
	end

	-- blood
	blood = math.ceil(damage / 10.0)
	if blood > 10 then blood = 10 end
	for i=1, blood do
		local blood = GetBloodLocal(target_char.Torso.Position)
		blood.Parent = workspace
		Services.Debris:AddItem(blood, 3)
	end
end

function Gv2:GetClosestPlayer(startChar)
	if startChar:findFirstChild("Torso") == nil then return nil end
	players = Services.Players:children()
	minPlayer = nil
	minDist = 1000
	for i,v in ipairs(players) do
		if v.Character ~= nil then
			if v.Character ~= startChar then
				if v.Character:findFirstChild("Torso") ~= nil then
					if (v.Character.Torso.Position - startChar.Torso.Position).magnitude < minDist then
						minPlayer = v
						minDist = (v.Character.Torso.Position - startChar.Torso.Position).magnitude
					end
				end
			end
		end
	end
	return minPlayer
end

function Gv2:GetClosestEnemy(player, dist)
	if player.Character == nil or player.Character:findFirstChild("Torso") == nil then return end

	players = game.Players:children()

	minPlayer = nil
	minDist = dist
	for i,v in ipairs(players) do
		if v.Character ~= nil then
			if v.TeamColor ~= player.TeamColor then
				--if v.Character ~= startChar then
					if v.Character:findFirstChild("Torso") ~= nil then
						if (v.Character.Torso.Position - player.Character.Torso.Position).magnitude < minDist then
							minPlayer = v
							minDist = (v.Character.Torso.Position - player.Character.Torso.Position).magnitude
						end
					end
				--end
			end
		end
	end
	return minPlayer
end

function Gv2:tagHumanoid(ball, humanoid)
	if ball.className == "Player" then
		local new_tag = Instance.new("ObjectValue")
		new_tag.Name = "creator"
		new_tag.Value = ball
		new_tag.Parent = humanoid
		Services.Debris:AddItem(new_tag, 2)
		return
	end

	local tag = ball:findFirstChild("creator")
	if tag ~= nil then
		local new_tag = tag:clone()
		new_tag.Parent = humanoid
		Services.Debris:AddItem(new_tag, 2)
	end
end

function Gv2:GiveGun(player, properties)
	if properties.Name == "Chainsaw" or properties.Name == "Combat Knife" then
		-- the chainsaw and knife are ready to go already
		properties:Clone().Parent = player.Backpack
		return
	end

	local gun = game.Lighting.GunTemplate:Clone()
	
	for i,v in ipairs(properties:GetChildren()) do
		v:Clone().Parent = gun
	end
	local settingsMod = require(properties.SettingsModule)
	
	gun.Name = properties.Name
	gun.GripPos = settingsMod.GripPos
	gun.Parent = player.Backpack
	gun.GunScript.Disabled = false
end

return Gv2