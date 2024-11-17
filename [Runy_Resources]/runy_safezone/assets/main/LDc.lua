screenW, screenH = guiGetScreenSize()
sW, sH = (screenW/1366), (screenH/768)

local circleTexture = dxCreateTexture("assets/images/wall.png")

function drawCircle(x, y, radius)
    local originx,originy = x,y
    local numberOfPoints = math.floor(math.pow(radius, 0.4) * 5)
    local step = math.pi * 2 / numberOfPoints
    local sx,sy
    
    for point=0, numberOfPoints do
        local ex = math.cos(point * step) * radius
        local ey = math.sin(point * step) * radius
        if sx then
            local screw = radius * 0.5
            if (screw < 300) then 
                screw = radius * 3
            end
            dxDrawMaterialSectionLine3D(x+sx, y+sy, 0, x+ex, y+ey, 0, 0, 0, 150000, screw, circleTexture, 10000, tocolor(255, 255, 255, 255), originx, originy, 0)
        end
        sx,sy = ex,ey
    end
end

function isPlayerInCircle(x, y, radius)
    local px, py = getElementPosition(localPlayer);
    if ((x-px)^2+(y-py)^2 <= radius^2) then return true; end
    return false;
end

addEventHandler("onClientPreRender", root, function()
    
    for _, marker in ipairs(getElementsByType("marker", resourceRoot)) do
        if getElementDimension(localPlayer) == getElementDimension(marker) then
            
            if getElementData(marker, "safezoneMarker") then
                
                local x, y, z = getElementPosition(marker)
                local tamanhoGas = getMarkerSize(marker)
                local radius = tamanhoGas / 2
                
                drawCircle(x, y, radius)
                if (not isPlayerInCircle(x, y, radius)) then
                    
                    if (getElementData(localPlayer, 'teleport.pvp')) or (getElementData(localPlayer, 'runyInPareamento')) or (getElementData(localPlayer, 'spectatingPlayer')) then 
                        return 
                    end 
                    
                    if not (getElementData(localPlayer, 'battleRoyaleRunning')) then
                        if getWeather() ~= 0 then
                            setWeather ( 0 )
                            setWeatherBlended ( 0 )
                        end
                        return
                    end
                    
                    dxDrawRectangle(0, 0, screenW, screenH, tocolor(109, 40, 217, 90), true)
                    if getWeather() ~= 16 then
                        setWeather ( 16 )
                        setWeatherBlended ( 19 )
                    end
                    
                else
                    
                    if getWeather() ~= 0 then
                        setWeather ( 0 )
                        setWeatherBlended ( 0 )
                    end
                    
                end
                
            end
            
        end
        
    end
    
end)

function Texto(text, x1, y1, w1, h1, ...)
    return dxDrawText(text, sW * x1, sH * y1, sW * w1, sH * h1, ...)
end

function Image(x1, y1, w1, h1, ...)
    return dxDrawImage(sW * x1, sH * y1, sW * w1, sH * h1, ...)
end

local barX, barY, barWidth, barHeight = sW * 246, sH * 40, sW * 70, sH * 5

addEventHandler("onClientPreRender", root, function()
    local seconds = getElementData(localPlayer, "temporestantegas")
    if seconds then
        local totalSeconds = getElementData(localPlayer, "temporestantegas")
        if not (gasTick) then gasTick = getTickCount() end 
        local seconds = interpolateBetween(seconds, 0, 0, 0, 0, 0, ((getTickCount() - gasTick) / (seconds * 1000)), 'Linear')
        local elapsedTime = (getTickCount() - gasTick) / 1000
        local remainingSeconds = totalSeconds - elapsedTime
        remainingSeconds = math.max(0, remainingSeconds)
        local progress = remainingSeconds / totalSeconds
        local currentBarWidth = barWidth * progress
        Image(205.5, 21, 154, 42, "assets/images/base.png")
        dxDrawRectangle(barX, barY, currentBarWidth, barHeight, tocolor(109, 40, 217, 255))
        Texto(""..segundosParaHora(math.floor(seconds)), 318, 34, 31, 15, tocolor ( 255, 255, 255, 255 ), (sW*1.15), "default-bold" )
    end
end)

addEvent('onClientRefreshTickGas', true)
addEventHandler('onClientRefreshTickGas', root, 

function()
    gasTick = getTickCount() 
end)

function segundosParaHora(segundos)
    local minutos = math.floor(segundos / 60)
    local segundosRestantes = segundos % 60
    return string.format("%02d:%02d", minutos, segundosRestantes)
end

addEvent("playGasMoveAudio", true)
addEventHandler("playGasMoveAudio", root, function(audioPath)
    if audioPath then
        playSound(audioPath)
    end
end)