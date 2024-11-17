
addEventHandler("onPlayerChat", root, function(tresc, msgtype)
    if (msgtype == 0) then
        cancelEvent()
    end
end)

local teleportX, teleportY, teleportZ = 2479.64282, 590.04059, 157.16562

addEvent("NPCTREINO", true)
addEventHandler("NPCTREINO", resourceRoot, function(player)
    triggerEvent("iniciarTreino", root, player)
    -- local clothes = exports['customcharacter']:getPlayerClothesCustom(player)
    -- triggerClientEvent(root, "ClothePlayerLobby", root, player, clothes)
    -- removeElementData(player, 'likespartida')
    if isElement(player) and getElementData(player, 'killPartida') then
        removeElementData(player, 'killPartida')
    end
    if isElement(player) and getElementData(player, 'temporestantegas') then
        removeElementData(player, 'temporestantegas')
    end
    
end)

addEvent("AIMLABTREINO", true)
addEventHandler("AIMLABTREINO", resourceRoot, function(player)
    triggerClientEvent("BALAOTREINO", resourceRoot, player)
    -- local clothes = exports['customcharacter']:getPlayerClothesCustom(player)
    -- triggerClientEvent(root, "ClothePlayerLobby", root, player, clothes)
    -- removeElementData(player, 'likespartida')
    if isElement(player) and getElementData(player, 'killPartida') then
        removeElementData(player, 'killPartida')
    end
    if isElement(player) and getElementData(player, 'temporestantegas') then
        removeElementData(player, 'temporestantegas')
    end
    
end)

addEvent("NPCSAIRTREINO", true)
addEventHandler("NPCSAIRTREINO", resourceRoot, function(player)
    triggerEvent("sairDoTreino2", root, player)
    -- local clothes = exports['customcharacter']:getPlayerClothesCustom(player)
    -- triggerClientEvent(root, "ClothePlayerLobby", root, player, clothes)
    -- removeElementData(player, 'likespartida')
    if isElement(player) and getElementData(player, 'killPartida') then
        removeElementData(player, 'killPartida')
    end
    if isElement(player) and getElementData(player, 'temporestantegas') then
        removeElementData(player, 'temporestantegas')
    end
    
end)

addEventHandler('onPlayerLogin', root, 
function(player)
    setElementData(source, "lobbyLogin", true)
    setElementData(source, 'modo', 'Lobby')
    triggerClientEvent(source, 'lobby : login', source)
    triggerClientEvent(source, 'lobby : login', source)
    -- setTimer(function(source) 
    --     local clothes = exports['customcharacter']:getPlayerClothesCustom(source)
    --     triggerClientEvent(root, "ClothePlayerLobby", root, source, clothes)
    -- end, 2500, 1, source)
end
)

addEvent("NotifyServerForClient", true)
addEventHandler("NotifyServerForClient", resourceRoot, function(player, message)
    triggerClientEvent(player, "Notify", player, message)
end)

addEvent('tirarFrozenByFn', true)
addEventHandler('tirarFrozenByFn', resourceRoot, function(player)
    setElementFrozen(player, false)
end)

addEvent('verifyPremium > FN', true)
addEventHandler('verifyPremium > FN', resourceRoot, function(player)
    setTimer(function ()
        local accName = getAccountName(getPlayerAccount(player))
        local isPremium = false
        if isObjectInACLGroup("user."..accName, aclGetGroup("Premium")) then
            isPremium = true
        end
        triggerClientEvent(player, "premiumStats > FN", resourceRoot, isPremium)
    end, 5000, 0)
end)

addEvent('colocarFrozenByFn', true)
addEventHandler('colocarFrozenByFn', resourceRoot, function(player)
    setElementFrozen(player, true)
end)

addEvent('removePlayerWeapons', true)
addEventHandler('removePlayerWeapons', resourceRoot,
function (player)
    exports['mg']:removeQuit(player, player)
    takeAllWeapons(player)
    toggleControl(player, "fire", true)
    triggerClientEvent(player, 'announcement', player, false)
    setPedArmor(player, 0)
    -- local clothes = exports['customcharacter']:getPlayerClothesCustom(player)
    -- triggerClientEvent(root, "ClothePlayerLobby", root, player, clothes)
    
    -- removeElementData(player, 'likespartida')
    if isElement(player) and getElementData(player, 'killPartida') then
        removeElementData(player, 'killPartida')
    end
    if isElement(player) and getElementData(player, 'temporestantegas') then
        removeElementData(player, 'temporestantegas')
    end
    
    
end)

addEvent('removeAnimation', true)
addEventHandler('removeAnimation', resourceRoot,
function (player)
    setPedAnimation(player)
end)

addEvent('ReturnToLobbyForOwner', true)
addEventHandler('ReturnToLobbyForOwner', root, function(player)
    triggerClientEvent(player, 'returnToLobbyClientEvent', player, player)
    -- clothes = exports['customcharacter']:getPlayerClothesCustom(player)
    -- triggerClientEvent(root, "ClothePlayerLobby", root, player, clothes)
    triggerEvent('ChangeBliped', player, player, 'destroy')
    -- removeElementData(player, 'likespartida')
    if isElement(player) and getElementData(player, 'killPartida') then
        removeElementData(player, 'killPartida')
    end
    if isElement(player) and getElementData(player, 'temporestantegas') then
        removeElementData(player, 'temporestantegas')
    end
    
    
    
    -- local clothes = exports['customcharacter']:getPlayerClothesCustom(player)
    -- triggerClientEvent(root, "ClothePlayerLobby", root, player, clothes)
end)

addEvent('onPlayerLobbyDimension', true)
addEventHandler('onPlayerLobbyDimension', resourceRoot, function(player)
    if isElement(player) then
        triggerEvent('ChangeBliped', player, player, 'destroy')

        -- Define a dimensão do jogador como 0
        setPlayerMoney(player, 0)
        setElementDimension(player, 0) -- Mantendo o jogador na dimensão 0 sempre

        if getElementData(player, 'myDuo') then
            local Bliped = getElementData(player, 'blipFriend')
            if isElement(Bliped) then
                destroyElement(Bliped)
            end
        end

        if client ~= player then 
            return 
        end

        local playerID = getElementData(player, "ID")
        if tonumber(playerID) then 
            setElementFrozen(player, true)
            
            setTimer(function()
                if isElement(player) then
                    setPedAnimation(player, "CRACK", "Bbalbat_Idle_02", -1, true, true, false, false)
                end
            end, 200, 1)
        end
    end
end)



addEvent('onPlayerInviteReceiverToLobby', true)
addEventHandler('onPlayerInviteReceiverToLobby', resourceRoot,

function(player, id)
    
    if (client ~= player) then 
        
        return 
        
    end
    
    if not (tonumber(id)) then 
        
        return triggerClientEvent(player, "Notify", player, "Insira um ID válido.")
        
    end
    
    if (isElement(getElementData(player, 'myDuo'))) then 
        
        return triggerClientEvent(player, "Notify", player, "Você já está em um DUO.")
        
    end 
    
    local receiver = getPlayerFromID(tonumber(id))
    if not (isElement(receiver)) then 
        
        return triggerClientEvent(player, "Notify", player, "Jogador não foi encontrado com sucesso.")
        
    end 
    
    if (isElement(getElementData(receiver, 'myDuo'))) then 
        
        return triggerClientEvent(player, "Notify", player, "Jogador já está em um DUO.")
        
    end 
    
    if (getElementData(receiver, 'runyInPareamento') or getElementData(receiver, 'battleRoyaleRunning')) then 
        
        return triggerClientEvent(player, "Notify", player, "Jogador está em uma partida.")
        
    end 
    
    if (isElement(getElementData(receiver, 'lobbyInvite'))) then 
        
        return triggerClientEvent(player, "Notify", player, "Jogador já tem um convite em andamento.")
        
    end 
    
    setElementData(receiver, 'lobbyInvite', player)
    triggerClientEvent(player, "Notify", player, "Convite enviado com sucesso.")
    -- clothes = exports['customcharacter']:getPlayerClothesCustom(receiver)
    -- triggerClientEvent(player, "ClothePlayerLobby", player, receiver, clothes)
    
    -- clothes2 = exports['customcharacter']:getPlayerClothesCustom(player)
    -- triggerClientEvent(player, "ClothePlayerLobby", player, player, clothes2)
    
    -- removeElementData(player, 'likespartida')
    if getElementData(player, 'killPartida') then
        removeElementData(player, 'killPartida')
    end
    if getElementData(player, 'killPartida') then
        removeElementData(player, "temporestantegas")
    end

end)

function getPlayerFromID(id)
    for i, v in ipairs(getElementsByType('player')) do
        if not isGuestAccount(getPlayerAccount(v)) and tonumber(getElementData(v, 'ID')) == tonumber(id) then
            return v
        end
    end
    return false
end

getPlayerID = function(id)
    if tonumber(id) then
        for _, v in ipairs(getElementsByType("player")) do
            if tonumber(getElementData(v, 'ID')) == tonumber(id) then
                return v 
            end
        end
    end
    return false
end

addCommandHandler('setPremium', function(player, _, playerID)
    if player and isElement(player) and getElementType(player) == "player" then
        if playerID and playerID ~= "" then
            local numPlayerID = tonumber(playerID)
            if numPlayerID then
                local idPlayer = getPlayerID(numPlayerID)
                if idPlayer then
                    if getElementData(idPlayer, 'runy:premium') then
                        outputDebugString("Este jogador ja possui um premium!")
                    else
                        setElementData(idPlayer, 'runy:premium', true) 
                        outputDebugString("Premium setado para: " .. getPlayerName(idPlayer))
                    end
                else
                    outputDebugString("Este jogador está offline!")
                end
            else
                outputDebugString("Digite um ID válido!")
            end
        else
            outputDebugString("Tente /setPremium [PLAYERID]")
        end
    end
end)

addCommandHandler('removePremium', function(player, _, playerID)
    if player and isElement(player) and getElementType(player) == "player" then
        if playerID and playerID ~= "" then
            local numPlayerID = tonumber(playerID)
            if numPlayerID then
                local idPlayer = getPlayerID(numPlayerID)
                if idPlayer then
                    if not getElementData(idPlayer, 'runy:premium') then
                        outputDebugString("Esse jogador não tem premium!")
                    else
                        setElementData(idPlayer, 'runy:premium', false)
                        outputDebugString("Premium removido de: " .. getPlayerName(idPlayer))
                    end
                else
                    outputDebugString("Este jogador está offline!")
                end
            else
                outputDebugString("Digite um ID válido!")
            end
        else
            outputDebugString("Tente /removePremium [PLAYERID]")
        end
    end
end)