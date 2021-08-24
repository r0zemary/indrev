ENT.Type = "anim"

ENT.PrintName = "Generator"

ENT.Spawnable = true

ENT.Category = "Industrial Revolution Beta"

function ENT:SetupDataTables()
	self:NetworkVar("Float",0,"Fuel")
	self:NetworkVar("Bool",0,"Toggled")
	self:NetworkVar("Int", 0, "UpgradeLevel")
	self:NetworkVar("Int", 1, "UpgradeCost")
	self:NetworkVar("Float", 2, "MaxFuel")
end