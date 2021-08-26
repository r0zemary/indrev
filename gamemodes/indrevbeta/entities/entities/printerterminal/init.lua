AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("imgui.lua")

include("shared.lua")

local interval = 1

function ENT:Initialize()
	self:SetModel("models/props_lab/reciever_cart.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:SetColor(Color(120,120,255))

	self.timer = CurTime()

	local phys = self:GetPhysicsObject()

	if phys:IsValid() then
		phys:Wake()
	end
end

function ENT:Think()
	if CurTime() > self.timer + interval then
		self.timer = CurTime()
		self:SetStoredMoney(0)
		for k,v in pairs(ents.FindByClass("indrevprinter")) do
			if v:IsValid() then
				self:SetStoredMoney(self:GetStoredMoney() + v:GetStoredMoney())
			end
		end
	end
end

function ENT:Use(a,c)
	for k,v in pairs(ents.FindByClass("indrevprinter")) do
		if v:IsValid() then
			SetGlobalInt("money", GetGlobalInt("money") + v:GetStoredMoney())
			v:SetStoredMoney(0)
		end
	end
	if self:GetStoredMoney() > 0 then
		self:EmitSound("ambient/levels/labs/coinslot1.wav")
	end
	self:SetStoredMoney(0)
end