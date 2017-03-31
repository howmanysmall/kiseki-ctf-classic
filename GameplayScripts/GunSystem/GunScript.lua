-------------------------------------------------------------------------------------------------------------------------------------------
-- Kiseki CTF: Classic Edition Gun System
-- Rescripted by shloid (da man!!!) 
-------------------------------------------------------------------------------------------------------------------------------------------

-- Services
local Debris = game:GetService("Debris")
local Players = game:GetService("Players")
local UserInput = game:GetService("UserInputService")
local RepStorage = game:GetService("ReplicatedStorage")
local ContextAction = Game:GetService("ContextActionService")

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
print("variables are a-ok")
-- removed ones
--reloadTimeTag = Tool.ReloadTime
--rateOfFireTag = Tool.RateOfFire
--startUpTimeTag = Tool.StartupTime
--bulletSpeedTag = Tool.BulletSpeed
--recoilTag = Tool.Recoil

-------------------------------------------------------------------------------------------------------------------------------------------
-- Functions / Methods
-------------------------------------------------------------------------------------------------------------------------------------------

function fire(v, playSound)
	if playSound then Sounds.Fire:Play() end
	if ToolSettings.Firing == false or ToolSettings.Reloading == true or ToolSettings.Equipped == false then return end
	
	-- Variables
	local new_script = nil
	local missile = Bullet:Clone()
	missile.Anchored = false
	missile.Transparency = 0
	local spawnPos = Handle.Position

	if Tool.Name == "LAW" then
		missile.Name = "Mortar"
		v = Vector3.new(v.x, 0, v.z)
		v = v.unit
		v = v + Vector3.new(0, 2, 0)
		v = v.unit
	end

	missile.CFrame = CFrame.new(spawnPos, spawnPos + v)
	missile.Velocity = v * SettingsModule.BulletSpeed

	-- add scripts
	if Tool.Name == "M79" or Tool.Name == "LAW" then
		 new_script = script.GrenadeScript:Clone()
	else
		 new_script = script.BulletScript:Clone()
	end
	
	new_script.Disabled = false
	new_script.Parent = missile

	-- add damage & creator tag
	local damageTag = Instance.new("IntValue",missile)
	damageTag.Name = "Damage"
	damageTag.Value = SettingsModule.Damage

	local creator_tag = Instance.new("ObjectValue",missile)
	creator_tag.Name = "creator"
	creator_tag.Value = Player

	missile.Parent = workspace
end

function Reload()
	if ToolSettings.Reloading then return end
	print("[Server] Gun: Reloading.") 
	
	if msg then msg.Text = "Reloading..." end
	if Sounds.Reload ~= nil then Sounds.Reload:play() end

	reloadDebounce = false
	firing = false
	Tool.Enabled = false

	if Tool.Name ~= "Spas-12" then
		wait(SettingsModule.ReloadTime)
	else
		for i = 1, 7 do
			wait(SettingsModule.ReloadTime / 7)
			Sounds.Reload:Play()
		end
	end

	print("[Server] Gun: Reloaded.")
	Tool.Enabled = true
	ToolSettings.Clip = ToolSettings.Magazine
	reloadDebounce = true
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
			
			local targetPos = Character.Humanoid.TargetPoint
			local lookAt = CFrame.new(Handle.Position, targetPos) -- lookAt points at the target
				  lookAt = lookAt * CFrame.fromEulerAnglesXYZ(
						   math.rad(math.random(-chain * SettingsModule.Recoil, chain * SettingsModule.Recoil)) / 4,
						   math.rad(math.random(-chain * SettingsModule.Recoil, chain * SettingsModule.Recoil)) / 8,
						   0
				   )
				
			--if rounds > 1 then
				for i = 1, rounds do
					if i ~= 1 then
						fire(lookAt.lookVector, false)
					else
						fire(lookAt.lookVector, true)
					end
					wait()
				end
			--else
				--fire(lookAt.lookVector, true)
				--wait()
			--end

			-- recoil cap
			if chain < 10 then
				chain = chain + 1
			end

			ToolSettings.Clip = ToolSettings.Clip - 1
			onAmmoChanged()
			print("[Server]",Tool.Name,"'s Clip:",ToolSettings.Clip)
			Tool.Enabled = false
			wait(SettingsModule.FireRate)
			if Tool.Name == "Socom" then
				ToolSettings.Firing = false
				break
			end
			Tool.Enabled = true
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
	if ToolSettings.Equipped == false then return end
	
	if input.UserInputType == Enum.UserInputType.Gamepad1 then
		if input.KeyCode == Enum.KeyCode.ButtonY then
			--Reload()
		end
	elseif input.UserInputType == Enum.UserInputType.Keyboard then
		if input.KeyCode == Enum.KeyCode.R then
			--Reload()
		end
	elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
		ToolSettings.Firing = true
		Tool.Enabled = true
		mainFiring()
	elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
		GunZoom("Scope")
	end
end)

UserInput.InputEnded:connect(function(input)
	ToolSettings.Firing = false
end)

Tool.Equipped:connect(function(mouse) 
	Character = Tool.Parent
	Player = Players:GetPlayerFromCharacter(Character)
	msg = Player:FindFirstChild("AmmoHUD")
	if msg == nil then
		msg = Instance.new("Message",Player)
		msg.Name = "AmmoHUD"
	end
	onAmmoChanged()
	ToolSettings.Equipped = true
	Tool.Enabled = true
	
	mouse.Button1Down:connect(function()
		print("firing!!!")
		--ToolSettings.Firing = true
		--mainFiring()
	end)
	
	mouse.Button1Up:connect(function()
		--ToolSettings.Firing = false
		--wait(.5)
	end)
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