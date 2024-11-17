local mortes = 0

--[[ addEventHandler("onClientRender", root, function()
    dxDrawText("Mortes: " .. mortes, 10, 10, 200, 20, tocolor(255, 255, 255, 255), 1, "default-bold", "left", "top", false, false, true)
end) ]]

addEvent("onNPCKilled", true)
addEventHandler("onNPCKilled", root, function()
    mortes = mortes + 1 -- Incrementa o contador de mortes
end)
