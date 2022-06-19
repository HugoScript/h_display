--[[DOESNT WORK 
anim = {}
numberAnim = 0
numberFrame = 0
function CreateAnimation(displayI, toChoose, style)
    numberAnim = numberAnim + 1
    anim[numberAnim] = {}
    displayInfo = displayI[toChoose]
    onSlide = nil

    while true do
        Wait(1)
        local cursorCoords = GetCursorScreenPosition()
        DrawRect(0.5, 0.928, 0.5, 0.146, 0, 0, 0, 255)

        CreateDrawAnim(displayInfo, style, cursorCoords)

        ParamsAnim(toChoose, style, cursorCoords, displayI)

    end
end

function CreateDrawAnim(displayInfo, style, cursorCoords)
        if style == "rect" then
            DrawRect(displayInfo.x, displayInfo.y, displayInfo.width, displayInfo.height, displayInfo.r, displayInfo.g, displayInfo.b, displayInfo.a)
        elseif style == "sprite" then
            DrawSprites(displayInfo.dict, displayInfo.img, displayInfo.x, displayInfo.y, displayInfo.width, displayInfo.height, 0, displayInfo.r, displayInfo.g, displayInfo.b, displayInfo.a)
        elseif style == "circle" then
            DrawSprites(displayInfo.dict, displayInfo.img, displayInfo.x, displayInfo.y, displayInfo.width, displayInfo.height, 0, displayInfo.r, displayInfo.g, displayInfo.b, displayInfo.a)
        elseif style == "text" then
            Draw2DText(displayInfo.x, displayInfo.y, displayInfo.width, displayInfo.height, displayInfo.text, displayInfo.r, displayInfo.g, displayInfo.b, displayInfo.a, displayInfo.scale)
        end

        if PressedClickSpriteButton(cursorCoords.x, cursorCoords.y, displayInfo.x, displayInfo.y, displayInfo.width, displayInfo.height) and (onSlide == "rect" or onSlide == nil) then
            typeChoose = "rect"
            choose = k
            onSlide = "rect"
            displayInfo.x = cursorCoords.x
            displayInfo.y = cursorCoords.y
        end
        if IsControlReleased(0, 69) and onSlide == "rect" then
            onSlide = nil
        end
end

function ParamsAnim(choose, typeChoose, cursorCoords, d)
    if choose ~= nil then
        if IsControlJustPressed(0, 70) then
            typeChoose = nil
            choose = nil
        else
            --DRAW BAR ON RIGHT
            DrawRect(0.9, 0.5, 0.2, 0.9, 35, 39, 42, 200)
            
            -- DRAW RED POINT TO CHANGE SIZE
            DrawPoint(d[choose], d[choose].x, d[choose].y, d[choose].width, d[choose].height, typeChoose)

            --DRAW TEXT ON TOP OF BAR 'OPTIONS'
            for k, v in pairs(optionBar.text) do
                Draw2DText(v.x, v.y, v.width, v.height, v.text, v.r, v.g, v.b, v.a, v.scale)
            end

            --DRAW ALL OF INFORMATION TABLE RIGHT PANEL '+', '-', number ...
            local yStartButton = 0.1
            for k, v in pairs(d[choose]) do
                if k ~= "trigger" and k ~= "txt" and k ~= "img" and k ~= "dict" and k ~= "over" and k ~= "animation" then
                    Draw2DText(0.92, yStartButton, 0.01, 0.01, k, 255, 255, 255, 255, 0.5)
                    Draw2DText(0.85, yStartButton + 0.05, 0.01, 0.01, "-", 255, 255, 255, 255, 0.5)
                    Draw2DText(0.9, yStartButton + 0.05, 0.01, 0.01, tostring(math.round(v, 3)), 255, 255, 255, 255, 0.5)
                    Draw2DText(0.98, yStartButton + 0.05, 0.01, 0.01, "+", 255, 255, 255, 255, 0.5)
                
                    if OnClickSpriteButton(cursorCoords.x, cursorCoords.y, 0.91, yStartButton + 0.07, 0.05, 0.03)  then-- click on number
                        value = InputBox()
    
                        if tonumber(value) ~= nil then
                            if tonumber(value) >= 0 then
                                if k ~= "r" and k ~= "g" and k ~= "b" and k ~= "a" and tonumber(value) <= 1 then
                                    d[n][k] = tonumber(value)
                                elseif tonumber(value) <= 255 then
                                    d[n][k] = tonumber(value)
                                end
                            end
                        end
                    end
    
                    if OnClickSpriteButton(cursorCoords.x, cursorCoords.y, 0.85, yStartButton + 0.07, 0.015, 0.02)  then -- "-"
                        if tonumber(d[n][k]) > 0.01 then
                            if k ~= "r" and k ~= "g" and k ~= "b" and k ~= "a" then
                                d[n][k] = tonumber(d[n][k] - 0.01)
                            elseif tonumber(d[n][k]) >= 1.0 then
                                d[n][k] = tonumber(d[n][k] - 1.0)
                            end
                        end
                    end
    
                    if OnClickSpriteButton(cursorCoords.x, cursorCoords.y, 0.98, yStartButton + 0.07, 0.015, 0.02)  then-- "+"
                        if tonumber(d[n][k]) < 255 then
                            if (k ~= "r" and k ~= "g" and k ~= "b" and k ~= "a") then
                                if (tonumber(d[n][k]) < 1) then
                                    d[n][k] = tonumber(d[n][k] + 0.01)
                                end
                            else
                                d[n][k] = tonumber(d[n][k] + 1.0)
                            end
                        end
                    end
                    yStartButton = yStartButton + 0.1
                end
            end

            if IsControlJustPressed(0, 172) then
                numberFrame = numberFrame + 1
                
                anim[numberAnim][numberFrame] = {}
                anim[numberAnim][numberFrame] = d[choose]
                for k, v in pairs(anim[numberAnim]) do
                    print(k, json.encode(v))
                end
            end
            
            if IsControlJustPressed(0, 194) then
                Wait(50)
                for k, v in pairs(anim[numberAnim]) do
                    print(k, json.encode(v))
                end
                return
            end
        end
    end
end
]]