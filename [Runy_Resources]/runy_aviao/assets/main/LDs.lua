local plane, planeTimer, objectX, blipF = {}, {}, {}, {}
local delayDimension, runningMatch, membersFromMatch, startMatchTimer, planeMatch = {}, {}, {}, {}, {}

function getPlayerSquad(player)
    if (getElementData(player, 'myDuo')) then 
        for _, v in pairs(getElementData(player, 'myDuo')) do 
            return v
        end
    end
    return false
end

function joinInBattleRoyale(player)
    setPlayerMoney(player, 1)
    if (client and client ~= player) then
        if (getElementData(player, 'myDuo') ~= client) then 
            return 
        end
    end
    local duoPlayer = getElementData(player, 'myDuo')
    if isElement(blipF[player]) then
        destroyElement(blipF[player])
        blipF[player] = nil
    end
    if (isElement(duoPlayer)) then 
        if isElement(blipF[duoPlayer]) then
            destroyElement(blipF[duoPlayer])
            blipF[duoPlayer] = nil
        end
        if (getElementData(player, 'groupOwner')) then 
            if not (getElementData(duoPlayer, 'alreadyState')) then
                return config.notify(player, 'O jogador não está pronto para iniciar a partida.', 'error')
            end
            triggerClientEvent(duoPlayer, 'removeLobbyOnEnterMatch', duoPlayer)
            joinInBattleRoyale(duoPlayer)
        else 
            if (client == player) then 
                
                removeElementData(player, 'myDuo')
                removeElementData(duoPlayer, 'myDuo')
                
                removeElementData(player, 'groupOwner')
                removeElementData(duoPlayer, 'groupOwner')
                
            end
            
        end
        
    end 
    
    for i = 5000, 60000 do 
        if not (membersFromMatch[i]) then 
            membersFromMatch[i] = {}
        end 
        if not (isTimer(delayDimension[i])) and not (runningMatch[i]) and ((#membersFromMatch[i] or 0) < config.maxMembers) then 
            setElementDimension(player, i)
            
            table.insert(membersFromMatch[i], player)
            setElementData(player, 'runyInPareamento', i)
            
            local x, y, z = unpack(config.waitingPosition)
            setElementPosition(player, x, y, z)
            setElementHealth(player, 100)
            toggleControl(player, "fire", false)
            removeElementData(player, 'deadPlayer')
            exports['runy_samu']:removeDroppedEffect(player)
            
            if not (isTimer(startMatchTimer[i])) then 
                
                startMatchTimer[i] = setTimer(function(i)
                    if (#membersFromMatch[i] >= config.minimunMembers) then
                        startPlane(i)
                    else
                        cancelMatch(i)
                    end
                end, config.startTime * 10000, 1, i)
                
            end
            
            for _, v in ipairs(membersFromMatch[i]) do 
                
                if (isElement(v)) then 
                    
                    if isElement(blipF[v]) then
                        destroyElement(blipF[v])
                        blipF[v] = nil
                    end
                    
                    if getElementData(player, 'autoFormação') and not getElementData(player, 'myDuo') then
                        if player ~= v then
                            if getElementData(v, 'autoFormação') and not getElementData(v, 'myDuo') then
                                setElementData(player, 'myDuo', v)
                                setElementData(v, 'myDuo', player)
                            end
                        end
                    end
                    triggerClientEvent(v, 'onClientDrawBattleRoyaleTimer', v, getTimerDetails(startMatchTimer[i]), #membersFromMatch[i])
                end
            end 
            break 
        end 
    end 
end
addEvent('onPlayerStartJoinBattleRoyale', true)
addEventHandler('onPlayerStartJoinBattleRoyale', root, joinInBattleRoyale)

function startPlane(i)  
    local dimensao = i
    for _, v in ipairs(membersFromMatch[i]) do 
        if (isElement(v)) then
            removeElementData(v, 'teleport.pvp')
            takeAllWeapons(v)
            setPedArmor(v, 0)
        end
    end
    exports['runy_dropItem']:destroyLoot(dimensao)
    exports['runy_loot']:destroyLoot(dimensao)
    for _, v in ipairs(membersFromMatch[i]) do 
        if (isElement(v)) then
            triggerClientEvent(v, "destroyMarkersTrigger", resourceRoot, dimensao)
        end
    end
    --[[ exports['runy_shop']:stockAdd(dimensao) ]]
    
    triggerEvent("iniciarSafezoneNoServidor", root, dimensao)
    triggerEvent("iniciarVerificacaoDimensao", root, dimensao)
    triggerEvent("onCreateLoot", root, dimensao)
    triggerEvent("spawnVeiculo", root, dimensao)
    for _, v in ipairs(membersFromMatch[i]) do 
        if (isElement(v)) then
            triggerClientEvent(v, "createMarkersTrigger", resourceRoot, dimensao)
            triggerEvent("giveStairs", v, v, dimensao)
        end
    end
    if (isElement(plane[i])) then 
        destroyElement(plane[i])
        destroyElement(objectX[i])
    end
    
    local routeIndex = math.random(1, #config.routes)
    local route = config.routes[routeIndex]
    
    objectX[i] = createVehicle(592, unpack(route.startPosition))
    plane[i] = createObject(config.planeModel, unpack(route.startPosition))
    setElementFrozen( objectX[i], true)
    setElementAlpha(plane[i], 0)
    attachElements(objectX[i], plane[i], 0, 0, 0)
    setElementDimension(plane[i], i)
    setElementDimension(objectX[i], i)
    moveObject(plane[i], route.flightTime * 1000, unpack(route.finishPosition))
    for _, v in ipairs(membersFromMatch[i]) do 
        if (isElement(v)) then 
            PlaySound3Ds(v, 'engineplane', 600, 0.3, plane[i])
            setElementAlpha(v, 0)
            exports['pattach']:setVisibleAll(v, false)
            toggleAllControls(v, false)
            giveWeapon(v, 46, 1, true)
            triggerClientEvent(v, 'onClientRemoveBattleRoyaleTimer', v)
            removeElementData(v, 'runyInPareamento', i)
            setElementData(v, 'battleRoyaleMatch', i)
            attachElements(v, plane[i], 0, - 45, 25, 0, 0, 180)
            local rmx, rmy, rmz = getElementRotation(objectX[i])
            setElementRotation( v, 0, 0, rmz-180 )
            exports["runy_inventario"]:giveItem(v, 19, 1)
            local x, y, z = getElementPosition(plane[i])
            setElementPosition(v, x, y, z)
            
            setElementHealth(v, 100) -- Definir a vida do jogador como 100
        end 
    end 
    
    setTimer(function(i)
        for _, v in ipairs(membersFromMatch[i]) do 
            if (isElement(v) and getElementData(v, 'battleRoyaleMatch')) then 
                dropFromPlane(v)
            end 
        end
        membersFromMatch[i] = {}
        destroyElement(plane[i])
        destroyElement(objectX[i])
    end, route.flightTime * 1000, 1, i)
    runningMatch[i] = true 
    setTimer(function(i)
        runningMatch[i] = false 
    end, config.matchTime * 60000, 1, i)
    
    local playerCount = #membersFromMatch[i]
    local message = 'RUNY - **Iniciada** uma partida com `' .. playerCount .. '` **jogadores** na **dimensão** `' .. i .. '`!'
    triggerEvent("RunyLogsDiscord5", root, root, message, 1)
end

function preventPlaneDamage(attacker, weapon, bodypart, loss)
    local planeElement = source
    if (getElementType(planeElement) == "object" and isElement(planeElement)) then
        cancelEvent() 
    end
end
addEventHandler("onClientObjectDamage", root, preventPlaneDamage)


function cancelPlayerMatch(player)
    if getElementData(player, 'runyInPareamento') then
        local dimension = getElementData(player, 'runyInPareamento')
        removeElementData(player, 'runyInPareamento')
        for i, v in ipairs(membersFromMatch[dimension]) do
            if v == player then
                table.remove(membersFromMatch[dimension], i)
                triggerClientEvent(player, 'onClientRemoveBattleRoyaleTimer', player)
                triggerClientEvent(player, "progressBar", resourceRoot, 0)
                toggleAllControls(v, true) 
                updateTimerForDimension(dimension)
                
                break
            end
        end 
    end
end       
addEvent('cancelMatchPlayer', true)
addEventHandler('cancelMatchPlayer', root, cancelPlayerMatch)

function updateTimerForDimension(dimension)
    for _, player in ipairs(getElementsByType("player")) do
        if getElementData(player, 'runyInPareamento') == dimension then
            triggerClientEvent(player, 'onClientDrawBattleRoyaleTimer', player, getTimerDetails(startMatchTimer[dimension]), #membersFromMatch[dimension])
        end
    end
end

local customRooms = {}

function generateRoomCode()
    local code = ""
    local characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local length = 6
    
    for i = 1, length do
        local randomIndex = math.random(1, #characters)
        code = code .. characters:sub(randomIndex, randomIndex)
    end
    
    return code
end

function createCustomRoom(player)
    if not isObjectInACLGroup("user."..getAccountName(getPlayerAccount(player)), aclGetGroup("Staff")) then
        outputChatBox("Você não tem permissão para criar salas personalizadas.", player, 255, 0, 0)
        return
    end
    
    local roomCode = generateRoomCode()
    local i = {math.random(7000, 8000)}
    local room = {
        code = roomCode,
        creator = player,
        players = {player},
        i = i,
        started = false
    }
    
    customRooms[roomCode] = room
    
    local x, y, z = unpack(config.customRoomPosition)
    setElementPosition(player, x, y, z)
    setElementDimension(player, i[1])
    triggerClientEvent(player, "removeLobbySala", resourceRoot)
    
    outputChatBox("Sala personalizada criada com sucesso. Código: " .. roomCode, player, 0, 255, 0)
    triggerClientEvent(player, "showRoomCode", resourceRoot, roomCode)
    
    updateCustomRoomPlayerCount(roomCode)
end

function joinCustomRoom(player, roomCode)
    local room = customRooms[roomCode]
    
    if not room then
        outputChatBox("Sala personalizada não encontrada.", player, 255, 0, 0)
        return
    end
    
    for _, p in ipairs(room.players) do
        if p == player then
            outputChatBox("Você já está em uma sala personalizada.", player, 255, 0, 0)
            return
        end
    end
    
    table.insert(room.players, player)
    outputChatBox("Você entrou na sala personalizada. Código: " .. roomCode, player, 0, 255, 0)
    
    local x, y, z = unpack(config.customRoomPosition)
    setElementPosition(player, x, y, z)
    setElementDimension(player, room.i[1])
    triggerClientEvent(player, "removeLobbySala", resourceRoot)
    
    updateCustomRoomPlayerCount(roomCode)
end

local tempoEspera = 15 * 60 * 1000
local tempoUltimaInicializacao = {}

function updateCustomRoomPlayerCount(roomCode)
    local room = customRooms[roomCode]
    
    if room then
        local playerCount = #room.players
        for _, player in ipairs(room.players) do
            triggerClientEvent(player, "updateCustomRoomPlayerCount", resourceRoot, playerCount)
        end
    end
end

function startCustomRoom(player)
    local accountName = getAccountName(getPlayerAccount(player))
    
    for code, room in pairs(customRooms) do
        if room.creator == player then
            if room.started then
                outputChatBox("A partida já foi iniciada nesta sala personalizada. Código: " .. code, player, 255, 0, 0)
                return
            end
            
            local i = room.i[1]
            if tempoUltimaInicializacao[i] and getTickCount() - tempoUltimaInicializacao[i] < tempoEspera then
                local tempoRestante = math.ceil((tempoEspera - (getTickCount() - tempoUltimaInicializacao[i])) / 1000)
                outputChatBox("Você deve esperar " .. tempoRestante .. " segundos antes de iniciar a sala novamente.", player, 255, 0, 0)
                return
            end
            tempoUltimaInicializacao[i] = getTickCount()
            room.started = true
            if not membersFromMatch[i] then
                membersFromMatch[i] = {}
            end
            for _, p in ipairs(room.players) do
                table.insert(membersFromMatch[i], p)
                setElementDimension(p, i)
            end
            
            triggerClientEvent(player, "removeLobby", resourceRoot)
            triggerClientEvent(player, "cameraTargetPlayer", resourceRoot)
            
            leaveCustomRoomStart(player)
            
            startPlaneSala(i)
            
            outputChatBox("A partida foi iniciada na sala personalizada. Código: " .. code, player, 0, 255, 0)
            triggerClientEvent(player, "hideRoomCode", resourceRoot)
            return
        end
    end
    outputChatBox("Você não criou nenhuma sala personalizada.", player, 255, 0, 0)
end

function leaveCustomRoom(player)
    local accountName = getAccountName(getPlayerAccount(player))
    
    for roomCode, room in pairs(customRooms) do
        for i, p in ipairs(room.players) do
            if p == player then
                table.remove(room.players, i)
                outputChatBox("Você saiu da sala personalizada.", player, 255, 255, 0)
                triggerClientEvent(player, "hideRoomCode", resourceRoot)
                updateCustomRoomPlayerCount(roomCode)
                
                if room.creator == player then
                    for _, otherPlayer in ipairs(room.players) do
                        outputChatBox("A sala personalizada foi desativada porque o criador saiu.", otherPlayer, 255, 0, 0)
                        leaveCustomRoom(otherPlayer)
                    end
                    customRooms[roomCode] = nil
                end
                
                return
            end
        end
    end
    outputChatBox("Você não está em uma sala personalizada.", player, 255, 0, 0)
end

function leaveCustomRoomStart(player)
    local accountName = getAccountName(getPlayerAccount(player))
    
    for roomCode, room in pairs(customRooms) do
        for i, p in ipairs(room.players) do
            if p == player then
                table.remove(room.players, i)
                outputChatBox("Sala personalizada iniciou.", player, 255, 255, 0)
                triggerClientEvent(player, "hideRoomCode", resourceRoot)
                updateCustomRoomPlayerCount(roomCode)
                
                if room.creator == player then
                    for _, otherPlayer in ipairs(room.players) do
                        leaveCustomRoomStart(otherPlayer)
                    end
                    customRooms[roomCode] = nil
                end
                return
            end
        end
    end
end

addEventHandler("onPlayerQuit", root, function()
    for code, room in pairs(customRooms) do
        if room.creator == source then
            for _, player in ipairs(room.players) do
                leaveCustomRoom(player)
            end
            customRooms[code] = nil
            outputChatBox("A sala personalizada criada por " .. getPlayerName(source) .. " foi desativada porque o criador fechou o servidor.", root, 255, 0, 0)
        end
    end
end)

addEventHandler("onPlayerLogout", root, function()
    for code, room in pairs(customRooms) do
        if room.creator == source then
            for _, player in ipairs(room.players) do
                leaveCustomRoom(player)
            end
            customRooms[code] = nil
            outputChatBox("A sala personalizada criada por " .. getPlayerName(source) .. " foi desativada porque o criador fechou o servidor.", root, 255, 0, 0)
        end
    end
end)

addCommandHandler("sairsala", leaveCustomRoom)
addCommandHandler("createsala", createCustomRoom)
addCommandHandler("iniciarsala", startCustomRoom)
addCommandHandler("entrarsala", function(player, cmd, roomCode)
    joinCustomRoom(player, roomCode)
end)

function startPlaneSala(i)  
    if not membersFromMatch[i] then
        membersFromMatch[i] = {}
    end
    
    local dimensao = i
    for _, v in ipairs(membersFromMatch[i]) do 
        if (isElement(v)) then
            removeElementData(v, 'teleport.pvp')
            takeAllWeapons(v)
            setPedArmor(v, 0)
            config.notify(v, 'Partida começará em alguns instantes.', 'info')
        end
    end
    
    triggerEvent("iniciarSafezoneNoServidor", root, dimensao)
    triggerEvent("iniciarVerificacaoDimensao", root, dimensao)
    triggerEvent("onCreateLoot", root, dimensao)
    triggerEvent("spawnVeiculo", root, dimensao)
    if (isElement(plane[i])) then 
        destroyElement(plane[i])
        destroyElement(objectX[i])
    end 
    
    local routeIndex = math.random(1, #config.routes)
    local route = config.routes[routeIndex]
    objectX[i] = createVehicle(592, unpack(route.startPosition))
    plane[i] = createObject(config.planeModel, unpack(route.startPosition))
    
    setElementFrozen( objectX[i], true)
    setElementAlpha(plane[i], 0)
    attachElements(objectX[i], plane[i], 0, 0, 0)
    setElementDimension(objectX[i], i)
    
    setElementAlpha(plane[i], 0)
    setObjectScale(plane[i], config.planeScale)
    setElementDimension(plane[i], i)
    moveObject(plane[i], route.flightTime * 1000, unpack(route.finishPosition))
    
    for _, v in ipairs(membersFromMatch[i]) do 
        if (isElement(v)) then 
            PlaySound3Ds(v, 'engineplane', 600, 0.3, plane[i])
            setElementAlpha(v, 0)
            exports['pattach']:setVisibleAll(v, false)
            toggleAllControls(v, false)
            giveWeapon(v, 46, 1, true)
            triggerClientEvent(v, 'onClientRemoveBattleRoyaleTimer', v)
            removeElementData(v, 'runyInPareamento', i)
            setElementData(v, 'battleRoyaleMatch', i)
            local x, y, z = getElementPosition(plane[i])
            setElementPosition(v, x, y, z)
            attachElements(v, plane[i], 0, - 50, 25)
            
            exports["runy_inventario"]:giveItem(v, 19, 1)
            
            setElementHealth(v, 100) -- Definir a vida do jogador como 100
        end 
    end 
    setTimer(function(i)
        
        for _, v in ipairs(membersFromMatch[i]) do 
            if (isElement(v) and getElementData(v, 'battleRoyaleMatch')) then 
                dropFromPlane(v)
            end 
        end
        membersFromMatch[i] = {}
        destroyElement(plane[i])
        destroyElement(objectX[i])
    end, route.flightTime * 1000, 1, i)
    
    runningMatch[i] = true 
    setTimer(function(i)
        runningMatch[i] = false 
    end, config.matchTime * 60000, 1, i)
    
    local playerCount = #membersFromMatch[i]
    local message = 'RUNY - **Iniciada** uma sala com `' .. playerCount .. '` **jogadores** na **dimensão** `' .. i .. '`!'
    triggerEvent("RunyLogsDiscord5", root, root, message, 1)
end 

function cancelMatch(i)
    if isTimer(startMatchTimer[i]) then
        killTimer(startMatchTimer[i])
    end
    
    for _, player in ipairs(membersFromMatch[i]) do
        config.notify(player, 'A partida de Battle Royale foi cancelada devido à falta de jogadores.', 'error')
        triggerClientEvent(player, 'onClientRemoveBattleRoyaleTimer', player)
    end
    
    membersFromMatch[i] = {}
    setTimer(function(i)
        for _, element in ipairs(getElementsByType("player")) do
            if getElementDimension(element) == i and getElementData(element, "runyInPareamento") then
                triggerClientEvent("returnToLobbyCancelMatch", element, element)
            end
        end
    end, 1000, 1, i)
    
    runningMatch[i] = true
    setTimer(function(i)
        runningMatch[i] = false
    end, config.matchTime * 60000, 1, i)
end

function dropFromPlane(player)
    if (getElementData(player, 'battleRoyaleMatch')) then
        local duoZ = getElementData(player, 'myDuo')
        if duoZ then
            if getElementData(player, 'groupOwner') then
                if getElementData(duoZ, 'follow') == player then
                    setTimer(function()
                        dropFromPlane(duoZ)
                    end, 600, 1)
                end
            end
        end
        local i = getElementData(player, 'battleRoyaleMatch')
        if (isElement(plane[i])) then
            local x, y, z = getElementPosition(plane[i])
            local rmx, rmy, rmz = getElementRotation(objectX[i])
            setElementRotation( player, 0, 0, rmz-180 )
            setElementAlpha(player, 255)
            exports['pattach']:setVisibleAll(player, true)
            detachElements(player, plane[i])
            takeAllWeapons(player)
            setPedArmor(player, 0)
            setCameraTarget(player, player)
            toggleAllControls(player, true)
            attachElements(player, objectX[i], 0, -30, -1, 0, 0, 180)
            detachElements(player, objectX[i])
            setElementPosition(player, x, y, z - 11)
            setPedWeaponSlot(player, 11)
            setElementData(player, 'battleRoyaleRunning', true)
            triggerClientEvent("onPlayerEnterDimension", root, i)
            removeElementData(player, 'battleRoyaleMatch')
            giveWeapon(player, 46, 1, true)
            toggleControl(player, "previous_weapon", false)
            toggleControl(player, "next_weapon", false)
            if isElement(blipF[player]) then
                destroyElement(blipF[player])
                blipF[player] = nil
                removeElementData(player,'blipFriend')
            end
            local friend = getElementData(player, 'myDuo')
            if friend then
                if isElement(blipF[friend]) then
                    destroyElement(blipF[friend])
                    blipF[friend] = nil
                    removeElementData(friend,'blipFriend')
                end
                if getElementData(friend, 'battleRoyaleMatch') then
                    blipF[player] = createBlipAttachedTo(friend, 0, 2, 0, 255, 0, 255, 0, 10000, player)
                    setElementData(friend, 'blipFriend', blipF[player])
                end
                if getElementData(player, 'battleRoyaleMatch') then
                    blipF[friend] = createBlipAttachedTo(player, 0, 2, 0, 255, 0, 255, 0, 10000, friend)
                    setElementData(player, 'blipFriend', blipF[friend])
                end
            end
        end
    end
end

local playersInDimensions = {}

addEventHandler('onPlayerLogin', root, function()
    if not (isKeyBound(source, config.key, 'down', dropFromPlane)) then 
        bindKey(source, config.key, 'down', dropFromPlane)
    end 
end)

addEventHandler('onResourceStart', resourceRoot, function()  
    for i, player in ipairs(getElementsByType('player')) do 
        if not (isKeyBound(player, config.key, 'down', dropFromPlane)) then 
            bindKey(player, config.key, 'down', dropFromPlane)
        end 
    end 
end)

function PlaySound3Ds(playerSource, som, distance, volume, object)
    if distance == "all" then
        triggerClientEvent(root, "playSounds", playerSource, som, playerSource)
    else
        for i, players in pairs(getElementsByType("player")) do
            if object then
                triggerClientEvent(players, "playSounds", players, som, playerSource, volume, distance, object)
            else
                triggerClientEvent(playerSource, "playSounds", playerSource, som, playerSource, volume, distance)
            end
        end
    end
end

function blipFriendChange(player, type, id)
    if isElement(blipF[player]) then
        local duo = getElementData(player, 'myDuo')
        if type == 'change' then
            setBlipIcon(blipF[player], (id and tonumber(id) or 0) )
        elseif type == 'move' then
            setElementPosition(blipF[player], id[1], id[2], id[3])
        elseif type == 'color' then
            setBlipColor(blipF[player], id[1], id[2], id[3])
        elseif type == 'detach' then
            detachElements(blipF[player], player )
        elseif type == 'attach' then
            attachElements(blipF[player], duo, 0, 0, 0 )
            setBlipIcon(blipF[player], 0)
            setBlipColor(blipF[player], 0, 255, 0)
        elseif type == 'destroy' then
            if isElement(blipF[player]) then
                destroyElement(blipF[player])
                blipF[player] = nil
            end
        end
    end
end
addEvent('ChangeBliped', true)
addEventHandler('ChangeBliped', root, blipFriendChange)

function AutoFormar(player)
    setTimer(function(player)
    end, 300, 1, player)
end
addEvent('AutoFormar', true)
addEventHandler('AutoFormar', root, AutoFormar)

function getPlayerInDimension(dim)
    count = 0
    for _, player in ipairs(getElementsByType("player")) do
        if getElementDimension(player) == dim then
            count = count + 1
        end
    end
    return count
end

addEventHandler("onPlayerQuit", root,function()
    if getElementData(source, 'myDuo') then
        local duo = getElementData(source, 'myDuo')
        removeElementData(source, 'myDuo')
        removeElementData(source, 'groupOwner')
        removeElementData(source, 'battleRoyaleMatch') 
        removeElementData(source, 'blipFriend') 
        removeElementData(duo, 'myDuo')
        removeElementData(duo, 'groupOwner')
        removeElementData(duo, 'battleRoyaleMatch')
        removeElementData(duo, 'blipFriend')
        if isElement(blipF[duo]) then
            destroyElement(blipF[duo])
            blipF[duo] = nil
        end
        if isElement(blipF[source]) then
            destroyElement(blipF[source])
            blipF[source] = nil
        end
    end
end)