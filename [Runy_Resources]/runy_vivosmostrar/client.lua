screenW, screenH = guiGetScreenSize()
sW, sH = (screenW/1366), (screenH/768)

local vivosVisible = false
local textSize = (sW * 1.4) 
local numPlayers = 0

function Texto(text, x1, y1, w1, h1, ...)
    return dxDrawText(text, sW * x1, sH * y1, sW * w1, sH * h1, ...)
end

function renderPlayerCount()

    --[[ if not vivosVisible then return end ]]
    
    if not (getElementData(localPlayer, 'battleRoyaleRunning')) and not (getElementData(localPlayer, 'runyInPareamento')) then return end
    local text = numPlayers or 0

    text = 0 
    text2 = 0 
    for i, v in ipairs(getElementsByType('player')) do 

        if (getElementDimension(v) == getElementDimension(localPlayer) and (getElementData(v, 'battleRoyaleRunning') or getElementData(v, 'runyInPareamento'))) then 

            text2 = text2 + 1

            if (isElement(getElementData(v, 'myDuo'))) then 

                text = text + 0.5

            else 

                text = text + 1
            
            end


        end

    end 

    Texto(tostring(math.floor(text)), 225, 32, 18, 20, tocolor(255, 255, 255, 255), textSize, "default-bold", "center", "top")
    Texto(tostring(math.floor(text2)), 85, 32, 17, 20, tocolor(255, 255, 255, 255), textSize, "default-bold", "center", "top")
end
addEventHandler("onClientRender", root, renderPlayerCount)

addEvent("onPlayerCountUpdate", true)
addEventHandler("onPlayerCountUpdate", root, function(players, dimension)
    if getElementDimension(localPlayer) == dimension then
        numPlayers = players
        vivosVisible = true
    else
        vivosVisible = false
    end
end)


function hideVivos()
    vivosVisible = false
end
addEvent("hideVivos", true)
addEventHandler("hideVivos", root, hideVivos)


function showVivos()
    vivosVisible = true
end
addEvent("showVivos", true)
addEventHandler("showVivos", root, showVivos)