
config = {

    ["Connection"] = {

        ["connectionType"] = "SQLite";
        ["directorySQLite"] = "assets/database/";
        ["hostMySQL"] = "127.0.0.1";
        ["dbName"] = "runygg";
        ["dbUser"] = "root";
        ["dbPassword"] = "";

    };

    ["Definitions"] = {

        ["changeID"] = "setid"; -- Comando para mudar o id de uma pessoa!
        ["startID"] = 1000; -- Id que vai começar a contagem
        ["elementID"] = "ID"; -- ElementData do ID

    };

};

message = function (element, type, msg)
    --exports["srp~notify"]:addBox(element, type, msg)
end

_getPlayerName = getPlayerName
function getPlayerName (player)
    if (not isElement (player)) then
        return false
    end
    return string.gsub (_getPlayerName (player), '#%x%x%x%x%x%x', '');
end

getPlayerID = function(id)
    if ( tonumber(id) ) then
        player = false
        for i, v in ipairs(getElementsByType("player")) do
            if ( getElementData(v, config["Definitions"]["elementID"]) == id ) then
                player = v
                break
            end
        end
        return player
    end
end