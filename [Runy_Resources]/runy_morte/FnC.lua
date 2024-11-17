local screenWidth, screenHeight = guiGetScreenSize()
local resW, resH = 1366, 768
local nx, ny = (screenWidth/resW), (screenHeight/resH)
local isPlayerDead = false
local image2


function Texto(text, x1, y1, w1, h1, ...)
    return dxDrawText(text, nx *x1, ny *y1, nx *w1, ny *h1, ...)
end

function Image(x1, y1, w1, h1, ...)
    return dxDrawImage(nx* x1, ny* y1, nx* w1, ny* h1, ...)
end

function showImage2()
    if not imageShown2 then
        image2 = dxCreateTexture("assets/dead.png")
        addEventHandler("onClientRender", root, drawImage2)
        triggerEvent("hideShowRadar", localPlayer)
        showCursor(true)
        imageShown2 = true
    end
end

addEventHandler("onClientClick", getRootElement(), function(b, s)
    if isEventHandlerAdded("onClientRender", getRootElement(), drawImage2) then 
        if b == "left" and s == "down" then
            if isCursorOnElement( 602, 702, 133, 37 ) then
                returnToLobby2()
            end
        end
    end
end)

function drawImage2()
    if imageShown2 then
        Image(602, 702, 133, 37, 'assets/return.png', 0, 0, 0, (isCursorOnElement(602, 702, 133, 37) and tocolor(255, 255, 255, 255) or tocolor(199, 199, 199, 199)))
        local width, height = dxGetMaterialSize(image2)
        dxDrawImage((screenWidth - width) / 2, ((screenHeight - height) / 2)-100, width, height, image2)
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
                    dxDrawText((playersInDimension+1)..'º', sx+82, sy+468, sx, sy, tocolor(255, 255, 255, 255), 0.8, 'default-bold', "center", "center", false, false, false, true)
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
                dxDrawText((playersInDimension+1)..'º', sx+82, sy+468, sx, sy, tocolor(255, 255, 255, 255), 0.8, 'default-bold', "center", "center", false, false, false, true)
                dxDrawText('0', sx+139, sy+468, sx, sy, tocolor(255, 255, 255, 255), 0.8, 'default-bold', "center", "center", false, false, false, true)
            end
        end
    end
end

addEvent("showImageOnScreen2", true)
addEventHandler("showImageOnScreen2", resourceRoot, function()
    showImage2()
end)

function onPlayerDeath()
    if not isPlayerDead then
        isPlayerDead = true
        setElementData(localPlayer, 'deadPlayer', true)
        setElementData(localPlayer, "battleRoyaleRunning", nil)
        setElementData(localPlayer, "runyInPareamento", nil)
        local receiver = getElementData(localPlayer, 'myDuo')
        if (isElement(receiver)) then 
            if (getElementData(receiver, 'deadPlayer')) then 
                triggerServerEvent('onPlayerDerrota', root, receiver)
            end 
        end 

        local playerDimension = getElementDimension(localPlayer)
        playersInDimension = getPlayerInDimension(playerDimension)
      --  if playersInDimension <= 5 then
     --       triggerServerEvent("addPoints", localPlayer, localPlayer, 6+(getElementData(localPlayer, 'killPartida') or 0))
    --    elseif playersInDimension > 5 and playersInDimension <= 7 then
    --        triggerServerEvent("addPoints", localPlayer, localPlayer, 2+(getElementData(localPlayer, 'killPartida') or 0))
    --    elseif playersInDimension > 7 and playersInDimension <= 12 then
    --        triggerServerEvent("removePoints", localPlayer, localPlayer, playersInDimension)
  --      else
    --        triggerServerEvent("removePoints", localPlayer, localPlayer, 10+playersInDimension)
   --     end
        
        toggleControl("jump", false)
        toggleControl("forwards", false)
        toggleControl("backwards", false)
        toggleControl("left", false)
        toggleControl("right", false)
        showImage2()
        setElementPosition(localPlayer, 1537, -1351.8, 329.462)
        setElementRotation(localPlayer, 0, 0, 90)
        setElementDimension(localPlayer, getElementData(localPlayer, 'ID'))
        setPedAnimation(localPlayer, "CAMERA", "camcrch_cmon", -1, true, false, false)
        local duo = getElementData(localPlayer, 'myDuo')
        if duo then
            if getElementType(duo) == 'player' then
                if isElement( duo_ped ) then
                    destroyElement(duo_ped)
                    duo_ped = nil
                end
                duo_ped = createPed(getElementModel(duo), 1537, -1354.5, 329.464)
                setElementRotation( duo_ped, 0, 0, 90)
                setElementDimension(duo_ped, getElementData(localPlayer, 'ID'))
                setPedAnimation(localPlayer, "CAMERA", "camcrch_cmon", -1, true, false, false)
              --  local clothes = exports['runy_lobby4']:clothesClient(duo)
             --   exports["customcharacter"]:setPlayerClothe(duo_ped, getElementModel(duo), clothes)
            end
        end
        setTimer(function() 
            local playerID = tonumber(getElementData(localPlayer, "ID")) or 0
            if playerID then 
                setElementDimension(localPlayer, playerID)
            end
            
            local duo = getElementData(localPlayer, 'myDuo')
            if duo then
                if getElementType(duo) == 'player' then
                    if isElement( duo_ped ) then
                        destroyElement(duo_ped)
                        duo_ped = nil
                    end
                    duo_ped = createPed(getElementModel(duo), 1537, -1354.5, 329.464)
                    setElementRotation( duo_ped, 0, 0, 90)
                    setElementDimension(duo_ped, getElementDimension(localPlayer))
                    setPedAnimation(localPlayer, "CAMERA", "camcrch_cmon", -1, true, false, false)
                 --   local clothes = exports['runy_lobby4']:clothesClient(duo)
                  --  exports["customcharacter"]:setPlayerClothe(duo_ped, getElementModel(duo), clothes)
                end
            end
            
        end, 100, 1)
    end
end
addEvent("runyMorteEvent", true)
addEventHandler("runyMorteEvent", root, onPlayerDeath)

addEvent('onClientShowDerrota', true)
addEventHandler('onClientShowDerrota', root, onPlayerDeath)

function returnToLobby2()
    toggleControl("jump", true)
    toggleControl("forwards", true)
    toggleControl("backwards", true)
    toggleControl("left", true)
    toggleControl("right", true)
    isPlayerDead = false
    if isElement( duo_ped ) then
        destroyElement(duo_ped)
        duo_ped = nil
    end
    setElementFrozen(localPlayer, false)
    hideImage2()
    triggerEvent("returnToLobbyClientEvent", localPlayer, localPlayer)
end

function hideImage2()
    if imageShown2 then
        removeEventHandler("onClientRender", root, drawImage2)
        if image2 then
            destroyElement(image2)
            image2 = nil
        end
        imageShown2 = false
        showCursor(false)
    end
end
addEvent("hideImage2Dead", true)
addEventHandler("hideImage2Dead", getRootElement(), onPlayerDeath)

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