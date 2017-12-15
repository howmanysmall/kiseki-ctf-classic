local game = game
local require = require
local script = script
local wait = wait
local spawn = spawn
local Instance = Instance local Instance_new = Instance.new
--@services
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
--@main
local _Gv2 = require(ReplicatedStorage:FindFirstChild("_Gv2"))

local Ball = script.Parent
local damageTag = Ball.Damage
local CreatorV = Ball:FindFirstChild("creator")
local Creator = CreatorV.Value
local ExplosionSound = Ball:FindFirstChild("Explosion") or nil

local function OnTouched(Hit)
	if hit.Parent == nil then return end
	local humanoid = hit.Parent:findFirstChild("Humanoid")
	if humanoid then
		_Gv2:tagHumanoid(Ball, humanoid)
		if Creator.Character == humanoid.Parent then
			humanoid:TakeDamage(20)
		else
			_Gv2:DealDamage(Creator.Character, humanoid.Parent, damageTag.Value)
		end
	end
end

local function explode(hit)
	connection:Disconnect()
	if ExplosionSound then
		ExplosionSound:Play()
	end
	local explosion = Instance_new("Explosion")
	explosion.BlastPressure = 10000
	explosion.DestroyJointRadiusPercent = 0
	explosion.BlastRadius = 12
	explosion.Position = Ball.Position
	explosion.Parent = Workspace
	explosion.Hit:Connect(function(part, distance)
		 OnTouched(part)
	end)
	wait(0.3)
	Ball:Destroy()
end

connection = Ball.Touched:Connect(explode)

spawn(function()
	wait(5)
	Ball.Parent = nil
end)
