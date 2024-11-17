--  addCommandHandler('criarMarker', function(player)
--      triggerClientEvent(player, "createMarkersTrigger", resourceRoot, getElementDimension(player))
--  end)

--  addCommandHandler('destruirMarker', function(player, dim)
--      triggerClientEvent(player, "destroyMarkersTrigger", resourceRoot, getElementDimension(player))
--  end)

addEvent('fn:RealivePlayerForTotem', true)
addEventHandler('fn:RealivePlayerForTotem', root, function(player)
    exports['runy_safezone']:realivePlayer(player)
end)

addEvent("fn:getItemForTotem", true)
addEventHandler("fn:getItemForTotem", root, function(player, item)
    if exports['runy_inventario']:getItem(player, item) > 0 then
        return true
    end
end)