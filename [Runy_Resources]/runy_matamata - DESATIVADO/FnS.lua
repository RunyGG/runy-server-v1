outputDebugString('[FN / PEDRO DEVELOPER] RESOURCE '..getResourceName(getThisResource())..' ATIVADA COM SUCESSO', 4, 189, 224, 28)

local matamataPlayers = {}
local dimensionTimers = {}
local playerKills = {}

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
        setTimer(function(player, v)
            if isElement(player) then 
                if getElementData(player, 'fn:matamata.runy') then 
                    setElementAlpha(player, 255)
                    exports['mg']:giveNewWeapon(player, 'm4', 9999, v.weapon)
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
    removeElementData(player, 'fn:matamata.timer')
    triggerClientEvent(player, "returnToLobbyClientEvent", player)
    takeAllWeapons(player)
    playerKills[player] = nil
end

addEventHandler('onResourceStart', getResourceRootElement(getThisResource()), 
    function()
        for _, player in ipairs(getElementsByType('player')) do 
            if getElementData(player, 'fn:matamata.runy') then 
                setSpawnPlayer(player) 
            end
        end
    end
)

addEventHandler('onResourceStop', getResourceRootElement(getThisResource()), 
    function()
        for _, player in ipairs(getElementsByType('player')) do 
            if getElementData(player, 'fn:matamata.runy') then 
                setSpawnPlayer(player)
            end
        end
    end
)

addEventHandler('onPlayerSpawn', root,
    function()
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
                        --giveWeapon(player, 31, 9999, true) 
                        exports['mg']:giveNewWeapon(player, 'm4', 9999, 31)

                    end

                end

            end, 5 * 1000, 1, source, v)

        end

    end
)

addEvent('onPlayerEnterInMataMata', true)
addEventHandler('onPlayerEnterInMataMata', root, setupMatamataPlayer)

addEvent('onPlayerExitMataMata', true)
addEventHandler('onPlayerExitMataMata', resourceRoot, setSpawnPlayer)

function segundosParaHora(seconds)
    local minutes = math.floor(seconds / 60)
    local seconds = seconds % 60
    return string.format("%02d:%02d", minutes, seconds)
end

addCommandHandler("sairmatamata",
    function(player)
        setSpawnPlayer(player)
    end
)

setTimer(function()
    updateMatamataPlayers()
end, 5000, 0)

setTimer(function()
    for dim, time in pairs(dimensionTimers) do
        if time > 0 then
            dimensionTimers[dim] = time - 1
            for _, player in ipairs(getElementsByType("player")) do
                if getElementDimension(player) == dim and getElementData(player, 'fn:matamata.runy') then
                    triggerClientEvent(player, 'onUpdateDimensionTimer', resourceRoot, dimensionTimers[dim])
                end
            end
        else
            for _, player in ipairs(getElementsByType("player")) do
                if getElementDimension(player) == dim and getElementData(player, 'fn:matamata.runy') then
                    setSpawnPlayer(player)
                    triggerClientEvent(player, "Notify", player, "Seu tempo no modo mata-mata acabou!")
                end
            end
            dimensionTimers[dim] = nil
        end
    end
end, 1000, 0)

addEventHandler("onPlayerWasted", root, function(totalAmmo, killer)
    if killer and getElementData(killer, 'fn:matamata.runy') then
        if not playerKills[killer] then
            playerKills[killer] = 0
        end
        playerKills[killer] = playerKills[killer] + 1
        triggerClientEvent(killer, "onPlayerKillUpdate", resourceRoot, playerKills[killer])
        
        if playerKills[killer] == 30 then
            local dimension = getElementDimension(killer)
            endMataMataForDimension(dimension)
        end
    end
end)

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
        triggerClientEvent(root, "Notify", root, winner .. " venceu o mata-mata!")
    end

    dimensionTimers[dimension] = nil
end

addEvent('onPlayerRequestWeapon', true)
addEventHandler('onPlayerRequestWeapon', resourceRoot, function(player, weaponId)
    takeAllWeapons(player)
    giveWeapon(player, weaponId, 9999, true)
end)