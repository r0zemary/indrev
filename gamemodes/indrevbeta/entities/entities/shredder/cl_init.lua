include("shared.lua")
local imgui = include("imgui.lua")

function ENT:Draw()
	self:DrawModel()

	if imgui.Entity3D2D(self, Vector(-20,-36,40), Angle(0, 0, 90), 0.2) then
		local WorkPercent = math.Clamp((CurTime() - self:GetTimerProgress()) / self:GetTimerInterval(), 0, 1)
		local OrePercent = math.Clamp(self:GetOre() / self:GetMaxOre(), 0, 1)
		local FuelPercent = math.Clamp(self:GetFuel() / self:GetMaxFuel(), 0, 1)
		draw.RoundedBox(0,0,50,150,30,Color(10,10,10))
		draw.RoundedBox(0,0,50,WorkPercent * 150,30,Color(120,120,255))
		draw.SimpleText("WORK", "TheDefaultSettings", 75,65,Color(255,255,255),1,1)

		draw.RoundedBox(0,0,100,150,30,Color(10,10,10))
		draw.RoundedBox(0,0,100,OrePercent * 150,30,Color(200,125,200))
		draw.SimpleText(self:GetOre(), "TheDefaultSettings", 75, 115, Color(255,255,255),1,1)

		draw.RoundedBox(0,0,150,150,30,Color(0,0,0))
		draw.RoundedBox(0,0,150,FuelPercent * 150,30,Color(175,125,31))
		draw.SimpleText(FuelPercent * self:GetMaxFuel(), "TheDefaultSettings", 75, 165, Color(255,255,255), 1, 1)
		imgui.End3D2D()
	end
end