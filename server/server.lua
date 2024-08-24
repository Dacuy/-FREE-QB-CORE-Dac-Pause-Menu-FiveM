local QBCore = exports['qb-core']:GetCoreObject()
local joinTime = 0

RegisterNetEvent('esx:playerLoaded', function()
    joinTime = os.time()
end)

QBCore.Functions.CreateCallback('getPlayerData', function(source, cb)
    local xPlayer = QBCore.Functions.GetPlayer(source)

    if not xPlayer then
        cb(nil)
        return
    end

    local playerData = xPlayer.PlayerData
    local jobData = playerData.job
    local charinfo = playerData.charinfo
    local money = playerData.money

    local Datas = {
        name = charinfo.firstname .. " " .. charinfo.lastname,
        job = jobData.name,
        jobGrade = jobData.grade.name,
        cash = money.cash,
        money = money.bank,
        from = charinfo.nationality,
        id = source
    }
    cb(Datas)
end)

QBCore.Functions.CreateCallback('jobCount', function(source, cb)
    local policeCount, emsCount = 0, 0
    local players = QBCore.Functions.GetPlayers()

    for _, playerId in ipairs(players) do
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
    QBCore.Functions.Kick(source, 'Te saliste pete')
end)
