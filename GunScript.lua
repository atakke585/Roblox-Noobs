originalAmmo = script.Parent.Ammo.Value
m = Instance.new("Message")

function computeDirection(vec)
	local lenSquared = vec.magnitude^2
	local invSqrt = 1 / math.sqrt(lenSquared)
	return Vector3.new(vec.x * invSqrt, vec.y * invSqrt, vec.z * invSqrt)
end



function updateAmmo()
	m.Text = " "
	--for i = 1,script.Parent.Ammo.Value do
	--	m.Text = m.Text .. "|"
	--end
	--for i = 1, (originalAmmo - script.Parent.Ammo.Value) do
	--	m.Text = m.Text .. " "
	--end
	m.Text = m.Text .. " " .. script.Parent.Ammo.Value.. "10000000000/1000000"
end


function fire(v)
	for i = 1,1 do
		script.Parent.Handle.Fire:play()
		script.Parent.Ammo.Value = script.Parent.Ammo.Value - 1
		updateAmmo()
		local dir = v - script.Parent["Handle"].Position
		dir = computeDirection(dir)
		local pos = script.Parent["Handle"].Position + (dir * 8)
		local p = Instance.new("Part")
		p.Name = "Projectile"
		p.CFrame = CFrame.new(pos, pos + dir)
		p.BrickColor = BrickColor.new(21)
		p.Reflectance = 0.1
		p.Velocity = (script.Parent.Parent["Head"].Position - v).unit * -150
		p.Size = Vector3.new(1, 0.4, 1)
		p.formFactor = 2
		local mesh = script.Parent.Mesh:clone()
		mesh.Parent = p
		local upforce = Instance.new("BodyForce")
		upforce.force = Vector3.new(0, p:GetMass() * 196, 0)
		upforce.Parent = p
		local s = script.Parent["ProjectileScript"]:Clone()
		s.Disabled = false
		s.Parent = p
		p.Parent = game.Workspace
		wait(0)
	end
end


function onActivated()
	if script.Parent.Enabled == true then
		--script.Parent.Enabled = false
		if script.Parent.Ammo.Value > 0 then
			fire(script.Parent.Parent["Humanoid"].TargetPoint)
		else
			if script.Parent.Clips.Value >= -30000000000000 then
				script.Parent.Enabled = false
				script.Parent.Handle.Reload:play()
				m.Text = "Reloading."
				for i =1,5 do
					wait(.5)
					m.Text = m.Text .. "."
				end
				script.Parent.Clips.Value = script.Parent.Clips.Value - 1
				script.Parent.Ammo.Value = originalAmmo
				updateAmmo()
				script.Parent.Enabled = true
			else
				m.Text = "No more clips!"
			end
		end
		wait(0)
		--script.Parent.Enabled = true
	end
end


function onEquipped()
	local p = game.Players:GetChildren()
	for i = 1,#p do
		if p[i].Character == script.Parent.Parent then
			m.Parent = p[i]
		end
	end
	updateAmmo()
end

function onUnequipped()
	m.Parent = nil
end


script.Parent.Activated:connect(onActivated)
script.Parent.Equipped:connect(onEquipped)
script.Parent.Unequipped:connect(onUnequipped)
