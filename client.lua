local ModelSpawned = false
local PlayingAnim = false
local CurrentLocation = nil
local playerPed = GetPlayerPed(-1)
local context = GetHashKey("MINI_PROSTITUTE_LOW_PASSENGER")
local Hookers = {
	{id = 1, VoiceName = "HOOKER_LEAVES_ANGRY", modelHash = "s_f_y_hooker_01", x = 128.65, y = -1055.36, z = 29.19, heading = 156.4},
	{id = 2, VoiceName = "HOOKER_LEAVES_ANGRY", modelHash = "s_f_y_hooker_01", x = -1101.1756591796, y = ,-1967.1433105468, z = 13.143761634826, heading = 156.4}, 
	{id = 3, VoiceName = "HOOKER_LEAVES_ANGRY", modelHash = "s_f_y_hooker_01", x = 84.951293945312, y = -1300.8311767578, z = 29.274017333984, heading = 156.4}, 
	{id = 4, VoiceName = "HOOKER_LEAVES_ANGRY", modelHash = "s_f_y_hooker_01", x = 397.28326416016, y = 297.40753173828, z = 103.01886749268, heading = 156.4},	
}
local locations = {
	{
		name = "Fahişe Bölgesi",
		pos = {x = 129.63, y = -1060.41, z = 29.19},
		size = 5.0
	},
	
	{
		name = "Fahişe Bölgesi",
		pos = {x = -1101.1756591796, y = ,-1967.1433105468, z = 13.143761634826},
		size = 5.0
	},
	
	{
		name = "Fahişe Bölgesi",
		pos = {x = 84.951293945312, y = -1300.8311767578, z = 29.274017333984},
		size = 5.0
	},
	
	{
		name = "Fahişe Bölgesi",
		pos = {x = 397.28326416016, y = 297.40753173828, z = 103.01886749268},
		size = 5.0
	},
}

Citizen.CreateThread(function()
	while true do
			Citizen.Wait(0)
			coords = GetEntityCoords(playerPed)
			for k,v in pairs(locations) do
					if GetDistanceBetweenCoords(coords, v.pos.x, v.pos.y, v.pos.z, true) < v.size then
							CurrentLocation = v
							break
					else
							CurrentLocation = nil
					end
			end
	end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
	
	if (not ModelSpawned) then
	  
	  for i=1, #Hookers do
		RequestModel(GetHashKey(Hookers[i].modelHash))
        while not HasModelLoaded(GetHashKey(Hookers[i].modelHash)) do
          Citizen.Wait(0)
        end
		SpawnedPed = CreatePed(2, Hookers[i].modelHash, Hookers[i].x, Hookers[i].y, Hookers[i].z, Hookers[i].heading, true, true)
		ModelSpawned = true
		TaskSetBlockingOfNonTemporaryEvents(SpawnedPed, true)
		Citizen.Wait(1)
		TaskStartScenarioInPlace(SpawnedPed, "WORLD_HUMAN_SMOKING", 0, false)
		
	end
    end
	end
end)

Citizen.CreateThread(function()
	while true do
			Citizen.Wait(0)
			if CurrentLocation ~= nil then
					SetTextComponentFormat('STRING')
					AddTextComponentString('~b~~h~E~h~~w~ tuşuna basarak fahişeyi çağır.')
					DisplayHelpTextFromStringLabel(0, 0, 1, -1)
					if IsControlJustPressed(0,51) then
						TaskEnterVehicle(SpawnedPed, GetVehiclePedIsIn(playerPed, false), -1, 0, 1.0, 1, 0)
						Citizen.Wait(5000)
						TriggerEvent("chatMessage", "Fahişe", {0 , 255, 0 }, "Hey tatlım, ne istersin? Oral mı yoksa daha iyi bir şey mi?")
						Citizen.Wait(1000)
						TriggerEvent("chatMessage", "Info", {0 , 255, 0 }, "Sakso için /sakso, oral için /oral veya fahişeyi göndermek için /fgönder yazın.")
					end
			end
	end
end)

RegisterCommand("sakso", function(source, args, raw)
	TriggerEvent("blowjob") 
end, false)
RegisterNetEvent("blowjob")
AddEventHandler("blowjob", function(inputText)
	RequestAnimDict("oddjobs@towing")
	while (not HasAnimDictLoaded("oddjobs@towing")) do 
	Citizen.Wait(0)
	end
	TaskPlayAnim(SpawnedPed,"oddjobs@towing","f_blow_job_loop", 1.0, -1.0, 10000, 0, 1, true, true, true)
	TaskPlayAnim(playerPed,"oddjobs@towing","m_blow_job_loop", 1.0, -1.0, 10000, 0, 1, true, true, true) 
end)

RegisterCommand("oral", function(source, args, raw)
	TriggerEvent("havesex") 
end, false)
RegisterNetEvent("havesex")
AddEventHandler("havesex", function(inputText)
	RequestAnimDict("mini@prostitutes@sexlow_veh")
	while (not HasAnimDictLoaded("mini@prostitutes@sexlow_veh")) do 
	Citizen.Wait(0)
	end
	TaskPlayAnim(SpawnedPed,"mini@prostitutes@sexlow_veh","low_car_sex_loop_female", 1.0, -1.0, 25000, 0, 1, true, true, true)
	TaskPlayAnim(playerPed,"mini@prostitutes@sexlow_veh","low_car_sex_loop_player", 1.0, -1.0, 25000, 0, 1, true, true, true)
end)

RegisterCommand("fgönder", function(source, args, raw)
	TriggerEvent("sendhookerhome") 
end, false)
RegisterNetEvent("sendhookerhome")
AddEventHandler("sendhookerhome", function(inputText)
	TaskLeaveVehicle(SpawnedPed, vehicle, 0)
	TaskGoToCoordAnyMeans(SpawnedPed, 128.65, -1055.36, 29.19, 5.0, 0, 0, 786603, 0xbf800000)
	
end)

Citizen.CreateThread(function()
	while true do
	  Citizen.Wait(1000)
			if IsEntityDead(SpawnedPed) then
			  SpawnedPed = CreatePed(2, "s_f_y_hooker_01", 128.65, -1055.36, 29.19, 156.4, true, true)
			  TaskSetBlockingOfNonTemporaryEvents(SpawnedPed, true)
			  Citizen.Wait(1)
			  TaskStartScenarioInPlace(SpawnedPed, "WORLD_HUMAN_SMOKING", 0, false)
			end
	end
end)
