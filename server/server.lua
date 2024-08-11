local QBCore = exports['qb-core']:GetCoreObject()
local joinTime = 0

-- IsPlayerLoaded
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
    joinTime = os.time()
end)

-- PlayerData Callback
QBCore.Functions.CreateCallback('getPlayerData', function(source, cb)
    local xPlayer = QBCore.Functions.GetPlayer(source)

    if not xPlayer then
        return
    end

    -- Verificar el rol del usuario (admin, jugador, etc.)
    
    -- Verificar el rango del trabajo
    local jobGrade = xPlayer.PlayerData.job.grade.name

    -- Arreglar la obtención de dinero
    local money = {
        cash = xPlayer.PlayerData.money["cash"],
        bank = xPlayer.PlayerData.money["bank"],
    }
    -- Datos recopilados
    local Datas = {
        name = xPlayer.PlayerData.charinfo.firstname .. " " .. xPlayer.PlayerData.charinfo.lastname,
        job = xPlayer.PlayerData.job.name,
        jobGrade = jobGrade,
        cash = money.cash,
        money = money.bank,
        from = xPlayer.PlayerData.charinfo.nationality,
        id = source
    }
    cb(Datas)
end)



-- Disconnect Callback
RegisterNetEvent('disconnectPlayer', function()
    local src = source
    QBCore.Functions.Kick(src,'Te saliste pete')
end)

-- GetPlayTime Callback
RegisterNetEvent('getPlayTime', function(source, cb)
    local playerTime = QBCore.Functions.ConvertToMinutes(os.time() - joinTime)
    cb(playerTime)
end)


function QBCore.Functions.ConvertToMinutes(sec)
    return math.floor((sec % 3600) / 60)
end