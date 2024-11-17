function onDeathHandler(_, killer)
    local deadPlayerName = getPlayerName(source)
    local deadPlayerID = getElementData(source, "ID") or "N/A"
    local deathDimension = getElementDimension(source)

    if killer and getElementType(killer) == "player" then
        local killerName = getPlayerName(killer)
        local killerID = getElementData(killer, "ID") or "N/A"
        local killerDimension = getElementDimension(killer)

        if killerDimension == deathDimension then
            for _, player in ipairs(getElementsByType("player")) do
                if getElementDimension(player) == deathDimension then
                    triggerClientEvent(player, "displayKillFeed", player, killerName, killerID, deadPlayerName, deadPlayerID, source, killer)
                end
            end
        end
    else
        for _, player in ipairs(getElementsByType("player")) do
            if getElementDimension(player) == deathDimension then
                triggerClientEvent(player, "displayDeathFeed", player, deadPlayerName, deadPlayerID)
            end
        end
    end
end
addEventHandler("onPlayerWasted", root, onDeathHandler)

addEvent('fn:reloadinfos',true)
addEventHandler('fn:reloadinfos', root, function(wasted, killer) 

    if not (isElement(wasted)) then 

        return 
        
    end

    if not (isElement(killer)) then 

        return 
        
    end

    local killerGroup = "N/A"
    local victimGroup = "N/A"

    if type(config) == "table" then
        for i, v in pairs(config) do 
            
            if isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(killer)), aclGetGroup(v)) then

                killerGroup = v

            end

            if isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(wasted)), aclGetGroup(v)) then

                victimGroup = v

            end

        end
    end

    local playerName = isElement(player) and getAccountName(account) or "N/A"
    triggerClientEvent(root, "updateKillFeedGroups", resourceRoot, killerGroup, victimGroup)
end)