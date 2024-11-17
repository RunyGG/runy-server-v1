function checkPlayerPermissions()
    local player = client
    removeElementData(player, "battleRoyaleRunning")
end
addEvent("checkPlayerPermissions", true)
addEventHandler("checkPlayerPermissions", resourceRoot, checkPlayerPermissions)

addEvent('onPlayerWin', true)
addEventHandler('onPlayerWin', root, function(player)
    
    --if not (isElement(player)) then 
    --    
    --    return 
    --    
    --end
    --
    --if (client and client ~= player) then
    --    
    --    if (getElementData(player, 'myDuo') ~= client) then 
    --        
    --        return 
    --        
    --    end
    --    
    --end
    triggerEvent("NZ > updateMission", player, player, "win1", 1)
    triggerEvent("NZ > updateMission", player, player, "win2", 1)
    triggerEvent("NZ > updateMission", player, player, "win3", 1)
    
    triggerClientEvent(player, 'onClientShowWin', player)
    
end)