ball = script.Parent
local invelocity = ball.Velocity
wait()

function onTouched(hit)
	if hit.Anchored == false then
	hit:BreakJoints()
	hit.Velocity = ball.Velocity
	end
	ball.Velocity = invelocity
end

connection = script.Parent.Touched:connect(onTouched)



wait(2)

ball.Parent = nil
