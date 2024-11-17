local coletes = {}

function verificarColete(player)
    local playerArmor = getPedArmor(player)
    if playerArmor > 0 then
        if not coletes[player] then
            local x, y, z = getElementPosition(player)
            coletes[player] = createObject(1242, 0, 0, 0)
            exports.pAttach:attach(coletes[player], player, "spine", -0.2, 0.042, 0, 180, 90, 0)
            local Colete = getElementData(player, 'Colete')
            if Colete then
                triggerClientEvent(root, 'setArmaStickerC', resourceRoot, player, 'colete', 'files/weapons/skins/'..Colete..".png", coletes[player])
            end
        end
    elseif coletes[player] then
        destroyElement(coletes[player])
        coletes[player] = nil
    end
end

setTimer(function()
    for _, player in ipairs(getElementsByType("player")) do
        verificarColete(player)
    end
end, 1000, 0)

addEventHandler("onPlayerQuit", root, function()
    if coletes[source] then
        destroyElement(coletes[source])
        coletes[source] = nil
    end
end)