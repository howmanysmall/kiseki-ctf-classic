-------------------------------------------------------------------------------------------------------------------------------------------
-- Kiseki CTF: Classic Edition Gun System
-- Scripted by Clockwork, Modified by shloid
-------------------------------------------------------------------------------------------------------------------------------------------

-- Services
local Debris = game:GetService("Debris")
local Players = game:GetService("Players")
local UserInput = game:GetService("UserInputService")
local RepStorage = game:GetService("ReplicatedStorage")
local ContextAction = game:GetService("ContextActionService")

-- Tool
local Tool = script.Parent

-------------------------------------------------------------------------------------------------------------------------------------------
wait(1)
while Tool:FindFirstChild("Handle") == nil do wait(.1) end
-------------------------------------------------------------------------------------------------------------------------------------------

-- Tool Essentials
local Bullet = Tool:WaitForChild("Bullet"):Clone()
local Handle = Tool:WaitForChild("Handle")
local Sounds = {
	Fire = Handle:WaitForChild("Fire");
	Reload = (Handle:FindFirstChild("Reload") or nil);
	Startup = (Handle:FindFirstChild("Startup") or nil);
}
local HandleMesh = Handle.Mesh

-- Modules
local _Gv2 = require(RepStorage:FindFirstChild("_Gv2"))
local SettingsModule = require(Tool:WaitForChild("SettingsModule"))

-- Settings
local ToolSettings = {
	Clip = SettingsModule.MaxAmmo;
	Magazine = SettingsModule.MaxAmmo;
	
	Firing = false;
	Reloading = false;
	Equipped = false;
}

print("["..Tool.Name.."] variables have successfully loaded.")

-------------------------------------------------------------------------------------------------------------------------------------------
-- Functions / Methods
-------------------------------------------------------------------------------------------------------------------------------------------

function fire(v, playSound)
	if ToolSettings.Firing == false or ToolSettings.Reloading == true or ToolSettings.Equipped == false then return end
	if playSound then Sounds.Fire:Play() end
	if Tool.Name == "LAW" or Tool.Name == "M79" then
		local spawnPos = Handle.Position
		local missile = Bullet:Clone()
		missile.Anchored = false
		missile.Transparency = 0
		
		missile.Name = "Mortar"
		v = Vector3.new(v.x, 0, v.z)
		v = v.unit
		v = v + Vector3.new(0, 2, 0)
		v = v.unit
		
		missile.CFrame = CFrame.new(spawnPos, spawnPos + v)
		missile.Velocity = v * (SettingsModule.BulletSpeed/2)
		local new_script = script.GrenadeScript:Clone()
		
		-- add damage & creator tag
		local damageTag = Instance.new("IntValue",missile)
		damageTag.Name = "Damage"
		damageTag.Value = SettingsModule.Damage

		local creator_tag = Instance.new("ObjectValue",missile)
		creator_tag.Name = "creator"
		creator_tag.Value = Player
		
		new_script.Parent = missile
		new_script.Disabled = false
		missile.Parent = workspace
	else
		local ray = Ray.new(Handle.CFrame.p, (Mouse.Hit.p - Handle.CFrame.p).unit * 300)
		local part, position = workspace:FindPartOnRay(ray, Character, false, true)
 
		local beam = Instance.new("Part", workspace)
		beam.BrickColor = Player.TeamColor
		beam.FormFactor = "Custom"
		beam.Material = "Neon"
		beam.Transparency = 0.25
		beam.Anchored = true
		beam.Locked = true
		beam.CanCollide = false
 
		local distance = (Handle.CFrame.p - position).magnitude
		beam.Size = Vector3.new(0.3, 0.3, distance)
		beam.CFrame = CFrame.new(Handle.CFrame.p, position) * CFrame.new(0, 0, -distance / 2)
		
		local creator_tag = Instance.new("ObjectValue",beam)
		creator_tag.Name = "creator"
		creator_tag.Value = Player
 
		Debris:AddItem(beam, 0.1)
		if part then
 			local hithum = (part.Parent:FindFirstChild("Humanoid") or part.Parent.Parent:FindFirstChild("Humanoid"))
			if hithum then
				_Gv2:DealDamage(Character,hithum.Parent,SettingsModule.Damage)
			end
		end
	end
end

function Reload()
	if ToolSettings.Reloading then return end
	print("[Server] Gun: Reloading.") 
	
	if msg then msg.Text = "Reloading..." end
	if Sounds.Reload ~= nil then Sounds.Reload:play() end

	ToolSettings.Reloading = true
	ToolSettings.Firing = false
	Tool.Enabled = false

	if Tool.Name ~= "Spas-12" then
		if Tool.Name == "M79" or Tool.Name == "LAW" then
			-- do nothing
		else
			wait(Sounds.Reload.TimeLength)
		end
	else
		for i = 1, 7 do
			wait(SettingsModule.ReloadTime / 7)
			Sounds.Reload:Play()
		end
	end
	print("[Server] Gun: Reloaded.")
	ToolSettings.Clip = ToolSettings.Magazine
	onAmmoChanged()
	Tool.Enabled = true
	ToolSettings.Reloading = false
end

function onAmmoChanged()
	if msg then
		if ToolSettings.Clip <= 0 then
			msg.Text = "Reloading..."
			Reload()
		else
			msg.Text = ToolSettings.Clip .. "/" .. ToolSettings.Magazine
		end
	end
end

function mainFiring(name, inputState, inputObject)
	if ToolSettings.Equipped == true and Tool.Enabled == true and ToolSettings.Clip > 0 and ToolSettings.Firing == true and ToolSettings.Reloading == false then
		if Tool.Name == "XM214 Minigun" and Character:FindFirstChild("LeftArm1") == nil and _Gv2.debug == false then
			return
		end
		print("firing")
		if SettingsModule.StartupTime ~= 0 and Sounds.Startup ~= nil then
			Sounds.Startup:Play()
		end
		
		local rounds = 1 -- for rounds
		local chain = 0 -- for recoil
		local fired = false
		if Character:FindFirstChild("Class") then
			if Character.Class.Value == "Sensation Man" and Character.Torso:FindFirstChild("123") then
				Character.Torso:FindFirstChild("123"):Play()
			end	
		end
		
		wait(SettingsModule.StartupTime)
		
		while (ToolSettings.Firing == true) do
			--wait()
			if Tool.Name == "Spas-12" then
				rounds = 4
				chain = 5
			else
				rounds = 1
			end

			if Tool.Name == "Barrett" then
				if Character.Torso.Velocity.magnitude > 2 then
					ToolSettings.Firing = false
					break
				end
			end
			
			for i = 1, rounds do
				local targetPos = Character.Humanoid.TargetPoint
				local lookAt = CFrame.new(Handle.Position, targetPos) -- lookAt points at the target
					  lookAt = lookAt * CFrame.fromEulerAnglesXYZ(
							   math.rad(math.random(-chain * SettingsModule.Recoil, chain * SettingsModule.Recoil)) / 4,
							   math.rad(math.random(-chain * SettingsModule.Recoil, chain * SettingsModule.Recoil)) / 8,
							   0
				 	  )
				if i ~= 1 then
					fire(lookAt.lookVector, false)
				else
					fire(lookAt.lookVector, true)
				end
				wait()
			end

			-- recoil cap
			if chain < 10 then chain = chain + 1 end

			ToolSettings.Clip = ToolSettings.Clip - 1
			onAmmoChanged()
			print("[Server]",Tool.Name,"'s Clip:",ToolSettings.Clip)
			Tool.Enabled = false
			
			if ToolSettings.Clip <= 0 then
				ToolSettings.Reloading = true
				Reload()
			end
			wait(SettingsModule.FireRate)
			Tool.Enabled = true
			if Tool.Name == "Socom" then
				ToolSettings.Firing = false
				break
			end
		end
		
		ToolSettings.Firing = false
		if Character:FindFirstChild("Class") then
			if Character.Class.Value == "Sensation Man" and Character.Torso:FindFirstChild("123") then
				Character.Torso:FindFirstChild("123"):Stop()
			end	
		end
	end
end

-------------------------------------------------------------------------------------------------------------------------------------------
-- Equipped + Unequipped functions.
-------------------------------------------------------------------------------------------------------------------------------------------

UserInput.InputBegan:connect(function(input)
	if ToolSettings.Equipped == false or Handle.Mesh ~= HandleMesh then return end
	if input.UserInputType == Enum.UserInputType.Keyboard then
		if input.KeyCode == Enum.KeyCode.R then
			Reload()
		end
	elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
		if ToolSettings.Reloading == false then
			ToolSettings.Firing = true
			mainFiring()
		end
	end
end)

UserInput.InputEnded:connect(function(input)
	ToolSettings.Firing = false
end)

Tool.Equipped:connect(function(mouse) 
	Character = Tool.Parent
	Mouse = mouse
	Player = Players:GetPlayerFromCharacter(Character)
	msg = Player:FindFirstChild("AmmoHUD")
	if msg == nil then
		msg = Instance.new("Message",Player)
		msg.Name = "AmmoHUD"
	end
	onAmmoChanged()
	ToolSettings.Equipped = true
	Tool.Enabled = true
end)

Tool.Unequipped:connect(function()  
	ToolSettings.Firing = false
	ToolSettings.Equipped = false
	ToolSettings.Reloading = false
	
	for i, v in pairs(Handle:GetChildren()) do
		if v:IsA("Sound") then
			v:Stop()
		end
	end
end)

script.Reload.Changed:connect(function(v)
	if v == true then
		Reload()
	end
end)
