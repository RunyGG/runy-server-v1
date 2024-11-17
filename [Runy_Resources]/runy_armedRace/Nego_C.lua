-- CLIENT

screenW, screenH = guiGetScreenSize()
sW, sH = (screenW/1366), (screenH/768)

local showBase = false
local dimensionTimer = 0
local playerKills = 0

local font = dxCreateFont('assets/fonts/font.ttf', 20)

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

        Image(10, 21, 358.58, 37, "assets/base.png")
        Texto(segundosParaHora(timerValue), 66, 24, 46, 20, tocolor(255, 255, 255, 255), sW*(1), font, 'left', 'top', false, false, false, true)
        Texto(tostring(playersInDimension), 209, 24, 21, 25, tocolor(255, 255, 255, 255), sW*(1), font, 'left', 'top', false, false, false, true)
        Texto(killText, 320.58, 24, 24, 25, tocolor(255, 255, 255, 255), sW*(1), font, 'left', 'top', false, false, false, true)

        for index = 0, 4 do
            local togl = config.gungame[(playerKills+1)+index]

            if togl[1] == 'x' then
                Image(1267, 534-(((index+1))*30), 14, 14, "assets/circle.png", 0, 0, 0, tocolor(109, 40, 217, 150))
            else
                Image(1237, 534-(((index+1))*30), 73, 21, "assets/"..togl[1]..".png", 0, 0, 0, tocolor(255, 255, 255, 150))
            end
        end

        --for index = 1, 5 do
        --    
        --end
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
addEventHandler("onPlayerKillUpdate", resourceRoot, function(kills, weapon)
    playerKills = kills
    recentWeapon = weapon
end)