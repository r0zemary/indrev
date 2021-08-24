include("shared.lua")
local imgui = include("imgui.lua")

surface.CreateFont( "TheDefaultSettings", {
	font = "Arial", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 30,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

function ENT:Draw()
	self:DrawModel()

	if imgui.Entity3D2D(self, Vector(13,-15,5), Angle(0, 90, 90), 0.2) then
		local FuelPercent = math.Clamp((self:GetFuel() / self:GetMaxFuel()) * 10, 0, self:GetMaxFuel())
		local WorkPercent = math.Clamp((CurTime() - self:GetTimerProgress()) / self:GetTimerInterval(), 0, 1)
		draw.RoundedBox(0,0,0,150,30,Color(10,10,10))
		draw.RoundedBox(0,0,50,150,30,Color(10,10,10))
		draw.RoundedBox(0,0,50,WorkPercent * 150,30,Color(120,120,255))
		draw.RoundedBox(0,0,0,FuelPercent * 15,30,Color(175,125,31))
		draw.SimpleText(self:GetFuel(), "TheDefaultSettings", 75, 15, Color(255,255,255),1,1)
		draw.SimpleText("WORK","TheDefaultSettings", 75, 65, Color(255,255,255), 1, 1)
		imgui.End3D2D()
	end
end