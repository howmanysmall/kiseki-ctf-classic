local ball = script.Parent
local r_storage = game:GetService("ReplicatedStorage")
local _Gv2 = require(r_storage:FindFirstChild("_Gv2"))
damageTag = ball.Damage

function makeFlak()
	for i=1,1 do
		local s = Instance.new("Part")
		s.Shape = 1 -- block
		s.formFactor = 2 -- plate
		s.Size = Vector3.new(1,.4,1)
		s.BrickColor = BrickColor.Black()
		local v = Vector3.new(math.random(-1,1), math.random(0,1), math.random(-1,1))
		s.Velocity = 15 * v
		s.CFrame = CFrame.new(ball.Position - ball.Velocity.unit * 10, ball.Position + v)
		s.Parent = game.Workspace
		game:service("Debris"):AddItem(s, .3)
	end
end

function onTouched(hit)
	if hit.Parent == ball.creator.Value.Character then return end
	if hit.Parent.Parent == ball.creator.Value.Character then return end
	if hit.Parent.Parent.Parent == ball.creator.Value.Character then return end
	if hit.Parent == nil then return end
	if hit.Name == "Bullet" then return end
	if hit.Name == "Handle" then return end

	local humanoid = hit.Parent:findFirstChild("Humanoid")

	if humanoid == nil then
		humanoid = hit.Parent.Parent:findFirstChild("Humanoid")
	end

	if humanoid ~= nil then
		_Gv2:tagHumanoid(ball, humanoid)

		local tag = ball:findFirstChild("creator")
		if hit.Name == "Head" then
			damageTag.Value = damageTag.Value * 2
		end

		-- VAMPIRIC VIM
		if humanoid.Parent.Class.Value == "Vampire" then
			if hit.Name ~= "Head" and hit.Name ~= "Torso" then
				damageTag.Value = damageTag.Value / 2
			end
		end

		_Gv2:DealDamage(tag.Value.Character, humanoid.Parent, damageTag.Value)
	else
		makeFlak()
	end

	ball:remove()
end

connection = ball.Touched:connect(onTouched)

delay(5, function() ball.Parent = nil end)

while true do
	wait(.25)
	ball.CFrame = CFrame.new(ball.Position, ball.Position + ball.Velocity.unit)
end