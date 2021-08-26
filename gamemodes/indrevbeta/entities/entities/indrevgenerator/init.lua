AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("imgui.lua")

include("shared.lua")

local interval = 10

function ENT:Initialize()
	self:SetModel("models/props_vehicles/generatortrailer01.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:SetToggled(false)
	self:SetFuel(0)
	self:SetUpgradeCost(200)
	self:SetMaxFuel(100)
	self:SetUpgradeLevel(1)

	self.timer = CurTime()

	local phys = self:GetPhysicsObject()

	if phys:IsValid() then
		phys:Wake()
	end
end

function ENT:Use(ply)
	if self:GetToggled() == false and self:GetFuel() > 0 then
		self:SetToggled(true)
		self:EmitSound("vehicles/APC/apc_start_loop3.wav")
	else
		self:SetToggled(false)
		self:StopSound("vehicles/APC/apc_start_loop3.wav")
		self:EmitSound("vehicles/APC/apc_shutdown.wav")
	end

end

function ENT:StartTouch(ent)
	if ent:GetClass() == "fuel" then
		ent:Remove()
		self:SetFuel(self:GetFuel() + 7)
		self:SetFuel(math.Clamp(self:GetFuel(), 0, self:GetMaxFuel()))
	end
end

function ENT:Think()
	local tally = 0
	local gencount = 1
	for k,v in pairs(ents.FindInSphere(self:GetPos(), 1500)) do
		if v:IsValid() and v:GetClass() == "indrevprinter" or v:GetClass() == "fuelrefinery" or v:GetClass() == "fuelproducer" or v:GetClass() == "drill" or v:GetClass() == "cleaner" or v:GetClass() == "dieselrefinery" then
			tally = tally + 1
		end
		if v:IsValid() and v:GetClass() == "indrevgenerator" and v:GetToggled() == true then
			gencount = gencount + 1
			tally = tally / (gencount * 0.65)
		end
	end

	if self:GetFuel() > 0 and self:GetToggled() == true and CurTime() > self.timer + interval then
		self.timer = CurTime()
		self:SetFuel(self:GetFuel() - (1 + tally))
	elseif self:GetFuel() <= 0 and self:GetToggled() == true then
		self:SetToggled(false)
		self:SetFuel(0)
		self:StopSound("vehicles/APC/apc_start_loop3.wav")
	end
end