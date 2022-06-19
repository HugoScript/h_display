RegisterNetEvent('h_server:DrawUi')
AddEventHandler('h_server:DrawUi', function(infoUI)
    while true do
        Wait(1)
        DisableControlAction(0, 24, true)
        local cursorCoords = GetCursorScreenPosition()

        for k, v in pairs(infoUI) do
            if json.encode(v) ~= "[]" and k ~= "name" then
                local info = v[1]

                if k == "txt" then
                    Draw2DText(info["x"], info["y"], info["width"], info["height"], info["txt"], info["r"], info["g"], info["b"], info["a"], info["scale"])
                end

                if k == "rect" then
                    DrawRect(info["x"], info["y"], info["width"], info["height"], info["r"], info["g"], info["b"], info["a"])
                end

                if k == "sprite" or k == "circle" then
                    DrawSprites(info["dict"], info["img"], info["x"], info["y"], info["width"], info["height"], 0, info["r"], info["g"], info["b"], info["a"])
                end

                if k == "buttonS" then
                    DrawSprites(info["dict"], info["img"], info["x"], info["y"], info["width"], info["height"], 0, info["r"], info["g"], info["b"], info["a"])
                end
            end
        end
    end
end)