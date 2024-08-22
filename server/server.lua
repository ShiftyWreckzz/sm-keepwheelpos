local steeringAngles = {}

RegisterServerEvent('sm-wheelpos:updateSteeringAngle')
AddEventHandler('sm-wheelpos:updateSteeringAngle', function(vehicleNetId, angle)
    steeringAngles[vehicleNetId] = angle
    TriggerClientEvent('sm-wheelpos:applySteeringAngle', -1, vehicleNetId, angle)
end)

CreateThread(function()
    while true do
        for vehicleNetId, angle in pairs(steeringAngles) do
            TriggerClientEvent('sm-wheelpos:applySteeringAngle', -1, vehicleNetId, angle)
        end
        Wait(5000)
    end
end)