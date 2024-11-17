--[[function getSpectators(player)
    local spectators = {}
    for _, playerInGame in ipairs(getElementsByType("player")) do
        local target = getElementData(playerInGame, "spectatingPlayer")
        iprint(target)
        if target == player then
            table.insert(spectators, playerInGame)
        end
    end
    iprint(spectators)
    return spectators
end ]]

function spawnPlayerTo(player,x,y,z,rot,skin,frozen)
	spawnPlayer(player,x,y,z,rot,skin,0);
	setElementFrozen(player,frozen);
end

addEvent("onPlayerSpectateStop", true)
addEventHandler("onPlayerSpectateStop", root, function(player)
    setElementAlpha(player, 255)
    toggleAllControls(player, true)
    setElementData(player, "spectatingPlayer", nil)
    if (isPedHeadless(player)) then
        setPedHeadless(player, false)
    end
    local playerID = tonumber(getElementData(player, "ID")) or 0
    if playerID then 
        setElementDimension(player, playerID)
    end
    setElementPosition(player, 1214.37170, -1678.34485, 34.80469)
    showCursor ( player, false ) 
end)