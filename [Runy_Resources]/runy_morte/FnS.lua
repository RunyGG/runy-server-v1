function checkGroup(player)
    local account = getPlayerAccount(player)
    if not isGuestAccount(account) then
        local playerName = getAccountName(account)
    end
end
addEvent("fn:checkGroup > Morte", true)
addEventHandler("fn:checkGroup > Morte", resourceRoot, checkGroup)

addEvent('onPlayerDerrota', true)
addEventHandler('onPlayerDerrota', root, function(player)

        --if (client and client ~= player) then
        --
        --    if (getElementData(player, 'myDuo') ~= client) then 
    --
        --        return 
    --
        --    end
    --
        --end

        triggerClientEvent(player, 'onClientShowDerrota', player)

    end

)