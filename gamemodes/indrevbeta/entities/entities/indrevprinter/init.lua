AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("imgui.lua")

include("shared.lua")

local nearbyGenerator = false

function ENT:Initialize()
	self:SetModel("models/props_lab/reciever_cart.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:SetTimerInterval(1)
	self:SetUpgradeLevel(1)
	self:SetUpgradeCost(150)

	self.timer = CurTime()

	local phys = self:GetPhysicsObject()

	if phys:IsValid() then
		phys:Wake()
	end
end

function ENT:StartTouch(ent)
	if ent:GetClass() == "cleansedore" then
		ent:Remove()
		self:SetStoredMoney(self:GetStoredMoney() + ent:GetOreValue())
	end
end

function ENT:Think()
	if CurTime() > self.timer + self:GetTimerInterval() then
		self.timer = CurTime()
		nearbyGenerator = false
		for k,v in pairs(ents.FindInSphere(self:GetPos(), 1500)) do
			if v:IsValid() and v:GetClass() == "indrevgenerator" and v:GetToggled() == true then
				nearbyGenerator = true
			end
		end
		if nearbyGenerator == true then
			self:SetStoredMoney(self:GetStoredMoney() + 1)
		end
	end
end

function ENT:Use(a,c)
	SetGlobalInt("money", GetGlobalInt("money") + self:GetStoredMoney())
	if self:GetStoredMoney() > 0 then
		self:EmitSound("ambient/levels/labs/coinslot1.wav")
	end
	self:SetStoredMoney(0)
end