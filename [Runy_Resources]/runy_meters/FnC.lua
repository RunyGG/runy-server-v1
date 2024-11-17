local sW, sH = guiGetScreenSize()
local isPlayerInAir = false
local minAltura = sH * (479 / 768)
local maxAltura = sH * (201 / 768)
local minAlturaText = sH * (487 / 768)
local maxAlturaText = sH * (209 / 768)
local minSpeedY = sH * (513.55 / 768)
local maxSpeedY = sH * (198.75 / 768)
local minSpeedImageY = sH * (505.8 / 768)
local maxSpeedImageY = sH * (191 / 768)

img2 = dxCreateTexture('assets/smoke.png')

function getSpeedKMH(element)
    local vx, vy, vz = getElementVelocity(element)
    return math.sqrt(vx^2 + vy^2 + vz^2) * 180
end

screenW, screenH = guiGetScreenSize()
sW2, sH2 = (screenW/1366), (screenH/768)

local touchOnGroun = false
function forRuny()
    
    if (getElementData(localPlayer, 'battleRoyaleRunning')) then 
        
        local localPlayer = getLocalPlayer()
        local px, py, pz = getElementPosition(localPlayer)
        local groundZ = getGroundPosition(px, py, pz)
        local distance = pz - groundZ
        local speedKMH = getSpeedKMH(localPlayer)
        
        if distance > 2 then
            isPlayerInAir = true
        else
            isPlayerInAir = false
        end
        
        if isPlayerInAir and not touchOnGroun then
            
            
            dxDrawImage(sW * ((402.44-50) / 1366), sH * (201 / 768), sW * (74.94 / 1366), sH * (363.13 / 768), "assets/bg.png", 0, 0, 0, tocolor(255, 255, 255, 200))
            
            dxDrawImage(sW * ((834.23+50) / 1366), sH * (201 / 768), sW * (66.02 / 1366), sH * (324.81 / 768), "assets/bg2.png", 0, 0, 0, tocolor(255, 255, 255, 200))
            
            local arrowYaltura = minAltura - (minAltura - maxAltura) * (distance / 100)
            if arrowYaltura < maxAltura then arrowYaltura = maxAltura end
            if arrowYaltura > minAltura then arrowYaltura = minAltura end
            
            dxDrawImage(sW * ((282-50) / 1366), arrowYaltura, sW * (132 / 1366), sH * (33.31 / 768), "assets/arrow.png", 0, 0, 0, tocolor(255, 255, 255, 200))
            
            local textYaltura = minAlturaText - (minAlturaText - maxAlturaText) * (distance / 100)
            if textYaltura < maxAlturaText then textYaltura = maxAlturaText end
            if textYaltura > minAlturaText then textYaltura = minAlturaText end
            
            dxDrawText(tostring(math.floor(distance)), sW * ((316-40) / 1366), textYaltura, sW * ((188-50) / 1366), sH * (18 / 768), tocolor(255, 255, 255, 200), (sW2*1.3), "default-bold", "left", "top")
            
            if not getElementData(localPlayer, "parachuting") then
                if math.floor(distance) <= 90 then
                    setElementData(localPlayer, "parachuting", true)
                    exports.parachute:addLocalParachute()
                end
                for index, players in pairs(getElementsByType('player')) do
                    if getElementData(players, 'lined') then
                        local colorLine = getElementData(players, 'lined')
                        for _, bones in ipairs({24,34,53,43}) do
                            local sx, sy, sz = getPedBonePosition( players, bones )
                            if sx then
                                dxDrawMaterialLine3D(sx, sy, sz-0.6, sx, sy, sz+15, true, img2, 0.02, tocolor(colorLine[1], colorLine[2], colorLine[3], 50), false)
                            end
                        end
                    end
                end
            end
            
            local speedImageY = minSpeedImageY - (minSpeedImageY - maxSpeedImageY) * (distance / 100)
            if speedImageY < maxSpeedImageY then speedImageY = maxSpeedImageY end
            if speedImageY > minSpeedImageY then speedImageY = minSpeedImageY end
            
            dxDrawImage(sW * ((834+50) / 1366), speedImageY, sW * (223.93 / 1366), sH * (33.31 / 768), "assets/arrow2.png", 0, 0, 0, tocolor(255, 255, 255, 200))
            
            local speedY = minSpeedY - (minSpeedY - maxSpeedY) * (distance / 100)
            if speedY < maxSpeedY then speedY = maxSpeedY end
            if speedY > minSpeedY then speedY = minSpeedY end
            
            dxDrawText(string.format("%.1f km/h", speedKMH), sW * ((966.77+50) / 1366), speedY, sW * ((188+50) / 1366), sH * (18 / 768), tocolor(255, 255, 255, 200), (sW2*1.2), "default-bold", "left", "top")
            
        else 
            
            touchOnGroun = true
            
        end
        
    else 
        
        touchOnGroun = false
        
    end 
    
end
addEventHandler("onClientRender", root, forRuny)