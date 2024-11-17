local showKillsMostrar = false
screenW, screenH = guiGetScreenSize()
sW, sH = (screenW/1366), (screenH/768)

addCommandHandler("stats", function()
    triggerServerEvent("requestPlayerStats", localPlayer)
end)

playerKills = 0

function Texto(text, x1, y1, w1, h1, ...)
    return dxDrawText(text, sW * x1, sH * y1, sW * w1, sH * h1, ...)
end

addEvent("updatePlayerKills", true)
addEventHandler("updatePlayerKills", root, function(kills)
    playerKills = kills
    if playerKills ~= 0 then
        setElementData(localPlayer, 'killPartida', playerKills)
    end
end)

addEventHandler("onClientRender", root, function()
    if not showKillsMostrar then return end
    
    local fontSize = (sW * 1.4)
    local font = "default-bold"
    local textColor = tocolor(255, 255, 255, 255)

    Texto(playerKills, 178, 32, 17, 20, textColor, fontSize, font, "left", "top")
end)

addCommandHandler("assists", function()
    triggerServerEvent("requestPlayerAssists", localPlayer)
end)

function showKillsMostrar()
    showKillsMostrar = true
end
addEvent("showKillsMostrar", true)
addEventHandler("showKillsMostrar", root, showKillsMostrar)

function hideKillsMostrar()
    showKillsMostrar = false
end
addEvent("hideKillsMostrar", true)
addEventHandler("hideKillsMostrar", root, hideKillsMostrar)