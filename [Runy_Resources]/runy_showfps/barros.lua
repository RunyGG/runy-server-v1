local showingFPS = false
local x, y = guiGetScreenSize()
local iFPS = 0
local iFrames = 0
local iStartTick = getTickCount()

function GetFPS()
    return iFPS
end

function toggleFPS()
    showingFPS = not showingFPS
    if showingFPS then
        addEventHandler("onClientRender", root, displayFPS)
    else
        removeEventHandler("onClientRender", root, displayFPS)
    end
end

function displayFPS()
    iFrames = iFrames + 1
    if getTickCount() - iStartTick >= 1000 then
        iFPS = iFrames
        iFrames = 0
        iStartTick = getTickCount()
    end
    dxDrawText("" .. GetFPS() .. " FPS", 0, 0, 50, 15, tocolor(255, 255, 255), 1.1, "default-bold", "left", "top", false, false, true)
end

addCommandHandler("fps", toggleFPS)
