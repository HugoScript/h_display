RegisterServerEvent('h_display:saveFileJson')
AddEventHandler('h_display:saveFileJson', function(ui, nameUi)
    infoUI = ui

    local save = {}
    local loadFile = LoadResourceFile(GetCurrentResourceName(), "./uiSave.json")
    local uiN = 0

    if loadFile == "" then
        save[1] = infoUI
    else
        for k, v in pairs(json.decode(loadFile)) do
            save[k] = v
            uiN = uiN + 1
        end
        save[uiN + 1] = infoUI
    end
    SaveResourceFile(GetCurrentResourceName(), "uiSave.json", json.encode(save))
end)


RegisterServerEvent('h_display:getUiInfo')
AddEventHandler('h_display:getUiInfo', function(uiName)
    local extract = {}
    local loadFile = LoadResourceFile(GetCurrentResourceName(), "./uiSave.json")
    extract = json.decode(loadFile)
    
    for k, v in pairs(extract) do
        print(v.name, uiName)
        if tostring(v.name) == tostring(uiName) then
            Wait(5)
            TriggerClientEvent('h_server:DrawUi', -1, v)
        end
    end
end)