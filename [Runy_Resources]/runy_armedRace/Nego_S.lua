local matamataPlayers = {}
local dimensionTimers = {}
local playerKills = {}
local weaponRecent = {}

function hasSpaceInDimension(dimension)
    local playerCount = 0
    for _, player in ipairs(getElementsByType('player')) do
        if getElementData(player, 'fn:matamata.runy') and getElementDimension(player) == dimension then
            playerCount = playerCount + 1
        end
    end
    return playerCount < config.maxPlayersPerDimension
end

function findFreeDimension()
    for dim = config.DIMENSION_START, config.DIMENSION_END do
        if hasSpaceInDimension(dim) then
            return dim
        end
    end
    return false
end

function updateMatamataPlayers()
    matamataPlayers = {}
    for _, player in ipairs(getElementsByType("player")) do
        if getElementDimension(player) and getElementData(player, "fn:matamata.runy") then
            local playerName = getPlayerName(player)
            local playerTime = getElementData(player, 'fn:matamata.timer') or 0
            table.insert(matamataPlayers, { name = playerName, timer = playerTime })
        end
    end
    triggerClientEvent('onUpdateMatamataPlayers', resourceRoot, matamataPlayers)
end

function setupMatamataPlayer(player)
    local freeDimension = findFreeDimension()
    if freeDimension then
        local v = config.teleports
        local randomPos = math.random(#v.positions) 
        local pos = v.positions[randomPos]
        setElementPosition(player, pos[1], pos[2], pos[3])
        setElementInterior(player, 0)
        setElementDimension(player, freeDimension)
        setElementData(player, 'fn:matamata.runy', true)
        setElementData(player, 'fn:matamata.runy.dimension', freeDimension)
        setElementData(player, 'fn:matamata.timer', config.mataMataTime)
        setElementHealth(player, 100)
        setPedArmor(player, 100)
        takeAllWeapons(player)
        toggleControl(player, 'fire', true)
        setElementAlpha(player, 200)
        
        bindKey(player, '3', 'up', changeWeapon)
        bindKey(player, '2', 'up', changeWeapon)
        
        setTimer(function(player, v)
            if isElement(player) then 
                if getElementData(player, 'fn:matamata.runy') then 
                    setElementAlpha(player, 255)
                    if not playerKills[player] then
                        playerKills[player] = 0
                    end
                    if config.gungame[playerKills[player]][1] ~= 'x' then
                        exports['mg']:giveNewWeapon(player, config.gungame[playerKills[player]][1], 9999)
                        weaponRecent[player] = config.gungame[playerKills[player]][1]
                    end
                end
            end
        end, 5000, 1, player, v)
        
        if not dimensionTimers[freeDimension] then
            dimensionTimers[freeDimension] = config.mataMataTime
        end
        
        triggerClientEvent(player, 'onPlayerEnteredMataMata', resourceRoot, dimensionTimers[freeDimension])
        updateMatamataPlayers()
    else
        triggerClientEvent(player, "Notify", player, "O modo mata-mata está cheio. Por favor, tente novamente mais tarde.")
    end
end

function setSpawnPlayer(player)
    setElementAlpha(player, 255)
    toggleControl(player, "fire", false)
    setPedArmor(player, 0)
    triggerClientEvent(player, "onPlayerKillUpdate", resourceRoot, 0)
    removeElementData(player, 'fn:matamata.runy')
    removeElementData(player, 'fn:matamata.runy.dimension')
    removeElementData(player, 'fn:matamata.runytimer')
    triggerClientEvent(player, "returnToLobbyClientEvent", player)
    takeAllWeapons(player)
    playerKills[player] = nil
end

addEventHandler('onResourceStart', getResourceRootElement(getThisResource()), function()
    for _, player in ipairs(getElementsByType('player')) do 
        if getElementData(player, 'fn:matamata.runy') then 
            setSpawnPlayer(player) 
        end
    end
end)

addEventHandler('onResourceStop', getResourceRootElement(getThisResource()), function()
    for _, player in ipairs(getElementsByType('player')) do 
        if getElementData(player, 'fn:matamata.runy') then 
            setSpawnPlayer(player)
        end
    end
end)

addEventHandler('onPlayerSpawn', root,function()
    if getElementData(source, 'fn:matamata.runy') then 
        local i = getElementData(source, 'fn:matamata.runy')
        local v = config.teleports
        local randomPos = math.random(#v.positions) 
        local pos = v.positions[randomPos]
        setElementPosition(source, pos[1], pos[2], pos[3])
        setElementData(source, 'fn:matamata.runy', i)
        setElementHealth(source, 100)
        setPedArmor(source, 100)
        takeAllWeapons(source)
        setElementAlpha(source, 200)
        setTimer(function(player, v)
            if isElement(player) then
                if getElementData(player, 'fn:matamata.runy') then 
                    setElementAlpha(player, 255)
                    if not playerKills[player] then
                        playerKills[player] = 0
                    end
                    if config.gungame[playerKills[player]][1] ~= 'x' then
                        exports['mg']:giveNewWeapon(player, config.gungame[playerKills[player]][1], 9999)
                        weaponRecent[player] = config.gungame[playerKills[player]][1]
                    end
                end
            end
        end, 3000, 1, source, v)
    end
end)

addEvent('onPlayerEnterInMataMata', true)
addEventHandler('onPlayerEnterInMataMata', root, setupMatamataPlayer)

addEvent('onPlayerExitMataMata', true)
addEventHandler('onPlayerExitMataMata', resourceRoot, setSpawnPlayer)

function segundosParaHora(seconds)
    local minutes = math.floor(seconds / 60)
    local seconds = seconds % 60
    return string.format("%02d:%02d", minutes, seconds)
end

setTimer(function()
    updateMatamataPlayers()
end, 5000, 0)

setTimer(function()
    for dim, time in pairs(dimensionTimers) do
        if time > 0 then
            dimensionTimers[dim] = time - 1
            for _, player in ipairs(getElementsByType("player")) do
                toggleControl(player, "next_weapon", false)
                toggleControl(player, "previous_weapon", false)
                if getElementDimension(player) == dim and getElementData(player, 'fn:matamata.runy') then
                    triggerClientEvent(player, 'onUpdateDimensionTimer', resourceRoot, dimensionTimers[dim])
                end
            end
        else
            for _, player in ipairs(getElementsByType("player")) do
                toggleControl(player, "next_weapon", false)
                toggleControl(player, "previous_weapon", false)
                if getElementDimension(player) == dim and getElementData(player, 'fn:matamata.runy') then
                    setSpawnPlayer(player)
                    triggerClientEvent(player, "Notify", player, "Seu tempo no modo corrida armada acabou!")
                    unbindKey(player, '3', 'up', changeWeapon)
                    unbindKey(player, '2', 'up', changeWeapon)
                end
            end
            dimensionTimers[dim] = nil
        end
    end
end, 1000, 0)

local Delay = {}

function changeWeapon(player, b, s)
    if not getElementData(player, 'fn:matamata.runy') then return end
    if not isTimer( Delay[player]) then
        local weapon = weaponRecent[player]
        Delay[player] = setTimer(function() end, 1000, 1)
        if b == '3' then
            exports['mg']:giveNewWeapon(player, 'faca', 1)
        elseif b == '2' then
            exports['mg']:giveNewWeapon(player, weapon, 9999)
        end
    end
end

function newPosition(source, killer)
    if killer and getElementData(killer, 'fn:matamata.runy') then
        if not playerKills[source] then
            playerKills[source] = 0
        end
        if not playerKills[killer] then
            playerKills[killer] = 0
        end
        
        local deathDimension = getElementDimension(source)
        local killerDimension = getElementDimension(killer)
        if killerDimension == deathDimension then
            for _, player in ipairs(getElementsByType("player")) do
                if getElementDimension(player) == deathDimension then
                    triggerClientEvent(player, "displayKillFeed", player, getPlayerName(killer), getElementData(killer, 'ID'), getPlayerName(source), getElementData(source, 'ID'), source, killer)
                end
            end
        end


        if getElementData(killer, 'cweapon') == 'faca' then
            if playerKills[source] > 1 then
                if config.gungame[playerKills[source]-1][1] == 'x' then
                    playerKills[source] = playerKills[source] - 2
                else
                    playerKills[source] = playerKills[source] - 1
                end
            else
                playerKills[source] = playerKills[source]
            end
            triggerClientEvent(source, "onPlayerKillUpdate", resourceRoot, playerKills[source], weaponRecent[source] )
        end
        
        if getElementData(killer, 'cweapon') == 'faca' then
            if playerKills[killer] >= 29 then
                local dimension = getElementDimension(killer)
                endMataMataForDimension(dimension)
            end
            
            if config.gungame[playerKills[killer]+1][1] == 'x' then
                playerKills[killer] = playerKills[killer] + 2
            else
                playerKills[killer] = playerKills[killer] + 1
            end
        else
            playerKills[killer] = playerKills[killer] + 1
        end
        triggerClientEvent(killer, "onPlayerKillUpdate", resourceRoot, playerKills[killer], weaponRecent[killer] )
        
        if config.gungame[(playerKills[killer] or 0)][1] ~= 'x' then
            exports['mg']:giveNewWeapon(killer, config.gungame[(playerKills[killer] or 0)][1], 9999)
            weaponRecent[killer] = config.gungame[(playerKills[killer] or 0)][1]
        end
        
        respawn(source)

        if playerKills[killer] == 30 then
            local dimension = getElementDimension(killer)
            endMataMataForDimension(dimension)
        end
    end
end
addEvent('newPosition', true)
addEventHandler('newPosition', root, newPosition)

function respawn(player)
    local v = config.teleports
    local randomPos = math.random(#v.positions) 
    local pos = v.positions[randomPos]
    setElementPosition(player, pos[1], pos[2], pos[3])
    
    setElementHealth(player, 100)
    setPedArmor(player, 100)
    takeAllWeapons(player)
    setElementAlpha(player, 200)
    setTimer(function(player, v)
        if isElement(player) then
            if getElementData(player, 'fn:matamata.runy') then 
                setElementAlpha(player, 255)
                if not playerKills[player] then
                    playerKills[player] = 0
                end
                if config.gungame[playerKills[player]][1] ~= 'x' then
                    exports['mg']:giveNewWeapon(player, config.gungame[playerKills[player]][1], 9999)
                    weaponRecent[player] = config.gungame[playerKills[player]][1]
                end
            end
        end
    end, 3000, 1, player, v)
end

function endMataMataForDimension(dimension)
    local winner = nil
    local maxKills = 0
    
    for _, player in ipairs(getElementsByType("player")) do
        if getElementDimension(player) == dimension and getElementData(player, 'fn:matamata.runy') then
            local kills = playerKills[player] or 0
            if kills > maxKills then
                maxKills = kills
                winner = getPlayerName(player)
            end
            setSpawnPlayer(player)
        end
    end
    if winner then
        triggerClientEvent(root, "Notify", root, winner .. " venceu o corrida armada!")
    end
    dimensionTimers[dimension] = nil
end