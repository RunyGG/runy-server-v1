local screen = { guiGetScreenSize() }
local sW, sH = guiGetScreenSize()
local resW, resH = 1366, 768
local sx, sy = screen[1]/resW, screen[2]/resH

local isProgressBarRendered = false
local customFont = dxCreateFont("assets/fonts/font.ttf", 12)
local tempoRestante = 3000
local rotation = 0

local _dxDrawText = dxDrawText

function dxDrawText(text, x, y, w, h, ...)
    _dxDrawText(text, x, y, x + w, y + h, ...)
end


local SvgsRectangle = {}

function dxDrawBordRectangle(x, y, w, h, radius, color, post)
    if not SvgsRectangle[radius + w + h] then
        local Path = string.format([[
            <svg width="%s" height="%s" viewBox="0 0 %s %s" fill="none" xmlns="http://www.w3.org/2000/svg">
            <rect opacity="1" width="%s" height="%s" rx="%s" fill="#FFFFFF"/>
            </svg>
        ]], w, h, w, h, w, h, radius)
        SvgsRectangle[radius + w + h] = svgCreate(w, h, Path)
    end
    if SvgsRectangle[radius + w + h] then
        dxDrawImage(x, y, w, h, SvgsRectangle[radius + w + h], 0, 0, 0, color, post)
    end
end

function isCursorOnPosition(x, y, w, h)
    if cx and cy then
        if cx >= x and cx <= (x + w) and cy >= y and cy <=(y + h) then
            return true
        end
    end
    return false
end

function lerp(a, b, t)
    return a + (b - a) * t
end

tickBar = 0

function progress()
    local tempoPassado = getTickCount() - tick
    local tempoRestante = time - tempoPassado

    if tempoRestante < 0 then
        tempoRestante = 0
    end

    local minutos = math.floor(tempoRestante / 60000)
    local segundos = math.floor((tempoRestante % 60000) / 1000)

    local tempoText = string.format("%02d:%02d", minutos, segundos)

    local barra = interpolateBetween(94, 0, 0, 0, 0, 0, tempoPassado / time, "Linear")
    local interpolateBar = lerp(tickBar, barra, 0.15)

    dxDrawImage(sW * (588/1366), sH * (687/768), sW * (190/1366), sH * (62/768), "assets/bg.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawRectangle(sW * (672 / 1366), sH * (715 / 768), sW * (interpolateBar / 1366), sH * (6 / 768), tocolor(109, 40, 217, 255), false)

    dxDrawText(tempoText, sW * (607/1366), sH * (705/768), sW * (48/1366), sH * (25/768), tocolor(255, 255, 255), 1.0, customFont, "center", "center")

    tickBar = interpolateBar
end

function toggleProgress(tempo)
    if not isProgressBarRendered then

        tick = getTickCount()
        time = tempo
        tempoRestante = tempo
        rotation = 0
        isProgressBarRendered = true
        addEventHandler("onClientRender", root, progress)
        Timer = setTimer(function()
            removeEventHandler("onClientRender", root, progress)
            isProgressBarRendered = false
        end, tempo, 1)
        
    else
        removeEventHandler("onClientRender", root, progress)
        killTimer(Timer)
        tempoRestante = tempo
        tick = getTickCount()
        time = tempo
        addEventHandler("onClientRender", root, progress)
        Timer = setTimer(function()
            removeEventHandler("onClientRender", root, progress)
            isProgressBarRendered = false
        end, tempo, 1)
    end
end

addEvent("progressBar", true)
addEventHandler("progressBar", root, toggleProgress)
