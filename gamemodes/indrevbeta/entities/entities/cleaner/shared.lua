ENT.Type = "anim"

ENT.PrintName = "Fuel"

ENT.Spawnable = true

ENT.Category = "Industrial Revolution Beta"

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "UpgradeCost")
	self:NetworkVar("Int", 1, "UpgradeLevel")
	self:NetworkVar("Int", 2, "TimerInterval")
	self:NetworkVar("Int", 3, "StoredOre")
	self:NetworkVar("Int", 4, "MaxOre")
	self:NetworkVar("Float", 0, "TimerProgress")
end