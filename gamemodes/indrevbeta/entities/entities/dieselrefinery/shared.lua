ENT.Type = "anim"

ENT.PrintName = "Diesel Refinery"

ENT.Spawnable = true

ENT.Category = "Industrial Revolution Beta"

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Fuel")
	self:NetworkVar("Int", 1, "MaxFuel")
	self:NetworkVar("Int", 2, "TimerInterval")
	self:NetworkVar("Int", 3, "UpgradeCost")
	self:NetworkVar("Int", 4, "UpgradeLevel")
	self:NetworkVar("Float", 0, "TimerProgress")
end