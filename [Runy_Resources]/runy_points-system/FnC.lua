local isRankPanelOpen = false
local isTopPlayersOpen = false
local rankPanelHandler = nil
local topPlayersPanelHandler = nil

local sW, sH = guiGetScreenSize()
local resW, resH = 1366, 768
local nx, ny = (sW/resW), (sH/resH)

local font = dxCreateFont("assets/fonts/font.ttf", sW * (36/1366))
local font2 = dxCreateFont("assets/fonts/font.ttf", sW * (13/1366))
local font3 = dxCreateFont("assets/fonts/font.ttf", sW * (12/1366))

local maxPoints = 99999
increment = {
    bronze1 = 50, bronze2 = 50, bronze3 = 50, bronze4 = 50,
    prata1 = 100, prata2 = 50, prata3 = 50, prata4 = 50,
    ouro1 = 100, ouro2 = 100, ouro3 = 100, ouro4 = 100,
    platina1 = 210, platina2 = 100, platina3 = 100, platina4 = 100, 
    diamante1 = 300, diamante2 = 200, diamante3 = 200, diamante4 = 200, 
    global = 99999, lenda = 500, mestre = 500
}

local currentPoints = 0

local patenteCores = {
    bronze1 = tocolor(172, 79, 46),
    bronze2 = tocolor(172, 79, 46),
    bronze3 = tocolor(172, 79, 46),
    bronze4 = tocolor(172, 79, 46),
    
    prata1 = tocolor(163, 163, 163),
    prata2 = tocolor(163, 163, 163),
    prata3 = tocolor(163, 163, 163),
    prata4 = tocolor(163, 163, 163),
    
    ouro1 = tocolor(109, 40, 217),
    ouro2 = tocolor(109, 40, 217),
    ouro3 = tocolor(109, 40, 217),
    ouro4 = tocolor(109, 40, 217),
    
    platina1 = tocolor(80, 184, 200),
    platina2 = tocolor(80, 184, 200),
    platina3 = tocolor(80, 184, 200),
    platina4 = tocolor(80, 184, 200),
    
    diamante1 = tocolor(165, 112, 204),
    diamante2 = tocolor(165, 112, 204),
    diamante3 = tocolor(165, 112, 204),
    diamante4 = tocolor(165, 112, 204),
    
    mestre = tocolor(161, 60, 60),
    lenda = tocolor(100, 100, 125),
    global = tocolor(217, 170, 40),
}

function drawRankPanel()
    dxDrawImage(sW * (293/1366), sH * (227/768), sW * (783/1366), sH * (313/768), "assets/background.png")
    
    local patente = getElementData(localPlayer, "patente") or "bronze4"
    local pontos = getElementData(localPlayer, "pontos") or 0
    
    if pontos >= maxPoints then
        currentPoints = maxPoints
    else
        currentPoints = pontos % increment[patente]
    end
    local barSize = (currentPoints / increment[patente]) * (sW * (582 / 1366))
    if pontos >= maxPoints then
        barSize = sW * (582 / 1366)
    end
    
    dxDrawImage(sW * (630/1366), sH * (408/768), sW * (110/1366), sH * (110/768), 'assets/elo/'..patente..'.png')
    
    local id = getElementData(localPlayer, "ID") or 0
    local name = getPlayerName(localPlayer)
    
    local patenteCor = patenteCores[patente] or tocolor(255, 255, 255)
    
    dxDrawText(name.."#BBDE1E #"..id, sW * (430/1366), sH * (272/768), sW * (489/1366), sH * (54/768), tocolor(255, 255, 255, 255), 1, font, "left", "top", false, false, false, true, false)
    dxDrawText("Bem vindo "..name.." seu rank fica logo abaixo:", sW * (430/1366), sH * (318/768), sW * (495/1366), sH * (18/768), tocolor(155, 155, 155, 255), 1, font3, "left", "top", false, false, false, true)
    
    dxDrawText(patente, sW * (398/1366), sH * (372/768), sW * (39/1366), sH * (20/768), patenteCor, 1, font2, "left", "top", false, false, false, true)
    dxDrawText(pontos, sW * (954/1366), sH * (372/768), sW * (22/1366), sH * (20/768), tocolor(155, 155, 155, 255), 1, font2, "left", "top", false, false, false, true)
end

local topPlayers = {}

local playerPosition = nil

addEvent("receivePlayerPosition", true)
addEventHandler("receivePlayerPosition", root, function(position)
    playerPosition = position
end)

function drawTopPlayers()
    Image(0, 0, 1366, 768, "assets/background.png")
    Image(0, 0, 1366, 768, "assets/background.png")
    Image(267, 85, 833, 642, "assets/rank.png")
    
    local startY = sH * (200/768)
    local startY2 = sH * (192/768)
    local spacingY = sH * (36/768)
    
    local playerFound = false 
    
    for i, playerData in ipairs(topPlayers) do
        local playerID = playerData.id
        
        if playerID ~= 0 then
            local playerName = playerData.name
            local playerPoints = playerData.points or 0
            local playerRank = playerData.rank or "bronze4"
            local playerWins = playerData.vitorias or 0
            local kills = playerData.Rkills
            local death = playerData.Rdeath
            local playerColor = patenteCores[playerRank] or tocolor(255, 255, 255)
            
            Texto(i .. "°", 294, 90+(i*50), 12, 20, playerColor, 1, font2, "left", "top", false, false, false, true, false)
            Texto(playerRank, 436, 90+(i*50), 79, 20, playerColor, 1, font3, "left", "top", false, false, false, true, false)
            Texto(playerName.." #"..playerID, 599, 90+(i*50), 48, 20, playerColor, 1, font2, "left", "top", false, false, false, true, false)
            Texto(math.round(((kills == 0 and 1 or kills)/(death == 0 and 1 or death)), 2), 754, 90+(i*50), 31, 20, playerColor, 1, font3, "left", "top", false, false, false, true, false)
            Texto(playerWins, 871, 90+(i*50), 20, 20, playerColor, 1, font2, "left", "top", false, false, false, true, false)
            Texto(playerPoints, 1003, 90+(i*50), 39, 20, playerColor, 1, font2, "left", "top", false, false, false, true, false)
            
            if playerName == getPlayerName(localPlayer) then
                playerFound = true
            end
        end
    end
    
    local playerData = {
        name = getPlayerName(localPlayer),
        points = getElementData(localPlayer, "pontos") or 0,
        rank = getElementData(localPlayer, "rank") or "bronze4",
        patente = getElementData(localPlayer, "patente") or "bronze4",
        id = getElementData(localPlayer, "ID") or 0,
        playerWins = getElementData(localPlayer, "vitorias") or 0,
        kills = getElementData(localPlayer, "rankedkills") or 0,
        death = getElementData(localPlayer, "rankeddeath") or 0
    }
    
    if playerData.id ~= 0 and playerPosition then
        local playerColor = tocolor(155, 155, 155)
        Texto(playerPosition .. "°", 291, 697, 34, 20, playerColor, 1, font3, "left", "top", false, false, false, true, false)
        Texto(playerData.patente, 436, 697, 59, 20, playerColor, 1, font3, "left", "top", false, false, false, true, false)
        Texto(playerData.name .. " #" .. playerData.id, 599, 697, 48, 20, playerColor, 1, font3, "left", "top", false, false, false, true, false)
        Texto(math.round(((playerData.kills == 0 and 1 or playerData.kills)/(playerData.death == 0 and 1 or playerData.death)), 2), 754, 697, 34, 20, playerColor, 1, font3, "left", "top", false, false, false, true, false)
        Texto(playerData.playerWins, 870, 697, 11, 20, playerColor, 1, font3, "left", "top", false, false, false, true, false)
        Texto(playerData.points, 1003, 697, 11, 20, playerColor, 1, font3, "left", "top", false, false, false, true, false)
        
        local patenteImage = playerData.patente or "bronze4"
        Image(404, 691, 40, 40, 'assets/elo/'..patenteImage..'.png')
        
    end

    Image(0, 0, 1366, 81, ":runy_lobby4/files/cage_lobby.png", 0, 0, 0, tocolor(255, 255, 255, 255))
        
    if isMouseInPosition(nx*777, ny*36, nx*121.04, ny*29.5) or aba == "Lobby" then
        Image(777, 36, 121.04, 29.5, ":runy_lobby4/files/base_inicio-select.png", 0, 0, 0, tocolor(255,255,255,255))
    else
        Image(777, 36, 121.04, 29.5, ":runy_lobby4/files/base_inicio.png", 0, 0, 0, tocolor(255,255,255,255))
    end
    if isMouseInPosition(nx*347, ny*36, nx*120.6, ny*29.5) or aba == "Custom" then
        Image(347, 36, 120.6, 29.5, ":runy_lobby4/files/base_custom-select.png", 0, 0, 0, tocolor(255,255,255,255))
    else
        Image(347, 36, 120.6, 29.5, ":runy_lobby4/files/base_custom.png", 0, 0, 0, tocolor(255,255,255,255))
    end
    if isMouseInPosition(nx*467, ny*36, nx*121.6, ny*29.5) or aba == "Custom" then
        Image(467, 36, 121.6, 29.5, ":runy_lobby4/files/base_ranking-select.png", 0, 0, 0, tocolor(255,255,255,255))
    else
        Image(467, 36, 121.6, 29.5, ":runy_lobby4/files/base_ranking.png", 0, 0, 0, tocolor(255,255,255,255))
    end
    if isMouseInPosition(nx*1023, ny*36, nx*120.04, ny*30.5) or aba == "Equipamentos" then
        Image(1023, 36, 120.04, 30.5, ":runy_lobby4/files/base_settings-select.png", 0, 0, 0, tocolor(255,255,255,255))
    else
        Image(1023, 36, 120.04, 30.5, ":runy_lobby4/files/base_settings.png", 0, 0, 0, tocolor(255,255,255,255))
    end
    if isMouseInPosition(nx*224, ny*36, nx*120.6, ny*29.5) or aba == "Ranked" then
        Image(224, 36, 120.6, 29.5, ":runy_lobby4/files/base_ranked-select.png", 0, 0, 0, tocolor(255,255,255,255))
    else
        Image(224, 36, 120.6, 29.5, ":runy_lobby4/files/base_ranked.png", 0, 0, 0, tocolor(255,255,255,255))
    end
    if isMouseInPosition(nx*900, ny*35, nx*120.04, ny*30.5) or aba == "Groups" then
        Image(900, 35, 120.04, 30.5, ":runy_lobby4/files/base_groups-select.png", 0, 0, 0, tocolor(255,255,255,255))
    else
        Image(900, 35, 120.04, 30.5, ":runy_lobby4/files/base_groups.png", 0, 0, 0, tocolor(255,255,255,255))
    end
end

setTimer(function()
    triggerServerEvent('requestPlayerPosition', localPlayer, localPlayer)
end, 35000, 0)

addEventHandler("onClientResourceStart", resourceRoot, function()
    triggerServerEvent("requestPlayerPosition", resourceRoot, localPlayer)
end)

function updateTopPlayers(newTopPlayers)
    topPlayers = newTopPlayers
end
addEvent("updateTopPlayers", true)
addEventHandler("updateTopPlayers", resourceRoot, updateTopPlayers)

addEventHandler("onResourceStop", resourceRoot, function()
    closeRankPanel()
    closeTopPlayers()
end)

addEventHandler("onPlayerQuit", root, function()
    closeRankPanel()
    closeTopPlayers()
end)

addEvent("rankRunyGG", true)
addEventHandler("rankRunyGG", root, function()
    if not isRankPanelOpen then
        closeTopPlayers()
        isRankPanelOpen = true
        rankPanelHandler = addEventHandler("onClientRender", root, drawRankPanel)
    end
end)

addEvent("rankRunyGGTop10", true)
addEventHandler("rankRunyGGTop10", root, function()
    if not isTopPlayersOpen then
        closeRankPanel()
        isTopPlayersOpen = true
        topPlayersPanelHandler = addEventHandler("onClientRender", root, drawTopPlayers)
        triggerServerEvent("requestTopPlayers", resourceRoot)
    end
end)

addEvent("closeRankPanel", true)
addEventHandler("closeRankPanel", root, function()
    closeRankPanel()
end)

addEvent("closeTopPlayers", true)
addEventHandler("closeTopPlayers", root, function()
    closeTopPlayers()
end)

function closeRankPanel()
    if isRankPanelOpen then
        isRankPanelOpen = false
        removeEventHandler("onClientRender", root, drawRankPanel)
        triggerEvent("returnToLobbyCancelMatch", localPlayer, localPlayer)

    end
end
bindKey("backspace", "down", closeRankPanel)

function closeTopPlayers()
    if isTopPlayersOpen then
        isTopPlayersOpen = false
        removeEventHandler("onClientRender", root, drawTopPlayers)
        triggerEvent("returnToLobbyCancelMatch", localPlayer, localPlayer)

    end
end
bindKey("backspace", "down", closeTopPlayers)

bindKey("F5", "down", function()
    isRankPanelOpen = not isRankPanelOpen
    if isRankPanelOpen then
        closeTopPlayers()
        rankPanelHandler = addEventHandler("onClientRender", root, drawRankPanel)
    else
        removeEventHandler("onClientRender", root, drawRankPanel)
    end
end)

bindKey("F6", "down", function()
    isTopPlayersOpen = not isTopPlayersOpen
    if isTopPlayersOpen then
        closeRankPanel()
        topPlayersPanelHandler = addEventHandler("onClientRender", root, drawTopPlayers)
        triggerServerEvent("requestTopPlayers", resourceRoot)
    else
        removeEventHandler("onClientRender", root, drawTopPlayers)
    end
end)

addEventHandler("onClientRender", root, function()
    for index, ped in pairs(getElementsByType('ped', resourceRoot)) do
        if isElement(ped) and getElementDimension(ped) == getElementDimension(localPlayer) then
            local data = getElementData(ped, 'dataRank')
            if data then
                local x, y, z = getElementPosition(ped)
                local cx, cy, cz = getCameraMatrix()
                if getDistanceBetweenPoints3D(cx, cy, cz, x, y, z) < 50 then
                    local sx, sy = getScreenFromWorldPosition(x, y, z + 1.5)
                    if sx and sy then
                        dxDrawText(data.name..' #FFFFFF#'..data.id, sx, sy, sx, sy, patenteCores[getLevelToPoints(math.ceil(data.points))], 1, 'default-bold', "center", "bottom", false, false, false, true)
                        --dxDrawText("Pontos: #FFFFFF" .. math.ceil(data.points) .. "", sx, sy + 15, sx, sy + 15, patenteCores[getLevelToPoints(math.ceil(data.points))], 1, 'default-bold', "center", "bottom", false, false, false, true)
                        local playerImage = getLevelToPoints(math.ceil(data.points))
                        dxDrawImage(sx-25, sy-50, 46, 46, 'assets/elo/'..playerImage..'.png')
                    end
                end
            end
        end
    end
end)

light = {}

addEventHandler( "onClientResourceStart", getRootElement(), function ()
    for i,v in ipairs(positionsRank) do
        if isElement(light[i]) then
            destroyElement( light[i] )
        end
        light[i] = createLight( 1, v[1], (i == 1 and v[2]+10 or v[2]+8), v[3]+2, 14, 100, 100, 100, 0, 0, 0, true)
    end
    if isElement(luzplayer) then
        destroyElement( luzplayer )
        luzplayer = nil
    end
    luzplayer = createLight( 1, 2185.208, 356+30, 64+2, 7, 100, 100, 100, 0, 0, 0, true)
end);

function Texto(text, x1, y1, w1, h1, ...)
    return dxDrawText(text, nx *x1, ny *y1, nx *w1, ny *h1, ...)
end

function Image(x1, y1, w1, h1, ...)
    return dxDrawImage(nx* x1, ny* y1, nx* w1, ny* h1, ...)
end

function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end

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
