ENT.Type = "anim"

ENT.PrintName = "Shredder"

ENT.Spawnable = true

ENT.Category = "Industrial Revolution Beta"

function ENT:SetupDataTables()
    self:NetworkVar("Int", 0, "UpgradeCost")
    self:NetworkVar("Int", 1, "UpgradeLevel")
    self:NetworkVar("Float", 0, "TimerProgress")
    self:NetworkVar("Float", 1, "TimerInterval")
    self:NetworkVar("Float", 2, "Fuel")
    self:NetworkVar("Float", 3, "MaxFuel")
    self:NetworkVar("Float", 4, "Ore")
    self:NetworkVar("Float", 5, "MaxOre")
end