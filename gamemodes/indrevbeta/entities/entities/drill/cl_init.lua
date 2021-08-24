include("shared.lua")
local imgui = include("imgui.lua")

function ENT:Draw()
	self:DrawModel()

	if imgui.Entity3D2D(self, Vector(-20,-36,30), Angle(0, 0, 90), 0.2) then
		local WorkPercent = math.Clamp((CurTime() - self:GetTimerProgress()) / self:GetTimerInterval(), 0, 1)
		draw.RoundedBox(0,0,50,150,30,Color(10,10,10))
		draw.RoundedBox(0,0,50,WorkPercent * 150,30,Color(120,120,255))
		draw.SimpleText("WORK", "TheDefaultSettings", 75,65,Color(255,255,255),1,1)
		imgui.End3D2D()
	end
end