addEventHandler('onPlayerWasted', root, function(_, killer)
    if (killer and getElementType(killer) == "player") then
        local x, y, z = getElementPosition(source)
        triggerClientEvent(killer, 'Fn > MatarPlayer', killer, source, x, y, z)
    end
end)

local func = function(killer, w, l, bp)
    triggerClientEvent(killer, 'Fn > MatarPlayer', killer)
end
addEvent('onPlayerHeadshot', true)
addEventHandler('onPlayerHeadshot', root, func)