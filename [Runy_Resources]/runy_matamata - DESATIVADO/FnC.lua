-- CLIENT

screenW, screenH = guiGetScreenSize()
sW, sH = (screenW/1366), (screenH/768)

local showBase = false
local dimensionTimer = 0
local playerKills = 0

function Texto(text, x1, y1, w1, h1, ...)
    return dxDrawText(text, sW * x1, sH * y1, sW * w1, sH * h1, ...)
end

function Image(x1, y1, w1, h1, ...)
    return dxDrawImage(sW * x1, sH * y1, sW * w1, sH * h1, ...)
end

addEventHandler("onClientPreRender", root, function()
    if not (getElementData(localPlayer, 'fn:matamata.runy')) then return end
    if showBase then
        playersInDimension = 0
        for i, v in ipairs(getElementsByType('player')) do 
            if (getElementDimension(v) == getElementDimension(localPlayer) and getElementData(v, 'fn:matamata.runy')) then 
                playersInDimension = playersInDimension + 1
            end
        end 

        local timerValue = dimensionTimer or 0
        local killText = tostring(playerKills)

        Image(10, 21, 358.11, 37, "assets/base.png")
        Texto(segundosParaHora(timerValue), 66, 29, 59, 21, tocolor(255, 255, 255, 255), (sW*1), "default-bold", "left", "top")
        Texto(tostring(playersInDimension), 209, 26, 22, 21, tocolor(255, 255, 255, 255), (sW*1), "default-bold", "left", "top")
        Texto(killText, 320.11, 27, 28, 21, tocolor(255, 255, 255, 255), (sW*1), "default-bold", "left", "top")

        Image(22, 698, 210, 42, "assets/base_sair.png")
    end
end)

addEvent('onPlayerEnteredMataMata', true)
addEventHandler('onPlayerEnteredMataMata', resourceRoot, function(timer)
    showBase = true
    dimensionTimer = timer or 0
end)

addEvent('onUpdateDimensionTimer', true)
addEventHandler('onUpdateDimensionTimer', resourceRoot, function(timer)
    dimensionTimer = timer or 0
end)

addEvent('onUpdateMatamataPlayers', true)
addEventHandler('onUpdateMatamataPlayers', resourceRoot, function(players)
    playersInDimension = #players
end)

function segundosParaHora(seconds)
    local minutes = math.floor(seconds / 60)
    local seconds = seconds % 60
    return string.format("%02d:%02d", minutes, seconds)
end

addEvent("onPlayerKillUpdate", true)
addEventHandler("onPlayerKillUpdate", resourceRoot, function(kills)
    playerKills = kills
end)

local lastWeaponRequestTime = 0
local weaponRequestDelay = 1500

addEventHandler('onClientKey', root, function(key, press)
    if press then
        local currentTime = getTickCount()
        
        if currentTime - lastWeaponRequestTime < weaponRequestDelay then
            return
        end

        if (key == 'f' or key == 'F') then
            if (getElementData(localPlayer, 'fn:matamata.runy')) then
                triggerServerEvent('onPlayerExitMataMata', resourceRoot, localPlayer)
            end
        elseif key == '1' then
            if (getElementData(localPlayer, 'fn:matamata.runy') and getElementAlpha(localPlayer) == 255) then
                triggerServerEvent('onPlayerRequestWeapon', resourceRoot, localPlayer, 31) -- M4A1
                lastWeaponRequestTime = currentTime
            end
        elseif key == '2' then
            if (getElementData(localPlayer, 'fn:matamata.runy') and getElementAlpha(localPlayer) == 255) then
                triggerServerEvent('onPlayerRequestWeapon', resourceRoot, localPlayer, 30) -- AK-47
                lastWeaponRequestTime = currentTime
            end
        elseif key == '3' then
            if (getElementData(localPlayer, 'fn:matamata.runy') and getElementAlpha(localPlayer) == 255) then
                triggerServerEvent('onPlayerRequestWeapon', resourceRoot, localPlayer, 29) -- MP5
                lastWeaponRequestTime = currentTime
            end
        elseif key == '4' then
            if (getElementData(localPlayer, 'fn:matamata.runy') and getElementAlpha(localPlayer) == 255) then
                triggerServerEvent('onPlayerRequestWeapon', resourceRoot, localPlayer, 32) -- Tec-9
                lastWeaponRequestTime = currentTime
            end
        elseif key == '5' then
            if (getElementData(localPlayer, 'fn:matamata.runy') and getElementAlpha(localPlayer) == 255) then
                triggerServerEvent('onPlayerRequestWeapon', resourceRoot, localPlayer, 23) -- Silenced Pistol
                lastWeaponRequestTime = currentTime
            end
        end
    end
end)