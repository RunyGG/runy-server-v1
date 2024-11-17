
local db = dbConnect('sqlite', 'assets/database/data.sqlite')
dbExec(db, 'Create table if not exists perfil (user TEXT, dados TEXT)')

function openInventory(player)
    if (client and client ~= player) then return end
    local itens = getPlayerItens(player)
    triggerClientEvent(player, 'NZ > Perfil', player, itens)
end
addEvent('NZ > perfil', true)
addEventHandler('NZ > perfil', root, openInventory)

addEventHandler("onPlayerLogin", root,function()
    local accName = getAccountName(getPlayerAccount(source))
    local data = dbPoll(dbQuery(db, 'Select * from perfil where user = ?', accName), -1)
    if data and #data > 0 then
    else
        local ID = source:getData('ID')
        local level = source:getData('level') or 0
        local like = source:getData('likes') or 0
        local kill = source:getData('rankedkills') or 1
        local death = source:getData('rankeddeath') or 1
        local nick = source:getName()
        local patente = source:getData('patente') or 'bronze4'
        local position = 999
        dados = {
            banner = '0', avatar = '0', verified = false, likes = like, acc = accName,
            patente = patente, positionRank = position, arma = 'g36c', kills = kill, death = death,
            name = nick, level = level, ID = ID
        }
        dbExec(db, 'Insert into perfil(user, dados) Values(?, ?)', getAccountName(getPlayerAccount(source)), toJSON(dados))
    end
end)

function updatePerfil(player, id, type)
    local accName = getAccountName(getPlayerAccount(player))
    local data = dbPoll(dbQuery(db, 'Select * from perfil where user = ?', accName), -1)
    if type == 'avatar' then
        if data and #data > 0 then
            local dados = getPlayerDados(player)
            local ID = player:getData('ID')
            local like = player:getData('likes') or 0
            local nick = player:getName()
            local kill = player:getData('rankedkills') or 1
            local death = player:getData('rankeddeath') or 1
            local level = player:getData('level') or 0
            local verificado = player:getData('verificado') or false
            local position = 999
            change = {
                banner = dados['banner'], avatar = id, verified = verificado, likes = like, acc = accName,
                patente = patente, positionRank = position, arma = 'g36c', kills = kill, death = death,
                name = nick, level = level, ID = ID
            }
            dbExec(db, 'Update perfil set dados = ? where user = ?', toJSON(change), getAccountName(getPlayerAccount(player)))
        else
            local ID = source:getData('ID')
            local level = source:getData('level') or 0
            local like = source:getData('likes') or 0
            local kill = source:getData('rankedkills') or 1
            local death = source:getData('rankeddeath') or 1
            local nick = source:getName()
            local patente = source:getData('patente') or 'bronze4'
            local position = 999
            local verificado = player:getData('verificado') or false
            dados = {
                banner = '0', avatar = '0', verified = verificado, likes = like, acc = accName,
                patente = patente, positionRank = position, arma = 'g36c', kills = kill, death = death,
                name = nick, level = level, ID = ID
            }
            dbExec(db, 'Insert into perfil(user, dados) Values(?, ?)', getAccountName(getPlayerAccount(source)), toJSON(dados))
        end
    elseif type == 'banner' then
        if data and #data > 0 then
            local dados = getPlayerDados(player)
            local ID = player:getData('ID')
            local like = player:getData('likes') or 0
            local nick = player:getName()
            local kill = player:getData('rankedkills') or 1
            local death = player:getData('rankeddeath') or 1
            local level = player:getData('level') or 0
            local position = 999
            local verificado = player:getData('verificado') or false
            
            change = {
                banner = id, avatar = dados['avatar'], verified = verificado, likes = like, acc = accName,
                patente = patente, positionRank = position, arma = 'g36c', kills = kill, death = death,
                name = nick, level = level, ID = ID
            }
            dbExec(db, 'Update perfil set dados = ? where user = ?', toJSON(change), getAccountName(getPlayerAccount(player)))
        else
            local ID = source:getData('ID')
            local level = source:getData('level') or 0
            local like = source:getData('likes') or 0
            local kill = source:getData('rankedkills') or 1
            local death = source:getData('rankeddeath') or 1
            local nick = source:getName()
            local patente = source:getData('patente') or 'bronze4'
            local position = 999
            dados = {
                banner = '0', avatar = '0', verified = false, likes = like, acc = accName,
                patente = patente, positionRank = position, arma = 'g36c', kills = kill, death = death,
                name = nick, level = level, ID = ID
            }
            dbExec(db, 'Insert into perfil(user, dados) Values(?, ?)', getAccountName(getPlayerAccount(source)), toJSON(dados))
        end
    end
end
addEvent('NZ > updatePerfil', true)
addEventHandler('NZ > updatePerfil', root, updatePerfil)

addCommandHandler( 'perfil', function(pl, _, uid)
    local account = getAccountByID((tonumber(uid)-1000))
    local acc = getAccountName(account)
    local data = dbPoll(dbQuery(db, 'Select * from perfil where user = ?', acc), -1)
    if data and #data > 0 then
        local dados = fromJSON(data[1]['dados'])
        triggerClientEvent(pl, 'NZ > perfil', pl, dados, getAccountName(getPlayerAccount(pl)))
    end
end)

function closeInventory(player)
    triggerClientEvent(player, 'NZ > closePerfil', player)
end
addEvent('NZ > closePerfil', true)
addEventHandler('NZ > closePerfil', root, closeInventory)

function getPlayerFromID(id)
    for i, v in ipairs(getElementsByType('player')) do
        if not isGuestAccount(getPlayerAccount(v)) and getElementData(v, 'ID') == tonumber(id) then
            return v
        end
    end
    return false
end

function getPlayerDados(player)
    local data = dbPoll(dbQuery(db, 'Select * from perfil where user = ?', getAccountName(getPlayerAccount(player))), - 1)
    if (#data ~= 0) then 
        return fromJSON(data[1]['dados'])
    else 
        return {}
    end
end

function getPlayerID(id)
    v = false
    for i, player in ipairs (getElementsByType("player")) do
        if getElementData(player, "ID") == id then
            v = player
            break
        end
    end
    return v
end