include("shared.lua")


local function OpenMenu()
	local frame = vgui.Create("DFrame")
		frame:SetSize(1000,720)
		frame:Center()
		frame:MakePopup()
		frame:SetTitle("Shop")
		frame:SetVisible(true)

	local genbutton = vgui.Create("DButton", frame)
		genbutton:SetPos(10, 30)
		genbutton:SetSize(80,80)
		genbutton:SetVisible(true)
		genbutton:SetText("Generator")
		genbutton:SetTooltip("$100")
		genbutton.DoClick = function()
			net.Start("BuyGenerator")
			net.SendToServer()
		end
	local fuelprodbutton = vgui.Create("DButton", frame)
		fuelprodbutton:SetPos(100,30)
		fuelprodbutton:SetSize(80,80)
		fuelprodbutton:SetVisible(true)
		fuelprodbutton:SetText("Fuel Producer")
		fuelprodbutton:SetTooltip("$100")
		fuelprodbutton.DoClick = function()
			net.Start("BuyFuelProducer")
			net.SendToServer()
		end
	local printerbutton = vgui.Create("DButton", frame)
		printerbutton:SetPos(190,30)
		printerbutton:SetSize(80,80)
		printerbutton:SetVisible(true)
		printerbutton:SetText("Printer")
		printerbutton:SetTooltip("$200")
		printerbutton.DoClick = function()
			net.Start("BuyPrinter")
			net.SendToServer()
		end
	local refinerybutton = vgui.Create("DButton", frame)
		refinerybutton:SetPos(280,30)
		refinerybutton:SetSize(80,80)
		refinerybutton:SetVisible(true)
		refinerybutton:SetText("Refinery")
		refinerybutton:SetTooltip("$50")
		refinerybutton.DoClick = function()
			net.Start("BuyRefinery")
			net.SendToServer()
		end
	local fuelbutton = vgui.Create("DButton", frame)
		fuelbutton:SetPos(370,30)
		fuelbutton:SetSize(80,80)
		fuelbutton:SetVisible(true)
		fuelbutton:SetText("Fuel")
		fuelbutton:SetTooltip("$25")
		fuelbutton.DoClick = function()
			net.Start("BuyFuel")
			net.SendToServer()
		end
	local drillbutton = vgui.Create("DButton", frame)
		drillbutton:SetPos(460,30)
		drillbutton:SetSize(80,80)
		drillbutton:SetVisible(true)
		drillbutton:SetText("Drill")
		drillbutton:SetTooltip("$1000")
		drillbutton.DoClick = function()
			net.Start("BuyDrill")
			net.SendToServer()
		end
	local cleanerbutton = vgui.Create("DButton", frame)
		cleanerbutton:SetPos(550,30)
		cleanerbutton:SetSize(80,80)
		cleanerbutton:SetVisible(true)
		cleanerbutton:SetText("Cleaner")
		cleanerbutton:SetTooltip("$500")
		cleanerbutton.DoClick = function()
			net.Start("BuyCleaner")
			net.SendToServer()
		end
	local resetbutton = vgui.Create("DButton", frame)
		resetbutton:SetPos(910,630)
		resetbutton:SetSize(80,80)
		resetbutton:SetVisible(true)
		resetbutton:SetText("RESET GAME")
		resetbutton.DoClick = function()
			RunConsoleCommand("stopsound")
			net.Start("ResetMoney")
			net.SendToServer()
		end
end

local function UpgradeMenu()
	local hit = LocalPlayer():GetEyeTrace().Entity
	local frame = vgui.Create("DFrame")
	frame:SetSize(1000,720)
	frame:Center()
	frame:MakePopup()
	frame:SetTitle("Upgrade")
	frame:SetVisible(true)

	local upgradebutton = vgui.Create("DButton", frame)
	upgradebutton:SetPos(10,30)
	upgradebutton:SetSize(980,200)
	upgradebutton:SetVisible(true)
	if hit:GetClass() == "indrevgenerator" and hit:GetUpgradeLevel() < 4 and hit:IsValid() then
		upgradebutton:SetText("Upgrade: " .. hit:GetUpgradeCost())
		upgradebutton.DoClick = function()
			net.Start("UpgradeGenerator")
			net.SendToServer()
			frame:SetVisible(false)
		end
	elseif hit:GetClass() == "fuelproducer" and hit:GetUpgradeLevel() < 4 and hit:IsValid() then
		upgradebutton:SetText("Upgrade: " .. hit:GetUpgradeCost())
		upgradebutton.DoClick = function()
			net.Start("UpgradeProducer")
			net.SendToServer()
			frame:SetVisible(false)
		end
	elseif hit:GetClass() == "fuelrefinery" and hit:GetUpgradeLevel() < 4 and hit:IsValid() then
		upgradebutton:SetText("Upgrade: " .. hit:GetUpgradeCost())
		upgradebutton.DoClick = function()
			net.Start("UpgradeRefinery")
			net.SendToServer()
			frame:SetVisible(false)
		end
	elseif hit:GetClass() == "drill" and hit:GetUpgradeLevel() < 4 and hit:IsValid() then
		upgradebutton:SetText("Upgrade: " .. hit:GetUpgradeCost())
		upgradebutton.DoClick = function()
			net.Start("UpgradeDrill")
			net.SendToServer()
			frame:SetVisible(false)
		end
	elseif hit:GetClass() == "cleaner" and hit:GetUpgradeLevel() < 4 and hit:IsValid() then
		upgradebutton:SetText("Upgrade: " .. hit:GetUpgradeCost())
		upgradebutton.DoClick = function()
			net.Start("UpgradeCleaner")
			net.SendToServer()
			frame:SetVisible(false)
		end
	elseif hit:GetClass() == "indrevprinter" and hit:GetUpgradeLevel() < 4 and hit:IsValid() then
		upgradebutton:SetText("Upgrade: " .. hit:GetUpgradeCost())
		upgradebutton.DoClick = function()
			net.Start("UpgradePrinter")
			net.SendToServer()
			frame:SetVisible(false)
		end
	else
		upgradebutton:SetText("MAX UPGRADED")
		upgradebutton.DoClick = function() frame:SetVisible(false)
	end
end
end


net.Receive("OpenMenu", function(len)
	OpenMenu()
end)

net.Receive("UpgradeMenu", function(len)
	UpgradeMenu()
end)

local tally = 0

hook.Add("Think", "GetMachines", function()
	tally = 0
	for k,v in pairs(ents.GetAll()) do
		if v:IsValid() and v:GetClass() == "indrevprinter" or v:GetClass() == "fuelrefinery" or v:GetClass() == "fuelproducer" or v:GetClass() == "indrevgenerator" then
			tally = tally + 1
		end
	end
end)

hook.Add("HUDPaint", "HudDraw", function()

	if !LocalPlayer():Alive() then
		return
	end

	draw.RoundedBox(0,0,0,ScrW(),40,Color(0,0,0, 200))
	draw.RoundedBox(5,5,5,30,30,Color(120,255,120))
	draw.DrawText("$", "DermaLarge", 20, 5, Color(0,0,0),TEXT_ALIGN_CENTER)
	draw.DrawText(GetGlobalInt("money"), "DermaLarge", 40, 5, Color(255,255,255),TEXT_ALIGN_LEFT)
	draw.RoundedBox(5,200,5,30,30,Color(120,120,255))
	draw.DrawText("M", "DermaLarge", 215, 5, Color(0,0,0), TEXT_ALIGN_CENTER)
	draw.DrawText(tally, "DermaLarge", 235, 5, Color(255,255,255), TEXT_ALIGN_LEFT)


	//draw.RoundedBox(0,118,3,254,34,Color(20,20,20, 150))
	//draw.RoundedBox(0, 120, 5, LocalPlayer():Health() * 2.5, 30, Color(255,120,120))
end)

function HideHud(name)
	for k,v in pairs({"CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo"}) do
		if name  == v then
			return false
		end
	end
end
hook.Add("HUDShouldDraw", "HideDefaultHud", HideHud)