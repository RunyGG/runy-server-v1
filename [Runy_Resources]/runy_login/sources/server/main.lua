tableCodes = {}

addEventHandler("onResourceStart", resourceRoot,
function()
    db = dbConnect("sqlite", "dados.sqlite")
    dbExec(db, "CREATE TABLE IF NOT EXISTS LoginSystem(account, password, serial, email)") 
    dbExec(db, "CREATE TABLE IF NOT EXISTS CodeGenerate(email, code, timestamp)") 
    dbQuery(saveLogins, db, "SELECT * FROM LoginSystem")
    dbQuery(saveCodes, db, "SELECT * FROM CodeGenerate")
end
);

addEvent("JOAO.registerAccount", true)
addEventHandler("JOAO.registerAccount", root,
function(player, account, pass, pass2)
    if account and pass and pass2 then
        if #account < 4 and #pass < 4 then  
            notifyS(player, "Minimo de 4 caracteres para o usuário e senha.", "error")
            return
        end
        
        if pass ~= pass2 then 
            notifyS(player, "As senhas não são iguais.", "error")
            return
        end
        
        if string.find(account, " ") and not string.find(pass, " ") and not string.find(pass2, " ") then
            notifyS(player, "Não pode existir espaços no usuario e senha.", "error")
            return
        end
        
        if #getAccountsBySerial(getPlayerSerial(player)) >= 1 then 
            notifyS(player, "Você já registrou o máximo de contas possíveis.", "error")
            return
        end
        
        if getAccount(account) then
            notifyS(player, "Essa conta já existe.", "error")
            return
        end
        
        local acc = addAccount(account, pass);
        if not acc then 
            notifyS(player, "Falha ao criar a conta, contate a administração!", "error")
            return
        end
        
        triggerClientEvent(player, "JOAO.saveLoginToXML", player, account, pass)
        notifyS(player, "Conta criada com sucesso!, Bem-vindo(a).", "success")
        notifyS(player, "Você logou em sua conta com sucesso!", "success")
        triggerClientEvent(player, "JOAO.closeMenuLogin", player)
        setElementData(player, 'MeloSCR:Logado', true)
        logIn(player, acc, pass);
        setTimer(function ()
            triggerClientEvent(player, "returnToLobbyLoginEvent", player)
        end, 2000, 1)
    end
end
);

Discord = {}

addEvent("JOAO.loginAccount", true)
addEventHandler("JOAO.loginAccount", root, function(player, account, password, discordID)
    Discord[player] = discordID
    setTimer(function(player)
        if #Discord[player] > 0 then
            setElementData(player, 'DiscordID', Discord[player])
        end
    end, 500, 6, player)
    if account and password then
        if not getAccount(account) then
            notifyS(player, "Essa conta não existe!", "error")
            return
        end
        local acc = getAccount(account, password)
        if not acc then 
            notifyS(player, "A senha de sua conta não é essa!", "error") 
            return
        end
        
        triggerClientEvent(player, "JOAO.closeMenuLogin", player)
        triggerClientEvent(player, "JOAO.saveLoginToXML", player, account, password)
        notifyS(player, "Você logou em sua conta com sucesso!", "success")
        setElementData(player, 'MeloSCR:Logado', true)
        logIn(player, acc, password);
        setTimer(function(player)
            triggerClientEvent(player, "returnToLobbyLoginEvent", player)

            --setTimer(function(player)
            --    if #Discord[player] < 1 or not getElementData(player, 'DiscordID') then
            --        kickPlayer( player, player, "ATIVE TODAS AS OPÇÕES NO MENU > MULTIJOGADOR > ABAIXO DO NICK | E MANTENHA SEU DISCORD ABERTO!")
            --    end
            --end, 2000, 1, player)


        end, 1000, 1, player)
    end
end);

function isCodeVerifyGenerate(code)
    for i, v in pairs(tableCodes) do
        if v.code == code then
            return i
        end
    end
    return false
end

function isAccountByEmail(email)
    for i, v in pairs(tableAccounts) do
        if v.email == email then
            return i
        end
    end
    return false
end

function verifyAccounts(serial)
    countSerial = 0
    if tableAccounts then
        for i, v in pairs(tableAccounts) do
            if v.serial == serial then
                countSerial = countSerial + 1
            end
        end
    end
    return countSerial
end

function saveLogins(queryTable)
    local result = dbPoll(queryTable, 0)
    for i=1, #result do
        local row = result[i]
        tableAccounts[row.account] = row
    end
end

function saveCodes(queryTable)
    local result = dbPoll(queryTable, 0)
    for i=1, #result do
        local row = result[i]
        tableCodes[row.email] = row
    end
end

function gerarCodigo(numberGerar)
    Letters = {'a', 'A', 'b', 'B', 'c', 'C', 'd', 'D', 'e', 'E', 'f', 'F', 'g', 'G', 'h', 'H', 'i', 'I', 'j', 'J', 'k', 'K', 'l', 'L', 'm', 'M', 'n', 'N', 'o', 'O', 'p', 'P', 'q', 'Q', 'r', 'R', 's', 'S', 't', 'T', 'u', 'U', 'v', 'V', 'w', 'W', 'x', 'X', 'y', 'Y', 'z', 'Z', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0'}
    sas = ''
    for i=1, numberGerar do
        sas = sas ..Letters[math.random(#Letters)]
    end
    return sas
end