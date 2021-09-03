AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

util.AddNetworkString("OpenMenu")
util.AddNetworkString("UpgradeMenu")
util.AddNetworkString("BuyGenerator")
util.AddNetworkString("BuyFuelProducer")
util.AddNetworkString("BuyPrinter")
util.AddNetworkString("BuyRefinery")
util.AddNetworkString("BuyFuel")
util.AddNetworkString("BuyDrill")
util.AddNetworkString("BuyCleaner")
util.AddNetworkString("BuyDieseler")
util.AddNetworkString("BuyShredder")
util.AddNetworkString("BuyTerminal")
util.AddNetworkString("BuyCompactor")
util.AddNetworkString("UpgradeGenerator")
util.AddNetworkString("UpgradeProducer")
util.AddNetworkString("UpgradeRefinery")
util.AddNetworkString("UpgradeDrill")
util.AddNetworkString("UpgradeCleaner")
util.AddNetworkString("UpgradePrinter")
util.AddNetworkString("UpgradeShredder")
util.AddNetworkString("UpgradeCompactor")
util.AddNetworkString("UpgradeDieseler")
util.AddNetworkString("ResetMoney")

local function has_value (tab, val)
	for index, value in ipairs(tab) do
		if value == val then
			return true
		end
	end
	return false
end

local function BuyEntity(ent, plyr, offset, ang)
	local trace = plyr:GetEyeTrace().HitPos
	local bought = ents.Create(ent)
	local plypos = plyr:GetPos()
	local delta = plypos - trace
	delta.x = math.Clamp(delta.x, -200, 200)
	delta.y = math.Clamp(delta.y, -200, 200)
	local result = plypos - delta
	result.z = plypos.z + offset
	bought:SetPos(result)
	local aimvector = plyr:LocalEyeAngles()
	aimvector.p = 0
	aimvector.r = 0
	aimvector.y = aimvector.y - ang
	bought:SetAngles(aimvector)
	bought:Spawn()
end

hook.Add("ShowSpare1", "Spare1Menu", function(ply)
	net.Start("OpenMenu")
	net.Send(ply)
end)

hook.Add("ShowSpare2", "Spare2Menu", function(ply)
	local hit = ply:GetEyeTrace().Entity
	upgradeable = {"indrevgenerator",
	"indrevprinter",
	"fuelproducer",
	"fuelrefinery",
	"drill",
	"cleaner",
	"shredder",
	"compactor",
	"dieselrefinery"}
	if has_value(upgradeable, hit:GetClass()) then
		net.Start("UpgradeMenu")
		net.Send(ply)
	end
end)

SetGlobalInt("money", 500)

net.Receive("BuyGenerator", function(len, ply)
	if GetGlobalInt("money") >= 100 then
		BuyEntity("indrevgenerator", ply, 16, 90)
		SetGlobalInt("money", GetGlobalInt("money") - 100)
	end

end)

net.Receive("BuyFuelProducer", function(len, ply)
	if GetGlobalInt("money") >= 100 then
		BuyEntity("fuelproducer", ply, 50, 180)
		SetGlobalInt("money", GetGlobalInt("money") - 100)
	end
end)

net.Receive("BuyPrinter", function(len, ply)
	if GetGlobalInt("money") >= 200 then
		BuyEntity("indrevprinter", ply, 48, 180)
		SetGlobalInt("money", GetGlobalInt("money") - 200)
	end
end)

net.Receive("BuyTerminal", function(len, ply)
	if GetGlobalInt("money") >= 500 then
		BuyEntity("printerterminal", ply, 48, 180)
		SetGlobalInt("money", GetGlobalInt("money") - 500)
	end
end)

net.Receive("BuyRefinery", function(len, ply)
	if GetGlobalInt("money") >= 50 then
		BuyEntity("fuelrefinery", ply, 30, 180)
		SetGlobalInt("money", GetGlobalInt("money") - 50)
	end
end)

net.Receive("BuyCompactor", function(len, ply)
	if GetGlobalInt("money") >= 1000 then
		BuyEntity("compactor", ply, 30, 180)
		SetGlobalInt("money", GetGlobalInt("money") - 1000)
	end
end)

net.Receive("BuyFuel", function(len, ply)
	if GetGlobalInt("money") >= 25 then
		BuyEntity("fuel", ply, 24, 180)
		SetGlobalInt("money", GetGlobalInt("money") - 25)
	end
end)

net.Receive("BuyDrill", function(len, ply)
	if GetGlobalInt("money") >= 1000 then
		BuyEntity("drill", ply, 60, 180)
		SetGlobalInt("money", GetGlobalInt("money") - 1000)
	end
end)

net.Receive("BuyCleaner", function(len, ply)
	if GetGlobalInt("money") >= 500 then
		BuyEntity("cleaner", ply, 36, 270)
		SetGlobalInt("money", GetGlobalInt("money") - 500)
	end
end)

net.Receive("BuyDieseler", function(len, ply)
	if GetGlobalInt("money") >= 500 then
		BuyEntity("dieselrefinery", ply, 36, 180)
		SetGlobalInt("money", GetGlobalInt("money") - 500)
	end
end)

net.Receive("BuyShredder", function(len, ply)
	if GetGlobalInt("money") >= 1500 then
		BuyEntity("shredder", ply, 60, 180)
		SetGlobalInt("money", GetGlobalInt("money") - 1500)
	end
end)

net.Receive("UpgradeGenerator", function(len, ply)
	local hit = ply:GetEyeTrace().Entity
	if hit:GetClass() == "indrevgenerator" and GetGlobalInt("money") >= hit:GetUpgradeCost() then
		if hit:GetUpgradeLevel() == 1 then
			hit:SetMaxFuel(120)
			hit:SetUpgradeLevel(2)
			hit:SetUpgradeCost(300)
			SetGlobalInt("money", GetGlobalInt("money") - 200)
		elseif hit:GetUpgradeLevel() == 2 then
			hit:SetMaxFuel(140)
			hit:SetUpgradeLevel(3)
			hit:SetUpgradeCost(400)
			SetGlobalInt("money", GetGlobalInt("money") - 300)
		elseif hit:GetUpgradeLevel() == 3 then
			hit:SetMaxFuel(160)
			hit:SetUpgradeLevel(4)
			SetGlobalInt("money", GetGlobalInt("money") - 400)
		end
	end
end)

net.Receive("UpgradeProducer", function(len, ply)
	local hit = ply:GetEyeTrace().Entity
	if hit:GetClass() == "fuelproducer" and GetGlobalInt("money") >= hit:GetUpgradeCost() then
		if hit:GetUpgradeLevel() == 1 then
			hit:SetTimerInterval(13)
			hit:SetUpgradeLevel(2)
			hit:SetUpgradeCost(400)
			SetGlobalInt("money", GetGlobalInt("money") - 200)
		elseif hit:GetUpgradeLevel() == 2 then
			hit:SetTimerInterval(11)
			hit:SetUpgradeLevel(3)
			hit:SetUpgradeCost(600)
			SetGlobalInt("money", GetGlobalInt("money") - 400)
		elseif hit:GetUpgradeLevel() == 3 then
			hit:SetTimerInterval(9)
			hit:SetUpgradeLevel(4)
			SetGlobalInt("money", GetGlobalInt("money") - 600)
		end
	end
end)

net.Receive("UpgradeRefinery", function(len, ply)
	local hit = ply:GetEyeTrace().Entity
	if hit:GetClass() == "fuelrefinery" and GetGlobalInt("money") >= hit:GetUpgradeCost() then
		if hit:GetUpgradeLevel() == 1 then
			hit:SetTimerInterval(4)
			hit:SetMaxFuel(12)
			hit:SetUpgradeLevel(2)
			hit:SetUpgradeCost(400)
			SetGlobalInt("money", GetGlobalInt("money") - 200)
		elseif hit:GetUpgradeLevel() == 2 then
			hit:SetTimerInterval(3)
			hit:SetMaxFuel(14)
			hit:SetUpgradeLevel(3)
			hit:SetUpgradeCost(600)
			SetGlobalInt("money", GetGlobalInt("money") - 400)
		elseif hit:GetUpgradeLevel() == 3 then
			hit:SetTimerInterval(2)
			hit:SetMaxFuel(16)
			hit:SetUpgradeLevel(4)
			SetGlobalInt("money", GetGlobalInt("money") - 600)
		end
	end
end)

net.Receive("UpgradeDrill", function(len, ply)
	local hit = ply:GetEyeTrace().Entity
	if hit:GetClass() == "drill" and GetGlobalInt("money") >= hit:GetUpgradeCost() then
		if hit:GetUpgradeLevel() == 1 then
			hit:SetTimerInterval(22)
			hit:SetUpgradeLevel(2)
			hit:SetUpgradeCost(1500)
			SetGlobalInt("money", GetGlobalInt("money") - 1250)
		elseif hit:GetUpgradeLevel() == 2 then
			hit:SetTimerInterval(19)
			hit:SetUpgradeLevel(3)
			hit:SetUpgradeCost(1750)
			SetGlobalInt("money", GetGlobalInt("money") - 1500)
		elseif hit:GetUpgradeLevel() == 3 then
			hit:SetTimerInterval(16)
			hit:SetUpgradeLevel(4)
			SetGlobalInt("money", GetGlobalInt("money") - 1750)
		end
	end
end)

net.Receive("UpgradeCleaner", function(len, ply)
	local hit = ply:GetEyeTrace().Entity
	if hit:GetClass() == "cleaner" and GetGlobalInt("money") >= hit:GetUpgradeCost() then
		if hit:GetUpgradeLevel() == 1 then
			hit:SetTimerInterval(17)
			hit:SetMaxOre(5)
			hit:SetUpgradeLevel(2)
			hit:SetUpgradeCost(800)
			SetGlobalInt("money", GetGlobalInt("money") - 600)
		elseif hit:GetUpgradeLevel() == 2 then
			hit:SetTimerInterval(14)
			hit:SetMaxOre(7)
			hit:SetUpgradeLevel(3)
			hit:SetUpgradeCost(1000)
			SetGlobalInt("money", GetGlobalInt("money") - 800)
		elseif hit:GetUpgradeLevel() == 3 then
			hit:SetTimerInterval(11)
			hit:SetMaxOre(9)
			hit:SetUpgradeLevel(4)
			SetGlobalInt("money", GetGlobalInt("money") - 1000)
		end
	end
end)

net.Receive("UpgradePrinter", function(len, ply)
	local hit = ply:GetEyeTrace().Entity
	if hit:GetClass() == "indrevprinter" and GetGlobalInt("money") >= hit:GetUpgradeCost() then
		if hit:GetUpgradeLevel() == 1 then
			hit:SetTimerInterval(0.85)
			hit:SetUpgradeLevel(2)
			hit:SetUpgradeCost(300)
			SetGlobalInt("money", GetGlobalInt("money") - 150)
		elseif hit:GetUpgradeLevel() == 2 then
			hit:SetTimerInterval(0.7)
			hit:SetUpgradeLevel(3)
			hit:SetUpgradeCost(450)
			SetGlobalInt("money", GetGlobalInt("money") - 300)
		elseif hit:GetUpgradeLevel() == 3 then
			hit:SetTimerInterval(0.55)
			hit:SetUpgradeLevel(4)
			SetGlobalInt("money", GetGlobalInt("money") - 450)
		end
	end
end)

net.Receive("UpgradeShredder", function(len, ply)
	local hit = ply:GetEyeTrace().Entity
	if hit:GetClass() == "shredder" and GetGlobalInt("money") >= hit:GetUpgradeCost() and hit:GetUpgradeLevel() < 4 then
		SetGlobalInt("money", GetGlobalInt("money") - hit:GetUpgradeCost())
		hit:SetTimerInterval(hit:GetTimerInterval() - 1)
		hit:SetMaxOre(hit:GetMaxOre() + 2)
		hit:SetMaxFuel(hit:GetMaxFuel() + 15)
		hit:SetUpgradeCost(hit:GetUpgradeCost() + 500)
		hit:SetUpgradeLevel(hit:GetUpgradeLevel() + 1)
	end
end)

net.Receive("UpgradeCompactor", function(len, ply)
	local hit = ply:GetEyeTrace().Entity
	if hit:GetClass() == "compactor" and GetGlobalInt("money") >= hit:GetUpgradeCost() and hit:GetUpgradeLevel() < 4 then
		SetGlobalInt("money", GetGlobalInt("money") - hit:GetUpgradeCost())
		hit:SetTimerInterval(hit:GetTimerInterval() - 1)
		hit:SetMaxMetal(hit:GetMaxMetal() + 2)
		hit:SetUpgradeLevel(hit:GetUpgradeLevel() + 1)
		hit:SetUpgradeCost(hit:GetUpgradeCost() + 500)
	end
end)

net.Receive("UpgradeDieseler", function(len, ply)
	local hit = ply:GetEyeTrace().Entity
	if hit:GetClass() == "dieselrefinery" and GetGlobalInt("money") >= hit:GetUpgradeCost() and hit:GetUpgradeLevel() < 4 then
		SetGlobalInt("money", GetGlobalInt("money") - hit:GetUpgradeCost())
		hit:SetTimerInterval(hit:GetTimerInterval() - 1)
		hit:SetMaxFuel(hit:GetMaxFuel() + 2)
		hit:SetUpgradeLevel(hit:GetUpgradeLevel() + 1)
		hit:SetUpgradeCost(hit:GetUpgradeCost() + 500)
	end
end)

net.Receive("ResetMoney", function(len, ply)
	SetGlobalInt("money", 500)
	local indrevents = {"cleaner",
	"cleansedore",
	"compactor",
	"diesel",
	"dieselrefinery",
	"drill",
	"fuel",
	"fuelproducer",
	"fuelrefinery",
	"gear",
	"indrevgenerator",
	"indrevprinter",
	"ore",
	"printerterminal",
	"refinedmetal",
	"scrapmetal",
	"shredder",
	"strongmetal",
	"unrefinedfuel"}
	for k,v in pairs(ents.GetAll()) do
		if has_value(indrevents, v:GetClass()) then
			v:Remove()
		end
	end
end)

function GM:PlayerSpawn(ply)
	ply:SetModel("models/player/kleiner.mdl")
	ply:Give("weapon_physcannon")
	ply:Give("weapon_physgun")
	ply:SetWalkSpeed(300)
	ply:SetRunSpeed(500)
	ply:SetupHands()
	ply:GodEnable()
end



function GM:PlayerInitialSpawn(ply, trns)
	ply:ChatPrint("Welcome to Industrial Revolution! Press F3 to purchase machines and F4 while looking at them to upgrade them.")
end

function GiveMoney(ply, cmd, args)
	if args[1] then
		SetGlobalInt("money", GetGlobalInt("money") + args[1])
	end
end
concommand.Add("givemoney", GiveMoney, nil, "nil", 16384)
function SetMoney(ply, cmd, args)
	if args[1] then
		SetGlobalInt("money", 0 + args[1])
	end
end
concommand.Add("setmoney", SetMoney, nil, "nil", 16384)