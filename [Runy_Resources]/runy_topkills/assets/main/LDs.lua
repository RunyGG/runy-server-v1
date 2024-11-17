
outputDebugString('RESOURCE '..getResourceName(getThisResource())..' ATIVADA COM SUCESSO', 4, 204, 82, 82)

function openTopKillRank(player)

    if (getElementData(player, 'battleRoyaleRunning')) then 
        
        local scores = exports['runy_killsmostrar']:getPlayersStats(getElementDimension(player))
        triggerClientEvent(player, 'onClientDrawRunyTopKill', player, scores)
    
    end

end

addEventHandler('onPlayerLogin', root, 

    function()

        if not (isKeyBound(source, config.key, 'both', openTopKillRank)) then 

            bindKey(source, config.key, 'both', openTopKillRank)

        end
        
    end

)

addEventHandler('onResourceStart', getResourceRootElement(getThisResource()), 

    function()

        for _, player in ipairs(getElementsByType('player')) do 

            if not (isKeyBound(player, config.key, 'both', openTopKillRank)) then 

                bindKey(player, config.key, 'both', openTopKillRank)

            end

        end

    end

)