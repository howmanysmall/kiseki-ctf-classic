-------------------------------------------------------------------------------------------------------------------------------------------
-- Kiseki CTF: Classic Edition Gun System
-- Scripted by Clockwork, Modified by shloid
-------------------------------------------------------------------------------------------------------------------------------------------

-- Services
local Rep = game:GetService("ReplicatedStorage")
local _Gv2 = require(Rep:FindFirstChild("_Gv2"))

-- Variables
local Ball = script.Parent
local damageTag = Ball.Damage
local CreatorV = Ball:findFirstChild("creator")
local Creator = CreatorV.Value
local ExplosionSound = (Ball:FindFirstChild("Explosion") or nil)

-------------------------------------------------------------------------------------------------------------------------------------------
-- Functions / Methods
-------------------------------------------------------------------------------------------------------------------------------------------

function onTouched(hit)
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

function explode(hit)
	connection:disconnect()
	if ExplosionSound ~= nil then
		ExplosionSound:Play()
	end
	
	local explosion = Instance.new("Explosion",workspace)
	explosion.BlastPressure = 10000
	explosion.DestroyJointRadiusPercent = 0
	explosion.BlastRadius = 12
	explosion.Position = Ball.Position
	explosion.Hit:connect(function(part, distance)
		 onTouched(part)
	end)
	
	wait(.3)
	Ball:Destroy()
end

connection = Ball.Touched:connect(explode)

spawn(function()
	wait(5)
	Ball.Parent = nil
end)
