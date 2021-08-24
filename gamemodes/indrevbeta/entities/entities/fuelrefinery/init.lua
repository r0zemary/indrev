AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("imgui.lua")

include("shared.lua")

local nearbyGenerator = false

function ENT:Initialize()
	self:SetModel("models/props_lab/powerbox01a.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:SetFuel(0)
	self:SetMaxFuel(10)
	self:SetUpgradeLevel(1)
	self:SetUpgradeCost(150)
	self:SetTimerInterval(5)

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
	nearbyGenerator = false
	for k,v in pairs(ents.FindInSphere(self:GetPos(), 1000)) do
		if v:IsValid() and v:GetClass() == "indrevgenerator" and v:GetToggled() == true then
			nearbyGenerator = true
		end
	end
	if CurTime() > self.timer + self:GetTimerInterval() then
		self.timer = CurTime()
		self:SetTimerProgress(self.timer)
		if self:GetFuel() > 0 and nearbyGenerator == true then
			self:SetFuel(self:GetFuel() - 1)
			local fuel = ents.Create("fuel")
			fuel:SetPos(self:LocalToWorld(Vector(0,0,50)))
			fuel:Spawn()
			self:EmitSound("buttons/button4.wav")
		end
	end

end