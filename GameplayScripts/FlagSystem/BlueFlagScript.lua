--------------------------------------------------------------------------------------------------------------------------------
-- Blue Flag Script
-- By shloid (da man!!!)
--------------------------------------------------------------------------------------------------------------------------------

-- Services
local Players = game:GetService("Players")
local RepStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

-- Self
local Self = script.Parent
local FlagHandle = Self:WaitForChild("Handle")
local FlagStand = Self:WaitForChild("FlagStand")
FlagHandle.Name = "FlagHandle"
local CaptureFlag = RepStorage:WaitForChild("CaptureFlag")
local ReturnFlag = RepStorage:WaitForChild("ReturnFlag")

-- Game Essentials
local Settings = {
	TeamColor = BrickColor.new("Bright blue");
	PickedUp = false;
	AtSpawn = true;
	Carrier = nil;
	ReturnFlagOnDrop = true;
	FlagRespawnTime = 60
}

local FlagCopy = FlagHandle:Clone()
FlagCopy.Parent = RepStorage.FlagContent
local FlagCarrier = {}

local FlagDestroyed = Instance.new("BoolValue",Self)
FlagDestroyed.Name = "flagDestroyed"

--------------------------------------------------------------------------------------------------------------------------------
-- Functions / Methods
--------------------------------------------------------------------------------------------------------------------------------

function destroyFlag(targ)
	if targ ~= FlagHandle then
		local opposingStand = Self.Parent:WaitForChild("RedFlagStand")
		opposingStand.flagDestroyed.Value = true
	else
		RepStorage.GameMessage.Value = "Bravo Team's flag has returned to their base."
		FlagDestroyed.Value = true
	end
	targ:Destroy()
end

function onCarrierDied(player,flag)
	if flag and player then
		RepStorage.GameMessage.Value = player.Name.." has dropped Bravo Team's flag!"
		flag.Parent = workspace
		flag.CanCollide = false
		flag.Anchored = true
		Settings.PickedUp = false
		Settings.Carrier = nil
		if Settings.ReturnFlagOnDrop then
			wait(Settings.FlagRespawnTime)
			if not Settings.AtSpawn and not Settings.PickedUp then
				ReturnFlag:Fire(Settings.TeamColor)
				destroyFlag(flag)
			end
		end
	end
end

function pickupFlag(player)
	RepStorage.GameMessage.Value = ""..player.Name.." has taken Bravo Team's flag!"
	Settings.Carrier = player.Name
	Settings.AtSpawn = false
	Settings.PickedUp = true
	
	local torso = player.Character:FindFirstChild('Torso')
	local humanoid = player.Character:FindFirstChild("Humanoid")
	
	FlagHandle.Parent = player.Character
	FlagHandle.Anchored = false
	FlagHandle.CanCollide = false
	
	local weld = Instance.new('Weld',FlagHandle)
	weld.Name = 'PlayerFlagWeld'
	weld.Part0 = FlagHandle
	weld.Part1 = torso
	weld.C0 = CFrame.new(0,0,-1)
	
	humanoid.Died:connect(function()
		onCarrierDied(player,FlagHandle)
	end)
end

function bindFlagTouched(targ)
	targ.Touched:connect(function(newTarg)
		if Players:GetPlayerFromCharacter(newTarg.Parent) then
			local player = Players:GetPlayerFromCharacter(newTarg.Parent) 
			local humanoid = newTarg.Parent:FindFirstChild('Humanoid')
			if humanoid == nil or humanoid.Health <= 0 then return end
			if player.TeamColor ~= Settings.TeamColor then
				pickupFlag(player)
			else
				if Settings.AtSpawn == false and Settings.PickedUp == false then
					destroyFlag(targ)
				end
			end
		end
	end)
end

function createNewFlag()
	local newFlag = FlagCopy:Clone()
	
	Settings.Carrier = nil
	FlagDestroyed.Value = false
	Settings.AtSpawn = true
	Settings.PickedUp = false
	
	bindFlagTouched(newFlag)
	newFlag.Parent = Self
	FlagHandle = newFlag
end

function bindBaseTouched(base)
	base.Touched:connect(function(otherPart)
		if Players:GetPlayerFromCharacter(otherPart.Parent) then
			local player = Players:GetPlayerFromCharacter(otherPart.Parent)
			if player.TeamColor == Settings.TeamColor then
				if otherPart.Parent:FindFirstChild("FlagHandle") then
					local theFlag = otherPart.Parent:FindFirstChild("FlagHandle")
					if theFlag ~= FlagHandle then
						destroyFlag(theFlag)
						CaptureFlag:Fire(player)
					end
				end
			end
		end
	end)
end

--------------------------------------------------------------------------------------------------------------------------------
-- Method Execution
--------------------------------------------------------------------------------------------------------------------------------

bindFlagTouched(FlagHandle)
bindBaseTouched(FlagStand)

FlagDestroyed.Changed:connect(function(v)
	if v == true then
		createNewFlag()
	end
end)