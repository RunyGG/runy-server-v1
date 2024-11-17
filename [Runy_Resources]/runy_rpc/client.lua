local application = {}
local modo

function updateRichPresence()
    local playerName = getPlayerName(localPlayer)
    local playerID = getElementData(localPlayer, 'ID') -- Supondo que 'ID' seja o elemento data que guarda o ID do jogador
    
    local playerInfo = playerName .. " (ID: " .. tostring(playerID) .. ")"

    setDiscordRichPresenceDetails(playerInfo)
    setDiscordRichPresenceState(modo)
end

function timerModo()
    modo = getElementData(localPlayer, 'modo') or 'Conectando...'
    updateRichPresence()
end
setTimer(timerModo, 1000, 0)

function setDiscordRichPresence()
    resetDiscordRichPresenceData()
    local connected = setDiscordApplicationID(application.IDapplication)
    if connected then
        setDiscordRichPresenceAsset(application.logo, application.name)
        setTimer(updateRichPresence, 1000, 0)
    end
end

addEvent('richPresence', true)
addEventHandler('richPresence', root, function(data)
    application = data
    setDiscordRichPresence()
end)

addEventHandler('onClientResourceStart', resourceRoot, function()
    setElementData(localPlayer, 'modo', 'Lobby')
end)
