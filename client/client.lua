local QBCore = exports['qb-core']:GetCoreObject()
local openActive = false
local isMenuActive = false

Citizen.CreateThread(function()
    while true do
        local playerDataSent = false
        local playTimeSent = false

        local playerPed = PlayerPedId()
        local inVehicle = IsPedInAnyVehicle(playerPed, false)

        if not openActive and not isMenuActive then
            DisplayRadar(inVehicle) 
            SetPauseMenuActive(false)
        else
            DisplayRadar(false)
            SetPauseMenuActive(false)
        end 

        if (IsControlJustPressed(1, 200) or IsControlJustPressed(1, 199)) and not openActive then 
            openActive = true
            isMenuActive = false
            SetPauseMenuActive(false)
            DisplayRadar(false)

            SendNUIMessage({action = "uiEnabled"})
            SetNuiFocus(true, true)
            
            if not playerDataSent then
                QBCore.Functions.TriggerCallback('getPlayerData', function(datas)
                    SendNUIMessage({
                        type = 'serverInfo',
                        playerDatas = datas,
                        activePlayersNumber = #GetActivePlayers()
                    })
                    QBCore.Functions.TriggerCallback('jobCount', function(data)
                        SendNUIMessage({
                            type = 'jobCount',
                            emsCount = data.emsCount,
                            policeCount = data.policeCount
                        })
                        
                    end)
                end)
                playerDataSent = true
            end

            if not playTimeSent then
                QBCore.Functions.TriggerCallback('getPlayTime', function(time)
                    SendNUIMessage({onlinePlayTime = time})
                end)
                playTimeSent = true
            end
        end 

        if IsControlJustPressed(1, 200) and IsPauseMenuActive() then 
            QBCore.Functions.resumeGame()
            TransitionFromBlurred(1000)
        end

        if IsControlJustReleased(1, 177) and isMenuActive then
            QBCore.Functions.resumeGame()
            TransitionFromBlurred(1000)
        end

        Wait(0)
    end
end)

-- Funciones
function QBCore.Functions.resumeGame()
    openActive = false
    isMenuActive = false
    SendNUIMessage({action = "uiDisabled"})
    SetNuiFocus(false, false)

    local playerPed = PlayerPedId()
    local inVehicle = IsPedInAnyVehicle(playerPed, false)
    DisplayRadar(inVehicle)
end

RegisterNUICallback('resumeGame', QBCore.Functions.resumeGame)

RegisterNUICallback('closeGui', function()
    QBCore.Functions.resumeGame()
end)

RegisterNUICallback('showMap', function()
    ActivateFrontendMenu(GetHashKey('FE_MENU_VERSION_MP_PAUSE'), 0, -1)
    isMenuActive = true
    SendNUIMessage({action = "uiDisabled"})
    SetNuiFocus(false, false)
end)

RegisterNUICallback('showSettings', function()
    ActivateFrontendMenu(GetHashKey('FE_MENU_VERSION_LANDING_MENU'), 0, -1)
    isMenuActive = true
    SendNUIMessage({action = "uiDisabled"})
    SetNuiFocus(false, false)
end)

RegisterNUICallback('disconnect', function()
    TriggerServerEvent('disconnectPlayer')
end)
