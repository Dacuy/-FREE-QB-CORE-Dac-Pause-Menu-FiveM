local QBCore = exports['qb-core']:GetCoreObject()
local joinTime = 0

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
    joinTime = os.time()
end)

QBCore.Functions.CreateCallback('getPlayerData', function(source, cb)
    local xPlayer = QBCore.Functions.GetPlayer(source)

    if not xPlayer then
        return
    end

    
    local jobGrade = xPlayer.PlayerData.job.grade.name

    local money = {
        cash = xPlayer.PlayerData.money["cash"],
        bank = xPlayer.PlayerData.money["bank"],
    }
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

QBCore.Functions.CreateCallback('jobCount', function(source, cb)
    local policeCount = 0
    local emsCount = 0

    for _, playerId in ipairs(GetPlayers()) do
        local player = QBCore.Functions.GetPlayer(tonumber(playerId))
        if player then
            local jobName = player.PlayerData.job.name
            if jobName == "police" then
                policeCount = policeCount + 1
            elseif jobName == "ambulance" then
                emsCount = emsCount + 1
            end
        end
    end

    cb({policeCount = policeCount, emsCount = emsCount})
end)


-- Disconnect Callback
RegisterNetEvent('disconnectPlayer', function()
    local src = source
    QBCore.Functions.Kick(src,'Te saliste pete')
end)