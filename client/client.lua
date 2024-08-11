local QBCore = exports['qb-core']:GetCoreObject()
local openActive = false
local isMenuActive = false

Citizen.CreateThread(function()
    while true do
        local playerDataSent = false
        local playTimeSent = false

        -- Control de radar y pausa del menú
        if not openActive then 
            DisplayRadar(true)
            if isMenuActive then
                SetPauseMenuActive(true)
            end
        else
            DisplayRadar(false)
            SetPauseMenuActive(false)
        end 

        -- Manejo de apertura y cierre del menú
        if (IsControlJustPressed(1,200) or IsControlJustPressed(1,199)) and not openActive then 
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

        -- Reanudar juego con ESCAPE
        if IsControlJustPressed(1,200) and IsPauseMenuActive() then 
            QBCore.Functions.resumeGame()
            TransitionFromBlurred(1000)
        end

        Wait(0)
    end
end)

-- Functions
function QBCore.Functions.resumeGame()
    openActive = false
    isMenuActive = false
    SendNUIMessage({action = "uiDisabled"})
    SetNuiFocus(false, false)
end

-- Callbacks
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
