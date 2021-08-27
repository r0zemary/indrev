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
	self:SetColor(Color(127, 101, 63, 255))

	self:SetMetal(0)
	self:SetMaxMetal(8)
	self:SetUpgradeLevel(1)
	self:SetUpgradeCost(1000)
	self:SetTimerInterval(10)

	self.timer = CurTime()
	self:SetTimerProgress(self.timer)

	local phys = self:GetPhysicsObject()

	if phys:IsValid() then
		phys:Wake()
	end
end

function ENT:StartTouch(ent)
	if ent:GetClass() == "scrapmetal" and self:GetMetal() < self:GetMaxMetal() then
		ent:Remove()
		self:SetMetal(self:GetMetal() + 1)
		self:SetMetal(math.Clamp(self:GetMetal(), 0, self:GetMaxMetal()))
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
		if self:GetMetal() >= 2 and nearbyGenerator == true then
			self:SetMetal(self:GetMetal() - 2)
			local refined = ents.Create("refinedmetal")
			refined:SetPos(self:LocalToWorld(Vector(0,0,50)))
			refined:Spawn()
			self:EmitSound("ambient/machines/machine1_hit2.wav", 75, 80)
		end
	end

end