--function assignPlayerDimensionID(player)
--    local id = getElementData(player, "ID")
--    if not id or type(id) ~= "number" then
--        id = 0
--        setElementData(player, "ID", id)
--    end
--end
--
--addEventHandler("onPlayerJoin", root, function()
--    assignPlayerDimensionID(source)
--end)

function givePlayerWeapons(player)
    exports["runy_inventario"]:giveItem(player, 49, 1)
    exports["runy_inventario"]:giveItem(player, 32, 1)
    exports["runy_inventario"]:giveItem(player, 33, 1)
    exports["runy_inventario"]:giveItem(player, 19, 1)
    exports["runy_inventario"]:giveItem(player, 41, 600)
end
addEvent("givePlayerWeapons", true)
addEventHandler("givePlayerWeapons", root, givePlayerWeapons)

function takePlayerWeapons(player)
    takeWeapon(player, 30)
    takeWeapon(player, 23)
end
addEvent("takePlayerWeapons", true)
addEventHandler("takePlayerWeapons", root, takePlayerWeapons)