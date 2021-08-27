AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/gibs/manhack_gib01.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)

	self:SetMaterial("models/props_canal/canal_bridge_railing_01b")

	local phys = self:GetPhysicsObject()

	if phys:IsValid() then
		phys:Wake()
	end
end