AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("imgui.lua")

include("shared.lua")

local nearbyGenerator = false

function ENT:Initialize()
	self:SetModel("models/props_wasteland/laundry_washer001a.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:SetUpgradeCost(200)
	self:SetUpgradeLevel(1)
	self:SetTimerInterval(15)

	self.timer = CurTime()
	self:SetTimerProgress(self.timer)

	local phys = self:GetPhysicsObject()

	if phys:IsValid() then
		phys:Wake()
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
		if nearbyGenerator == true then
			local fuel = ents.Create("unrefinedfuel")
			fuel:SetPos(self:LocalToWorld(Vector(0,0,55)))
			fuel:Spawn()
			self:EmitSound("items/suitchargeno1.wav")
		end
	end
end