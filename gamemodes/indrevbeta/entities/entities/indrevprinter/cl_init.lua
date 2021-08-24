include("shared.lua")
local imgui = include("imgui.lua")

surface.CreateFont( "MoneyFont", {
	font = "Arial", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 75,
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

	if imgui.Entity3D2D(self, Vector(13,-7, 27.5), Angle(0, 90, 90), 0.2) then
		draw.RoundedBox(0,0,0,112,30,Color(54,112,6))
		draw.SimpleText(self:GetStoredMoney(), "TheDefaultSettings", 56, 15, Color(255,255,255),1,1)
		imgui.End3D2D()
	end
end