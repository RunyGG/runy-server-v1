addEventHandler("onResourceStart", resourceRoot, 
function (nameResource)
    if ( config["Connection"]["connectionType"] == "MySQL" ) then
        db = dbConnect("mysql", "dbname="..config["Connection"]["dbName"].."; host="..config["Connection"]["hostMySQL"], config["Connection"]["dbUser"], config["Connection"]["dbPassword"], "autoreconnect=1")
        if ( db ) then
            dbExec(db, "create table if not exists Data( account_player TEXT, id_player INTEGER, serial_player TEXT )")
            outputDebugString("SUCCESS: Database ( "..getResourceName(nameResource).." ) conectada com sucesso ao servidor!", 4, 0, 128, 0)
        else
            outputDebugString("ERROR: Database ( "..getResourceName(nameResource).." ) falhou ao conectar com o servidor!", 4, 255, 0, 0)
        end
    elseif ( config["Connection"]["connectionType"] == "SQLite" ) then
        db = dbConnect("sqlite", config["Connection"]["directorySQLite"].."database.db")
        if ( db ) then
            dbExec(db, "create table if not exists Data( account_player TEXT, id_player INTEGER, serial_player TEXT )")
            outputDebugString("SUCCESS: Database ( "..getResourceName(nameResource).." ) conectada com sucesso ao servidor!", 4, 0, 128, 0)
        else
            outputDebugString("ERROR: Database ( "..getResourceName(nameResource).." ) falhou ao conectar com o servidor!", 4, 255, 0, 0)
        end
    end
    for i, v in ipairs(getElementsByType("player")) do
        refreshId(v)
    end
end)

addCommandHandler(config["Definitions"]["changeID"], function (player, _, playerID, id)
    if ( player and isElement(player) and getElementType(player) == "player" ) then
        if ( playerID and id ) then
            local id = tonumber(id)
            local playerID = tonumber(playerID)
            if ( playerID and id ) then
                local idPlayer = getPlayerID(playerID)
                if ( idPlayer ) then
                    local pesquisa = dbPoll(dbQuery(db, "select * from Data where account_player = ?", getAccountName(getPlayerAccount(idPlayer))), -1)
                    if ( #pesquisa ~= 0 ) then
                        dbExec(db, "update Data set id_player = ? where account_player = ?", id, getAccountName(getPlayerAccount(idPlayer)))
                        removeElementData(idPlayer, config["Definitions"]["elementID"])
                        setElementData(idPlayer, config["Definitions"]["elementID"], id)
                        message(player, "info", "Você alterou o id jogador ( "..getPlayerName(idPlayer).." ) com sucesso!")
                        message(idPlayer, "info", "O staff ( "..getPlayerName(player).." ) alterou seu id para ( "..id.." ) com sucesso!")
                    else
                        message(player, "error", "Este jogador não existe!")
                    end
                else
                    message(player, "error", "Este jogador esta offline!")
                end
            else
                message(player, "error", "Digite um id valido!")
            end
        else
            message(player, "error", "Tente /"..config["Definitions"]["changeID"].." [PLAYERID] [ID]")
        end
    end
end)

addEventHandler("onPlayerLogin", getRootElement(), function ()
    refreshId(source)
end)

refreshId = function(player)
    if ( player and isElement(player) and getElementType(player) == "player" ) then
        local pesquisa = dbPoll(dbQuery(db, "select * from Data where account_player = ?", getAccountName(getPlayerAccount(player))), -1)
        if ( #pesquisa == 0 ) then
            local id = getAccountID(getPlayerAccount(player)) + config["Definitions"]["startID"]
            dbExec(db, "insert into Data values (?, ?, ?)", getAccountName(getPlayerAccount(player)), id, getPlayerSerial(player))
            setElementData(player, config["Definitions"]["elementID"], id)
        else
            local id = pesquisa[1]["id_player"]
            setElementData(player, config["Definitions"]["elementID"], id)
        end
    end
end