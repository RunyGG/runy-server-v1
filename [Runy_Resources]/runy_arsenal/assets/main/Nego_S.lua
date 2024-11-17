local db = dbConnect('sqlite', 'assets/database/data.sqlite')
dbExec(db, 'Create table if not exists equipamentosPlayers(user TEXT, inventory TEXT)')

function openInventory(player)
    if (client and client ~= player) then return end
    local itens = getPlayerItens(player)
    triggerClientEvent(player, 'NZ > openArsenal', player, itens)
end
addEvent('NZ > RunyArsenal', true)
addEventHandler('NZ > RunyArsenal', root, openInventory)

function closeInventory(player)
    triggerClientEvent(player, 'NZ > RunyCloseArsenal', player)
end
addEvent('NZ > RunyCloseArsenal', true)
addEventHandler('NZ > RunyCloseArsenal', root, closeInventory)

addEvent('NZ > EquipWeaponSkin', true)
addEventHandler('NZ > EquipWeaponSkin', root, function(player, item, weapon, ABA, ABA2)
    if (client ~= player) then return end
    if ABA == 'SKINS' and ABA2 == 'MODELOS' then
        setElementData(player, 'newModelWeapon_'..weapon, config.itensX[item].weaponID)
    elseif ABA == 'SKINS' and ABA2 == 'SKINS' then
        setElementData(player, 'AdesiveWeapon_'..weapon, config.itensX[item].textures)
    elseif ABA == 'ATTACHS' then
        if ABA2 == 'PENTE' then
            setElementData(player, 'clip_'..weapon, config.itensX[item].textures)
        elseif ABA2 == 'CORONHA' then
            setElementData(player, 'butt_'..weapon, config.itensX[item].textures)
        elseif ABA2 == 'BOCA' then
            setElementData(player, 'attached_'..weapon, config.itensX[item].textures)
        end
    end
end)

function outputChange(theKey, oldValue, lv)
    if theKey == 'level_five' or theKey == 'level_glock' or theKey == 'level_g36c' or theKey == 'level_skorpion' or theKey == 'level_tec9' or theKey == 'level_mp5' or theKey == 'level_faca' or theKey == 'level_ak' or theKey == 'level_m4' then
        if (getElementType(source) == "player") then
            if dados[theKey] then
                for index, var in pairs(levelGive) do
                    if tonumber(lv or 0) >= index then
                      if var[1] then
                        giveItem(source, var[1]..''..dados[theKey])
                      end
                    end
                end
            end
        end
    end
end
addEventHandler("onElementDataChange", root, outputChange)

levelGive = {
    [1] = {'boca1'},
    [2] = {'pente1', 'padrao'},
    [3] = {'coronha1'},
    [4] = {},
    [5] = {},
    [6] = {},
    [7] = {},
    [8] = {},
    [9] = {},
    [10] = {'silenciador1'},
    [11] = {},
    [12] = {},
    [13] = {},
    [14] = {},
    [15] = {},
    [16] = {},
    [17] = {},
    [18] = {},
    [19] = {},
    [20] = {},
}

dados = {
    ['level_five'] = 'five',
    ['level_glock'] = 'glock',
    ['level_g36c'] = 'g36c',
    ['level_skorpion'] = 'skorpion',
    ['level_tec9'] = 'tec9',
    ['level_mp5'] = 'mp5',
    ['level_faca'] = 'faca',
    ['level_ak'] = 'ak',
    ['level_m4'] = 'm4',
}

addEvent('NZ > RemoveWeaponSkin', true)
addEventHandler('NZ > RemoveWeaponSkin', root, function(player, part, weapon, TYPE2)
    if (client ~= player) then return end
    if TYPE2 == 'MODELOS' then
        removeElementData(player, 'newModelWeapon_'..weapon)
    elseif TYPE2 == 'SKINS' then
        removeElementData(player, 'AdesiveWeapon_'..weapon)
    elseif TYPE2 == 'BOCA' then
        removeElementData(player, 'attached_'..weapon)
    elseif TYPE2 == 'PENTE' then
        removeElementData(player, 'clip_'..weapon)
    elseif TYPE2 == 'CORONHA' then
        removeElementData(player, 'butt_'..weapon)
    end
end)

addEvent("NZ > giveWeaponSkin", true)
addEventHandler("NZ > giveWeaponSkin", root, function(player, _, id, item)
    if (isObjectInACLGroup('user.'..getAccountName(getPlayerAccount(player)), aclGetGroup('Console'))) then 
        if (id and item) then
            local receiver = getPlayerFromID(id)
            if (isElement(receiver)) then 
                giveItem(receiver, item)
            end 
        end
    end
end)

addCommandHandler('skinWeapon', function(player, _, id, item)
    if (isObjectInACLGroup('user.'..getAccountName(getPlayerAccount(player)), aclGetGroup('Console'))) then 
        if (id and item) then
            local receiver = getPlayerFromID(id)
            if (isElement(receiver)) then 
                giveItem(receiver, item)
            end
        end 
    end
end)

addCommandHandler('takeSkin', function(player, _, id, item)
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
    local data = dbPoll(dbQuery(db, 'Select * from equipamentosPlayers where user = ?', getAccountName(getPlayerAccount(player))), - 1)
    if (#data ~= 0) then 
        return fromJSON(data[1]['inventory'])
    else 
        return {}
    end
end

itemsTrue = {
    ['grafite1'] = true,
    ['grafite2'] = true,
    ['grafite3'] = true,
    ['toxico1'] = true,
    ['toxico2'] = true,
    ['toxico3'] = true,
    ['xadrez1'] = true,
    ['xadrez2'] = true,
    ['xadrez3'] = true,
    ['padraoak'] = true,
    ['padraom4'] = true,
    ['padraog36c'] = true,
    ['padraomp5'] = true,
    ['padraotec9'] = true,
    ['padraoskorpion'] = true,
    ['padraofive'] = true,
    ['padraoglock'] = true,
    ['padraofaca'] = true,
    ['m4digital'] = true,
    ['akdragon'] = true,
}

function giveItem(player, item)
    if not (config.itensX[item]) then return false end
    
    local itens = getPlayerItens(player)    
    for i, v in ipairs(itens) do 
        if (v == item) then 
            return (itemsTrue[item] and exports['runy_equipamentos']:giveItem(player, 'token') or false)
        end
    end
    table.insert(itens, item)
    if ((#itens - 1) == 0) then 
        dbExec(db, 'Insert into equipamentosPlayers(user, inventory) Values(?, ?)', getAccountName(getPlayerAccount(player)), toJSON(itens))
    else
        dbExec(db, 'Update equipamentosPlayers set inventory = ? where user = ?', toJSON(itens), getAccountName(getPlayerAccount(player)))
    end
    return true
end

function takeItem(player, item)
    if not (config.itensX[item]) then return false end
    
    local itens = getPlayerItens(player)    
    for i, v in ipairs(itens) do 
        if (v == item) then 
            table.remove(itens, i)
        end
    end
    dbExec(db, 'Update equipamentosPlayers set inventory = ? where user = ?', toJSON(itens), getAccountName(getPlayerAccount(player)))
    return true
end