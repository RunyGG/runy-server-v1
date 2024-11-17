local db = dbConnect('sqlite', 'identidade.sqlite') 

dbExec(db, 'Create table if not exists identidade(user, name)') 

addEventHandler('onPlayerLogin', root, 
    function(_, acc) 
        if #dbPoll(dbQuery(db, 'Select * from identidade where user = ?', getAccountName(acc)), -1) ~= 0 then 
            local result = dbPoll(dbQuery(db, 'Select * from identidade where user = ?', getAccountName(acc)), -1) 
            setPlayerName(source, result[1]['name'])
        else 
            triggerClientEvent(source, 'onClientDrawIdentidade', source)      
        end
    end 
)

addEvent('onPlayerRegisterIdentidade', true) 
addEventHandler('onPlayerRegisterIdentidade', root, 
    function(player, user) 
        if string.find(user, '') then 
            if #user > 0 then 
                if #dbPoll(dbQuery(db, 'Select * from identidade where name = ?', string.gsub(user, ' ', '_')), -1) == 0 then
                    dbExec(db, 'Insert into identidade(user, name) Values(?, ?)', getAccountName(getPlayerAccount(player)), string.gsub(user, ' ', '_'))
                    setPlayerName(player, string.gsub(user, ' ', '_'))
                    triggerClientEvent(player, 'onClientRemoveIdentidade', player)
                else
                    message(player, 'Nome ja cadastado!', player)
                end
            else 
                message(player, 'Nome muito curto!', player)
            end
        else 
            message(player, 'Você precisa de um sobrenome!', player)
        end
    end 
)

addEvent('onPlayerSetSkin', true)
addEventHandler('onPlayerSetSkin', root, 
    function(player, skinID) 
        setElementModel(player, skinID)
    end 
)

addEvent('onPlayerResetName', true)
addEventHandler('onPlayerResetName', root, 
    function(player) 
        dbExec(db, 'Delete from identidade where user = ?', getAccountName(getPlayerAccount(player)))
        triggerClientEvent(source, 'onClientDrawIdentidade', source)      
    end
)

addEventHandler('onPlayerChangeNick', root, 
    function() 
        cancelEvent() 
    end
)

function message(player, message, title) 
    --exports['volt_notify']:notify(player, title, text) 
    triggerClientEvent(player, "Notify", player, message)
end