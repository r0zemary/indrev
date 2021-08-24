ENT.Type = "anim"

ENT.PrintName = "Printer"

ENT.Spawnable = true

ENT.Category = "Industrial Revolution Beta"

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "StoredMoney")
	self:NetworkVar("Float", 0, "TimerInterval")
	self:NetworkVar("Int", 1, "UpgradeLevel")
	self:NetworkVar("Int", 2, "UpgradeCost")
end