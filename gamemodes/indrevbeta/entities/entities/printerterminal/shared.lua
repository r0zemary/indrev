ENT.Type = "anim"

ENT.PrintName = "Printer Terminal"

ENT.Spawnable = true

ENT.Category = "Industrial Revolution Beta"

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "StoredMoney")
end