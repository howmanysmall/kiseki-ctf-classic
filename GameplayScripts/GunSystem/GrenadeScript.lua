ball = script.Parent
local r_storage = game:GetService("ReplicatedStorage")
local _Gv2 = require(r_storage:FindFirstChild("_Gv2"))
damageTag = ball.Damage

function onTouched(hit)
	if hit.Name ~= "Head" then return end
	if hit.Parent == nil then return end
	local humanoid = hit.Parent:findFirstChild("Humanoid")

	if humanoid ~= nil then
		_Gv2:tagHumanoid(ball, humanoid)

		local tag = ball:findFirstChild("creator")

		if tag.Value.Character == humanoid.Parent then
			humanoid:TakeDamage(50)
		else
			_Gv2:DealDamage(tag.Value.Character, humanoid.Parent, damageTag.Value)
		end
	end
end

function explode(hit)
	if hit.Parent == ball.creator.Value.Character then return end
	if hit.Parent.Parent == ball.creator.Value.Character then return end
	if hit.Parent.Parent.Parent == ball.creator.Value.Character then return end

	connection:disconnect()
	ball.Explosion:play()
	local explosion = Instance.new("Explosion")
	explosion.BlastPressure = 0

	if ball.Name == "Mortar" then
		explosion.BlastRadius = 12
	else
		explosion.BlastRadius = 6
	end

	
	explosion.Position = ball.Position
	explosion.Parent = game.Workspace
	explosion.Hit:connect(function(part, distance) onTouched(part) end)
	wait(.3)
	ball:remove()
end

connection = ball.Touched:connect(explode)

wait(5)
ball.Parent = nil