local sW, sH = guiGetScreenSize()
local lastHealth = 100
local lastArmor = 100

local hudVisible = false

function onClientRender_OpenFigmaToMTA()
     if not hudVisible then return end
     dxDrawImage(sW * (1025.5/1366), sH * (650/768), sW * (305/1366), sH * (100/768), "files/bg.png")
     dxDrawImage(sW * (1197/1366), sH * (21/768), sW * (130/1366), sH * (43/768), "files/runylogo.png")

     local vida = getElementHealth(localPlayer)
     local colete = getPedArmor(localPlayer)

     local deltaHealth = vida - lastHealth
     local deltaArmor = colete - lastArmor

     lastHealth = lastHealth + deltaHealth * 0.1
     lastArmor = lastArmor + deltaArmor * 0.1

     dxDrawImage(sW * (1066/1366), sH * (659/768), (lastHealth/100) * (sW * (94 / 1366)), 3.32, "files/statsBar.png", 0, 0, 0, tocolor(255, 255, 255, 255)) --// Vida
     dxDrawImage(sW * (1066/1366), sH * (670/768), (lastArmor/100) * (sW * (94 / 1366)), 3.32, "files/statsBar.png", 0, 0, 0, tocolor(109, 40, 217, 255)) --// Colete

end
addEventHandler("onClientRender", getRootElement(), onClientRender_OpenFigmaToMTA)

function hideHud()
     hudVisible = false
end
addEvent("hideHud", true)
addEventHandler("hideHud", root, hideHud)
 
 
function showHud()
     hudVisible = true
end
addEvent("showHud", true)
addEventHandler("showHud", root, showHud)