addEventHandler("onPlayerLogin", root,
    function(_, account)
        local playerName = getPlayerName(source)
        local playerID = getElementData(source, "ID") or 0
        local playerIP = getPlayerIP(source)
        local playerSerial = getPlayerSerial(source)
        local accountName = getAccountName(account)
        local date = getRealDateTime()

        local message = string.format(" Um player logou no servidor. **PLAYER** %s #%d | **IP**: %s - **SERIAL**: %s - **CONTA**: %s Data e hora: (%s).", playerName, playerID, playerIP, playerSerial, accountName, date)
        triggerEvent("RunyLogsDiscord3", root, root, message, 1)
    end
)

function onPlayerQuit()
    local playerName = getPlayerName(source)
    local playerID = getElementData(source, "ID") or 0
    local date = getRealDateTime()

    local message = string.format("RUNY - PLAYER %s #%d - saiu do servidor (%s).", playerName, playerID, date)
    triggerEvent("RunyLogsDiscord3", root, root, message, 1)
end
addEventHandler("onPlayerQuit", root, onPlayerQuit)

function getRealDateTime()
    local time = getRealTime()
    local year = time.year + 1900
    local month = time.month + 1
    local day = time.monthday
    local hour = time.hour
    local minute = time.minute
    local second = time.second

    return string.format("%04d-%02d-%02d %02d:%02d:%02d", year, month, day, hour, minute, second)
end

