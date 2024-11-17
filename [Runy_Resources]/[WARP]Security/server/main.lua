functions = functions or {}


local modules = {}







functions.isTriggerProtected = function(passedResource, originalResource, passedElement, originalElement)
    if (originalElement == passedElement) then
        return true
    end
    return false
end


function functions.alterData(theKey, oldValue)
   if client then 
      if getElementType(client) == "player" then
        for i, v in pairs(system.core.elements) do 
             if theKey == i then
                local newValue = getElementData(client, theKey) 
                setElementData(client, theKey, oldValue)
                if system.core.language['EN-US'] then 
                    sendDiscordMessage(system.core.logs['Avatar'], system.core.logs['UserName'], 'The player was punished for attempting to alter elementData (' ..theKey..') \n\nPlayer: '..system.core.utils['getPlayerName'](client)..'\n Serial: '..getPlayerSerial(client)..'', system.core.logs['WebHook'])
                    else
                    sendDiscordMessage(system.core.logs['Avatar'], system.core.logs['UserName'], '\n\nO Jogador foi punido pela tentativa de alteração do elementData (' ..theKey..')\n\nJogador: '..system.core.utils['getPlayerName'](client)..'\n Serial: '..getPlayerSerial(client)..'', system.core.logs['WebHook'])
                end
                   kickPlayer(client, '[AC]Module #2 detected elementData Change')
            end
         end
     end
  end
end

addEventHandler("onElementDataChange", getRootElement(), functions.alterData)





addEvent("Anti Cheat >> Painel GUI", true);
addEventHandler("Anti Cheat >> Painel GUI", resourceRoot, 
    function(element, cache)
        if (client ~= element) then
            return;
        end 
        takePlayerScreenShot(client, 1366, 768, "cameraphoto", 50)
        return;
    end
);



function functions.banCheater(reason, passedResource, originalResource, passedElement, originalElement)
    if functions.isTriggerProtected(passedResource, originalResource, passedElement, originalElement) then
        if system.core.bypass.getPermissions(client) then return end
        if client then
            if system.core.language['EN-US'] then 
            sendDiscordMessage(system.core.logs['Avatar'], system.core.logs['UserName'], 'The Player '..system.core.utils['getPlayerName'](client)..' \n\nThe player has been banned for using:\n (' ..reason..') \n\nPlayer: '..system.core.utils['getPlayerName'](client)..'\n Serial: '..getPlayerSerial(client)..'', system.core.logs['WebHook'])
            else
            sendDiscordMessage(system.core.logs['Avatar'], system.core.logs['UserName'], 'O Jogador '..system.core.utils['getPlayerName'](client)..' \n\nO Jogador foi punido pela utilização de:\n  (' ..reason..') \n\nJogador: '..system.core.utils['getPlayerName'](client)..'\n Serial: '..getPlayerSerial(client)..'', system.core.logs['WebHook'])
            end
            kickPlayer(client, reason)
        end
    end
end


addEvent(encryptEventName('onAnticheatDetect'), true)
addEventHandler(encryptEventName("onAnticheatDetect"), root, functions.banCheater)


local debugData = {}

addEventHandler("onDebugMessage", root, 
    function(message, level, file, line)
        if (level == 1) then
            if utf8.find(message, "triggered serverside event") then
                message = split(message, " ");

                local player = getPlayerFromName(message[2]:sub(2, -2));
                local eventName = message[6]:sub(1, -2);
                local count;

                if (debugData[player] and debugData[player].count) then
                    count = (debugData[player].count + 1);
                end

                if (isElement(player)) then
                    local playerName = getPlayerName(player);
                    local characterId = getPlayerSerial(player);

                    if (count and count > 100) then
                        setTimer(
                            function(thePlayer)
                                if (not isElement(thePlayer)) then
                                    return false
                                end
                                kickPlayer(player, '[AC]Detected Flood Events')
                                return;
                            end
                        , 5000, 1, player);
                    else
                        if (not debugData[player]) then
                            debugData[player] = {
                                count = 0;
                            };
                        end

                        debugData[player].count = (debugData[player].count + 1);

                        if isTimer(debugData[player].timer) then
                            killTimer(debugData[player].timer);
                        end

                        debugData[player].timer = setTimer(
                            function(player)
                                outputDebugString("[ANTI CHEAT] "..([[> **%s#%s** deu trigger no evento **%s** do servidor que não existe. %s]]):format(playerName, characterId, eventName, count and "x" .. count or ""));
                                debugData[player] = nil;
                            end
                        , 1000, 1, player);
                    end
                end
            end
        end
    end
);




addEvent(encryptEventName("Anti Cheat >> Fake weapon detected"), true);
addEventHandler(encryptEventName("Anti Cheat >> Fake weapon detected"), resourceRoot,
    function(element, weapon)
        local weaponExists = false;
        for k, v in ipairs(getPedWeapons(element)) do
            if (v == weapon) then
                weaponExists = true;
                break;
            end
        end
        if (not weaponExists) then
            if system.core.language['EN-US'] then 
                sendDiscordMessage(
                    system.core.logs['Avatar'],
                    system.core.logs['UserName'],
                    'The player has been banned for using fake weapons \n\nPlayer: ' .. system.core.utils.getPlayerName(element) .. '\n Serial: ' .. getPlayerSerial(element).. '\n ID from Player: #' ..system.core.utils['getPlayerID'](element),
                    system.core.logs['WebHook']
                )
            else 
                sendDiscordMessage(
                    system.core.logs['Avatar'],
                    system.core.logs['UserName'],
                    'O(A) Jogador(a) foi punido por utilização de Armas adquiridas com cheats \n\nJogador: ' .. system.core.utils.getPlayerName(element) .. '\n Serial: ' .. getPlayerSerial(element).. "\n ID Do Jogador: #" ..system.core.utils['getPlayerID'](element),
                    system.core.logs['WebHook']
                )
            end
            takePlayerScreenShot(element, 1366, 768, "cameraphoto", 100)
            setTimer(function()
               kickPlayer(element, '[AC]Module #17 detected (Fake Weapons Detected)')
            end, 10000, 1)
        end
    end
);


local db = dbConnect("sqlite", "core/database/manager.db")
if db then
    dbExec(db, [[
        CREATE TABLE IF NOT EXISTS players (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            ip TEXT,
            serial TEXT
        )
    ]])
end

addEventHandler("onPlayerJoin", root,
    function(playerNick, playerIP, playerUsername, playerSerial, playerVersion)
        local query = dbQuery(db, "SELECT serial FROM players WHERE ip = ?", playerIP)
        local result = dbPoll(query, -1)
        if result and #result > 0 then
            local storedSerial = result[1].serial
            if storedSerial ~= playerSerial then
                cancelEvent(true, "Spoofer detectado")
                return
            end
        else
            dbExec(db, "INSERT INTO players (ip, serial) VALUES (?, ?)", playerIP, playerSerial)
        end
    
    end
)

addEventHandler("onPlayerQuit", root,
    function()
        local playerIP = getPlayerIP(source)
        local playerSerial = getPlayerSerial(source)
    end
)



function isElementPlayer(element)
    if (element and isElement(element) and getElementType(element) == "player") then
        return true;
    end
    return false;
end

function getPedWeapons(element)
    local playerWeapons = {};
    if (isElementPlayer(element)) then
        for i = 2, 9 do
            local weapon = getPedWeapon(element, i);
            if (weapon and weapon ~= 0) then
                table.insert(playerWeapons, weapon);    
            end
        end
    end
	return playerWeapons;
end


addEventHandler("onPlayerScreenShot", root, function(res, sts, pixels, ttp, tag)

    local photo = base64Encode(pixels) 


    local sendOptions = {
        method = "POST", 
        headers = {
            ["Authorization"] = "Client-ID " .. system.core.screenShots['ClientID'], 
            ["Content-Type"] = "multipart/form-data"
        },
        formFields = {
            ["image"] = photo,
            ["type"] = "base64"
        }
    }

    fetchRemote("https://api.imgur.com/3/upload", sendOptions, function(response, info)
        if response then
            local callback = fromJSON(response)
            if callback and callback.success then
                local discordData = {
                    embeds = {
                        {
                            image = {
                                url = callback.data.link
                            }
                        }
                    }
                }
                local jsonData = toJSON(discordData)
                jsonData = string.sub(jsonData, 2, #jsonData - 1) 
                local options = {
                    method = "POST",
                    headers = {
                        ["Content-Type"] = "application/json"
                    },
                    postData = jsonData
                }

                fetchRemote(system.core.logs['WebHook'], options, function() end)
            else
            end
        else
            outputChatBox("")
        end
    end)
end)