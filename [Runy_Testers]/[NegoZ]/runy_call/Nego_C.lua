local screenW, screenH = guiGetScreenSize()
local resW, resH = 1366, 768
local sW, sH = (screenW/resW), (screenH/resH)

function showAux()
    if localPlayer:getData('battleRoyaleRunning') or localPlayer:getData('runyInPareamento') or localPlayer:getData('modo') == 'Lobby' then
        local mic = localPlayer:getData('mic')
        local fone = localPlayer:getData('sound')
        Image(15, 250, 30, 28, "files/"..(mic and 'mic' or 'micmute')..".png", 0, 0, 0, ((isMouseInPosition(15, 250, 30, 28) or mic) and tocolor(255, 255, 255, 255) or tocolor(255, 255, 255, 100)))
        Image(50, 250, 30, 28, "files/"..(fone and 'sound' or 'soundmute')..".png", 0, 0, 0, ((isMouseInPosition(50, 250, 30, 28) or fone) and tocolor(255, 255, 255, 255) or tocolor(255, 255, 255, 100)))
    end
end
addEventHandler("onClientRender", root, showAux)

addEventHandler("onClientClick", getRootElement(), function(button, state, clickX, clickY)
    if (isEventHandlerAdded('onClientRender', root, showAux)) then
        if localPlayer:getData('battleRoyaleRunning') or localPlayer:getData('runyInPareamento') or localPlayer:getData('modo') == 'Lobby' then
            if button == "left" and state == "down" then
                if isMouseInPosition(15, 250, 30, 28) then -- mic
                    triggerServerEvent( 'mic', resourceRoot, localPlayer, localPlayer:getData('mic'))
                elseif isMouseInPosition(50, 250, 30, 28) then -- fone
                    triggerServerEvent( 'sound', resourceRoot, localPlayer, localPlayer:getData('sound'))
                end
            end
        end
    end
end)

setTimer(function( )
    local duo = localPlayer:getData("myDuo")
    for i, v in ipairs( getElementsByType( 'player' ) ) do 
        if isElement( v ) then
            if duo == v then
                if localPlayer:getData('sound') then
                    setSoundVolume(v, 13)
                    setSoundVolume(localPlayer, 13)
                else
                    if not localPlayer:getData('mic') then
                        setSoundVolume(localPlayer, 0)
                    end
                    setSoundVolume(v, 0)
                end
            else
                setSoundVolume(v, 0)
                setSoundVolume(localPlayer, 0)
            end
        end
    end
end, 0, 0)

function Image(x1, y1, w1, h1, ...)
    return dxDrawImage(sW * x1, sH * y1, sW * w1, sH * h1, ...)
end

function isMouseInPosition(x,y,w,h)
    if isCursorShowing() then
        local sx,sy = guiGetScreenSize()
        local cx,cy = getCursorPosition()
        local cx,cy = (cx*sx),(cy*sy)
        if (cx >= (sW * x) and cx <= (sW * x) + (sW * w)) and (cy >= (sH * y) and cy <= (sH * y) + (sH * h)) then
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