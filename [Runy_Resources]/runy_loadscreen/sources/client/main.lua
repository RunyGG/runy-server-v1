local font4 = dxCreateFont("files/fonts/medium.ttf", 12)

percentCalc = 100

function drawProgressCircle(x, y, radius, startAngle, stopAngle, width, color, percentage)
    local numSegments = 100
    local startSegment = math.floor(numSegments * (startAngle / 360))
    local stopSegment = math.floor(numSegments * (stopAngle / 360) * (percentage / 100))

    for i = startSegment, stopSegment do
        local angle1 = math.rad((i / numSegments) * 360)
        local angle2 = math.rad(((i + 1) / numSegments) * 360)
        local x1 = x + math.cos(angle1) * radius
        local y1 = y + math.sin(angle1) * radius
        local x2 = x + math.cos(angle2) * radius
        local y2 = y + math.sin(angle2) * radius

        dxDrawLine(x1, y1, x2, y2, color, width)
    end
end

function dx()
    dxDrawRectangle(0, 0, 1366, 768, tocolor(0, 0, 0, 255))
    dxDrawImage(0, 0, 1366, 768, "files/imgs/base.png")
    dxDrawText(nameFile and string.lower(nameFile) or "runygg/core/client/c-main.lua", 598.75, 669.8, 207.3, 19.95, tocolor(99, 94, 106, 255), 1.00, font4, "left", "center", false, false, false, false, false)

    dxDrawImageSection(295, 732.01, (776/100*percentCalc), 5.54, 295, 732.01, (776/100*percentCalc), 5.54, "files/imgs/bar.png")

    drawProgressCircle(1005.9 + 32.15, 639.4 + 32.15, 29.5, 0, 360, 4, tocolor(109, 40, 217, 255), percentCalc)

    dxDrawText(string.format("%.0f%%", percentCalc), 1022.44, 664.17, 33, 18, tocolor(255, 255, 255, 255), 1.00, font4, "center", "center", false, false, false, false, false)
end

addEventHandler("onClientResourceStart", resourceRoot,
function()
    if not isEventHandlerAdded("onClientRender", root, dx) then
        percentCalc = 100
        setTransferBoxVisible(false)
        tocarSom()
        triggerServerEvent("JOAO.offVoice", localPlayer, localPlayer, true)
        addEventHandler("onClientRender", root, dx)
        showCursor(true)
        showChat(false)
    end
end)

function closeMenu()
    if isEventHandlerAdded("onClientRender", root, dx) then
        removeEventHandler("onClientRender", root, dx)
        if isTimer(TimerSound) then killTimer(TimerSound) end
        if isElement(sound) then destroyElement(sound) end
        triggerServerEvent("JOAO.offVoice", localPlayer, localPlayer, false)
        showCursor(false)
    end
end

function removeLoadScreen()    
    if (isTransferBoxActive()) then
        setTimer(removeLoadScreen, 2000, 1)
    else 
        if isEventHandlerAdded("onClientRender", root, dx) then
            closeMenu()
        end
    end
end
setTimer(removeLoadScreen, 2000, 1)

function tocarSom()
    if isElement(sound) then destroyElement(sound) end
    indexMusicPlay = config["Musics"][math.random(1, #config["Musics"])]
    tickMusicRestart = getTickCount()
    if config["Type download"] == "youtube" then
        sound = playSound("https://server1.mtabrasil.com.br/youtube/play?id="..indexMusicPlay[1], false)
    else
        sound = playSound(indexMusicPlay[1], false)
    end
    setSoundVolume(sound, 0.5)
end

addEventHandler("onClientSoundStopped", root,
function(reason)
    if isElement(sound) then
        if source == sound then
            if isEventHandlerAdded("onClientRender", root, dx) then
                if reason == "finished" then
                    tocarSom()
                end
            end
        end
    end
end)

addEventHandler("onClientTransferBoxProgressChange", root,
function(downloadedSize, totalSize)
    percentCalc = math.min((downloadedSize/totalSize)*100, 100)
end)

addEventHandler("onClientResourceFileDownload", root,
function(fileResource, fileName, fileSize, state)
    if state == "finished" then
        nameFile = getResourceName(fileResource).."/"..fileName
    end
end)

function isEventHandlerAdded( sEventName, pElementAttachedTo, func )
    if type( sEventName ) == "string" and isElement( pElementAttachedTo ) and type( func ) == "function" then
        local aAttachedFunctions = getEventHandlers( sEventName, pElementAttachedTo )
        if type( aAttachedFunctions ) == "table" and #aAttachedFunctions > 0 then
            for i, v in ipairs( aAttachedFunctions ) do
                if v == func then
                    return true
                end
            end
        end
    end
    return false
end