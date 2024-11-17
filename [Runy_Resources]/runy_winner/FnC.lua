local screenWidth, screenHeight = guiGetScreenSize()
local resW, resH = 1366, 768
local nx, ny = (screenWidth/resW), (screenHeight/resH)

function Texto(text, x1, y1, w1, h1, ...)
    return dxDrawText(text, nx *x1, ny *y1, nx *w1, ny *h1, ...)
end

function Image(x1, y1, w1, h1, ...)
    return dxDrawImage(nx* x1, ny* y1, nx* w1, ny* h1, ...)
end

local imageShown = false
local image
local dimensionTimers = {}
local playerCounts = {}
enterDimension = false

function showImage()
    if not imageShown then
        image = dxCreateTexture("assets/winner.png")
        if image then
            addEventHandler("onClientRender", root, drawImage)
            imageShown = true
        else
            outputChatBox("Falha ao carregar a imagem.")
        end
    end
end

addEventHandler("onClientClick", getRootElement(), function(b, s)
    if isEventHandlerAdded("onClientRender", getRootElement(), drawImage) then 
        if b == "left" and s == "down" then
            if isCursorOnElement( 602, 702, 133, 37 ) then
                returnToLobby2()
            end
        end
    end
end)

function drawImage()
    if image then
        Image(602, 702, 133, 37, 'assets/return.png', 0, 0, 0, (isCursorOnElement(602, 702, 133, 37) and tocolor(255, 255, 255, 255) or tocolor(199, 199, 199, 199)))
        
        local width, height = dxGetMaterialSize(image)
        dxDrawImage((screenWidth - width) / 2, ((screenHeight - height) / 2)-100, width, height, image)
        setCameraMatrix(1528.9167480469, -1353.2498779297, 330.22229003906, 1529.9155273438, -1353.2490234375, 330.17407226562, 0, 70)

        local duo = getElementData(localPlayer, 'myDuo')
        if duo and duo_ped then
            local x, y, z = getElementPosition(duo_ped)
            local cx, cy, cz = getCameraMatrix()
            if getDistanceBetweenPoints3D(cx, cy, cz, x, y, z) < 25 then
                local sx, sy = getScreenFromWorldPosition(x, y, z+1.15)
                if sx and sy then
                    dxDrawImage(sx-80, sy+195, 165, 62, 'assets/bg.png')
                    dxDrawImage(sx-73, sy+200, 50, 50, exports['runy_lobby4']:exportPicture(duo), 0, 0, 0, tocolor(255, 255, 255, alpha))
                    dxDrawText(getPlayerName(duo).. " #6D28D9#".. getElementData(localPlayer, "ID"), sx+10, sy+435, sx, sy, tocolor(255, 255, 255, 255), 1, 'default-bold', "center", "center", false, false, false, true)
                    
                    dxDrawText((getElementData(duo, 'killPartida') or 0), sx+12, sy+468, sx, sy, tocolor(255, 255, 255, 255), 0.8, 'default-bold', "center", "center", false, false, false, true)
                    dxDrawText('1º', sx+82, sy+468, sx, sy, tocolor(255, 255, 255, 255), 0.8, 'default-bold', "center", "center", false, false, false, true)
                    dxDrawText('0', sx+139, sy+468, sx, sy, tocolor(255, 255, 255, 255), 0.8, 'default-bold', "center", "center", false, false, false, true)
                end
            end
        end
        local x, y, z = getElementPosition(localPlayer)
        local cx, cy, cz = getCameraMatrix()
        if getDistanceBetweenPoints3D(cx, cy, cz, x, y, z) < 25 then
            local sx, sy = getScreenFromWorldPosition(x, y, z+1.15)
            if sx and sy then
                dxDrawImage(sx-80, sy+195, 165, 62, 'assets/bg.png')
                dxDrawImage(sx-73, sy+200, 50, 50, exports['runy_lobby4']:exportPicture(localPlayer), 0, 0, 0, tocolor(255, 255, 255, alpha))
                dxDrawText(getPlayerName(localPlayer).. " #6D28D9#".. getElementData(localPlayer, "ID"), sx+10, sy+435, sx, sy, tocolor(255, 255, 255, 255), 1, 'default-bold', "center", "center", false, false, false, true)
                dxDrawText((getElementData(localPlayer, 'killPartida') or 0), sx+12, sy+468, sx, sy, tocolor(255, 255, 255, 255), 0.8, 'default-bold', "center", "center", false, false, false, true)
                dxDrawText('1º', sx+82, sy+468, sx, sy, tocolor(255, 255, 255, 255), 0.8, 'default-bold', "center", "center", false, false, false, true)
                dxDrawText('0', sx+139, sy+468, sx, sy, tocolor(255, 255, 255, 255), 0.8, 'default-bold', "center", "center", false, false, false, true)
            end
        end
    end
end

addEvent("showImageOnScreen", true)
addEventHandler("showImageOnScreen", resourceRoot, function()
    showImage()
end)

function teleportPlayerToCustomLocation()
    triggerServerEvent("checkPlayerPermissions", resourceRoot, getElementDimension(localPlayer))
    setElementData(localPlayer, "runyInPareamento", false)
    showChat(false)
    showCursor( true )
    showImage()
    triggerEvent("hideActionBar", localPlayer)
    triggerEvent("hideGroupDesign", localPlayer)
    triggerEvent("hideFundos", localPlayer)
    triggerEvent("hideHud", localPlayer)
    triggerEvent("hideHudArma", localPlayer)
    triggerEvent("hideKillsMostrar", localPlayer)
    triggerEvent("hideVivos", localPlayer)
    triggerEvent("hideShowRadar", localPlayer)
    setElementPosition(localPlayer, 1537, -1351.8, 329.462)
    setElementRotation(localPlayer, 0, 0, -90)
    setElementHealth(localPlayer, 100)
    setElementFrozen(localPlayer, true)
    setPedAnimation(localPlayer, "DANCING", "DAN_Loop_A", -1, true, false, false)
    enterDimension = false
    setElementRotation(localPlayer, 0, 0, -90)
    
    toggleControl("jump", false)
    toggleControl("forwards", false)
    toggleControl("backwards", false)
    toggleControl("left", false)
    toggleControl("right", false)
    
   -- triggerServerEvent("NegoZ:ElementWin", localPlayer, localPlayer)
    
  --  triggerServerEvent("addPoints", localPlayer, localPlayer, 16+(getElementData(localPlayer, 'killPartida') or 0))
    local playerID = getElementData(localPlayer, "ID") or 0
    setElementDimension(localPlayer, playerID)
    local duo = getElementData(localPlayer, 'myDuo')
    if duo then
        if isElement( duo_ped ) then
            destroyElement(duo_ped)
            duo_ped = nil
        end
        duo_ped = createPed(getElementModel(duo), 1537, -1354.5, 329.464)
        setElementRotation( duo_ped, 0, 0, -90)
        setElementDimension(duo_ped, getElementDimension(localPlayer))
        setPedAnimation(duo_ped, "DANCING", "DAN_Loop_A", -1, true, false, false)
        
        local clothes = exports['runy_lobby4']:clothesClient(duo)
        exports["customcharacter"]:setPlayerClothe(duo_ped, getElementModel(duo), clothes)
        
    end

end

function returnToLobby2()
    toggleControl("jump", true)
    toggleControl("forwards", true)
    toggleControl("backwards", true)
    toggleControl("left", true)
    toggleControl("right", true)
    if isElement( duo_ped ) then
        destroyElement(duo_ped)
        duo_ped = nil
    end
    showCursor( false )
    
    setElementFrozen(localPlayer, false)
    hideImage()
    triggerEvent("returnToLobbyClientEvent", localPlayer, localPlayer)
end

function hideImage()
    if imageShown then
        removeEventHandler("onClientRender", root, drawImage)
        if image then
            destroyElement(image)
            image = nil
        end
        imageShown = false
    end
end

addEvent("onPlayerEnterDimension", true)
addEventHandler("onPlayerEnterDimension", resourceRoot, function(dim)
    if dimensionTimers[dim] then
        return
    end
    if getElementData(localPlayer, "battleRoyaleRunning") then
        local playerDimension = getElementDimension(localPlayer)
        local playerCount = getPlayerInDimension(playerDimension)
        dimensionTimers[dim] = setTimer(function()
            enterDimension = true
            if playerCount == 1 then
                teleportPlayerToCustomLocation()
            end
            killTimer(dimensionTimers[dim])
            dimensionTimers[dim] = nil
        end, 5000, 0)
    end
end)

function checkWinner()
    if getElementData(localPlayer, "battleRoyaleRunning") and enterDimension then
        local playerDimension = getElementDimension(localPlayer)
        if playerDimension == 0 then
            return --print('DIM ZERO')
        end
        local playerCount, remanescent = getPlayerInDimension(playerDimension)
        
        --print('PLAYERS EM DIMENSÃO '..playerCount)
        if playerCount == 1 or (playerCount == 2 and getElementData(localPlayer, 'myDuo') == remanescent) then
            teleportPlayerToCustomLocation()
            triggerServerEvent('onPlayerWin', localPlayer, (getElementData(localPlayer, 'myDuo') and getElementData(localPlayer, 'myDuo') or localPlayer))
        end
    else
        
    end
end
setTimer(checkWinner, 2000, 0) 

addEvent('onClientShowWin', true)
addEventHandler('onClientShowWin', root, 

function()
    
    teleportPlayerToCustomLocation()
    
end

)

function getPlayerInDimension(dim)
    count = 0
    local remanescent = localPlayer
    for _, player in ipairs(getElementsByType("player")) do
        if getElementDimension(player) == dim then
            if not getElementData(player, "spectatingPlayer") then
                count = count + 1
                
                if (localPlayer ~= player) then 
                    
                    remanescent = player
                    
                end
                
            end
        end
    end
    return count, remanescent
end

addEventHandler("onClientResourceStart", resourceRoot, function()
end)

countSpec = {}

function spectateFromPlayer(player)
    countSpec[player] = 0
    for i,v in pairs(getElementsByType('player')) do
        if v ~= player then
            if getElementData(v, "spectatingPlayer") == player then
                countSpec[player] = i
            end
        end
    end
    return countSpec[player]
end

function isCursorOnElement(x, y, w, h)
    if (not isCursorShowing()) then
        return false
    end
    local mx, my = getCursorPosition()
    local fullx, fully = guiGetScreenSize()
    cursorx, cursory = mx*fullx, my*fully
    if cursorx > nx*x and cursorx < nx*x + nx*w and cursory > ny*y and cursory < ny*y + ny*h then
        return true
    else
        return false
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
