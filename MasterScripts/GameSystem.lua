-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Game System for Kiseki CTF: Classic Edition 
-- Created by shloid (da man!!!)
-------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Services
local Players = game:GetService("Players")
local RepStorage = game:GetService("ReplicatedStorage")

-- Variables
local Stands = {}
local Settings = {
	CTF_Mode = true; -- automatically set to true
	Kills = "Kills";
	Wipeouts = "Wipeouts";
	Captures = "Captures";
	DefaultGameTime = 180;
	FirstBlood = "None",
}

-- Main Game Variables
local FirstBlood = "None"
local CurrentMap = "DemoMap"
local Gamemode = "Intermission"
local GameTime = 15
local RedScore = 0
local BluScore = 0
local MaxCaps = 5

-- Game Essentials
local Maps = RepStorage:WaitForChild("Maps")
local _Gv2 = require(RepStorage:WaitForChild("_Gv2"))
local Sounds = workspace:WaitForChild("Sounds")
local CapFlag = RepStorage:WaitForChild("CaptureFlag")
local ReturnFlag = RepStorage:WaitForChild("ReturnFlag")
local MsgDisplay = RepStorage:WaitForChild("GameMessage")
local TimeDisplay = RepStorage:WaitForChild("GameTime")

local A_Score = RepStorage:WaitForChild("AlphaScore")
local B_Score = RepStorage:WaitForChild("BravoScore")

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Functions / Methods
-------------------------------------------------------------------------------------------------------------------------------------------------------------

function onHumanoidDied(humanoid,player)
	if player:FindFirstChild("leaderstats") then
		local stats = player:FindFirstChild("leaderstats")
		local deaths = stats:FindFirstChild(Settings.Wipeouts)
		if deaths == nil then return end  
		deaths.Value = deaths.Value + 1
		local killer = getKillerOfHumanoidIfStillInGame(humanoid)
		if Settings.FirstBlood == "None" and killer ~= nil then
			Settings.FirstBlood = killer.Name
			Sounds.FirstBlood:Play()
			setMessage(Settings.FirstBlood,"is the first person to kill another player!")
		end
		handleKillCount(humanoid, player)
	end
end

function onPlayerRespawn(property, player)
	if property == "Character" and player.Character then
		local character = player.Character
		local humanoid = character:FindFirstChild("Humanoid")
		if humanoid == nil then return end
		humanoid.Died:connect(function() onHumanoidDied(humanoid, player) end)
	end
end

function getKillerOfHumanoidIfStillInGame(humanoid)
	local tag = nil
	for i,v in pairs(humanoid:GetChildren()) do 
		if v.Name == "creator" or v.Name == "Creator" then
			tag = v
		end
	end
	if tag ~= nil then
		local whodunit = Players:FindFirstChild(tag.Value)
		if whodunit then
			-- didn du nuthin
			return tag.Value
		end
	end
	print("[Server] Cannot find the killer.")
	return nil
end

function resetLeaderboardValues()
	for i,v in pairs(Players:GetPlayers()) do
		if v:FindFirstChild("leaderstats") then
			local vLeaderboard = v:FindFirstChild("leaderstats")
			for i, v2 in pairs(vLeaderboard:GetChildren()) do
				if v2:IsA("IntValue") then
					v2.Value = 0
				end
			end
		end
	end
end

function handleKillCount(humanoid,player)
	if getKillerOfHumanoidIfStillInGame(humanoid) ~= nil then
		local killer = getKillerOfHumanoidIfStillInGame(humanoid)
		if killer:FindFirstChild("leaderstats") then
			local stats = killer:FindFirstChild("leaderstats")
			local kills = stats:FindFirstChild(Settings.Kills)
			if kills == nil then 
				print("[Server] Kills are not within the player's status folder.")
				return 
			else 
				if killer ~= player then
					kills.Value = kills.Value + 1
				end
			end
		end
	end
end

function respawnCharacters()
	for i,v in pairs(Players:GetPlayers()) do
		v:LoadCharacter(true)
	end	
end

function spawnConfig(value)
	if value == true then
		Players.CharacterAutoLoads = true
		respawnCharacters()
	elseif value == false then
		Players.CharacterAutoLoads = false
		for i,v in pairs(workspace:GetChildren()) do
			if Players:GetPlayerFromCharacter(v) then
				local vcChildren = v:GetChildren()
				for i2,v2 in pairs(vcChildren) do
					v2:Destroy()
				end
			end
		end
	end
end

function OnCaptureFlag(player)
	if player:FindFirstChild("leaderstats") then
		local stats = player:FindFirstChild("leaderstats")
		local caps = stats:FindFirstChild(Settings.Captures)
		if caps == nil then return end
		caps.Value = caps.Value + 1
		print("[Server]",player.Name,"has captured a flag.")
		if player.TeamColor == BrickColor.new("Bright red") then
			RedScore = RedScore + 1
			setMessage(player.Name.." has captured Bravo Team's flag!")
		elseif player.TeamColor == BrickColor.new("Bright blue") then
			BluScore = BluScore + 1
			setMessage(player.Name.." has captured Alpha Team's flag!")
		end
		Sounds.CTF:Play()
		if RedScore == MaxCaps or BluScore == MaxCaps then
			GameTime = 0
		end
		wait(5)
		setMessage("")
	end
end

function OnReturnFlag(flagColor)
	local teamFlag = "Alpha"
	if flagColor == BrickColor.new("Bright blue") then
		teamFlag = "Bravo"
	end
	--print("[Server] "..teamFlag.."'s  has returned to their base") 
end

CapFlag.Event:connect(OnCaptureFlag)
ReturnFlag.Event:connect(OnReturnFlag)

function setMessage(text)
	print("[Server] New message:",text)
	spawn(function()
		MsgDisplay.Value = text
		wait(8)
		if MsgDisplay.Value == text then
			MsgDisplay.Value = ""
		end
	end)
end

function setTime()
	TimeDisplay.Value = GameTime
end

function selectMap()
	local returnMap
	local sdk = Maps:GetChildren()
	local mdr = math.random(1,8)
	returnMap = sdk[mdr]:Clone()
	wait(3)
	setMessage("Next Map: "..returnMap.Name)
	wait(5)
	if workspace:FindFirstChild(CurrentMap) then
		workspace:FindFirstChild(CurrentMap):Destroy()
	end
	CurrentMap = returnMap.Name
	returnMap.Parent = workspace
end

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Firing all the main functions.
-------------------------------------------------------------------------------------------------------------------------------------------------------------

Players.PlayerAdded:connect(function(player)
	--------------------------------------------------------------------------------
	-- Setting up the player's stats.
	--------------------------------------------------------------------------------
	
	local stats = Instance.new("Folder",player)
	stats.Name = "leaderstats"
	
	local kills = Instance.new("IntValue",stats)
	kills.Name = Settings.Kills
	
	local wos = Instance.new("IntValue",stats)
	wos.Name = Settings.Wipeouts
	
	if Settings.CTF_Mode == true then
		local caps = Instance.new("IntValue",stats)
		caps.Name = Settings.Captures
	end
	
	script.ScreenGui:Clone().Parent = player:WaitForChild("PlayerGui")
	script.FPSCounter:Clone().Parent = player:WaitForChild("PlayerGui")
	
	--------------------------------------------------------------------------------
	-- Setting up the player's character.
	--------------------------------------------------------------------------------
	
	player.CharacterAdded:connect(function(character)
		local humanoid = character:WaitForChild("Humanoid")
		humanoid.Died:connect(function() onHumanoidDied(humanoid, player) end)
	end)
	
	player.Changed:connect(function(property) onPlayerRespawn(property, player) end)
end)

print("[Server] Kiseki CTF Classic Game System has loaded.")

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Master Loop
-------------------------------------------------------------------------------------------------------------------------------------------------------------

while wait(1) do
	if _Gv2.debug == false then
		if workspace:FindFirstChild("DemoMap") then
			for i,v in pairs(workspace.DemoMap:GetChildren()) do
				v:Destroy()
			end
		end
		--------------------------------------------------------------------------------
		GameTime = GameTime - 1
		A_Score.Value = RedScore
		B_Score.Value = BluScore
		if Gamemode == "Intermission" then
			setMessage("Game starts in: "..GameTime.." seconds.")
			if GameTime == 0 then
				print("[Server] Selecting map...")
				setMessage("Selecting map...")
				selectMap()
				Gamemode = "54321"
				GameTime = 6
			end
		elseif Gamemode == "54321" then
			setMessage(GameTime.."...")
			if GameTime == 0 then
				print("[Server] Game has officially started.")
				setMessage("Go!")
				Gamemode = "InGame"
				GameTime = Settings.DefaultGameTime
				spawnConfig(true)
			end
		elseif Gamemode == "InGame" then
			setTime(GameTime)
			if GameTime == 0 then
				print("[Server] Game has ended. Determining the winner of the game.")
				setMessage("The game has ended!")
				Gamemode = "GameEnded"
				GameTime = 7
				spawnConfig(false)
				wait(5)
			end
		elseif Gamemode == "GameEnded" then
			setMessage("Determining winners...")
			if GameTime == 0 then
				if RedScore > BluScore then
					print("[Server] Alpha Team has won.")
					setMessage("Alpha Team wins!")
					Sounds.Win:Play()	
				elseif BluScore > RedScore then
					print("[Server] Bravo Team has won.")
					setMessage("Bravo Team wins!")
					Sounds.Win:Play()	
				else
					print("[Server] It was a tie.")
					setMessage("Tied! No one wins... :(")
				end
				
				wait(8)
				print("[Server] Intermission has started...")
				GameTime = 60
				RedScore = 0
				BluScore = 0
				Gamemode = "Intermission"
				Settings.FirstBlood = "None"
				resetLeaderboardValues()
			end
		end
		--------------------------------------------------------------------------------
	else
		if Players.CharacterAutoLoads == false then
			spawnConfig(true)
		end
	end
end
