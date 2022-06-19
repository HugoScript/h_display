RegisterCommand('createUI', function(source, args, rawCommand)
    DisplayCreationUI()
end, false)
RegisterCommand('drawUI', function(source, args, rawCommand)
    if args[1] ~= nil then
        TriggerServerEvent('h_display:getUiInfo', args[1])
    end
end, false)
Citizen.CreateThread(function()
    while true do
        Wait(5)
        if IsControlJustPressed(0, 288) then
            DisplayCreationUI()
        end
    end
end)