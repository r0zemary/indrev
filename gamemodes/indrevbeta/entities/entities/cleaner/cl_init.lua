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

	if imgui.Entity3D2D(self, Vector(0,21,5), Angle(0, 180, 90), 0.2) then
		local OrePercent = math.Clamp((self:GetStoredOre() / self:GetMaxOre()) * 3, 0, self:GetStoredOre())
		local WorkPercent = math.Clamp((CurTime() - self:GetTimerProgress()) / self:GetTimerInterval(), 0, 1)
		draw.RoundedBox(0,0,0,150,30,Color(10,10,10))
		draw.RoundedBox(0,0,0,OrePercent * 50,30,Color(175,125,31))
		draw.RoundedBox(0,-175,0,150,30,Color(0,0,0))
		draw.RoundedBox(0,-175,0,WorkPercent * 150,30,Color(120,120,255))
		draw.SimpleText(self:GetStoredOre(), "TheDefaultSettings", 75, 15, Color(255,255,255),1,1)
		draw.SimpleText("WORK", "TheDefaultSettings", -100, 15, Color(255,255,255), 1, 1)
		imgui.End3D2D()
	end
end