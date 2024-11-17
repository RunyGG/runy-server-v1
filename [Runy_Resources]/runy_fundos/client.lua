screenW, screenH = guiGetScreenSize()
sW, sH = (screenW/1366), (screenH/768)

local fundosVisible = false

function Image(x1, y1, w1, h1, ...)
    return dxDrawImage(sW * x1, sH * y1, sW * w1, sH * h1, ...)
end

function onClientRender_OpenFigmaToMTA()
     if not fundosVisible then return end
     Image(10, 21, 198, 42, "files/bg.png")
end
addEventHandler("onClientRender", getRootElement(), onClientRender_OpenFigmaToMTA)

function hideFundos()
     fundosVisible = false
 end
 addEvent("hideFundos", true)
 addEventHandler("hideFundos", root, hideFundos)
 
 
 function showFundos()
     fundosVisible = true
 end
 addEvent("showFundos", true)
 addEventHandler("showFundos", root, showFundos)

-- USEFUL

function dxDrawRoundedRectangle(x, y, rx, ry, color, radius)
     rx = rx - radius * 2
     ry = ry - radius * 2
     x = x + radius
     y = y + radius
     if (rx >= 0) and(ry >= 0) then
         dxDrawRectangle(x, y, rx, ry, color)
         dxDrawRectangle(x, y - radius, rx, radius, color)
         dxDrawRectangle(x, y + ry, rx, radius, color)
         dxDrawRectangle(x - radius, y, radius, ry, color)
         dxDrawRectangle(x + rx, y, radius, ry, color)
         dxDrawCircle(x, y, radius, 180, 270, color, color, 7)
         dxDrawCircle(x + rx, y, radius, 270, 360, color, color, 7)
         dxDrawCircle(x + rx, y + ry, radius, 0, 90, color, color, 7)
         dxDrawCircle(x, y + ry, radius, 90, 180, color, color, 7)
     end
end
