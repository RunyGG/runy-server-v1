local spectatingPlayer = nil
local sW, sH = guiGetScreenSize()
local resW, resH = 1366,768

screenW, screenH = guiGetScreenSize()

local screenW, screenH = guiGetScreenSize();
sW2, sH2 = (screenW/1366), (screenH/768)

transition = {
    alpha = {0, 255},
    tickCount = getTickCount()
}

local interpolateBetween, getRealTime, getCursorPosition, getTickCount, tocolor, formatNumber, unpack, round, fadeButton, getSystemLanguage, min, max = interpolateBetween, getRealTime, getCursorPosition, getTickCount, tocolor, formatNumber, unpack, math.round, fadeButton, getSystemLanguage, math.min, math.max;

local minPlayers = 1

function startSpectating(player)
    if isElement(player) then
        
        spectatingPlayer = player
        
        transition = {
            alpha = {0, 255},
            tickCount = getTickCount()
        }
        
        setElementData(localPlayer, "spectatingPlayer", player)
        
        if (isEventHandlerAdded('onClientRender', root, renderSpectate)) then 
            removeEventHandler("onClientRender", root, renderSpectate)
        end
        
        addEventHandler("onClientRender", root, renderSpectate)
        
        triggerEvent("hideActionBar", resourceRoot)
        triggerEvent("hideGroupDesign", resourceRoot)
        triggerEvent("hideFundos", resourceRoot)
        triggerEvent("hideHud", resourceRoot)
        triggerEvent("hideHudArma", resourceRoot)
        triggerEvent("hideKillsMostrar", resourceRoot)
        triggerEvent("hideVivos", resourceRoot)
    else
        
        print('sem player')
    end
end

function stopSpectating()
    removeEventHandler("onClientRender", root, renderSpectate)
    spectatingPlayer = nil
    triggerServerEvent("onPlayerSpectateStop", resourceRoot, localPlayer)
end

function stopSpectating2()
    removeEventHandler("onClientRender", root, renderSpectate)
    spectatingPlayer = nil
    showCursor(false)
end

local font = dxCreateFont('assets/fonts/font.ttf', 10)
local font2 = dxCreateFont('assets/fonts/font.ttf', 9)
local font3 = dxCreateFont('assets/fonts/font.ttf', 12)
local font4 = dxCreateFont('assets/fonts/font.ttf', 16)

function Image(x1, y1, w1, h1, ...)
    return dxDrawImage(sW2 * x1, sH2 * y1, sW2 * w1, sH2 * h1, ...)
end

function Texto(text, x1, y1, w1, h1, ...)
    return dxDrawText(text, sW2 * x1, sH2 * y1, sW2 * w1, sH2 * h1, ...)
end

local slotAction = {
    {1035, 685, 50.5, 50},
    {1094, 685, 50.5, 50},
    {1152, 685, 50.5, 50},
    {1211, 685, 50.5, 50},
    {1270, 685, 50.5, 50},
}

function renderSpectate()
    if isElement(spectatingPlayer) then
        if getElementData(spectatingPlayer, 'modo') == 'Lobby' then
            stopSpectating()
            setCameraTarget(localPlayer)
            triggerServerEvent("onPlayerSpectateStop", localPlayer, localPlayer)
            return
        end
        local x, y, z = getElementPosition(spectatingPlayer)
        local rx, ry, rz = getElementRotation(spectatingPlayer)
        setCameraMatrix(x, y, z + 2, x, y, z)
        setCameraTarget(spectatingPlayer)

        resource.buttons = {};
        local alpha = interpolateBetween(transition['alpha'][1], 0, 0, transition['alpha'][2], 0, 0, ((getTickCount() - transition.tickCount) / 400), "Linear");
        
        -- Button Return Lobby
        dxDrawImage(849, 703, 133, 37, "assets/images/return_to-lobby.png", 0,0,0, (isMouseInPosition(849, 703, 133, 37) and tocolor(255, 255, 255, 255) or tocolor(255, 255, 255, 100)))
        
        dxDrawImage(501, 590, 339, 159, 'assets/images/bg.png', 0, 0, 0, tocolor(255, 255, 255, alpha))
        dxDrawImage(516, 604, 60, 60, exports['runy_lobby4']:exportPicture(localPlayer), 0, 0, 0, tocolor(255, 255, 255, alpha))
        
        dxDrawImage(610, 633, (getElementHealth(spectatingPlayer)/100) * (214.2), 9, 'assets/images/bar.png', 0, 0, 0, tocolor(255, 255, 255, alpha))
        dxDrawImage(610, 650, (getPedArmor(spectatingPlayer)/100) * (214.2), 9, 'assets/images/bar.png', 0, 0, 0, tocolor(109, 40, 217, alpha))
        
        dxDrawText((getElementData(spectatingPlayer, 'killPartida') or 0), 811, 602, 17, 20, tocolor(255, 255, 255, 255), sW2*(1), font4)
        dxDrawText(getPlayerName(spectatingPlayer)..' #6D28D9('..(getElementData(spectatingPlayer, 'ID') or '???')..')', 588, 604, 211, 19, tocolor(255, 255, 255, 255), sW2*(1), font3, 'left', 'top', false, false, false, true)
        
        local action = (slotAction or {})
        if (action) then 
            for i = 1, 5 do 
                if (action[i] and action[i].item) then
                    dxDrawImage((519 + 6) + (63 * (i - 1)), 630 + 55, 35, 35, ':runy_inventario/files/imgs/itens/'..action[i].item..'.png', 0, 0, 0, tocolor(255, 255, 255, alpha))
                end
            end
        end
    else
        stopSpectating()
    end
end

function CountSpectatePlayers(player)
    local counting = 0
    for i, players in pairs(getElementsByType('player')) do
        if getElementData(players, 'spectatingPlayer') == player then
            counting = counting + 1
        end
    end
    return counting
end

function checkPlayersCount()
    if not isElement(spectatingPlayer) then
        return
    end
    local dimension = getElementDimension(spectatingPlayer)
    local players = getElementsByType("player")
    local playersInDimension = 0
    
    for _, player in ipairs(players) do
        if getElementDimension(player) == dimension then
            if getElementData(player, "battleRoyaleRunning") then
                playersInDimension = playersInDimension + 1
            end
        end
    end
    
    if playersInDimension <= minPlayers then
        if getElementData(localPlayer, "spectatingPlayer") then
            stopSpectatingAndReturn()
        end
    end
end

addEventHandler("onClientElementDimensionChange", root, function()
    if source == localPlayer then
        checkPlayersCount()
    end
end)
--setTimer(checkPlayersCount, 5000, 0)

addEventHandler("onClientClick", getRootElement(), function(button, state)
    if (isEventHandlerAdded('onClientRender', root, renderSpectate)) then
        if button=="left" and state=="down" then
            if isMouseInPosition(849, 703, 133, 37) then
                stopSpectatingAndReturn()
            end
        end
    end
end)

function stopSpectatingAndReturn()
    stopSpectating()
    setCameraTarget(localPlayer)
    triggerServerEvent("onPlayerSpectateStop", localPlayer, localPlayer, localPlayer)
    exports['runy_morte']:onPlayerDeath(localPlayer)
end
addEvent("fn:sairTelagem > lobby", true)
addEventHandler("fn:sairTelagem > lobby", localPlayer, stopSpectatingAndReturn)

function onPlayerWasted2()
    stopSpectating2()
    triggerEvent("showActionBar", resourceRoot)
    triggerEvent("showGroupDesign", resourceRoot)
    triggerEvent("showFundos", resourceRoot)
    triggerEvent("showHud", resourceRoot)
    triggerEvent("showHudArma", resourceRoot)
    triggerEvent("showKillsMostrar", resourceRoot)
    triggerEvent("showVivos", resourceRoot)
    triggerEvent("showShowRadar", resourceRoot)
    triggerEvent("showBussola", resourceRoot, localPlayer)
end
addEvent("onPlayerWasted2", true)
addEventHandler("onPlayerWasted2", root, onPlayerWasted2)

addEvent("onPlayerSpectate", true)
addEventHandler("onPlayerSpectate", resourceRoot, startSpectating)
--[[ addEventHandler("onClientPlayerWasted", localPlayer, onPlayerWasted) ]]

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

addEventHandler("onPlayerVehicleEnter", root, function(theVehicle, seat, jacked)
    if seat == 0 then
        setVehicleEngineState(theVehicle, false)
    end
end)

function isMouseInPosition(x,y,w,h)
    if isCursorShowing() then
        local sx,sy = guiGetScreenSize()
        local cx,cy = getCursorPosition()
        local cx,cy = (cx*sx),(cy*sy)
        if (cx >= x and cx <= x+w) and (cy >= y and cy <= y+h) then
            return true
        end
    end
end