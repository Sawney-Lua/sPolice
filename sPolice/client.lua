ESX = nil
blip = nil
blips = {}

  
RegisterCommand("co", function(source, args, rawcommand)
    local pos = GetEntityCoords(PlayerPedId())
    print(pos.x..", "..pos.y..", "..pos.z)
end, false)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

    PlayerData = ESX.GetPlayerData()
    if PlayerData.job.name == 'police' then
        arme = false
    end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
    
    if PlayerData.job.name == 'police' then
        arme = false
    end
end)


RMenu.Add("lspd", "lspds", RageUI.CreateMenu("~b~L.S.P.D","Menu LSPD"))
RMenu:Get("lspd", "lspds").Closed = function()end
RMenu:Get('lspd', 'lspds'):SetRectangleBanner(0, 0, 0, 255)

-----Sous-Menu----------
RMenu.Add("lspd", "lspd_main", RageUI.CreateSubMenu(RMenu:Get("lspd", "lspds"), "~b~L.S.P.D", "LSPD"))
RMenu:Get("lspd", "lspd_main").Closed = function()end
-----Sous-Menu2-------
RMenu.Add("lspd", "lspd_main1", RageUI.CreateSubMenu(RMenu:Get("lspd", "lspds"), "~b~L.S.P.D", "LSPD"))
RMenu:Get("lspd", "lspd_main1").Closed = function()end
-----Sous-Menu3-------
RMenu.Add("lspd", "lspd_main2", RageUI.CreateSubMenu(RMenu:Get("lspd", "lspds"), "~b~L.S.P.D", "LSPD"))
RMenu:Get("lspd", "lspd_main2").Closed = function()end
-----Sous-Menu4-------
RMenu.Add("lspd", "lspd_main3", RageUI.CreateSubMenu(RMenu:Get("lspd", "lspds"), "~b~L.S.P.D", "LSPD"))
RMenu:Get("lspd", "lspd_main3").Closed = function()end




Citizen.CreateThread(function()
    while true do 
        if IsControlJustReleased(0, 167) and not isDead and PlayerData.job and PlayerData.job.name == 'police' and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'police_actions') then
				OpenPoliceActionsMenu()
		end





-----------------Menu Sub---------------

RageUI.IsVisible(RMenu:Get("lspd","lspds"),true,true,true,function()

RageUI.Separator("~b~↓ Jobs - Police ↓")
RageUI.ButtonWithStyle("Intéraction Citoyen", "LSPD", {}, true,function(h,a,s)
        if s then
end
end,RMenu:Get("lspd","lspd_main"))

RageUI.ButtonWithStyle("Intéraction Véhicule", "LSPD", {}, true,function(h,a,s)
        if s then
end
end,RMenu:Get("lspd","lspd_main1"))

RageUI.ButtonWithStyle("Intéraction Service", "LSPD", {}, true,function(h,a,s)
    if s then      
end
end,RMenu:Get("lspd","lspd_main2"))

RageUI.ButtonWithStyle("Demande De Renfort", "LSPD", {}, true,function(h,a,s)
    if s then      
end
end,RMenu:Get("lspd","lspd_main3"))

        end, function()end, 1)
        

  ----------------------Menu Véhicule--------------------    
      
      
        RageUI.IsVisible(RMenu:Get("lspd","lspd_main1"),true,true,true,function()



            RageUI.Separator("~b~↓ Gestion - Véhicule ↓")
            RageUI.ButtonWithStyle("~b~Déverouiller le Véhicule", "LSPD", {RightBadge = RageUI.BadgeStyle.Car}, true,function(h,a,s)
                if s then
                    TriggerEvent('esx_mechanicjob:onHijack')
                end
            end)



        end, function()end, 1)

-----------------------------Menu Renfort-----------------

        RageUI.IsVisible(RMenu:Get("lspd","lspd_main3"),true,true,true,function()
            
            RageUI.Separator("~b~↓ Gestion - Renfort ↓")


            RageUI.ButtonWithStyle("~b~👨🏻‍💻 Petite demande", "LSPD", {RightBadge = RageUI.BadgeStyle.Tick}, true,function(h,a,s)
                coords = GetEntityCoords(PlayerPedId())
                if s then
                    local raison = 'petit'
					TriggerServerEvent('renfort', coords, raison)
                end
            end)
            RageUI.ButtonWithStyle("~b~👨🏻‍💻 Demande importante", "LSPD", {RightBadge = RageUI.BadgeStyle.Tick}, true,function(h,a,s)
                coords = GetEntityCoords(PlayerPedId())
                if s then
                    local raison = 'importante'
					TriggerServerEvent('renfort', coords, raison)
                end
            end)
            RageUI.ButtonWithStyle("~b~👨🏻‍💻 Demande importante", "LSPD", {RightBadge = RageUI.BadgeStyle.Tick}, true,function(h,a,s)
                coords = GetEntityCoords(PlayerPedId())
                if s then
                    local raison = 'omgad'
					TriggerServerEvent('renfort', coords, raison)
                end
            end)




        end, function()end, 1)

----------------------------------------MENU Service -------------------------------


        RageUI.IsVisible(RMenu:Get("lspd","lspd_main2"),true,true,true,function()
            RageUI.Separator("~b~↓ Gestion - Service ↓")



            RageUI.ButtonWithStyle("~b~Prendre Son Service", "Prendre Son Service", {RightBadge = RageUI.BadgeStyle.Tick}, true,function(h,a,s)
                if s then
                    local info = 'prise'
                    TriggerServerEvent('police:PriseEtFinservice', info)
                end
            end)

            RageUI.ButtonWithStyle("~b~Fin De Service", "Fin De Service", {RightBadge = RageUI.BadgeStyle.Tick}, true,function(h,a,s)
                if s then
                    local info = 'fin'
                    TriggerServerEvent('police:PriseEtFinservice', info)
                end
            end)

        end, function()end, 1)


-----------------------------MENU 1 -----------------------------


        RageUI.IsVisible(RMenu:Get("lspd","lspd_main"),true,true,true,function()
            RageUI.Separator("~b~↓ Intéraction - Police ↓")
            RageUI.ButtonWithStyle("~b~Ménotter", "Menotter La perssone la plus proche de vous.", {RightBadge = RageUI.BadgeStyle.Tick}, true,function(h,a,s)
                if s then
                    TriggerServerEvent('esx_policejob:handcuff', GetPlayerServerId(closestPlayer))

end
end)
        RageUI.ButtonWithStyle("~b~Démenotter", "", {RightBadge = RageUI.BadgeStyle.Tick}, true,function(h,a,s)
                if s then
                    TriggerEvent('esx_policejob:unrestrain')
end
end)
        RageUI.ButtonWithStyle("~b~Attacher", "", {RightBadge = RageUI.BadgeStyle.Tick}, true,function(h,a,s)
                if s then
                    TriggerServerEvent('esx_policejob:drag', GetPlayerServerId(closestPlayer))
end
end)
        RageUI.ButtonWithStyle("~r~Facture", "Donnez une Facture", {RightBadge = RageUI.BadgeStyle.Tick}, true,function(h,a,s)
                if s then
                    OpenBillingMenu()

end
end)
    RageUI.ButtonWithStyle("~r~Mettre Dans le Véhicule", "Donnez une Facture", {RightBadge = RageUI.BadgeStyle.Tick}, true,function(h,a,s)
                if s then
                TriggerServerEvent('esx_policejob:putInVehicle', GetPlayerServerId(closestPlayer))
end
end)
RageUI.ButtonWithStyle("~r~Sortis Du Véhicule", "Donnez une Facture", {RightBadge = RageUI.BadgeStyle.Tick}, true,function(h,a,s)
                if s then
                TriggerServerEvent('esx_policejob:OutVehicle', GetPlayerServerId(closestPlayer))

end
end)
        end, function()end, 1)

        Citizen.Wait(0)
    end
end)


-----------------------------------------


function OpenPoliceActionsMenu()
    RageUI.Visible(RMenu:Get('lspd', 'lspds'), not RageUI.Visible(RMenu:Get('lspd', 'lspds')))
end


RegisterNetEvent('esx_policejob:drag')
AddEventHandler('esx_policejob:drag', function(copId)
	if isHandcuffed then
		dragStatus.isDragged = not dragStatus.isDragged
		dragStatus.CopId = copId
	end
end)


function OpenBillingMenu()

    ESX.UI.Menu.Open(
      'dialog', GetCurrentResourceName(), 'billing',
      {
        title = "Facture"
      },
      function(data, menu)
      
        local amount = tonumber(data.value)
        local player, distance = ESX.Game.GetClosestPlayer()
  
        if player ~= -1 and distance <= 3.0 then
  
          menu.close()
          if amount == nil then
              ESX.ShowColoredNotification("~r~ERREUR~s~: ~g~Montant invalide", 25)
          else
              TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_police', _U('billing'), amount)
              Citizen.Wait(100)
              ESX.ShowColoredNotification("Vous avez bien envoyer une facture", 25)
          end
  
        else
          ESX.ShowColoredNotification("~r~ERREUR~s~: ~g~Aucun joueur à proximitée", 25)
        end
  
      end,
      function(data, menu)
          menu.close()
      end
    )
  end

  
RegisterNetEvent('esx_policejob:unrestrain')
AddEventHandler('esx_policejob:unrestrain', function()
	if isHandcuffed then
		local playerPed = PlayerPedId()
		isHandcuffed = false

		ClearPedSecondaryTask(playerPed)
		SetEnableHandcuffs(playerPed, false)
		DisablePlayerFiring(playerPed, false)
		SetPedCanPlayGestureAnims(playerPed, true)
		FreezeEntityPosition(playerPed, false)
		DisplayRadar(true)

		-- end timer
		if Config.EnableHandcuffTimer and handcuffTimer.active then
			ESX.ClearTimeout(handcuffTimer.task)
		end
	end
end)

RegisterNetEvent('esx_policejob:putInVehicle')
AddEventHandler('esx_policejob:putInVehicle', function()
	if isHandcuffed then
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if IsAnyVehicleNearPoint(coords, 5.0) then
			local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)

			if DoesEntityExist(vehicle) then
				local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

				for i=maxSeats - 1, 0, -1 do
					if IsVehicleSeatFree(vehicle, i) then
						freeSeat = i
						break
					end
				end

				if freeSeat then
					TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
					dragStatus.isDragged = false
				end
			end
		end
	end
end)

RegisterNetEvent('esx_policejob:OutVehicle')
AddEventHandler('esx_policejob:OutVehicle', function()
	local playerPed = PlayerPedId()

	if IsPedSittingInAnyVehicle(playerPed) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		TaskLeaveVehicle(playerPed, vehicle, 64)
	end
end)

RegisterNetEvent('esx_mechanicjob:onHijack')
AddEventHandler('esx_mechanicjob:onHijack', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		local chance = math.random(100)
		local alarm  = math.random(100)

		if DoesEntityExist(vehicle) then
			if alarm <= 33 then
				SetVehicleAlarm(vehicle, true)
				StartVehicleAlarm(vehicle)
			end

			TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)

			Citizen.CreateThread(function()
				Citizen.Wait(10000)
				if chance <= 66 then
					SetVehicleDoorsLocked(vehicle, 1)
					SetVehicleDoorsLockedForAllPlayers(vehicle, false)
					ClearPedTasksImmediately(playerPed)
					ESX.ShowNotification('Véhicule Ouvert')
				else
					ESX.ShowNotification('Ouverture A échouer')
					ClearPedTasksImmediately(playerPed)
				end
			end)
		end
	end
end)

RegisterNetEvent('police:InfoService')
AddEventHandler('police:InfoService', function(service, nom)
	if service == 'prise' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		ESX.ShowAdvancedNotification('LSPD INFORMATIONS', '~b~Prise de service', 'Agent: ~g~'..nom..'\n~w~Code: ~g~10-8\n~w~Information: ~g~Prise de service.', 'CHAR_CALL911', 8)
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
	elseif service == 'fin' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		ESX.ShowAdvancedNotification('LSPD INFORMATIONS', '~b~Fin de service', 'Agent: ~g~'..nom..'\n~w~Code: ~g~10-10\n~w~Information: ~g~Fin de service.', 'CHAR_CALL911', 8)
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
	elseif service == 'pause' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		ESX.ShowAdvancedNotification('LSPD INFORMATIONS', '~b~Pause de service', 'Agent: ~g~'..nom..'\n~w~Code: ~g~10-6\n~w~Information: ~g~Pause de service.', 'CHAR_CALL911', 8)
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
	elseif service == 'standby' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		ESX.ShowAdvancedNotification('LSPD INFORMATIONS', '~b~Mise en standby', 'Agent: ~g~'..nom..'\n~w~Code: ~g~10-12\n~w~Information: ~g~Standby, en attente de dispatch.', 'CHAR_CALL911', 8)
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
	elseif service == 'control' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		ESX.ShowAdvancedNotification('LSPD INFORMATIONS', '~b~Control routier', 'Agent: ~g~'..nom..'\n~w~Code: ~g~10-48\n~w~Information: ~g~Control routier en cours.', 'CHAR_CALL911', 8)
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
	elseif service == 'refus' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		ESX.ShowAdvancedNotification('LSPD INFORMATIONS', '~b~Refus d\'obtempérer', 'Agent: ~g~'..nom..'\n~w~Code: ~g~10-30\n~w~Information: ~g~Refus d\'obtempérer / Délit de fuite en cours.', 'CHAR_CALL911', 8)
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
	elseif service == 'crime' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		ESX.ShowAdvancedNotification('LSPD INFORMATIONS', '~b~Crime en cours', 'Agent: ~g~'..nom..'\n~w~Code: ~g~10-31\n~w~Information: ~g~Crime en cours / poursuite en cours.', 'CHAR_CALL911', 8)
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
	end
end)

RegisterNetEvent('renfort:setBlip')
AddEventHandler('renfort:setBlip', function(coords, raison)
	if raison == 'petit' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", 1)
		ESX.ShowAdvancedNotification('LSPD INFORMATIONS', '~b~Demande de renfort', 'Demande de renfort demandé.\nRéponse: ~g~CODE-2\n~w~Importance: ~g~Légère.', 'CHAR_CALL911', 8)
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
		color = 2
	elseif raison == 'importante' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", 1)
		ESX.ShowAdvancedNotification('LSPD INFORMATIONS', '~b~Demande de renfort', 'Demande de renfort demandé.\nRéponse: ~g~CODE-3\n~w~Importance: ~o~Importante.', 'CHAR_CALL911', 8)
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
		color = 47
	elseif raison == 'omgad' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", 1)
		PlaySoundFrontend(-1, "FocusIn", "HintCamSounds", 1)
		ESX.ShowAdvancedNotification('LSPD INFORMATIONS', '~b~Demande de renfort', 'Demande de renfort demandé.\nRéponse: ~g~CODE-99\n~w~Importance: ~r~URGENTE !\nDANGER IMPORTANT', 'CHAR_CALL911', 8)
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
		PlaySoundFrontend(-1, "FocusOut", "HintCamSounds", 1)
		color = 1
	end
	blipId = AddBlipForCoord(coords)
	SetBlipSprite(blipId, 161)
	SetBlipScale(blipId, 1.2)
	SetBlipColour(blipId, color)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Demande renfort')
	EndTextCommandSetBlipName(blipId)
	table.insert(blips, blipId)
	Wait(80 * 1000)
	for i, blipId in pairs(blips) do 
		RemoveBlip(blipId)
	end
end)
