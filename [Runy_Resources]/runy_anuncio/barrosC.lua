local screenW, screenH = guiGetScreenSize()
local resW, resH = 1366, 768
local x, y = (screenW / resW), (screenH / resH)

local font = dxCreateFont("assets/sbold.ttf", 10)

local lineHeight = 33
local baseImageHeight = y * 75.1
local imageExtraHeightPerLine = 15

local pos_x2 = x * 26

local painelAnuncio = false

function drawDx()
    local numLines = math.ceil(#sendMessage / lineHeight)
    local imageHeight = baseImageHeight + (numLines - 1) * imageExtraHeightPerLine

    dxDrawImage(x * 6, y * 302, x * 315.55, imageHeight, "assets/main.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawImage(x * 26, y * 291, x * 92, y * 22, "assets/main2.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawText(sendMessage, pos_x2, y * 325, x * 282, y * 468, tocolor(255, 255, 255, 255), 1.00, font, "left", "top", false, true, false, false, false)
end

function animateDraw()
    local initialTime = getTickCount()
    local duration = 1000

    function animateInitial()
        local currentTime = getTickCount()
        local passedTime = currentTime - initialTime
        if passedTime >= global.Duracao * 1500 then
            removeEventHandler("onClientRender", root, animateInitial)
            removeEventHandler("onClientRender", root, drawDx)
            painelAnuncio = false
        end

        local progress = passedTime / duration

        pos_x = interpolateBetween(0, 0, 0, 20, 0, 0, progress, "OutElastic")
        pos_x2 = interpolateBetween(0, 0, 0, 33, 0, 0, progress, "OutElastic")
        pos_x3 = interpolateBetween(0, 0, 0, 89, 0, 0, progress, "OutElastic")
        setTimer(function()
            pos_x = interpolateBetween(20, 0, 0, 0, 0, 0, progress, "InElastic")
            pos_x2 = interpolateBetween(33, 0, 0, 0, 0, 0, progress, "InElastic")
            pos_x3 = interpolateBetween(89, 0, 0, 0, 0, 0, progress, "InElastic")
        end, global.Duracao * 1500, 1)
    end

    if not painelAnuncio then
        addEventHandler("onClientRender", root, animateInitial)
        addEventHandler("onClientRender", root, drawDx)
        painelAnuncio = true
    end
end

function callAll(messageSend)
    if messageSend then
        sendMessage = messageSend
        animateDraw()
        playSoundFrontEnd(5)
    end
end
addEvent("barros:anuncioStaff", true)
addEventHandler("barros:anuncioStaff", getRootElement(), callAll)