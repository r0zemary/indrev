AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("imgui.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_wasteland/laundry_dryer002.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:SetColor(Color(89, 122, 143, 255))
	self:SetFuel(0)
	self:SetMaxFuel(50)
	self:SetUpgradeLevel(1)
	self:SetUpgradeCost(2000)
	self:SetTimerInterval(12)
	self:SetOre(0)
	self:SetMaxOre(6)

	self.timer = CurTime()
	self:SetTimerProgress(self.timer)

	local phys = self:GetPhysicsObject()

	if phys:IsValid() then
		phys:Wake()
	end
end

function ENT:StartTouch(ent)
	if ent:GetClass() == "diesel" then
		ent:Remove()
		self:SetFuel(self:GetFuel() + 5)
		self:SetFuel(math.Clamp(self:GetFuel(), 0, self:GetMaxFuel()))
		self:EmitSound("ambient/machines/machine1_hit1.wav", 75, 110)
	elseif ent:GetClass() == "cleansedore" and self:GetOre() < self:GetMaxOre() then
		ent:Remove()
		self:SetOre(self:GetOre() + 1)
		self:SetOre(math.Clamp(self:GetOre(), 0, self:GetMaxOre()))
		self:EmitSound("ambient/machines/machine1_hit1.wav", 75, 60)
	end
end

function ENT:Think()
	if CurTime() > self.timer + self:GetTimerInterval() then
		self.timer = CurTime()
		self:SetTimerProgress(self.timer)
		if self:GetFuel() >= 12 and self:GetOre() > 0 then
			self:SetFuel(self:GetFuel() - 12)
			self:SetOre(self:GetOre() - 1)
			local scrap = ents.Create("scrapmetal")
			scrap:SetPos(self:LocalToWorld(Vector(55,0,30)))
			scrap:Spawn()
			self:EmitSound("physics/plastic/plastic_barrel_break2.wav", 75, 80)
		end
	end
end