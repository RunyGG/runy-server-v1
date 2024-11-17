local sW, sH = guiGetScreenSize()
local resW, resH = 1366,768
local x, y = (sW/resW), (sH/resH)

local groupDesignVisible = false

function groupRuny()
     if not groupDesignVisible then return end
     dxDrawImage(sW * (16/1366), sH * (705/768), sW * (174/1366), sH * (42/768), "assets/bg.png")
     
     local vidaRuny = getElementHealth(localPlayer)
     local coleteRuny = getPedArmor(localPlayer)
     local playerID = getElementData(localPlayer, "ID")
     local namePlayer = getPlayerName(localPlayer)

     dxDrawText(namePlayer .. "" .. "#BBDE1E #" .. playerID, sW * (55/1366), sH * (712/768), sW * (59/1366), sH * (7/768), tocolor(255, 255, 255, 255), 1, "assets/fonts/font.ttf", "left", "top", false, false, false, true, false)

     dxDrawImage(sW * (55/1366), sH * (729/768), (vidaRuny/100) * (sW * (128 / 1366)), 4, "assets/health.png")
     dxDrawImage(sW * (55/1366), sH * (737/768), (coleteRuny/100) * (sW * (128 / 1366)), 4 , "assets/shield.png")

end
addEventHandler("onClientRender", getRootElement(), groupRuny)

function hideGroupDesign()
     groupDesignVisible = false
 end
 addEvent("hideGroupDesign", true)
 addEventHandler("hideGroupDesign", root, hideGroupDesign)
 
 
 function showGroupDesign()
     groupDesignVisible = false
 end
 addEvent("showGroupDesign", false)
 addEventHandler("showGroupDesign", root, showGroupDesign)