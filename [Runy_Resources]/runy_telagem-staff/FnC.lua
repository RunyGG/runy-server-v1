local spectatingPlayer = nil
local sW, sH = guiGetScreenSize()
local resW, resH = 1366,768
local x, y = (sW/resW), (sH/resH)

addCommandHandler("telar", function(cmd)
    local targetPlayer = selectRandomPlayerInDimension(localPlayer)
    if targetPlayer then
        startSpectating(localPlayer, targetPlayer)
    else
        outputChatBox("Nenhum jogador disponível para telar.", 255, 0, 0)
    end
end)

addCommandHandler("sairtelagem", function(cmd)
    stopSpectating()
end)

function selectNextPlayerInDimension(player, attempt)
    attempt = attempt or 1 -- Definir 1 como o valor padrão para attempt se não for especificado
    local dimension = getElementDimension(localPlayer)
    local potentialPlayers = {}
    for _, playerInGame in ipairs(getElementsByType("player")) do
        if getElementDimension(playerInGame) == dimension and playerInGame ~= player then
            table.insert(potentialPlayers, playerInGame)
        end
    end

    if #potentialPlayers > 0 then
        local index = 1
        for i, potentialPlayer in ipairs(potentialPlayers) do
            if potentialPlayer == spectatingPlayer then
                index = i
                break
            end
        end
        index = index + 1
        if index > #potentialPlayers then
            index = 1
        end
        if potentialPlayers[index] ~= localPlayer then
            startSpectating(localPlayer, potentialPlayers[index])
        else
            if attempt < #potentialPlayers then
                selectNextPlayerInDimension(player, attempt + 1) -- Chamar a função novamente com a próxima tentativa
            else
                outputChatBox("Nenhum jogador disponível para telar.", 255, 0, 0)
            end
        end
    else
        outputChatBox("Nenhum jogador disponível para telar.", 255, 0, 0)
    end
end

function selectPreviousPlayerInDimension(player, attempt)
    attempt = attempt or 1
    local dimension = getElementDimension(localPlayer)
    local potentialPlayers = {}
    for _, playerInGame in ipairs(getElementsByType("player")) do
        if getElementDimension(playerInGame) == dimension and playerInGame ~= player then
            table.insert(potentialPlayers, playerInGame)
        end
    end

    if #potentialPlayers > 0 then
        local index = 1
        for i, potentialPlayer in ipairs(potentialPlayers) do
            if potentialPlayer == spectatingPlayer then
                index = i
                break
            end
        end
        index = index - 1
        if index < 1 then
            index = #potentialPlayers
        end
        if potentialPlayers[index] ~= localPlayer then
            startSpectating(localPlayer, potentialPlayers[index])
        else
            if attempt < #potentialPlayers then
                selectPreviousPlayerInDimension(player, attempt + 1)
            else
                outputChatBox("Nenhum jogador disponível para telar.", 255, 0, 0)
            end
        end
    else
        outputChatBox("Nenhum jogador disponível para telar.", 255, 0, 0)
    end
end

function selectRandomPlayerInDimension(player)
    local dimension = getElementDimension(localPlayer)
    local potentialPlayers = {}
    for _, playerInGame in ipairs(getElementsByType("player")) do
        if getElementDimension(playerInGame) == dimension and playerInGame ~= player then
            table.insert(potentialPlayers, playerInGame)
        end
    end
    if #potentialPlayers > 0 then
        return potentialPlayers[math.random(#potentialPlayers)]
    else
        return nil
    end
end

function startSpectating(player, targetPlayer)
    if isElement(targetPlayer) then
        spectatingPlayer = targetPlayer

        setElementData(localPlayer, "spectatingPlayer", targetPlayer)

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
    end
end

function stopSpectating()
    if isElement(spectatingPlayer) then
        removeEventHandler("onClientRender", root, renderSpectate)
        spectatingPlayer = nil
        triggerServerEvent("onPlayerSpectateStop", resourceRoot, localPlayer)
        setCameraTarget(localPlayer)
    end
end

function renderSpectate()
    if isElement(spectatingPlayer) then
        local x, y, z = getElementPosition(spectatingPlayer)
        local rx, ry, rz = getElementRotation(spectatingPlayer)
        setCameraMatrix(x, y, z + 2, x, y, z)
        setCameraTarget(spectatingPlayer)

        local playerName = getPlayerName(spectatingPlayer)
        local playerHealth = getElementHealth(spectatingPlayer)
        local playerArmor = getPedArmor(spectatingPlayer)

        dxDrawImage(sW * (1165/1366), sH * (707/768), sW * (174/1366), sH * (42/768), "assets/fundo_player.png")

        -- Button Right

        dxDrawImage(sW * (820/1366), sH * (355/768), sW * (45.83/1366), sH * (58.33/768), "assets/s_right.png")
        if isMouseInPosition(sW * (820/1366), sH * (355/768), sW * (45.83/1366), sH * (58.33/768)) then
            dxDrawImage(sW * (820/1366), sH * (355/768), sW * (45.83/1366), sH * (58.33/768), "assets/s_right-select.png")
        end

        -- Button Left

        dxDrawImage(sW * (500/1366), sH * (355/768), sW * (45.83/1366), sH * (58.33/768), "assets/s_left.png")
        if isMouseInPosition(sW * (500/1366), sH * (355/768), sW * (45.83/1366), sH * (58.33/768)) then
            dxDrawImage(sW * (500/1366), sH * (355/768), sW * (45.83/1366), sH * (58.33/768), "assets/s_left-select.png")
        end
        
        dxDrawText(playerName, sW * (1204/1366), sH * (712/768), sW * (54/1366), sH * (15/768), tocolor(255, 255, 255, 255), 1.00, "assets/fonts/font.ttf", "left", "top", false, false, false, true, false)

        dxDrawImage(sW * (1204/1366), sH * (731/768), (playerHealth/100) * (sW * (128 / 1366)), 3, "assets/health.png")
        dxDrawImage(sW * (1204/1366), sH * (739/768), (playerArmor/100) * (sW * (128 / 1366)), 3, "assets/shield.png")

    else
        stopSpectating()
    end
end

addEventHandler("onClientClick", getRootElement(), function(button, state)
if (isEventHandlerAdded('onClientRender', root, renderSpectate)) then
        if button=="left" and state=="down" then
            if isMouseInPosition(sW * (820/1366), sH * (355/768), sW * (45.83/1366), sH * (58.33/768)) then
                selectNextPlayerInDimension(player)
            end
        end
    end
end)

addEventHandler("onClientClick", getRootElement(), function(button, state)
if (isEventHandlerAdded('onClientRender', root, renderSpectate)) then
        if button=="left" and state=="down" then
            if isMouseInPosition(sW * (500/1366), sH * (355/768), sW * (45.83/1366), sH * (58.33/768)) then
                selectPreviousPlayerInDimension(player)
            end
        end
    end
end)

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