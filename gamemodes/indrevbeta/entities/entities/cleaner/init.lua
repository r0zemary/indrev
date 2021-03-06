AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("imgui.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_wasteland/laundry_washer003.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)

	self:SetStoredOre(0)
	self:SetMaxOre(3)
	self:SetUpgradeLevel(1)
	self:SetUpgradeCost(600)
	self:SetTimerInterval(20)

	self.timer = CurTime()
	self:SetTimerProgress(self.timer)

	local phys = self:GetPhysicsObject()

	if phys:IsValid() then
		phys:Wake()
	end
end

function ENT:StartTouch(ent)
	if ent:GetClass() == "ore" and self:GetStoredOre() < self:GetMaxOre() then
		ent:Remove()
		self:SetStoredOre(self:GetStoredOre() + 1)
		self:SetStoredOre(math.Clamp(self:GetStoredOre(), 0, self:GetMaxOre()))
		local nearbyGenerator = false
		for k,v in pairs(ents.FindInSphere(self:GetPos(), 1500)) do
			if v:IsValid() and v:GetClass() == "indrevgenerator" and v:GetToggled() == true then
				nearbyGenerator = true
			end
		end
		if nearbyGenerator == true then
			self:EmitSound("ambient/machines/machine_whine1.wav")
		end
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
		if self:GetStoredOre() > 0 and nearbyGenerator == true then
			self:SetStoredOre(self:GetStoredOre() - 1)
			local ore = ents.Create("cleansedore")
			ore:SetPos(self:LocalToWorld(Vector(0,50,0)))
			ore:SetOreValue(20 * self:GetUpgradeLevel())
			ore:Spawn()
			self.timer = CurTime()
			self:StopSound("ambient/machines/machine_whine1.wav")
		end
	end

end