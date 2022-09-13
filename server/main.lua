if GetResourceState('es_extended') == 'started' then
    local ESX = exports['es_extended']:getSharedObject()

    ESX.RegisterCommand('setdimension', 'admin', function(xPlayer, args, showError)
        local xTarget = ESX.GetPlayerFromId(args.playerId.source)
        local vehicle = GetVehiclePedIsIn(GetPlayerPed(xTarget.source))

        SetPlayerRoutingBucket(xTarget.source, args.dimension)

        if vehicle ~= 0 then
            SetEntityRoutingBucket(vehicle, args.dimension)
        end

        xPlayer.showNotification(Locale('set_dimension_notification', GetPlayerName(xTarget.source), args.dimension))
    end, false, {
        help = Locale('set_dimension_help'),
        arguments = {
            {name = 'playerId', help = Locale('set_dimension_player'), type = 'player'},
            {name = 'dimension', help = Locale('set_dimension_bucket'), type = 'number'}
        }
    })

    ESX.RegisterCommand('getdimension', 'admin', function(xPlayer, args, showError)
        local xTarget = ESX.GetPlayerFromId(args.playerId.source)

        xPlayer.showNotification(Locale('get_dimension_notification', GetPlayerName(xTarget.source), GetPlayerRoutingBucket(xTarget.source)))
    end, false, {
        help = Locale('get_dimension_help'),
        arguments = {
            {name = 'playerId', help = Locale('get_dimension_player'), type = 'player'},
        }
    })
elseif GetResourceState('qb-core') == 'started' then
    local QBCore = exports['qb-core']:GetCoreObject()

    QBCore.Commands.Add('setdimension', Locale('set_dimension_help'), {
        {name = 'playerId', help = Locale('set_dimension_player')},
        {name = 'dimension', help = Locale('set_dimension_dimension')}
    }, true, function(source, args)
        local playerId, dimension = tonumber(args[1]), tonumber(args[2])
        local xPlayer, xTarget = QBCore.Functions.GetPlayer(source), QBCore.Functions.GetPlayer(playerId)

        if playerId and xTarget then
            if dimension then
                local vehicle = GetVehiclePedIsIn(GetPlayerPed(playerId))

                if vehicle ~= 0 then
                    SetEntityRoutingBucket(vehicle, dimension)
                end

                SetPlayerRoutingBucket(playerId, dimension)
                TriggerClientEvent('QBCore:Notify', source, Locale('set_dimension_notification', GetPlayerName(playerId), dimension), 'success')
            else
                TriggerClientEvent('QBCore:Notify', source, Locale('set_dimension_error_notdimension'), 'error')
            end
        else
            TriggerClientEvent('QBCore:Notify', source, Locale('set_dimension_error_notplayerid'), 'error')
        end
    end, 'admin')

    QBCore.Commands.Add('getdimension', Locale('get_dimension_help'), {
        {name = 'playerId', help = Locale('get_dimension_player')}
    }, true, function(source, args)
        local playerId = tonumber(args[1])
        local xTarget = QBCore.Functions.GetPlayer(playerId)

        if playerId and xTarget then
            TriggerClientEvent('QBCore:Notify', source, Locale('get_dimension_notification', GetPlayerName(playerId), GetPlayerRoutingBucket(playerId)), 'success')
        else
            TriggerClientEvent('QBCore:Notify', source, Locale('get_dimension_error_notplayerid'), 'error')
        end
    end, 'admin')
else
    print('^2[Playsec Dimensions]^4 No framework found, please. Use QB-Core or ESX, if you are already doing this start it under frameworks.^0')
end