local db = dbConnect('sqlite', 'assets/database/data.sqlite')
dbExec(db, 'Create table if not exists inventoryPlayers(user TEXT, inventory TEXT)')

function openInventory(player)
    if (client and client ~= player) then 
        return 
    end
    local itens = getPlayerItens(player)
    setElementDimension(player, getElementData(player, "ID"))
    triggerClientEvent(player, 'onClientDrawClothesInventory', player, itens)
end
addEvent('onPlayerOpenClothesInventory', true)
addEventHandler('onPlayerOpenClothesInventory', root, openInventory)

addEvent('onPlayerUseClotheItem', true)
addEventHandler('onPlayerUseClotheItem', resourceRoot, function(player, item)
    if (client ~= player) then 
        return 
    end
    local data = config.itensX[item]
    if not (data) then 
        return
    end

    if item == 'sakuramask1' or item == 'sakuramask2' then
        local cfg = config.itensX[item]
        setElementData(player, 'Mascara', {cfg[2], item})
        return
    end

    local clothes = exports['customcharacter']:getPlayerClothesCustom(player)
    clothes[(data[1] == 'perna' and 'short' or data[1])] = {tonumber(data[2]), tonumber(data[3])}
    exports['customcharacter']:UpdatePlayerClothes(player, clothes)
end)

addEvent('setPerson', true)
addEventHandler('setPerson', resourceRoot, function(player, skin)
setElementModel(player, tonumber(skin) )
end)

addEvent('onPlayerRemoveClotheItem', true)
addEventHandler('onPlayerRemoveClotheItem', resourceRoot, function(player, part)
    if (client ~= player) then 
        return 
    end

    if part == 'oculos' then
        removeElementData(player, 'Mascara')
    end

    local clothes = exports['customcharacter']:getPlayerClothesCustom(player)
    clothes[(part == 'perna' and 'short' or part)] = {0, 0}
    --triggerClientEvent(root, "setPlayerClothe", root, player, clothes["skin"], clothes)
    exports['customcharacter']:UpdatePlayerClothes(player, clothes)
    local itens = getPlayerItens(player)
    --triggerClientEvent(player, 'onClientDrawClothesInventory', player, itens, 'update')
end)

addEvent("giveItem:RunyRoupas", true)
addEventHandler("giveItem:RunyRoupas", root, function(player, _, id, item)
    if (isObjectInACLGroup('user.'..getAccountName(getPlayerAccount(player)), aclGetGroup('Console'))) then 
        if (id and item) then
            local receiver = getPlayerFromID(id)
            if (isElement(receiver)) then 
                giveItem(receiver, item)
                
                local itens = getPlayerItens(receiver)
                triggerClientEvent(receiver, 'onClientDrawClothesInventory', receiver, itens, 'update')
            end 
        end
    end
end)

addCommandHandler('clothes', function(player, _, id, item, category)
    if (isObjectInACLGroup('user.'..getAccountName(getPlayerAccount(player)), aclGetGroup('Console'))) then 
        if (id and item) then
            local receiver = getPlayerFromID(id)
            if (isElement(receiver)) then 
                giveItem(receiver, item, category)
            end 
        end
    end
end)

addCommandHandler('takeitem', function(player, _, id, item)
    if (isObjectInACLGroup('user.'..getAccountName(getPlayerAccount(player)), aclGetGroup('Console'))) then 
        if (id and item) then
            local receiver = getPlayerFromID(id)
            if (isElement(receiver)) then 
                takeItem(receiver, item)
            end 
        end
    end
end)

function getPlayerFromID(id)
    for i, v in ipairs(getElementsByType('player')) do
        if not isGuestAccount(getPlayerAccount(v)) and getElementData(v, 'ID') == tonumber(id) then
            return v
        end
    end
    return false
end

function getPlayerItens(player)
    local data = dbPoll(dbQuery(db, 'Select * from inventoryPlayers where user = ?', getAccountName(getPlayerAccount(player))), - 1)
    if (#data ~= 0) then 
        return fromJSON(data[1]['inventory'])
    else 
        return {}
    end
end

function giveItem(player, item, category)
    if not (config.itensX[item]) then 
        return false
    end
    
    local itens = getPlayerItens(player)    
    for i, v in ipairs(itens) do 
        if (v == item) then 
            return exports['runy_equipamentos']:giveItem(player, 'token')
        end
    end
    if config.itensX[item][1] == category then
        table.insert(itens, item)
        if ((#itens - 1) == 0) then 
            dbExec(db, 'Insert into inventoryPlayers(user, inventory) Values(?, ?)', getAccountName(getPlayerAccount(player)), toJSON(itens))
        else
            dbExec(db, 'Update inventoryPlayers set inventory = ? where user = ?', toJSON(itens), getAccountName(getPlayerAccount(player)))
        end
        
        local itens = getPlayerItens(player)
        triggerClientEvent(player, 'onClientDrawClothesInventory', player, itens, 'update')
        
        return true
    end
end

function takeItem(player, item)
    if not (config.itensX[item]) then 
        return false
    end
    local itens = getPlayerItens(player)    
    for i, v in ipairs(itens) do 
        if (v == item) then 
            table.remove(itens, i)
        end
    end
    dbExec(db, 'Update inventoryPlayers set inventory = ? where user = ?', toJSON(itens), getAccountName(getPlayerAccount(player)))
    
    local itens = getPlayerItens(player)
    triggerClientEvent(player, 'onClientDrawClothesInventory', player, itens, 'update')
    
    return true
end