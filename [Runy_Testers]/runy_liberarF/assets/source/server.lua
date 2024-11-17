function BANCODADOS(res)
    if res == getThisResource() then
        db = dbConnect("mysql", "dbname=s556_runy;host=181.215.45.110;charset=utf8", "u556_fyY3K4KWX6", "hzyK+G+KgJXPjm8V=6vp42m!")       
        -- dbExec(db,"CREATE TABLE IF NOT EXISTS dados (serial,ID,Status)")
    end
    if db then
        outputDebugString("CONEXÃO DATABASE CONCLUIDA")
    else
        outputDebugString("CONEXÃO DATABASE ERRADA")
    end
end
addEventHandler("onResourceStart",resourceRoot,BANCODADOS)

function getPlayerID(id)
    if id then
        v = false
        for i, player in ipairs(getElementsByType("player")) do
            if getElementData(player,ElementDataID) == id then
                v = player
                break
            end
        end
    end
    return v
end

function getFreeID()
    ID = false
    local result = dbPoll(dbQuery(db, "SELECT * FROM dados"),-1)
    if #result ~= 0 then
        local NovoID = (#result +1)
        ID = NovoID
    else
        ID = 1
    end
    return ID
end

function AtualizarWL(serial)
    iprint('Linha 40')
    local result = dbPoll(dbQuery(db, "SELECT * FROM dados WHERE serial =?", serial),-1)
    local novoid = getFreeID()
    if #result ~= 0 then
    else
        if type(novoid) ~= "number" then
            novoid = 1
        end
        dbExec(db, "INSERT INTO dados (serial, id, status) VALUES(?,?,?)", serial, novoid, 0)
        outputConsole("atualizado")
    end
end

 function Connect(_,_,_,serial)
     AtualizarWL(serial)
     local result = dbPoll(dbQuery(db, "SELECT * FROM dados WHERE serial = ?", serial), -1)
     if #result ~= 0 then
         local WL = result[1]["Status"]
         local MeuID = result[1]["ID"]
        if WL == 0 then
             Mensagem = "Por favor libere seu [ID : "..MeuID.."]\nEntre discord.gg/SeuDiscord Para liberar seu ID" -- MENSAGEM CASO NÃO TENHA ID LIBERADO
             cancelEvent(true,Mensagem)
         else
             if IdWL == true then
                 setElementData(source,ElementDataID,MeuID)
                 iprint(getElementData(source, ElementDataID))
             end
         end
     end
 end
addEventHandler("onPlayerConnect",root,Connect)

function isPlayerAuthorized(serial)
    local result = dbPoll(dbQuery(db, "SELECT * FROM dados WHERE serial = ? AND status = 1", serial), -1)
    if result and #result > 0 then
        return true
    else
        return false
    end
end

addEventHandler("onPlayerJoin", root, 
    function(player)
        local serial = getPlayerSerial(source)

        local result = dbPoll(dbQuery(db, "SELECT * FROM dados WHERE serial =?", serial), -1)

        if result and #result > 0 then
            local meuId = result[1]["id"]

            local ply = source
            iprint(meuId)

            if not isPlayerAuthorized(serial) then
                setTimer(
                    function(player)
                        kickPlayer(ply, "Você não está registrado no servidor.\nO seu ID para registro é: "..meuId.."\nPara se liberar, acesse: dsc.gg/runygg." )
                    end
               , 10*2500, 1)
            end
        else
            print("Sem resultados encontrado para o serial: ".. serial)
        end
    end
)