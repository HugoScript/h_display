function Draw2DText(x,y ,width,height, text, r,g,b,a, scale)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(0.0, scale)
    SetTextColour(r,g,b,a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

function GetCursorScreenPosition()
    if (not IsControlEnabled(0, 239)) then
        EnableControlAction(0, 239, true)
    end
    if (not IsControlEnabled(0, 240)) then
        EnableControlAction(0, 240, true)
    end

    return vector2(GetControlNormal(0, 239), GetControlNormal(0, 240))
end

function OnClickSpriteButton(cX, vY, x, y, w, h)
    local statut = false
    if (cX >= x - (w/2) and cX <= x + (w/2)) and (vY >= y - (h/2) and vY <= y + (h/2)) then
        if IsControlJustPressed(0, 69) then
            statut = true
        end
    end

    return statut
end

function PressedClickSpriteButton(cX, vY, x, y, w, h)
    local statut = false
    if (cX >= x - (w/2) and cX <= x + (w/2)) and (vY >= y - (h/2) and vY <= y + (h/2)) then
        if IsControlPressed(0, 69) then
            statut = true
        end
    end

    return statut
end

function math.round(num, decimals)
    decimals = math.pow(10, decimals or 0)
    num = num * decimals
    if num >= 0 then num = math.floor(num + 0.5) else num = math.ceil(num - 0.5) end
    return num / decimals
end

function InputBox()
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 300)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
        local result = GetOnscreenKeyboardResult()
        return result
    end
end

function DrawSprites(dict, name, x, y, width, height, heading, r, g, b, a)
    while not HasStreamedTextureDictLoaded(dict) do
        RequestStreamedTextureDict(dict, 1)
        Wait(0)
    end
        
    DrawSprite(dict, name, x, y, width, height, heading, r, g, b, a)
end