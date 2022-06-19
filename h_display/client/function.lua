optionBar = {
    buttonFonction = {
        ["rectangle"] = {x = 0.05, y = 0.05, width = 0.02, height = 0.03, r = 255, g = 255, b = 255, a = 200, dict = "texture_img", img = "square"},
        ["text"] = {x = 0.08, y = 0.05, width = 0.02, height = 0.03, r = 255, g = 255, b = 255, a = 200, dict = "texture_img", img = "text"},
        ["sprite"] = {x = 0.11, y = 0.05, width = 0.02, height = 0.03, r = 255, g = 255, b = 255, a = 200, dict = "texture_img", img = "sprite"},
        ["circle"] = {x = 0.14, y = 0.05, width = 0.02, height = 0.03, r = 255, g = 255, b = 255, a = 200, dict = "texture_img", img = "circle"},
    },
    buttonAddFonction = {
        ["button"] = {x = 0.18, y = 0.05, width = 0.02, height = 0.03, r = 255, g = 255, b = 255, a = 200, dict = "texture_img", img = "button"},
        ["over"] = {x = 0.21, y = 0.05, width = 0.02, height = 0.03, r = 255, g = 255, b = 255, a = 200, dict = "texture_img", img = "over"},
        --DOESNT WORK["animation"] = {x = 0.24, y = 0.05, width = 0.02, height = 0.03, r = 255, g = 255, b = 255, a = 200, dict = "texture_img", img = "animation"},
    },
    text = {
        [1] = {x = 0.89,    y = 0.07, width = 0.02, text = "OPTIONS", height = 0.02, r = 255, g = 255, b = 255, a = 255, scale = 0.5},
    },
    textInfo = {
        ["rect"] = {
            [1] = {text = "[SPACE]"},
        },
        ["text"] = {
            [1] = {text = "[T]"},
            [2] = {text = "[SPACE]"},
        },
        ["sprite"] = {
            [1] = {text = "[D]"},
            [2] = {text = "[B]"},
            [3] = {text = "[SPACE]"},
        },
        ["circle"] = {
            [1] = {text = "[SPACE]"},
        },
    }
}

function DisplayCreationUI()
    local playerId = PlayerPedId()
    FreezeEntityPosition(true, playerId)
    display = {}
    display.txt = {}
    display.rect = {}
    display.sprite = {}
    display.circle = {}
    display.calque = {}
    numberCalque = 0
    numberRect = 0
    numberText = 0
    numberSprite = 0
    numberCircle = 0
    typeChoose = nil
    choose = nil
    onSlide = nil
    EnterCursorMode()

    while true do
        Wait(1)
        DisableControlAction(0, 24, true)
        DisplayRadar(false)
        local cursorCoords = GetCursorScreenPosition()

        --FONCTION BAR (UP)
        for k, v in pairs(optionBar.buttonFonction) do
            DrawSprites(v.dict, v.img, v.x, v.y, v.width, v.height, 0, v.r, v.g, v.b, v.a)

            if OnClickSpriteButton(cursorCoords.x, cursorCoords.y, v.x, v.y, v.width, v.height) then
                Wait(5)
                --CREATE A NEW RECTANGLE OR SPRITE OR TEXT ... IN TABLE TO DRAW
                if k == "rectangle" then
                    Wait(5)
                    numberRect = numberRect + 1
                    nC = numberRect
                    dC = display.rect
                    toInput = {x = 0.5, y = 0.5, height = 0.1, width = 0.1, r = 255, g = 255, b = 255, a = 255, trigger = {}, over = {}, animation = {}}
                end
                if k == "text" then
                    Wait(5)
                    numberText = numberText + 1
                    nC = numberText
                    dC = display.txt
                    toInput = {x = 0.5, y = 0.5, txt = "Default text", height = 0.05, width = 0.05, r = 255, g = 255, b = 255, a = 255, scale = 0.5, trigger = {}, over = {}, animation = {}}
                end
                if k == "sprite" then
                    Wait(5)
                    numberSprite = numberSprite + 1
                    nC = numberSprite
                    dC = display.sprite
                    toInput = {x = 0.5, y = 0.5, dict = "texture_img", img = "categorie_down", height = 0.05, width = 0.05, r = 255, g = 255, b = 255, a = 255, trigger = {}, over = {}, animation = {}}
                end
                if k == "circle" then
                    Wait(5)
                    numberCircle = numberCircle + 1
                    nC = numberCircle
                    dC = display.circle
                    toInput = {x = 0.5, y = 0.5, dict = "texture_img", img = "circleDraw", height = 0.05, width = 0.05, r = 255, g = 255, b = 255, a = 255, trigger = {}, over = {}, animation = {}}
                end

                dC[nC] = toInput
                numberCalque = numberCalque + 1
                display.calque[numberCalque] = {style = k, num = nC}
            end
        end

        --DRAW(TEXT, BUTTON)
        if json.encode(display.rect) ~= "[]" then
            for k, v in pairs(display.rect) do
                DrawRect(v.x, v.y, v.width, v.height, v.r, v.g, v.b, v.a)

                --WHEN PRESSED CLICK ON RECTANGLE CHANGE COORDS AND ENTER IN MODIF MOD
                if PressedClickSpriteButton(cursorCoords.x, cursorCoords.y, v.x, v.y, v.width, v.height) and (onSlide == "rect" or onSlide == nil) then
                    typeChoose = "rect"
                    choose = k
                    onSlide = "rect"
                    v.x = cursorCoords.x
                    v.y = cursorCoords.y
                end
                if IsControlReleased(0, 69) and onSlide == "rect" then
                    onSlide = nil
                end
            end
        end

        if json.encode(display.txt) ~= "[]" then
            for k, v in pairs(display.txt) do
                Draw2DText(v.x, v.y, v.width, v.height, v.txt, v.r, v.g, v.b, v.a, v.scale)

                --WHEN PRESSED CLICK ON TEXT CHANGE COORDS AND ENTER IN MODIF MOD
                if PressedClickSpriteButton(cursorCoords.x, cursorCoords.y, v.x, v.y, v.width, v.height) and (onSlide == "text" or onSlide == nil) then
                    typeChoose = "text"
                    choose = k
                    onSlide = "text"
                    v.x = cursorCoords.x
                    v.y = cursorCoords.y
                end
                if IsControlReleased(0, 69) and onSlide == "text" then
                    onSlide = nil
                end
            end
        end

        if json.encode(display.sprite) ~= "[]" then
            for k, v in pairs(display.sprite) do
                DrawSprites(v.dict, v.img, v.x, v.y, v.width, v.height, 0, v.r, v.g, v.b, v.a)

                --WHEN PRESSED CLICK ON SPRITE CHANGE COORDS AND ENTER IN MODIF MOD
                if PressedClickSpriteButton(cursorCoords.x, cursorCoords.y, v.x, v.y, v.width, v.height) and (onSlide == "sprite" or onSlide == nil) then
                    typeChoose = "sprite"
                    choose = k
                    onSlide = "sprite"
                    v.x = cursorCoords.x
                    v.y = cursorCoords.y
                end
                if IsControlReleased(0, 69) and onSlide == "sprite" then
                    onSlide = nil
                end
            end
        end

        if json.encode(display.circle) ~= "[]" then
            for k, v in pairs(display.circle) do
                DrawSprites(v.dict, v.img, v.x, v.y, v.width, v.height, 0, v.r, v.g, v.b, v.a)

                --WHEN PRESSED CLICK ON CIRCLE CHANGE COORDS AND ENTER IN MODIF MOD
                if PressedClickSpriteButton(cursorCoords.x, cursorCoords.y, v.x, v.y, v.width, v.height) and (onSlide == "circle" or onSlide == nil) then
                    typeChoose = "circle"
                    choose = k
                    onSlide = "circle"
                    v.x = cursorCoords.x
                    v.y = cursorCoords.y
                    if IsControlJustReleased(0, 69) and onSlide == "circle" then
                        onSlide = nil
                    end
                end
            end
        end

        --CUSTOM MOD TO CHANGE PARAMS
        local del = Params(choose, typeChoose, cursorCoords)
        if del then
            print(typeChoose)
            if typeChoose == "rect" then
                table.remove(display.rect, choose)
                numberRect = numberRect - 1
            elseif typeChoose == "sprite" then
                table.remove(display.sprite, choose)
                numberSprite = numberSprite - 1
            elseif typeChoose == "circle" then
                table.remove(display.circle, choose)
                numberCircle = numberCircle - 1
            elseif typeChoose == "text" then
                table.remove(display.txt, choose)
                numberText = numberText - 1
            end
            
            choose = nil
            onSlide = nil
        end
        if IsControlJustPressed(0, 194) then--WHEN PRESS RETURN TO SAVE
            nameUi = InputBox()
            display.name = nameUi
            FreezeEntityPosition(false, playerId)
            TriggerServerEvent('h_display:saveFileJson', display)
            DisableControlAction(0, 24, false)
            LeaveCursorMode()
            return
        end
    end
end

--TO DRAW RED POINT
function DrawPoint(variable, dX, dY, dW, dH, type)
    local cursorCoords = GetCursorScreenPosition()
    local onClick = false
    local points = {
        [1] = {x = dX, y =dY, width = 0.005, height = 0.01, r = 255, g = 0, b = 0, a = 255},--midle
        [2] = {x = dX, y = dY - (dH/1.5), width = 0.005, height = 0.01, r = 255, g = 0, b = 0, a = 255},--down midle
        [3] = {x = dX, y = dY + (dH/1.5), width = 0.005, height = 0.01, r = 255, g = 0, b = 0, a = 255},--up midle
    
        [4] = {x = dX - (dW/1.5), y = dY + (dH/1.5), width = 0.005, height = 0.01, r = 255, g = 0, b = 0, a = 255},--down left
        [5] = {x = dX + (dW/1.5), y = dY - (dH/1.5), width = 0.005, height = 0.01, r = 255, g = 0, b = 0, a = 255},--up right
    
        [6] = {x = dX + (dW/1.5), y = dY + (dH/1.5), width = 0.005, height = 0.01, r = 255, g = 0, b = 0, a = 255},--down right
        [7] = {x = dX - (dW/1.5), y = dY - (dH/1.5), width = 0.005, height = 0.01, r = 255, g = 0, b = 0, a = 255},--up left
    
        [8] = {x = dX + (dW/1.5), y = dY, width = 0.005, height = 0.01, r = 255, g = 0, b = 0, a = 255},--midle right
        [9] = {x = dX - (dW/1.5), y = dY, width = 0.005, height = 0.01, r = 255, g = 0, b = 0, a = 255},--mide left
    }
    local pointsDraw = 0

    for k, v in pairs(points) do
        pointsDraw = pointsDraw + 1
        DrawRect(v.x, v.y, v.width, v.height, v.r, v.g, v.b, v.a)

        if OnClickSpriteButton(cursorCoords.x, cursorCoords.y, v.x, v.y, v.width, v.height)  then
            onClick = true
            while onClick do
                Wait(1)
                local cursorCoords = GetCursorScreenPosition()
                DrawRect(v.x, v.y, v.width, v.height, v.r, v.g, v.b, v.a)

                if PressedClickSpriteButton(cursorCoords.x, cursorCoords.y, v.x, v.y, v.width, v.height)  and (k == 8 or k == 9)then
                    variable.width = OnClickRedPoint(v.x, v.y, v.width, v.height, v.r, v.g, v.b, v.a, cursorCoords.x, variable, k, "no")
                elseif PressedClickSpriteButton(cursorCoords.x, cursorCoords.y, v.x, v.y, v.width, v.height)  and (k == 2 or k == 3)then
                    variable.width = OnClickRedPoint(v.x, v.y, v.width, v.height, v.r, v.g, v.b, v.a, cursorCoords.y, variable, k, "no")
                elseif PressedClickSpriteButton(cursorCoords.x, cursorCoords.y, v.x, v.y, v.width, v.height) and (k == 4 or k == 5 or k ==6 or k == 7 ) then
                    variable.width = OnClickRedPoint(v.x, v.y, v.width, v.height, v.r, v.g, v.b, v.a, cursorCoords.y, variable, cursorCoords.x, "all")
                else
                    onClick = false
                end
            end
        end
        if IsControlJustPressed(0, 22) then--PRESS SPACE TO DELETE
            return true
        end
    end
    local drawXCoordsInfo = 0.3
    for k, v in pairs(optionBar.textInfo[type]) do
        drawXCoordsInfo = drawXCoordsInfo + 0.1
        Draw2DText(drawXCoordsInfo, 0.9, 0.01, 0.01, v.text, 255, 255, 255, 255, 0.5)
    end
end

--WHEN CLICK ON RED POINT
function OnClickRedPoint(x, y, width, height, r, g, b, a, c, variable, k, all)
    onClickRedPoint = true
    local defaultC = c + variable.height
    local defaultC1 = k + variable.width
    statut = 0
    while onClickRedPoint do
        Wait(1)
        local cursorCoords = GetCursorScreenPosition()
        DrawRect(x, y, width, height, r, g, b, a)
        DrawRect(variable.x, variable.y, variable.width, variable.height, variable.r, variable.g, variable.b, variable.a)

        if k == 2 or k == 3 then
            cursor = cursorCoords.y
            statut = defaultC - cursor
            if statut < 0 then
                statut = (statut - statut) - statut
            end
            variable.height = statut

        elseif k == 8 or k == 9 then
            cursor = cursorCoords.x
            statut = defaultC - cursor
            if statut < 0 then
                statut = (statut - statut) - statut
            end
            variable.width = statut

        elseif all == "all" then
            cursor = cursorCoords.x
            cursorY = cursorCoords.y
            statutW = defaultC - cursor
            statutH = defaultC1 - cursorY
            if statutW < 0 then
                statutW = (statutW - statutW) - statutW
            end

            if statutH < 0 then
                statutH = (statutH - statutH) - statutH
            end
            variable.width = statutW
            variable.height = statutH
        end

        if IsControlJustReleased(0, 69) then
            if cursorY ~= nil then
                onClickRedPoint = false
                return statutW, statutH
            else
                onClickRedPoint = false
                return statut
            end
        end
    end
end

function Params(choose, typeChoose, cursorCoords)
    if choose ~= nil then
        if IsControlJustPressed(0, 70) then
            typeChoose = nil
            choose = nil
        else
            if typeChoose == "rect" then
                d = display.rect
                n = choose
            elseif typeChoose == "sprite" then
                d = display.sprite
                n = choose
            elseif typeChoose == "circle" then
                d = display.circle
                n = choose
            elseif typeChoose == "text" then
                d = display.txt
                n = choose
            end
            --DRAW BAR ON RIGHT
            DrawRect(0.9, 0.5, 0.2, 0.9, 35, 39, 42, 200)
            
            -- DRAW RED POINT TO CHANGE SIZE
            local del = DrawPoint(d[choose], d[choose].x, d[choose].y, d[choose].width, d[choose].height, typeChoose)

            --DRAW TEXT ON TOP OF BAR 'OPTIONS'
            for k, v in pairs(optionBar.text) do
                Draw2DText(v.x, v.y, v.width, v.height, v.text, v.r, v.g, v.b, v.a, v.scale)
            end

            --DRAW CUSTOM BUTTON 'ANIMATION'....
            for k, v in pairs(optionBar.buttonAddFonction) do
                DrawSprites(v.dict, v.img, v.x, v.y, v.width, v.height, 0, v.r, v.g, v.b, v.a)

                if OnClickSpriteButton(cursorCoords.x, cursorCoords.y, v.x, v.y, v.width, v.height) then
                    Wait(5)
                    if k == "button" then
                        Wait(5)
                        local inputTrigger = InputBox()
                        d[choose].trigger = inputTrigger
                    end
                    if k == "over" then
                        Wait(5)
                        local overInput = CreateOver(choose, typeChoose, d[choose].x, d[choose].y, d[choose].width, d[choose].height, d[choose].r, d[choose].g, d[choose].b, d[choose].a, d[choose].scale, d[choose].dict, d[choose].name)
                        d[choose].over = {dict = d[choose].dict, img = d[choose].img, x = d[choose].x, y =  d[choose].y, width = d[choose].width, height = d[choose].height, r = d[choose].r, g = d[choose].g, b = d[choose].b, a = d[choose].a, scale = d[choose].scale, trigger = d[choose].trigger}
                    end
                    --DOESNT WORKif k == "animation" then
                    --DOESNT WORK    Wait(5)
                    --DOESNT WORK    local returnAnim = CreateAnimation(d, choose, typeChoose)
                    --DOESNT WORK    print(returnAnim)
                    --DOESNT WORK    --d[choose].animation = {}
                    --DOESNT WORKend
                end
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
            if del then --WHEN SPACE TO DELETE
                return true
            end
        end
    end
end
