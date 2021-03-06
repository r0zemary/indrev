AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("imgui.lua")

include("shared.lua")



function ENT:Initialize()
	self:SetModel("models/props_lab/powerbox01a.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:SetFuel(0)
	self:SetMaxFuel(10)
	self:SetUpgradeLevel(1)
	self:SetUpgradeCost(500)
	self:SetTimerInterval(8)
	self:SetColor(Color(120,120,120))

	self.timer = CurTime()
	self:SetTimerProgress(self.timer)

	local phys = self:GetPhysicsObject()

	if phys:IsValid() then
		phys:Wake()
	end
end

function ENT:StartTouch(ent)
	if ent:GetClass() == "unrefinedfuel" and self:GetFuel() < self:GetMaxFuel() then
		ent:Remove()
		self:SetFuel(self:GetFuel() + 1)
		self:SetFuel(math.Clamp(self:GetFuel(), 0, self:GetMaxFuel()))
	end
end

function ENT:Think()
	if CurTime() > self.timer + self:GetTimerInterval() then
		self.timer = CurTime()
		self:SetTimerProgress(self.timer)
		local nearbyGenerator = false
		for k,v in pairs(ents.FindInSphere(self:GetPos(), 1500)) do
			if v:IsValid() and v:GetClass() == "indrevgenerator" and v:GetToggled() == true then
				nearbyGenerator = true
			end
		end
		if self:GetFuel() > 0 and nearbyGenerator == true then
			self:SetFuel(self:GetFuel() - 1)
			local fuel = ents.Create("diesel")
			fuel:SetPos(self:LocalToWorld(Vector(0,0,50)))
			fuel:Spawn()
			self:EmitSound("ambient/machines/machine1_hit2.wav")
		end
	end

end