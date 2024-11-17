local db = dbConnect('sqlite', 'assets/database/data.sqlite')
dbExec(db, 'Create table if not exists equipamentosPlayers(user TEXT, inventory TEXT)')

function openInventory(player)
    if (client and client ~= player) then return end
    local itens = getPlayerItens(player)
    setElementDimension(player, getElementData(player, "ID"))
    triggerClientEvent(player, 'NZ > openEquipaments', player, itens)
end
addEvent('NZ > RunyEquipamentos', true)
addEventHandler('NZ > RunyEquipamentos', root, openInventory)

addEvent('NZ > EquipSkin', true)
addEventHandler('NZ > EquipSkin', resourceRoot, function(player, item, aba)
    if (client ~= player) then return end
    if aba == 'rasante' then
        setElementData(player, 'lined', config.itensX[item].color)
    elseif aba == 'paraquedas' then
        setElementData(player, 'parachuteTexture', config.itensX[item].color)
    elseif aba == 'caixas' then
        if item == 'token' then return end
        triggerClientEvent(player, 'NZ > openCrate', player, item)
    elseif aba == 'mochila' then
        setElementData(player, 'Mochila', {config.itensX[item][2], config.itensX[item].color})
    elseif aba == 'avatar' then
        setElementData(player, 'avatar', config.itensX[item][2])
        triggerEvent('NZ > updatePerfil', player, player, config.itensX[item][2], 'avatar')
    elseif aba == 'banner' then
        triggerEvent('NZ > updatePerfil', player, player, config.itensX[item][2], 'banner')
    elseif aba == 'killfeed' then
        setElementData(player, 'killfeed', config.itensX[item][2])
        triggerClientEvent(player, 'addKillLOG', player, 'RunyGG', '0', 'RunyGG', '0', player)
    elseif aba == 'colete' then
        setElementData(player, 'Colete', config.itensX[item].color)
    elseif aba == 'silent' then
        setElementData(player, 'stylekill', config.itensX[item][2])
    end
end)

addEvent('NZ > RemoveSkin', true)
addEventHandler('NZ > RemoveSkin', resourceRoot, function(player, part)
    if (client ~= player) then return end
    if part == 'rasante' then
        removeElementData(player, 'lined')
    elseif part == 'paraquedas' then
        setElementData(player, 'parachuteTexture', 'parachute0')
    elseif part == 'mochila' then
        removeElementData(player, 'Mochila')
    elseif part == 'avatar' then
        setElementData(player, 'avatar', 0)
        triggerEvent('NZ > updatePerfil', player, player, 0, 'avatar')
    elseif part == 'banner' then
        triggerEvent('NZ > updatePerfil', player, player, 0, 'banner')
    elseif part == 'killfeed' then
        removeElementData(player, 'killfeed')
    elseif part == 'colete' then
        removeElementData(player, 'Colete')
    elseif part == 'silent' then
        removeElementData(player, 'stylekill')
    end
end)

addEvent("NZ > giveSkin", true)
addEventHandler("NZ > giveSkin", root, function(player, _, id, item)
    if (isObjectInACLGroup('user.'..getAccountName(getPlayerAccount(player)), aclGetGroup('Console'))) then 
        if (id and item) then
            local receiver = getPlayerFromID(id)
            if (isElement(receiver)) then 
                giveItem(receiver, item)
            end 
        end
    end
end)

-- Comando para adicionar item
addCommandHandler('item', function(player, _, id, item)
    if isObjectInACLGroup('user.'..getAccountName(getPlayerAccount(player)), aclGetGroup('Console')) then 
        if id and item then
            local receiver = getPlayerFromID(id)
            if isElement(receiver) then
                giveItem(receiver, item)
            end 
        end
    end
end)

-- Comando para remover item
addCommandHandler('take', function(player, _, id, item)
    if isObjectInACLGroup('user.'..getAccountName(getPlayerAccount(player)), aclGetGroup('Console')) then 
        if id and item then
            local receiver = getPlayerFromID(id)
            if isElement(receiver) then
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
    local data = dbPoll(dbQuery(db, 'Select * from equipamentosPlayers where user = ?', getAccountName(getPlayerAccount(player))), -1)
    if (#data ~= 0) then 
        return fromJSON(data[1]['inventory'])
    else 
        return {}
    end
end

function getPlayerEquip(player)
    local data = dbPoll(dbQuery(db, 'Select * from equips where user = ?', getAccountName(getPlayerAccount(player))), -1)
    if (#data ~= 0) then 
        return fromJSON(data[1]['inventory'])
    else 
        return {}
    end
end

function giveItem(player, item)
    if not (config.itensX[item]) then return false end
    
    local itens = getPlayerItens(player)
    if item ~= 'token' and not config.itensX[item]['split'] == true then
        for i, v in ipairs(itens) do
            if (v == item) then
                return giveItem(player, 'token')
            end
        end
    end
    
    table.insert(itens, item)
    
    local rowItemIndex = dbPoll(dbQuery(db, "SELECT * FROM equipamentosPlayers WHERE user = ? LIMIT 1", getAccountName(getPlayerAccount(player))), -1)
    
    if #rowItemIndex > 0 then
        dbExec(db, 'Update equipamentosPlayers set inventory = ? where user = ?', toJSON(itens), getAccountName(getPlayerAccount(player)))
    else
        dbExec(db, 'Insert into equipamentosPlayers(user, inventory) Values(?, ?)', getAccountName(getPlayerAccount(player)), toJSON(itens))
    end
    
    triggerClientEvent(player, 'NZ > openEquipaments', player, itens, 'update')
    return true
end

function takeItem(player, item)
    if not (config.itensX[item]) then return false end
    
    local itens = getPlayerItens(player)
    for i, v in ipairs(itens) do
        if (v == item) then
            table.remove(itens, i)
            break
        end
    end
    dbExec(db, 'Update equipamentosPlayers set inventory = ? where user = ?', toJSON(itens), getAccountName(getPlayerAccount(player)))
    triggerClientEvent(player, 'NZ > openEquipaments', player, itens, 'update')
    return true
end
addEvent('NZ > takeItemEquipamments', true)
addEventHandler('NZ > takeItemEquipamments', root, takeItem)

Mochilas = {}
Mascara = {}

function outputChange(theKey, oldValue, newValue)
    if (getElementType(source) == "player") then
        if theKey == 'Mochila' then
            if not newValue then
                if isElement(Mochilas[source]) then
                    destroyElement(Mochilas[source])
                    Mochilas[source] = nil
                end
                return
            end
            if not isElement(Mochilas[source]) then
              --  iprint(newValue)
                Mochilas[source] = createObject(371, -1000, -1000, -1000)
                setElementData(Mochilas[source], 'objectID', newValue[1])
                setElementDimension(Mochilas[source], getElementDimension(source))
                exports.pAttach:attach(Mochilas[source], source, "backpack", 0.1, -0.15, 0, 0, 90, 0)
                if newValue[2] then
                    exports['mg']:loadObjectSkin(source, Mochilas[source], newValue[2])
                end
            else
                setElementData(Mochilas[source], 'objectID', newValue[1])
                if newValue[2] then
                    exports['mg']:loadObjectSkin(source, Mochilas[source], newValue[2])
                end
            end
        elseif theKey == 'Mascara' then
            if not newValue then
                if isElement(Mascara[source]) then
                    destroyElement(Mascara[source])
                    Mascara[source] = nil
                end
                return
            end
            if not isElement(Mascara[source]) then
                Mascara[source] = createObject(371, -1000, -1000, -1000)
                setElementData(Mascara[source], 'objectID', newValue[1])
                setElementDimension(Mascara[source], getElementDimension(source))
                exports.pAttach:attach(Mascara[source], source, "head", 0.16, 0.118, 0.011, 185, 90, 0)
                setElementDoubleSided(Mascara[source], true)
                setObjectScale(Mascara[source], 1.1)
                if newValue[2] then
                    exports['mg']:loadObjectSkin(source, Mascara[source], newValue[2])
                end
            else
                setElementData(Mascara[source], 'objectID', newValue[1])
                if newValue[2] then
                    exports['mg']:loadObjectSkin(source, Mascara[source], newValue[2])
                end
            end
        end
    end
end
addEventHandler("onElementDataChange", root, outputChange)

addEventHandler ( "onPlayerLogin", root, function ( _, acc )
    setTimer ( Carregar_HS, 50, 1, acc )
end)

saveData = {
    'verificado', 'xp', 'level', 'Mascara', 'stylekill', 'avatar', 'killfeed', 'Colete', 'likes', 'Mochila', 'paraquedas', 'rasante', 'newModelWeapon_m4', 
    'AdesiveWeapon_m4', 'attached_m4', 'clip_m4', 'butt_m4', 'newModelWeapon_ak', 'AdesiveWeapon_ak', 'attached_ak', 'clip_ak', 'butt_ak', 'newModelWeapon_faca',
    'AdesiveWeapon_faca', 'attached_faca', 'clip_faca', 'butt_faca', 'newModelWeapon_mp5', 'AdesiveWeapon_mp5', 'attached_mp5', 'clip_mp5', 'butt_mp5', 'newModelWeapon_tec9', 
    'AdesiveWeapon_tec9', 'attached_tec9', 'clip_tec9', 'butt_tec9', 'newModelWeapon_skorpion', 'AdesiveWeapon_skorpion', 'attached_skorpion', 'clip_skorpion', 'butt_skorpion', 
    'newModelWeapon_g36c', 'AdesiveWeapon_g36c', 'attached_g36c', 'clip_g36c', 'butt_g36c', 'newModelWeapon_glock', 'AdesiveWeapon_glock', 'attached_glock', 'clip_glock',
    'butt_glock', 'newModelWeapon_five', 'AdesiveWeapon_five', 'attached_five', 'clip_five', 'butt_five', 'level_five', 'level_glock', 'level_g36c', 'level_skorpion', 'level_tec9',
    'level_mp5', 'level_faca', 'level_ak', 'level_m4', 'DiscordID', 'lined'
}

function Carregar_HS ( conta )
    if not isGuestAccount ( conta ) then
        if conta then	
            local source = getAccountPlayer ( conta )
            for i,v in pairs(saveData) do
                if v == 'Mascara' or v == 'Mochila' or 'lined' then
                    if getAccountData ( conta, v ) then
                        setElementData(source, v, fromJSON(getAccountData ( conta, v )))
                    end
                else
                    setElementData(source, v, getAccountData ( conta, v ))
                end
            end
        end
    end	
end

function Salvar_HS ( conta )
    if conta then
        local source = getAccountPlayer ( conta )
        for i,v in pairs(saveData) do
            if v == 'Mascara' or v == 'Mochila' or 'lined' then
                if getAccountData ( conta, v ) then
                    setAccountData (conta, v, toJSON(getElementData(source, v)))
                end
            else
                setAccountData (conta, v, getElementData(source, v))
            end
        end
    end
end

function Desligar_HS ( res )
    if res == getThisResource ( ) then
        for i, player in ipairs(getElementsByType("player")) do
            local acc = getPlayerAccount ( player )
            if not isGuestAccount ( acc ) then
                Salvar_HS ( acc )
            end
        end
    end
end 
addEventHandler ( "onResourceStop", getRootElement(), Desligar_HS )

function Sair_HS_Servidor ( quitType )
    local acc = getPlayerAccount(source)
    if not isGuestAccount ( acc ) then

        if isElement(Mochilas[source]) then
            destroyElement(Mochilas[source])
            Mochilas[source] = nil
        end
        if isElement(Mascara[source]) then
            destroyElement(Mascara[source])
            Mascara[source] = nil
        end

        Salvar_HS ( acc )
    end
end
addEventHandler ( "onPlayerQuit", getRootElement(), Sair_HS_Servidor )

function Iniciar_Resource ( res )
    if res == getThisResource ( ) then
        for i, player in ipairs(getElementsByType("player")) do
            local acc = getPlayerAccount ( player )
            if not isGuestAccount ( acc ) then
                Carregar_HS ( acc )
            end
        end
    end
end
addEventHandler ( "onResourceStart", getRootElement ( ), Iniciar_Resource )