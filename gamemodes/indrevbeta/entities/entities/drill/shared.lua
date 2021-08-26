ENT.Type = "anim"

ENT.PrintName = "Drill"

ENT.Spawnable = true

ENT.Category = "Industrial Revolution Beta"

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "UpgradeCost")
	self:NetworkVar("Int", 1, "UpgradeLevel")
	self:NetworkVar("Float", 1, "TimerInterval")
	self:NetworkVar("Float", 0, "TimerProgress")
end