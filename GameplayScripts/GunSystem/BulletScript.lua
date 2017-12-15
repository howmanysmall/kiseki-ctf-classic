----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- BulletScript
-- Scripted by clockwork, Modified by shloid (da man!!!)
----------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Services
local Debris = game:GetService("Debris")
local Players = game:GetService("Players")
local RepStorage = game:GetService("ReplicatedStorage")

-- Self
local ball = script.Parent
local _Gv2 = require(RepStorage:FindFirstChild("_Gv2"))
local CreatorV = ball:WaitForChild("creator")
local Creator = CreatorV.Value
local damageTag = 45

----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Functions / Methods
----------------------------------------------------------------------------------------------------------------------------------------------------------------

function makeFlak()
	for i = 1, 1 do
		local s = Instance.new("Part")
		s.Size = Vector3.new(1, 0.4, 1)
		if ball.Name == "SoulBolt" then
			s.BrickColor = Color3.fromRGB(255, 255, 255)
		else
			s.BrickColor = Color3.new(0, 0, 0)
		end
		s.Parent = workspace
		local v = Vector3.new(math.random(-1, 1), math.random(0, 1), math.random(-1, 1))
		s.Velocity = 15 * v
		s.CFrame = CFrame.new(ball.Position - ball.Velocity.unit * 10, ball.Position + v)
		Debris:AddItem(s, 0.3)
	end
end

ball.Touched:connect(function(hit)
	if hit.Parent == nil or hit.Parent == Creator.Character then makeFlak() return end
	local hum = hit.Parent:FindFirstChild("Humanoid")
	if hum then
		if hit.Parent:FindFirstChild("Class") then
			local hitClass = hit.Parent:FindFirstChild("Class")
			if _Gv2.DemonPeople[hitClass.Value] and ball.Name == "SoulBolt" then
				damageTag = 67.5
			end
		end
		_Gv2:DealDamage(Creator.Character, hit.Parent, damageTag)
		makeFlak()
	else
		makeFlak()
	end
	ball:Destroy()
end)

spawn(function()
	while wait(0.3) do
		ball.CFrame = CFrame.new(ball.Position, ball.Position + ball.Velocity.unit)
	end
end)
