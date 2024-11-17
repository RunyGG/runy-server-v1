local screen = {guiGetScreenSize ( )}
local resW, resH = 1366, 768
local sx, sy = (screen[1] / resW), (screen[2] / resH)
local img2 = dxCreateTexture( 'assets/images/smoke.png' )

cameras = {
    {588.9, 606.09, 11.09, 11.09, 'corpo'};
    {616.63, 607.33, 11.09, 8.63, 'bone'};
    {644.37, 607.33, 11.09, 8.63, 'paraquedas'};
    {672.1, 607.33, 11.09, 8.63, 'caixas'};
    {699.84, 607.33, 11.09, 8.63, 'tenis'};
}

windows = {
    {919, 250, 20, 15, 'rasante'};
    {985, 250, 20, 15, 'paraquedas'};
    {1052, 248, 20, 18, 'caixas'};
    {1121, 250, 18, 15, 'mochila'};
    {1186, 250, 20, 15, 'avatar'};
    {1252, 250, 20, 15, 'banner'};

    {920, 283, 20, 15, 'colete'};
    {989, 283, 20, 15, 'killfeed'};

    {1055, 283, 20, 15, 'silent'};

    --{991.75, 286.08, 9.57, 4.78, 'killfeed'};
}

remove = {
    {904.95, 319.57, 47.84, 47.84};
}

slots = {
    
    {974.62, 319.57, 47.84, 47.84, 255};
    {1040.39, 319.57, 47.84, 47.84, 255};
    {1106.17, 319.57, 47.84, 47.84, 255};
    {1171.95, 319.57, 47.84, 47.84, 255};
    {1237.72, 319.57, 47.84, 47.84, 255};
    
    {974.62, 386.54, 47.84, 47.84, 255};
    {1040.39, 386.54, 47.84, 47.84, 255};
    {1106.17, 386.54, 47.84, 47.84, 255};
    {1171.95, 386.54, 47.84, 47.84, 255};
    {1237.72, 386.54, 47.84, 47.84, 255};
    
    {974.62, 452.92, 47.84, 47.84, 255};
    {1040.39, 452.92, 47.84, 47.84, 255};
    {1106.17, 452.92, 47.84, 47.84, 255};
    {1171.95, 452.92, 47.84, 47.84, 255};
    {1237.72, 452.92, 47.84, 47.84, 255};
    
    {974.62, 519.29, 47.84, 47.84, 255};
    {1040.39, 519.29, 47.84, 47.84, 255};
    {1106.17, 519.29, 47.84, 47.84, 255};
    {1171.95, 519.29, 47.84, 47.84, 255};
    {1237.72, 519.29, 47.84, 47.84, 255};
    
    {974.62, 585.67, 47.84, 47.84, 255};
    {1040.39, 585.67, 47.84, 47.84, 255};
    {1106.17, 585.67, 47.84, 47.84, 255};
    {1171.95, 585.67, 47.84, 47.84, 255};
    {1237.72, 585.67, 47.84, 47.84, 255};
    
}

local createdFonts = {}
function getFont(font, size)
    if (createdFonts[font..':'..size]) then 
        return createdFonts[font..':'..size]
    else
        createdFonts[font..':'..size] = dxCreateFont('assets/fonts/'..font..'.ttf', sy * (size / 1.4))
        return createdFonts[font..':'..size]
    end
end

function drawScrollBar(x, y, width, height, scrollPos, scrollHeight)
    local thumbHeight = height * (height / scrollHeight)
    local thumbY = y + (scrollPos / (scrollHeight - height)) * (height - thumbHeight)
    dxDrawImage(x, y, width, height, 'assets/images/scroll_fundo.png', 0, 0, 0, tocolor(255, 255, 255, 255))
    dxDrawImage(x, thumbY, width, thumbHeight, 'assets/images/scroll.png', 0, 0, 0, tocolor(255, 255, 255, 255))
end

function drawClothes()
    
    local alpha = interpolateBetween(0, 0, 0, 255, 0, 0, ((getTickCount() - tick) / 300), 'Linear')
    
    dxDrawImage(555, 595, 255.77, 61.63, 'assets/images/fundo_cameras.png', 0, 0, 0, tocolor(255, 255, 255, alpha))
    
    for i, v in ipairs(cameras) do 
        
        dxDrawImage(582.12 + (27.73 * (i - 1)), 600.55, 24.65, 21.57, 'assets/images/bg_cameras.png', 0, 0, 0, ((isMouseInPosition(582.12 + (27.73 * (i - 1)), 600.55, 24.65, 21.57) or camera == v[5]) and tocolor(109, 40, 217, 255) or tocolor(255, 255, 255, 10)))
        dxDrawImage(v[1], v[2], v[3], v[4], 'assets/images/cameras/'..v[5]..'.png', 0, 0, 0, ((isMouseInPosition(582.12 + (27.73 * (i - 1)), 600.55, 24.65, 21.57) or camera == v[5]) and tocolor(255, 255, 255, alpha) or tocolor(133, 133, 133, alpha)))
        
    end
    
    dxDrawImage(582.12, 630.75, 89.88, 20.34, 'assets/images/fundo_2.png', 0, 0, 0, isMouseInPosition(582.12, 630.75, 89.88, 20.34) and tocolor(109, 40, 217, 150) or tocolor(0, 0, 0, 70))
    dxDrawText('Cancelar', 582.12, 630.75, 89.88, 20.34, isMouseInPosition(582.12, 630.75, 89.88, 20.34) and tocolor(255, 255, 255, alpha) or tocolor(141, 141, 141, alpha), 1, getFont('medium', 14), 'center', 'center')
    dxDrawImage(697.37, 630.75, 86.28, 20.34, 'assets/images/fundo_2.png', 0, 0, 0, isMouseInPosition(697.37, 630.75, 86.28, 20.34) and tocolor(109, 40, 217, 150) or tocolor(0, 0, 0, 70))
    dxDrawText('Salvar', 697.37, 630.75, 86.28, 20.34, isMouseInPosition(697.37, 630.75, 86.28, 20.34) and tocolor(255, 255, 255, alpha) or tocolor(141, 141, 141, alpha), 1, getFont('medium', 14), 'center', 'center')
    dxDrawRectangle(722.02, 610.41, 61.63, 2.47, tocolor(28, 28, 28, alpha))
    dxDrawRectangle(722.02, 610.41, 61.63 * (rotationProgress / 360), 2.47, tocolor(109, 40, 217, alpha))
    dxDrawImage(722.02 + (61.63 * (rotationProgress / 360)), 608.56, 6.16, 6.16, 'assets/images/circle.png', 0, 0, 0, tocolor(255, 255, 255, alpha))
    
    
    if (moving) then 
        local start, finish = sx * 722.02, sx * (722.02 + 61.63)
        local cx, cy = getCursorPosition()
        local mx, my = (cx * screen[1]), (cy * screen[2])
        
        if (mx < start) then 
            
            rotationProgress = 0
            
        elseif (mx > finish) then 
            
            rotationProgress = 360
            setElementRotation(localPlayer, 0, 0, 360)
            
        else 
            
            local progress = mx - start
            local height = sx * 61.63
            local percentage  = (progress / height) * 360
            rotationProgress = percentage
            
        end
        
        setElementRotation(localPlayer, 0, 0, 100 * (rotationProgress / 100))
        
        if not (getKeyState('mouse1')) then 
            
            moving = nil 
            
        end 
        
    end
    
    dxDrawImage(861, 164.1, 493.33, 493.33, 'assets/images/fundo_inventario.png', 0, 0, 0, tocolor(255, 255, 255, alpha))
    drawScrollBar(929.17, 385.95, 2.39, 247.56, page * 20, 945, 20, 20, 20, 20, 20, 20, alpha)
    
    local x, y = 0, 0 
    for i, v in ipairs(windows) do 
        
        if (isMouseInPosition(905.25 + x, 247.81 + y, 47.84, 20) or window == v[5]) then 
            
            dxDrawImage(905.25 + x, 247.81 + y, 47.84, 20, 'assets/images/bg_category.png', 0, 0, 0, tocolor(109, 40, 217, alpha))
            dxDrawImage(v[1], v[2], v[3], v[4], 'assets/images/categorys/'..v[5]..'.png', 0, 0, 0, tocolor(255, 255, 255, alpha))
            
        else 
            dxDrawImage(905.25 + x, 247.81 + y, 47.84, 20, 'assets/images/bg_category.png', 0, 0, 0, tocolor(255, 255, 255, 20))
            dxDrawImage(v[1], v[2], v[3], v[4], 'assets/images/categorys/'..v[5]..'.png', 0, 0, 0, tocolor(133, 133, 133, alpha))
        end
        x = x + 67 
        if (x >= 398) then 
            
            x = 0 
            y = y + 32 
            
        end
        
    end
    
    dxDrawImage(remove[1][1], remove[1][2], remove[1][3], remove[1][4], 'assets/images/remove.png', 0, 0, 0, (isMouseInPosition(remove[1][1], remove[1][2], remove[1][3], remove[1][4]) and tocolor(240, 40, 40, alpha) or tocolor(255, 255, 255, alpha)))
    for i, v in ipairs(slots) do 
        dxDrawImage(v[1], v[2], v[3], v[4], 'assets/images/slots.png', 0, 0, 0, tocolor(255, 255, 255, v[5]))
    end
    
    local line = 0
    for i, v in pairs(itens[window]) do 
        if (i > page and line < #slots) then 
            
            line2 = (line + 1)
            dxDrawImage(slots[i][1]+3, slots[i][2]+3, slots[i][3]-3, slots[i][4]-3, 'assets/images/icons/'..v..'.png', 0, 0, 0, isMouseInPosition(slots[i][1], slots[i][2], slots[i][3], slots[i][4]) and tocolor(255, 255, 255, alpha) or tocolor(255, 255, 255, alpha * 0.5))
            if window == 'rasante' and getElementData(localPlayer, 'lined') then
                local colorLine = getElementData(localPlayer, 'lined')
                for _, bones in ipairs({24,34,53,43}) do
                    local sx, sy, sz = getPedBonePosition( localPlayer, bones )
                    if sx then
                        dxDrawMaterialLine3D(sx, sy, sz, sx, sy, sz+15, true, img2, 0.02, tocolor(colorLine[1], colorLine[2], colorLine[3], 30), false)
                    end
                end
            end
            
        end
    end
end

addEventHandler('onClientKey', root, function(key, press)
    if (isEventHandlerAdded('onClientRender', root, drawClothes) and press) then 
        if (key == 'mouse_wheel_down') then 
            if (page < 35) then 
                page = page + 5
            end
        elseif (key == 'mouse_wheel_up') then 
            if (page > 0) then 
                page = page - 5
            end
        end
    end
end)

addEventHandler('onClientClick', root, 
function(b, s)
    if (b == 'left' and s == 'down') then 
        if (isEventHandlerAdded('onClientRender', root, drawClothes)) then 
            if (isMouseInPosition(722.02, 610.41, 61.63, 2.47)) then 
                moving = true
            elseif (isMouseInPosition(582.12, 630.75, 89.88, 20.34)) then 
                removeClothes()
                if isElement(chute) then
                    destroyElement(chute)
                end
                setPedAnimation( localPlayer )
                setElementAlpha(localPlayer, 255)
            elseif (isMouseInPosition(697.37, 630.75, 86.28, 20.34)) then 
                removeClothes()
                setPedAnimation( localPlayer )
                if isElement(chute) then
                    destroyElement(chute)
                end
                setElementAlpha(localPlayer, 255)
            else 
                for i, v in ipairs(cameras) do 
                    if (isMouseInPosition(582.12 + (27.73 * (i - 1)), 600.55, 24.65, 21.57)) then 
                        camera = v[5]
                        setCameraMatrix(unpack(config.cameras[camera]))
                    end
                end
                
                local x, y = 0, 0 
                for i, v in ipairs(windows) do 
                    if (isMouseInPosition(905.25 + x, 247.81 + y, 47.84, 20)) then 
                        window = v[5]
                        page = 0
                        if window == 'paraquedas' then
                            setPedAnimation( localPlayer )
                            setElementAlpha(localPlayer, 0)
                            local posx,posy,posz = getElementPosition ( localPlayer )
                            chute = createObject(3131, posx,posy,posz )
                            setElementData(chute, 'objectID', 50018)
                            if getElementData(localPlayer, 'parachuteTexture') then
                                triggerEvent('setArmaStickerC', resourceRoot, localPlayer, 'arma', 'files/weapons/skins/'..getElementData(localPlayer, 'parachuteTexture')..".png", chute)
                            end
                            setObjectScale(chute, 0.6)
                            setElementDimension(chute, getElementDimension( localPlayer ))
                            attachElements( chute, localPlayer, 0, 0, -0.5, 60, 30, 110)
                            
                            setPedArmor(localPlayer, 0)
                        elseif window == 'rasante' then
                            window = 'rasante'
                            setPedAnimation( localPlayer, "PARACHUTE", "FALL_skyDive", -1, true, true, false )
                            if isElement(chute) then
                                destroyElement(chute)
                            end
                            setPedArmor(localPlayer, 0)
                        elseif window == 'colete' then
                            setPedArmor(localPlayer, 100)
                            if isElement(chute) then
                                destroyElement(chute)
                            end
                            setPedAnimation(localPlayer)
                            setElementAlpha(localPlayer, 255)
                        else
                            if isElement(chute) then
                                destroyElement(chute)
                            end
                            setPedAnimation(localPlayer)
                            setElementAlpha(localPlayer, 255)
                            setPedArmor(localPlayer, 0)
                        end
                        
                        
                        return 
                    end
                    x = x + 67 
                    if (x >= 398) then 
                        x = 0 
                        y = y + 32 
                    end
                end
                
                local line = 0
                for i, v in ipairs(itens[window]) do 
                    if (i > page and line < #slots) then 
                        line = (line + 1)
                        if (isMouseInPosition(slots[i][1], slots[i][2], slots[i][3], slots[i][4])) then
                            triggerServerEvent('NZ > EquipSkin', resourceRoot, localPlayer, v, window)
                            if window == 'paraquedas' then
                                if getElementData(localPlayer, 'parachuteTexture') then
                                    triggerEvent('setArmaStickerC', resourceRoot, localPlayer, 'arma', 'files/weapons/skins/'..getElementData(localPlayer, 'parachuteTexture')..".png", chute)
                                end
                            elseif window == 'colete' then
                                setPedArmor(localPlayer, 0)
                                setTimer(function() 
                                    setPedArmor(localPlayer, 255)
                                end, 1200, 1)
                            end
                            
                        elseif (isMouseInPosition(remove[1][1], remove[1][2], remove[1][3], remove[1][4])) then
                            triggerServerEvent('NZ > RemoveSkin', resourceRoot, localPlayer, window)
                            if window == 'paraquedas' then
                                if chute then
                                    triggerEvent('setArmaStickerC', resourceRoot, localPlayer, 'arma', 'files/weapons/skins/'..(getElementData(localPlayer, 'parachuteTexture') or 'parachute0')..".png", chute)
                                end
                            elseif window == 'colete' then
                                setPedArmor(localPlayer, 0)
                                setTimer(function() 
                                    setPedArmor(localPlayer, 255)
                                end, 1200, 1)
                            end
                        end
                    end
                end
            end
        end
    end
end)

addEvent('NZ > openEquipaments', true)
addEventHandler('NZ > openEquipaments', root, function(clothes_, type)
    if type == 'update' then
        clothes = clothes_
        itens = {}
        for i, v in ipairs(config.categorys) do 
            if not (itens[v]) then 
                itens[v] = {}
            end 
        end
        for i, v in ipairs(clothes) do 
            table.insert(itens[config.itensX[v][1]], v)
        end
        return
    end
    if not (isEventHandlerAdded('onClientRender', root, drawClothes)) then 
        tick, clothes, camera, rotationProgress, page = getTickCount(), clothes_, 'corpo', config.spawnPlayer[4], 0
        addEventHandler('onClientRender', root, drawClothes)
        showCursor(true)
        setCameraMatrix(unpack(config.cameras[camera]))
        setElementPosition(localPlayer, config.spawnPlayer[1], config.spawnPlayer[2], config.spawnPlayer[3])
        setElementRotation(localPlayer, 0, 0, config.spawnPlayer[4])
        
        window = 'rasante'
        
        setPedAnimation( localPlayer, "PARACHUTE", "FALL_skyDive", -1, true, true, false )
        
        
        itens = {}
        for i, v in ipairs(config.categorys) do 
            if not (itens[v]) then 
                itens[v] = {}
            end 
        end
        for i, v in ipairs(clothes) do 
            table.insert(itens[config.itensX[v][1]], v)
        end
    end
end)

function removeClothes()
    
    if (isEventHandlerAdded('onClientRender', root, drawClothes)) then 
        
        removeEventHandler('onClientRender', root, drawClothes)
        showCursor(false)
        
        triggerEvent("returnToLobbyCancelMatch", localPlayer, localPlayer)
        
    end
    
end
addEvent('NZ > closeEquipaments', true)
addEventHandler('NZ > closeEquipaments', localPlayer, removeClothes)

------------------------------------------------
function isMouseInPosition(x, y, w, h)
    if isCursorShowing() then
        local x, y, w, h = aToR (x, y, w, h)
        local sx,sy = guiGetScreenSize()
        local cx,cy = getCursorPosition()
        local cx,cy = (cx*sx),(cy*sy)
        if (cx >= (x) and cx <= x+w) and (cy >= y and cy <= y+h) then
            return true
        end
    end
end

function isEventHandlerAdded( sEventName, pElementAttachedTo, func )
    if type( sEventName ) == 'string' and isElement( pElementAttachedTo ) and type( func ) == 'function' then
        local aAttachedFunctions = getEventHandlers( sEventName, pElementAttachedTo )
        if type( aAttachedFunctions ) == 'table' and #aAttachedFunctions > 0 then
            for i, v in ipairs( aAttachedFunctions ) do
                if v == func then
                    return true
                end
            end
        end
    end
    return false
end

function aToR (X, Y, sX, sY)
    local xd = X/resW or X
    local yd = Y/resH or Y
    local xsd = sX/resW or sX
    local ysd = sY/resH or sY
    return xd * screen[1], yd * screen[2], xsd * screen[1], ysd * screen[2]
end

_dxDrawRectangle = dxDrawRectangle
function dxDrawRectangle (x, y, w, h, color, postGUI, subPixelPositioning, realPosition)
    
    if (realPosition) then 
        return _dxDrawRectangle (x, y, w, h, color, postGUI, subPixelPositioning)
    else 
        local x, y, w, h = aToR (x, y, w, h)
        return _dxDrawRectangle (x, y, w, h, color, postGUI, subPixelPositioning)
    end 
end

_dxDrawText = dxDrawText
function dxDrawText (text, x, y, w, h, ...)
    local x, y, w, h = aToR (x, y, w, h)
    return _dxDrawText (text, x, y, (w + x), (h + y), ...)
end

_dxDrawImage = dxDrawImage
function dxDrawImage (x, y, w, h, ...)
    if (x == 0 and y == 0 and w == screen[1] or h == screen[2]) then 
        return _dxDrawImage (x, y, w, h, ...)
    else
        local x, y, w, h = aToR (x, y, w, h)
        return _dxDrawImage (x, y, w, h, ...)
    end
end

size = {}
function drawBorder ( radius, x, y, width, height, color, colorStroke, sizeStroke, postGUI )
    colorStroke = tostring(colorStroke)
    sizeStroke = tostring(sizeStroke)
    if (not size[height..':'..width]) then
        local raw = string.format([[
            <svg width='%s' height='%s' fill='none' xmlns='http://www.w3.org/2000/svg'>
                <mask id='path_inside' fill='#FFFFFF' >
                    <rect width='%s' height='%s' rx='%s' />
                </mask>
                <rect opacity='1' width='%s' height='%s' rx='%s' fill='#FFFFFF' stroke='%s' stroke-width='%s' mask='url(#path_inside)'/>
            </svg>
        ]], width, height, width, height, radius, width, height, radius, colorStroke, sizeStroke)
        size[height..':'..width] = svgCreate(width, height, raw)
    end
    if (size[height..':'..width]) then
        dxDrawImage(x, y, width, height, size[height..':'..width], 0, 0, 0, color, postGUI)
    end
end

function isEventHandlerAdded( sEventName, pElementAttachedTo, func )
    if type( sEventName ) == 'string' and isElement( pElementAttachedTo ) and type( func ) == 'function' then
        local aAttachedFunctions = getEventHandlers( sEventName, pElementAttachedTo )
        if type( aAttachedFunctions ) == 'table' and #aAttachedFunctions > 0 then
            for i, v in ipairs( aAttachedFunctions ) do
                if v == func then
                    return true
                end
            end
        end
    end
    return false
end 

function formatNumber(number, sep)
    assert(type(tonumber(number))=='number', 'Bad argument @\'formatNumber\' [Expected number at argument 1 got '..type(number)..']')
    assert(not sep or type(sep)=='string', 'Bad argument @\'formatNumber\' [Expected string at argument 2 got '..type(sep)..']')
    local money = number
    for i = 1, tostring(money):len()/3 do
        money = string.gsub(money, '^(-?%d+)(%d%d%d)', '%1'..sep..'%2')
    end
    return money
end