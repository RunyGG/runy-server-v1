addEventHandler("onPlayerWasted", root,
    function(ammo, killer)
        if killer and killer ~= source then
            local killedPlayerName = getPlayerName(source)
            local killedPlayerID = getElementData(source, "ID")
            triggerClientEvent(killer, "onPlayerKill", root, killedPlayerName, killedPlayerID)
        end
    end
)