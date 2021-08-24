ENT.Type = "anim"

ENT.PrintName = "Cleansed Ore"

ENT.Spawnable = true

ENT.Category = "Industrial Revolution Beta"

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "OreValue")
end