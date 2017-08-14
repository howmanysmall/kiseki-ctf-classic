--------------------------------------------------------------------------------------------------------------------------
-- UI System
-- Scripted by shloid
--------------------------------------------------------------------------------------------------------------------------

-- Services
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local RepStorage = game:GetService("ReplicatedStorage")

-- Replicated Storage Content
local _Gv2 = require(RepStorage:FindFirstChild("_Gv2"))
local GameMsg = RepStorage:WaitForChild("GameMessage")
local GameTime = RepStorage:WaitForChild("GameTime")
local A_Score = RepStorage:WaitForChild("AlphaScore")
local B_Score = RepStorage:WaitForChild("BravoScore")
local ServerMsg = RepStorage:WaitForChild("ServerMessage")

-- Variables
local Self = script.Parent
local ClassInfo = require(script:WaitForChild("ClassInfo"))
local TileModule = require(script:WaitForChild("TileModule"))

-- UI
local Sounds = Self:WaitForChild("Sounds")
local UIInfo = Self:WaitForChild("Info")
local UIAmmo = Self:WaitForChild("Ammo")
local UIClass = Self:WaitForChild("Class")
local UIClassInfo = UIClass:WaitForChild("Info")
local UIEffects = Self:WaitForChild("Effects")
local UICurrentClass = Self:WaitForChild("CurrentClass")
local UIFadeFrame = Self:WaitForChild("FadeFrame")
local InnerLabel = UIFadeFrame:WaitForChild("InnerLabel")
local OuterLabel = UIFadeFrame:WaitForChild("OuterLabel")
local UIFadeBG = UIFadeFrame:WaitForChild("BG")
local UIJetFuel = Self:WaitForChild("JetFuel")
local ClassButton = Self:WaitForChild("ClassButton")
local UpdateClassUI = Self:WaitForChild("UpdateClassUI")

-- Info Variables
local IRed = UIInfo:WaitForChild("Red")
local IBlu = UIInfo:WaitForChild("Blue")
local IMsg = UIInfo:WaitForChild("MessageLabel")
local ITme = UIInfo:WaitForChild("TimeLabel")

-- Player
local Player = Self.Parent.Parent
Player:WaitForChild("PlayerGui"):SetTopbarTransparency(0)
local ClassValue = Player:WaitForChild("Class")
local CurrentClass = ClassValue.Value
local AmmoUI = Player:WaitForChild("AmmoHUD")
local StatusUI = Player:WaitForChild("Status")
local UIControl = (Player:FindFirstChild("AmmoHudControl") or Instance.new("BindableEvent",Player))
UIControl.Name = "AmmoHudControl"
TileModule:tileBackgroundTexture(UIFadeBG)

-- Assets (for the future)
--local assets = {171332333,30624305,19860604,12222200,2800815,2766589,2766581,2774556,13510737,16211041,16211030,2767096,3087031,3086666,2974249,2974000}
--_Gv2:LoadAssets(assets)

--------------------------------------------------------------------------------------------------------------------------
-- Functions / Methods
--------------------------------------------------------------------------------------------------------------------------

function GenerateMessage(text,color)
	if text == nil or color == nil then return end
	StarterGui:SetCore("ChatMakeSystemMessage", {
		Text = text;
		Color = color;
		Font = Enum.Font.SourceSansBold;
		FontSize = Enum.FontSize.Size18;
	})
end

function changeColor(type)
	local types = {
		[0] = Color3.new(255/255, 0, 0),
		[1] = Color3.new(255/255, 170/255, 0),
		[2] = Color3.new(0, 255/255, 0)
	}
	if types[type] then
		return types[type]
	end	
end

function changeClassType(type)
	local types = {
		[0] = "OFFENSIVE",
		[1] = "DEFENSIVE",
		[2] = "SUPPORTIVE"
	}
	if types[type] then
		return types[type]
	end	
end

function FadeInOut(t)
	if t == true then
		for i = 1, 10 do
			wait()
			UIFadeFrame.BackgroundTransparency = UIFadeFrame.BackgroundTransparency + .1
			InnerLabel.ImageTransparency = InnerLabel.ImageTransparency + .1
			OuterLabel.ImageTransparency = OuterLabel.ImageTransparency + .1
			for i,v in pairs(UIFadeBG:GetChildren()) do
				if v:IsA("ImageLabel") then
					v.ImageTransparency = v.ImageTransparency + .1
				end
			end
		end
		InnerLabel.Visible = false
		OuterLabel.Visible = false
		Player:WaitForChild("PlayerGui"):SetTopbarTransparency(.5)
		UIFadeFrame.TextButton.Visible = false
	elseif t == false then
		InnerLabel.Visible = true
		OuterLabel.Visible = true
		for i = 1, 10 do
			wait()
			UIFadeFrame.BackgroundTransparency = UIFadeFrame.BackgroundTransparency - .1
			InnerLabel.ImageTransparency = InnerLabel.ImageTransparency - .1
			OuterLabel.ImageTransparency = OuterLabel.ImageTransparency - .1
			for i,v in pairs(UIFadeBG:GetChildren()) do
				if v:IsA("ImageLabel") then
					v.ImageTransparency = v.ImageTransparency - .1
				end
			end
		end
		Player:WaitForChild("PlayerGui"):SetTopbarTransparency(0)
		UIFadeFrame.TextButton.Visible = true
	end
end

UpdateClassUI.Event:connect(function(class)
	if ClassInfo[class] == nil then return end
	local selectedClass = ClassInfo[class]
	local selectedColor = changeColor(selectedClass.Type)
	local classType = changeClassType(selectedClass.Type)
	
	CurrentClass = class
	UIClassInfo:WaitForChild("ClassName").Text = class
	UIClassInfo:WaitForChild("ClassName"):WaitForChild("ClassType").TextColor3 = selectedColor
	UIClassInfo:WaitForChild("ClassName"):WaitForChild("ClassType").Text = classType.." CLASS"
	UIClassInfo:WaitForChild("ClassName").Visible = true
	UIClassInfo:WaitForChild("ClassBio").Text = selectedClass.Bio
	UIClassInfo:WaitForChild("ClassInput").Text = "Input: "..selectedClass.Input.."%"
	UIClassInfo:WaitForChild("ClassOutput").Text = "Output: "..selectedClass.Output.."%"
	UIClassInfo:WaitForChild("ClassSpeed").Text = "Movement Speed: "..selectedClass.Walkspeed
	UIClassInfo:WaitForChild("ClassAbilities").Text = "Abilities: "..table.concat(selectedClass.Abilities,", ")
end)

UIClassInfo.SelectButton.MouseEnter:connect(function()
	Sounds.Hover:Play()
end)

UIClassInfo.SelectButton.MouseButton1Click:connect(function()
	Sounds.Select:Play()
	if CurrentClass then
		UIClass.Visible = false
		ClassValue.Value = CurrentClass
		GenerateMessage("[Client] You have selected "..CurrentClass.." as your next class.",Color3.new(0,1,1))
	end
end)

for i,v in pairs(UIClass:WaitForChild("List"):GetChildren()) do
	if v:IsA("TextButton") then
		v.MouseEnter:connect(function()
			Sounds.Hover:Play()
		end)
		v.MouseButton1Click:connect(function()
			UpdateClassUI:Fire(v.Text)
			Sounds.Select:Play()
		end)
	end
end

UIControl.Event:connect(function(yes)
	UIAmmo.Visible = yes
end)

GameMsg.Changed:connect(function(v)
	IMsg.Text = v 
	if v == "Go!" then
		FadeInOut(true)
	elseif v == "The game has ended!" then
		FadeInOut(false)
	end
	
	if v == "" or v == " " or v == "  " then
		-- nothing lol
	else
		GenerateMessage("[Server] "..v,Color3.new(1,1,0))
	end
end)

ServerMsg.Changed:connect(function(v)
	GenerateMessage("[Server] "..v,Color3.new(1,1,0))
end)

ClassValue.Changed:connect(function(v)
	if Player.Character and GameTime.Value > 0 then
		if CurrentClass == "None" then
			CurrentClass = v
			UICurrentClass.Text = "Current Class: "..v
		else
			local pChar = Player.Character
			if pChar:FindFirstChild("Humanoid") then
				local pHum = pChar:FindFirstChild("Humanoid")
				spawn(function()
					pHum.Died:connect(function()
						UICurrentClass.Text = "Current Class: "..v
					end)
				end)
			end
		end
	else
		UICurrentClass.Text = "Current Class: "..v
	end
end)

GameTime.Changed:connect(function(v)
	if v == 0 then
		ITme.Text = ""
	else 
		ITme.Text = v 
	end
end)

A_Score.Changed:connect(function(v)
	IRed.Caps.Text = v
end)

B_Score.Changed:connect(function(v)
	IBlu.Caps.Text = v
end)

UIS.InputBegan:connect(function(input)
	if input.UserInputType == Enum.UserInputType.Keyboard then
		if input.KeyCode == Enum.KeyCode.V then
			if UIClass.Visible == false then
				UIClass.Visible = true
			else
				UIClass.Visible = false
			end
		end
	end
end)

if _Gv2.debug == true then
	UIFadeFrame.BackgroundTransparency = 1
	UIFadeFrame.Visible = false
end

spawn(function()
	while wait() do
		UIAmmo.AmmoLabel.Text = AmmoUI.Text
		UIEffects.Text = "You are currently under the effects of: "..StatusUI.Text
		if Player.Character ~= nil then
			local pValues = Player.Character:FindFirstChild("Values")
			if pValues then
				if pValues:FindFirstChild("Fuel") then
					local pFuel = pValues:FindFirstChild("Fuel")
					UIJetFuel.Text = "Jet Fuel: "..pFuel.Value.."%"
				end
			else
				UIJetFuel.Text = ""
			end
		else
			UIJetFuel.Text = ""
		end
	end
end)
