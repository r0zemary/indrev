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

	if imgui.Entity3D2D(self, Vector(-58,-22,55), Angle(0, 0, 90), 0.2) then
		draw.RoundedBox(0,0,0,300,30,Color(10,10,10))

		local FuelPercent = math.Clamp((self:GetFuel() / self:GetMaxFuel()) * 100, 0, self:GetMaxFuel())

		if self:GetToggled() == true then
			draw.RoundedBox(0,0,0,FuelPercent * 3,30,Color(204,123,17))
			draw.SimpleText(math.floor(self:GetFuel()) .. "%", "TheDefaultSettings", 150,15,Color(255,255,255),1,1)
		else
			draw.RoundedBox(0,0,0,FuelPercent * 3,30,Color(153,45,45))
			draw.SimpleText("OFF", "TheDefaultSettings", 150,15,Color(255,255,255),1,1)
		end

		imgui.End3D2D()
	end
end