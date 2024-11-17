function onPlayerDeath(totalAmmo, killer, killerWeapon, bodypart, stealth)
    local playerDuo = getElementData(source, 'myDuo')
    if (isElement(playerDuo)) then 
        if not getElementData(playerDuo, 'spectatingPlayer') then
            triggerEvent('ChangeBliped', playerDuo, playerDuo, 'detach')
            triggerEvent('ChangeBliped', playerDuo, playerDuo, 'change', 22)
            killer = playerDuo
            setTimer(function(player)
                if (isElement(player)) then 
                    if (isPedDead(player)) then
                        spawnPlayerTo(player,0,0,0,0,getElementModel(player),true,false)
                    end
                end
            end, 200, 1, source)
            showCursor ( source, true )  
            setElementAlpha(source, 0)
            toggleAllControls(source, false, true, false)
            local dimensionKiller = getElementDimension(killer)
            setElementDimension(source, dimensionKiller)
            setElementData(source, "telando", true)
            removeElementData(source, "battleRoyaleRunning")
            removeElementData(source, "runyInPareamento")
            triggerClientEvent(source, "onPlayerSpectate", resourceRoot, killer)
            local spectators = getSpectators(source)
            for _, spectator in ipairs(spectators) do
                local dimensionKiller = getElementDimension(killer)
                setElementDimension(spectator, dimensionKiller)
                triggerClientEvent(spectator, "onPlayerSpectate", resourceRoot, killer)
            end
        else
            local killer = (killer and killer or getRandomPlayer())
            setTimer(function(player)
                if (isElement(player)) then 
                    if (isPedDead(player)) then
                        spawnPlayerTo(player,0,0,0,0,getElementModel(player),true,false)
                    end
                end
            end, 200, 1, source)
            showCursor ( source, true )  
            setElementAlpha(source, 0)
            toggleAllControls(source, false, true, false)
            local dimensionKiller = getElementDimension(killer)
            setElementDimension(source, dimensionKiller)
            removeElementData(source, "battleRoyaleRunning")
            setElementData(source, "telando", true)
            removeElementData(source, "runyInPareamento")
            triggerClientEvent(source, "onPlayerSpectate", resourceRoot, killer)
            local spectators = getSpectators(source)
            for _, spectator in ipairs(spectators) do
                local dimensionKiller = getElementDimension(killer)
                setElementDimension(spectator, dimensionKiller)
                triggerClientEvent(spectator, "onPlayerSpectate", resourceRoot, killer)
            end
        end
    end
    
    if (getElementData(source, 'teleport.pvp')) or (getElementData(source, 'fn:matamata.runy')) then 
        spawnPlayerTo(source,0,0,0,0,getElementModel(source),false,false)
        setTimer(function(player)
            if (isElement(player)) then 
                setPedHeadless(player, false)
            end
        end, 500, 1, source)
        return 
    end 
    
    if killer and killer ~= source then
        setTimer(function(player)
            if (isElement(player)) then 
                if (isPedDead(player)) then
                    spawnPlayerTo(player,0,0,0,0,getElementModel(player),true,false)
                end
            end
        end, 200, 1, source)
        showCursor ( source, true )  
        setElementAlpha(source, 0)
        toggleAllControls(source, false, true, false)
        local dimensionKiller = getElementDimension(killer)
        setElementDimension(source, dimensionKiller)
        setElementData(source, "telando", true)
        removeElementData(source, "battleRoyaleRunning")
        removeElementData(source, "runyInPareamento")
        triggerClientEvent(source, "onPlayerSpectate", resourceRoot, killer)
        local spectators = getSpectators(source)
        for _, spectator in ipairs(spectators) do
            local dimensionKiller = getElementDimension(killer)
            setElementDimension(spectator, dimensionKiller)
            triggerClientEvent(spectator, "onPlayerSpectate", resourceRoot, killer)
        end
    else 
        killer = getRandomPlayer()
        local players = 0 
        for i, v in ipairs(getElementsByType('player')) do 
            if (getElementDimension(v) == getElementDimension(source)) then 
                players = players + 1
            end
        end
        if (players >= 2) then 
            while (killer == source or getElementDimension(killer) ~= getElementDimension(source)) do 
                killer = getRandomPlayer()
                setElementDimension(source, getElementDimension(killer))
            end
        else
            killer = source
        end
        setElementData(source, "telando", true)
        removeElementData(source, "battleRoyaleRunning")
        setTimer(function(player)
            if (isElement(player)) then 
                if (isPedDead(player)) then
                    spawnPlayerTo(player,0,0,0,0,getElementModel(player),true,false)
                end
                --setElementPosition(player, 2233.511, -1116.939, 1050.883)
            end
        end, 200, 1, source)
        showCursor ( source, true )  
        setElementAlpha(source, 0)
        toggleAllControls(source, false, true, false)
        local dimensionKiller = getElementDimension(killer)
        setElementDimension(source, dimensionKiller)
        triggerClientEvent(source, "onPlayerSpectate", resourceRoot, killer)
        local spectators = getSpectators(source)
        for _, spectator in ipairs(spectators) do
            local dimensionKiller = getElementDimension(killer)
            setElementDimension(spectator, dimensionKiller)
            triggerClientEvent(spectator, "onPlayerSpectate", resourceRoot, killer)
        end
    end
end
addEventHandler("onPlayerWasted", root, onPlayerDeath)

function getSpectators(player)
    local spectators = {}
    for _, playerInGame in ipairs(getElementsByType("player")) do
        local target = getElementData(playerInGame, "spectatingPlayer")
        if target == player then
            table.insert(spectators, playerInGame)
        end
    end
    return spectators
end

function spawnPlayerTo(player,x,y,z,rot,skin,frozen)
    spawnPlayer(player,x,y,z,rot,skin,getElementInterior(player), getElementDimension(player))
    setElementFrozen(player,frozen)
end

addEvent("onPlayerSpectateStop", true)
addEventHandler("onPlayerSpectateStop", root, function(player)
    triggerClientEvent(player, 'onClientShowDerrota', player)
    setElementAlpha(player, 255)
    toggleAllControls(player, true)
    removeElementData(player, "telando")
    setElementData(player, "spectatingPlayer", nil)
    if (isPedHeadless(player)) then
        setPedHeadless(player, false)
    end
    setElementPosition(player, 1537, -1351.8, 329.462)
    showCursor(player, false )
end)


addEvent("like", true)
addEventHandler("like", root, function(player, like)
    local likes = getElementData(player, 'likes') or 0
    local likepartida = getElementData(player, 'likespartida') or 0
    setElementData(player, 'likes', likes+like)
    setElementData(player, 'likespartida', likepartida+like)
end)