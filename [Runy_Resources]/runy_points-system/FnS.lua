local db = dbConnect("sqlite", "player_ranks.db")

dbExec(db, [[
    CREATE TABLE IF NOT EXISTS player_ranks (
        account TEXT PRIMARY KEY,
        playerName TEXT DEFAULT 'Unknown',
        playerID INTEGER DEFAULT 0,
        vitorias INTEGER DEFAULT 0,
        pontos INTEGER DEFAULT 0,
        kills INTEGER DEFAULT 0,
        death INTEGER DEFAULT 0
    );
]])

dbExec(db, [[
    CREATE TABLE IF NOT EXISTS accounts (
        username TEXT PRIMARY KEY,
        vitorias INTEGER DEFAULT 0,
        pontos INTEGER DEFAULT 0,
        kills INTEGER DEFAULT 0,
        death INTEGER DEFAULT 0
    );
]])

PEDRank = {}

function loadPlayerRankData(player)
    local account = getPlayerAccount(player)
    if not account then return end
    
    local query = dbQuery(db, "SELECT vitorias, pontos, kills, death FROM player_ranks WHERE account = ?", getAccountName(account))
    local result = dbPoll(query, -1)
    if result and #result > 0 then
        local wins = result[1]["vitorias"]
        local pontos = result[1]["pontos"]
        local rkills = result[1]["kills"]
        local rdeath = result[1]["death"]
        setElementData(player, "vitorias", wins)
        setElementData(player, "pontos", pontos)
        setElementData(player, "rankedkills", rkills)
        setElementData(player, "rankeddeath", rdeath)
    else
        setElementData(player, "patente", "bronze4")
        setElementData(player, "pontos", 1)
        setElementData(player, "rankedkills", 1)
        setElementData(player, "rankeddeath", 1)
        savePlayerRankData(player)
    end
end

function savePlayerRankData(player)
    local account = getPlayerAccount(player)
    if not account then return end
    
    local playerName = getPlayerName(player)
    local playerID = getElementData(player, "ID") or 0
    local wins = getElementData(player, "vitorias") or 0
    local pontos = getElementData(player, "pontos") or 1
    local rkills = getElementData(player, "rankedkills") or 0
    local rdeath = getElementData(player, "rankeddeath") or 0
    
    dbExec(db, "REPLACE INTO player_ranks (account, playerName, playerID, vitorias, pontos, kills, death) VALUES (?, ?, ?, ?, ?, ?, ?)", getAccountName(account), playerName, playerID, wins, pontos, rkills, rdeath)
    dbExec(db, "REPLACE INTO accounts (username, vitorias, pontos, kills, death) VALUES (?, ?, ?, ?, ?)", getAccountName(account), wins, pontos, rkills, rdeath)
end

addEventHandler("onPlayerLogin", root, function()
    loadPlayerRankData(source)
end)

addEventHandler("onPlayerLogout", root, function()
    savePlayerRankData(source)
end)

function addPlayerPoints(player, points)
    local currentPoints = getElementData(player, "pontos") or 1
    local newPoints = currentPoints + points
    setElementData(player, "pontos", newPoints)
    local newRank = getLevelToPoints(newPoints)
    if newRank then
        setElementData(player, "patente", newRank)
        if newRank == 'platina4' then
            triggerEvent("NZ > updateMission", player, player, "platina", 1)
        elseif newRank == 'diamante4' then
            triggerEvent("NZ > updateMission", player, player, "diamante", 1)
            exports['runy_roupas-inventario']:giveItem(player, 'diamantes1', 'corpo')
        elseif newRank == 'mestre' then
            triggerEvent("NZ > updateMission", player, player, "mestre", 1)
            exports['runy_roupas-inventario']:giveItem(player, 'mestres1', 'corpo')
        elseif newRank == 'lenda' then
            exports['runy_roupas-inventario']:giveItem(player, 'lendas1', 'corpo')
        elseif newRank == 'global' then
            exports['runy_roupas-inventario']:giveItem(player, 'globals1', 'corpo')
        end
    end
    savePlayerRankData(player)
end

function removePlayerPoints(player, points)
    local currentPoints = getElementData(player, "pontos") or 1
    local newPoints = math.max(currentPoints - points, 0)
    setElementData(player, "pontos", newPoints)
    local newRank = getLevelToPoints(newPoints)
    if newRank then
        setElementData(player, "patente", newRank)
    end
    savePlayerRankData(player)
end

function getPlayerRankPosition(accountName)
    local query = dbQuery(db, "SELECT account, ROW_NUMBER() OVER (ORDER BY pontos DESC) as position FROM player_ranks")
    local result = dbPoll(query, -1)
    if result and #result > 0 then
        for _, data in ipairs(result) do
            if data["account"] == accountName then
                return data["position"]
            end
        end
    end
    return '999'
end

addEvent("requestPlayerPosition", true)
addEventHandler("requestPlayerPosition", root, function(player)
    local account = getPlayerAccount(player)
    if not account then return end
    
    local accountName = getAccountName(account)
    local position = getPlayerRankPosition(accountName)
    triggerClientEvent(player, "receivePlayerPosition", player, position)
end)

addEvent("updatePlayerPoints", true)
addEventHandler("updatePlayerPoints", resourceRoot, function(player, points)
    addPlayerPoints(player, points)
end)

addEvent("removePlayerPoints", true)
addEventHandler("removePlayerPoints", resourceRoot, function(player, points)
    removePlayerPoints(player, points)
end)

addEvent("addPoints", true)
addEventHandler("addPoints", root, addPlayerPoints)

addEvent("removePoints", true)
addEventHandler("removePoints", root, removePlayerPoints)

local topPlayers = {}

function updateTopPlayers()
    local result = dbPoll(dbQuery(db, "SELECT account, playerName, playerID, vitorias, pontos, kills, death FROM player_ranks WHERE playerID <> 1 ORDER BY pontos DESC LIMIT 10"), -1)
    if result and #result > 0 then
        topPlayers = {}
        for i, data in ipairs(result) do
            local accountName = data["account"]
            local playerName = data["playerName"]
            local playerID = tonumber(data["playerID"])
            local wins = data["vitorias"]
            local pontos = tonumber(data["pontos"])
            local kills = tonumber(data["kills"])
            local death = tonumber(data["death"])
            local patente = getLevelToPoints(pontos)
            table.insert(topPlayers, {name = playerName, points = (pontos > 0 and pontos or 1), rank = patente, id = playerID, vitorias = wins, Rkills = kills, Rdeath = death})
            -- if i < 4 then
            --     if PEDRank[i] then
            --         destroyElement(PEDRank[i])
            --         PEDRank[i] = nil
            --     end
            --     local posi = positionsRank[i]
            --     PEDRank[i] = createPed( 1, posi[1], posi[2], posi[3], 0)
            --     setElementFrozen(PEDRank[i], true )
            --     --setElementDimension( PEDRank[i], 0)
            --     --local acc = getAccountByID(playerID)
            --     if accountName then
            --         --local playerSkin = (acc and getAccountData(acc, "funmodev2-skin") or 1)
            --         --setElementModel(PEDRank[i], playerSkin)
            --         setElementData(PEDRank[i], 'dataRank', {acc = accountName, name = playerName, points = pontos, id = playerID})
            --         --if playerSkin == 1 or playerSkin == 10 then
            --         --    exports['customcharacter']:UpdatePedClothes(PEDRank[i], accountName)
            --         --end
            --     end
            -- end
        end
        triggerClientEvent(root, "updateTopPlayers", resourceRoot, topPlayers)
    end    
end
setTimer(updateTopPlayers, 35000, 0)

function getPlayerInfoFromAccount(accountName)
    local playerName = "Unknown"
    local playerID = 0
    for _, player in ipairs(getElementsByType("player")) do
        if getPlayerAccount(player) and getAccountName(getPlayerAccount(player)) == accountName then
            playerName = getPlayerName(player)
            playerID = getElementData(player, "ID") or 0
            break
        end
    end
    return playerName, playerID
end

addEvent("requestTopPlayers", true)
addEventHandler("requestTopPlayers", root, function()
    updateTopPlayers()
end)

addEvent("NegoZ:ElementWin", true)
addEventHandler("NegoZ:ElementWin", root, function(player)
    local wins = getElementData(player, "vitorias") or 0
    setElementData(player, "vitorias", wins + 1)
    savePlayerRankData(player)
end)

--function addPlayerPointsCommand(player, command, targetPlayerName, points)
--    if not targetPlayerName or not points then
--        outputChatBox("Uso: /addpoints <nome_do_jogador> <pontos>", player, 255, 0, 0)
--        return
--    end
--    
--    local targetPlayer = getPlayerFromName(targetPlayerName)
--    if not targetPlayer then
--        outputChatBox("Jogador não encontrado.", player, 255, 0, 0)
--        return
--    end
--    addPlayerPoints(targetPlayer, tonumber(points))
--    outputChatBox("Pontos adicionados para " .. targetPlayerName .. ".", player, 0, 255, 0)
--end
--addCommandHandler("addpoints", addPlayerPointsCommand)
--
--function removePlayerPointsCommand(player, command, targetPlayerName, points)
--    if not targetPlayerName or not points then
--        outputChatBox("Uso: /removepoints <nome_do_jogador> <pontos>", player, 255, 0, 0)
--        return
--    end
--    
--    local targetPlayer = getPlayerFromName(targetPlayerName)
--    if not targetPlayer then
--        outputChatBox("Jogador não encontrado.", player, 255, 0, 0)
--        return
--    end
--    
--    removePlayerPoints(targetPlayer, tonumber(points))
--    outputChatBox("Pontos removidos de " .. targetPlayerName .. ".", player, 0, 255, 0)
--end
--addCommandHandler("removepoints", removePlayerPointsCommand)