local screenW, screenH = guiGetScreenSize()
local sW, sH = (screenW / 1366), (screenH / 768)
local feedMessages = {}
local backgroundSakura = dxCreateTexture("files/bgsakura.png")
local backgroundTexture = dxCreateTexture("files/bg1.png")
local backgroundTexture2 = dxCreateTexture("files/bg2.png")

local FADE_IN_DURATION = 1000
local DISPLAY_DURATION = 5000
local FADE_OUT_DURATION = 1000
local MESSAGE_SPACINGFundo = sH * 40
local MESSAGE_SPACING = sH * 80
local KILLER_TEXT_Y_OFFSET = sH * 176
local VICTIM_TEXT_Y_OFFSET = sH * 176
local FONT_SIZE = sH * 1.0

local MAX_MESSAGES = math.floor(screenH / MESSAGE_SPACING) - 1

function addKillFeedMessage(killerName, killerID, deadName, deadID, killerElement)
    local px, py, pz = getElementPosition(localPlayer)
    local killerGroup = "N/A"
    
    if killerElement and isElement(killerElement) then
        killerGroup = getElementData(killerElement, "fn:killerGroup") or "N/A"
    end

    local message = {
        killerName = killerName,
        killerID = killerID,
        deadName = deadName,
        deadID = deadID,
        killerElement = killerElement,
        timestamp = getTickCount(),
        fontSize = FONT_SIZE,
        victim = localPlayer,
        killerGroup = killerGroup,
        victimGroup = getElementData(localPlayer, "fn:victimGroup") or "N/A",
    }
    table.insert(feedMessages, message)
    
    while #feedMessages > MAX_MESSAGES do
        table.remove(feedMessages, 1)
    end
end

addEvent("addKillLOG", true)
addEventHandler("addKillLOG", root, addKillFeedMessage)

addEvent("displayKillFeed", true)
addEventHandler("displayKillFeed", root, function(killerName, killerID, deadName, deadID, sourceElement, killerElement)
    addKillFeedMessage(killerName, killerID, deadName, deadID, killerElement)
    triggerServerEvent("fn:reloadinfos", localPlayer, sourceElement, killerElement)
    nextMessageY = sH * 166
end)

addEvent("displayDeathFeed", true)
addEventHandler("displayDeathFeed", root, 
function(deadName, deadID)
    addKillFeedMessage(nil, nil, deadName, deadID, nil)
end)

function calculateTextY(index)
    local baseY = sH * 10
    return baseY + (index - 1) * MESSAGE_SPACING
end

function calculateKillerTextY(messageY)
    return messageY + KILLER_TEXT_Y_OFFSET
end

function calculateVictimTextY(messageY)
    return messageY + VICTIM_TEXT_Y_OFFSET
end

function changeFontSize(delta)
    FONT_SIZE = math.max(sH * 0.5, math.min(sH * 2, FONT_SIZE + delta))
    for _, message in ipairs(feedMessages) do
        message.fontSize = FONT_SIZE
    end
end

function increaseFontSize()
    changeFontSize(sH * 0.1)
end

function decreaseFontSize()
    changeFontSize(-sH * 0.1)
end

bindKey("num_add", "down", increaseFontSize)
bindKey("num_sub", "down", decreaseFontSize)

addEventHandler("onClientPlayerWasted", localPlayer, function()
    triggerServerEvent("fn:reloadinfos", localPlayer, localPlayer)
    local currentTime = getTickCount()
    local nextFundoY = sH * 117.8
    local nextMessageY = sH * 176

    for index, message in ipairs(feedMessages) do
        local elapsedTime = currentTime - message.timestamp
        local alpha = 255

        if elapsedTime < FADE_IN_DURATION then
            alpha = math.floor(255 * (elapsedTime / FADE_IN_DURATION))
        elseif elapsedTime > FADE_IN_DURATION + DISPLAY_DURATION then
            local fadeOutElapsed = elapsedTime - (FADE_IN_DURATION + DISPLAY_DURATION)
            if fadeOutElapsed < FADE_OUT_DURATION then
                alpha = math.floor(255 * (1 - (fadeOutElapsed / FADE_OUT_DURATION)))
            else
                table.remove(feedMessages, index)
            end
        end

        local killerTextY = calculateKillerTextY(nextMessageY)
        local victimTextY = calculateVictimTextY(nextMessageY)

        if message.killerName and message.killerID then
            local offsetY = sH * 887
            local killerTextY = calculateKillerTextY(nextMessageY - offsetY)
            local victimTextY = calculateVictimTextY(nextMessageY - offsetY)

            local killerText = message.killerName .. " #6D28D9#" .. message.killerID
            local victimText = message.deadName .. " #6D28D9#" .. message.deadID

            local background = (message.killerElement and message.killerElement:getData('killfeed') == 'sakura') and backgroundSakura or backgroundTexture
            dxDrawImage(sW * 1006, nextFundoY - sH * 16, sW * 326, sH * 31, background, 0, 0, 0, tocolor(255, 255, 255, alpha))

            dxDrawText(killerText, sW * 1051, killerTextY, screenW, screenH, tocolor(255, 255, 255, alpha), message.fontSize, "default-bold", "left", "center", false, false, false, true, false)
            dxDrawText(victimText, sW * 1225, victimTextY, screenW, screenH, tocolor(255, 255, 255, alpha), message.fontSize, "default-bold", "left", "center", false, false, false, true, false)

            dxDrawText(string.upper(message.killerGroup), sW * 1016, nextMessageY + sH * 43, sW * 100, sH * 15, tocolor(255, 255, 255, alpha), sH * 1.2, "default-bold", "left", "center", false, false, false, true, false)
            dxDrawText(string.upper(message.victimGroup), sW * 1189, nextMessageY + sH * 43, sW * 100, sH * 15, tocolor(255, 255, 255, alpha), sH * 1.2, "default-bold", "left", "center", false, false, false, true, false)

            nextMessageY = nextMessageY + MESSAGE_SPACING
            nextFundoY = nextFundoY + MESSAGE_SPACINGFundo
        else
            local offsetY = sH * 887
            local victimTextY = calculateVictimTextY(nextMessageY - offsetY)
            local victimText = message.deadName .. " #6D28D9#" .. message.deadID

            dxDrawImage(sW * 1155, nextFundoY - sH * 16, sW * 177, sH * 31, backgroundTexture2, 0, 0, 0, tocolor(255, 255, 255, alpha))
            dxDrawText(victimText, sW * 1199, victimTextY, screenW, screenH, tocolor(255, 255, 255, alpha), message.fontSize, "default-bold", "left", "center", false, false, false, true, false)

            nextMessageY = nextMessageY + MESSAGE_SPACING
            nextFundoY = nextFundoY + MESSAGE_SPACINGFundo
        end

        dxDrawText(message.deadName .. " (" .. message.deadID .. ") - " .. message.victimGroup, screenW * 0.05, victimTextY, screenW, screenH, tocolor(255, 255, 255, alpha), message.fontSize, "default-bold")

        nextMessageY = nextMessageY + MESSAGE_SPACING
    end
end)
