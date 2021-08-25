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
util.AddNetworkString("BuyRockwash")
util.AddNetworkString("UpgradeGenerator")
util.AddNetworkString("UpgradeProducer")
util.AddNetworkString("UpgradeRefinery")
util.AddNetworkString("UpgradeDrill")
util.AddNetworkString("UpgradeCleaner")
util.AddNetworkString("UpgradePrinter")
util.AddNetworkString("ResetMoney")


hook.Add("ShowSpare1", "Spare1Menu", function(ply)
	net.Start("OpenMenu")
	net.Send(ply)
end)

hook.Add("ShowSpare2", "Spare2Menu", function(ply)
	local hit = ply:GetEyeTrace().Entity
	if hit:GetClass() == "indrevgenerator" or hit:GetClass() == "indrevprinter" or hit:GetClass() == "fuelproducer" or hit:GetClass() == "fuelrefinery" or hit:GetClass() == "drill" or hit:GetClass() == "cleaner" then
		net.Start("UpgradeMenu")
		net.Send(ply)
	end
end)

SetGlobalInt("money", 500)

net.Receive("BuyGenerator", function(len, ply)
	local trace = ply:GetEyeTrace().HitPos
	local gen = ents.Create("indrevgenerator")
	local plypos = ply:GetPos()
	local delta = plypos - trace
	delta.x = math.Clamp(delta.x, -200, 200)
	delta.y = math.Clamp(delta.y, -200, 200)
	print(delta)
	local result = plypos - delta
	result.z = plypos.z + 16
	gen:SetPos(result)
	if GetGlobalInt("money") >= 100 then
		gen:Spawn()
		SetGlobalInt("money", GetGlobalInt("money") - 100)
	end

end)

net.Receive("BuyFuelProducer", function(len, ply)
	local trace = ply:GetEyeTrace().HitPos
	local fuel = ents.Create("fuelproducer")
	local plypos = ply:GetPos()
	local delta = plypos - trace
	delta.x = math.Clamp(delta.x, -200, 200)
	delta.y = math.Clamp(delta.y, -200, 200)
	local result = plypos - delta
	result.z = plypos.z + 50
	fuel:SetPos(result)
	if GetGlobalInt("money") >= 100 then
		fuel:Spawn()
		SetGlobalInt("money", GetGlobalInt("money") - 100)
	end
end)

net.Receive("BuyPrinter", function(len, ply)
	local trace = ply:GetEyeTrace().HitPos
	local printer = ents.Create("indrevprinter")
	local plypos = ply:GetPos()
	local delta = plypos - trace
	delta.x = math.Clamp(delta.x, -200, 200)
	delta.y = math.Clamp(delta.y, -200, 200)
	local result = plypos - delta
	result.z = plypos.z + 48
	printer:SetPos(result)
	if GetGlobalInt("money") >= 200 then
		printer:Spawn()
		SetGlobalInt("money", GetGlobalInt("money") - 200)
	end
end)

net.Receive("BuyRefinery", function(len, ply)
	local trace = ply:GetEyeTrace().HitPos
	local refinery = ents.Create("fuelrefinery")
	local plypos = ply:GetPos()
	local delta = plypos - trace
	delta.x = math.Clamp(delta.x, -200, 200)
	delta.y = math.Clamp(delta.y, -200, 200)
	local result = plypos - delta
	result.z = plypos.z + 24
	refinery:SetPos(result)
	if GetGlobalInt("money") >= 50 then
		refinery:Spawn()
		SetGlobalInt("money", GetGlobalInt("money") - 50)
	end
end)

net.Receive("BuyFuel", function(len, ply)
	local trace = ply:GetEyeTrace().HitPos
	local fuel = ents.Create("fuel")
	local plypos = ply:GetPos()
	local delta = plypos - trace
	delta.x = math.Clamp(delta.x, -200, 200)
	delta.y = math.Clamp(delta.y, -200, 200)
	local result = plypos - delta
	result.z = plypos.z + 24
	fuel:SetPos(result)
	if GetGlobalInt("money") >= 25 then
		fuel:Spawn()
		SetGlobalInt("money", GetGlobalInt("money") - 25)
	end
end)

net.Receive("BuyDrill", function(len, ply)
	local trace = ply:GetEyeTrace().HitPos
	local drill = ents.Create("drill")
	local plypos = ply:GetPos()
	local delta = plypos - trace
	delta.x = math.Clamp(delta.x, -200, 200)
	delta.y = math.Clamp(delta.y, -200, 200)
	local result = plypos - delta
	result.z = plypos.z + 60
	drill:SetPos(result)
	if GetGlobalInt("money") >= 1000 then
		drill:Spawn()
		SetGlobalInt("money", GetGlobalInt("money") - 1000)
	end
end)

net.Receive("BuyCleaner", function(len, ply)
	local trace = ply:GetEyeTrace().HitPos
	local cleaner = ents.Create("cleaner")
	local plypos = ply:GetPos()
	local delta = plypos - trace
	delta.x = math.Clamp(delta.x, -200, 200)
	delta.y = math.Clamp(delta.y, -200, 200)
	local result = plypos - delta
	result.z = plypos.z + 36
	cleaner:SetPos(result)
	if GetGlobalInt("money") >= 500 then
		cleaner:Spawn()
		SetGlobalInt("money", GetGlobalInt("money") - 500)
	end
end)

net.Receive("BuyDieseler", function(len, ply)
	local trace = ply:GetEyeTrace().HitPos
	local dieseler = ents.Create("dieselrefinery")
	local plypos = ply:GetPos()
	local delta = plypos - trace
	delta.x = math.Clamp(delta.x, -200, 200)
	delta.y = math.Clamp(delta.y, -200, 200)
	local result = plypos - delta
	result.z = plypos.z + 36
	dieseler:SetPos(result)
	if GetGlobalInt("money") >= 500 then
		dieseler:Spawn()
		SetGlobalInt("money", GetGlobalInt("money") - 500)
	end
end)

net.Receive("UpgradeGenerator", function(len, ply)
	local hit = ply:GetEyeTrace().Entity
	if hit:GetClass() == "indrevgenerator" and GetGlobalInt("money") > hit:GetUpgradeCost() then
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
	if hit:GetClass() == "fuelproducer" and GetGlobalInt("money") > hit:GetUpgradeCost() then
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
	if hit:GetClass() == "fuelrefinery" and GetGlobalInt("money") > hit:GetUpgradeCost() then
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
	if hit:GetClass() == "drill" and GetGlobalInt("money") > hit:GetUpgradeCost() then
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
	if hit:GetClass() == "cleaner" and GetGlobalInt("money") > hit:GetUpgradeCost() then
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
	if hit:GetClass() == "indrevprinter" and GetGlobalInt("money") > hit:GetUpgradeCost() then
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

net.Receive("ResetMoney", function(len, ply)
	SetGlobalInt("money", 500)
	for k,v in pairs(ents.GetAll()) do
		if v:GetClass() == "fuelproducer" or v:GetClass() == "fuel" or v:GetClass() == "fuelrefinery" or v:GetClass() == "indrevprinter" or v:GetClass() == "indrevgenerator" or v:GetClass() == "unrefinedfuel" or v:GetClass() == "drill" or v:GetClass() == "cleaner" or v:GetClass() == "ore" or v:GetClass() == "cleansedore" then
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



function GM:PlayerInitialSpawn()

end

function GiveMoney(ply, cmd, args)
	if args[1] then
		SetGlobalInt("money", GetGlobalInt("money") + args[1])
	end
end
concommand.Add("givemoney", GiveMoney, nil, "nil", 16384)