local playerStats = {}

local lastDamageKiller = {}

function resetPlayerStats(player)
    if playerStats[player] then
        playerStats[player].kills = 0
        playerStats[player].assists = 0
        triggerClientEvent(player, "updatePlayerKills", player, playerStats[player].kills)
    end
end
addEvent("resetPlayerStats", true)
addEventHandler("resetPlayerStats", resourceRoot, resetPlayerStats)

addEventHandler("onPlayerJoin", root, function()
    playerStats[source] = {kills = 0, assists = 0}
end)

function getPlayersStats(dimension)

    local scores = {}
    for i, v in ipairs(getElementsByType('player')) do 

        if (getElementDimension(v) == tonumber(dimension)) then 

            if not (playerStats[v]) then

                playerStats[v] = {kills = 0, assists = 0}

            end

            table.insert(scores, 

                {
                    
                    name = getPlayerName(v)..'#6B6B6B('..(getElementData(v, 'ID') or '???')..')';
                    kills = playerStats[v].kills;
                    assists = playerStats[v].assists;

                }

            )

        end

    end

    table.sort(scores, 

        function(a, b)

            if (a.kills > b.kills) then 
                
                return true 

            end

        end

    )

    return scores

end

function addKill(player)
    if player and isElement(player) and getElementType(player) == "player" and playerStats[player] then
        if getElementData(player, "teleport.pvp") then
            return
        end
        
        playerStats[player].kills = playerStats[player].kills + 1
        triggerClientEvent(player, "updatePlayerKills", player, playerStats[player].kills)
    end
end


function addAssist(player)
    if player and isElement(player) and getElementType(player) == "player" and playerStats[player] then
        playerStats[player].assists = playerStats[player].assists + 1
    end
end

local recentDamage = {}

addEventHandler("onPlayerJoin", root, function()
    recentDamage[source] = {}
end)

addEventHandler("onPlayerWasted", root, function(_, killer)
    if killer and isElement(killer) and getElementType(killer) == "player" then

        if not getElementData(killer, "teleport.pvp") then
            addKill(killer)
        end
        
        recentDamage[source] = {}

    else 

        local killer = lastDamageKiller[source]
        if (isElement(killer)) then 

            if not getElementData(killer, "teleport.pvp") then
                addKill(killer)
            end
            
            recentDamage[source] = {}

        end

    end

    if playerStats[source] then
        local assistsBeforeDeath = playerStats[source].assists
        playerStats[source].kills = 0
        playerStats[source].assists = 0
        triggerClientEvent(source, "updatePlayerKills", source, playerStats[source].kills)

        playerStats[source].assists = assistsBeforeDeath
    end
end)

addEventHandler("onPlayerKill", root, function(killer, weapon, bodypart)
    if killer and isElement(killer) and getElementType(killer) == "player" and source ~= killer then
        if not getElementData(killer, "teleport.pvp") then
            addKill(killer)
        end
        addAssist(source)
    end
end)

addEventHandler("onPlayerDamage", root, function(attacker)
    if attacker and isElement(attacker) and getElementType(attacker) == "player" then


        lastDamageKiller[source] = attacker

        if not recentDamage[source] then
            recentDamage[source] = {}
        end
        recentDamage[source][attacker] = getTickCount()
    end
end)

function showPlayerStats(player)
    if player and isElement(player) and getElementType(player) == "player" and playerStats[player] then
        return playerStats[player].kills, playerStats[player].assists
    end
    return 0, 0
end