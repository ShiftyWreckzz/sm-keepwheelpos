CreateThread(function()
    local angle = 0.0
    local hasTriggered = false
    while true do
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsUsing(ped)
        if DoesEntityExist(veh) and GetPedInVehicleSeat(veh, -1) then
            local tangle = GetVehicleSteeringAngle(veh)
            local speed = GetEntitySpeed(veh)

            if tangle > 10.0 or tangle < -10.0 then
                angle = tangle
            end

            if speed < 0.1 then
                if GetIsTaskActive(ped, 2) and not GetIsTaskActive(ped, 151) then
                    SetVehicleSteeringAngle(veh, angle)
                    hasTriggered = false
                end

                -- Only reset angle to 0.0 when the vehicle is stopped and steering angle is below or equal to 10
                if tangle >= -10.0 and tangle <= 10.0 then
                    angle = 0.0
                end
            end
        elseif not hasTriggered and DoesEntityExist(veh) then
            TriggerServerEvent('sm-wheelpos:updateSteeringAngle', NetworkGetNetworkIdFromEntity(veh), angle)
            hasTriggered = true
        else
            Wait(2000)
        end
        Wait(50)
    end
end)

RegisterNetEvent('sm-wheelpos:applySteeringAngle')
AddEventHandler('sm-wheelpos:applySteeringAngle', function(vehicleNetId, angle)
    local veh = NetworkGetEntityFromNetworkId(vehicleNetId)
    if DoesEntityExist(veh) then
        SetVehicleSteeringAngle(veh, angle)
    end
end)
