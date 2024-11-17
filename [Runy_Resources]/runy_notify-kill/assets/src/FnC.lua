local killMessages = {}
local fadeDuration = 1000
local displayDuration = 2000

function drawKillMessages()
    for i, msg in ipairs(killMessages) do
        local yPosition = 650 - (i - 1) * 38
        dxDrawImage(595, yPosition, 179, 31, "assets/imgs/bg_dead.png", 0, 0, 0, tocolor(255, 255, 255, msg.alpha))
        dxDrawText(msg.name .. " #" .. msg.id, 644, yPosition + 8, 90, 15, tocolor(255, 255, 255, msg.alpha), 1, "default-bold")
    end
end

function showKillNotification(name, id)
    local newMsg = { name = name, id = id, alpha = 0 }
    table.insert(killMessages, newMsg)

    local fadeInTime = fadeDuration / 2
    local fadeOutTime = fadeDuration / 2

    setTimer(function()
        if newMsg.alpha < 255 then
            newMsg.alpha = newMsg.alpha + 255 / (fadeInTime / 10)
            if newMsg.alpha > 255 then newMsg.alpha = 255 end
        end
    end, 10, fadeInTime / 10)

    setTimer(function()
        setTimer(function()
            if newMsg.alpha > 0 then
                newMsg.alpha = newMsg.alpha - 255 / (fadeOutTime / 10)
                if newMsg.alpha < 0 then newMsg.alpha = 0 end
            end
        end, 10, fadeOutTime / 10)
    end, displayDuration + fadeInTime, 0)

    setTimer(function()
        for j, msg in ipairs(killMessages) do
            if msg == newMsg then
                table.remove(killMessages, j)
                break
            end
        end
    end, displayDuration + fadeInTime + fadeOutTime, 1)
end

addEvent("onPlayerKill", true)
addEventHandler("onPlayerKill", root, function(killerName, killerID)
    showKillNotification(killerName, killerID)
end)

addEventHandler("onClientRender", root, drawKillMessages)