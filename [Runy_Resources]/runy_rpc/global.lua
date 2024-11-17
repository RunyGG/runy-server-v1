local config = {
    IDapplication = '1243638745857527848', -- ID da aplicação do Discord.
    logo = 'https://i.imgur.com/a1qJUST.png', -- Logo da aplicação.
    name = 'Runy GG - Battle Royale', -- Nome ao passar o mouse na imagem.
    partidaBattleRoyale = {
        maxPartidas = 40, -- Quantidade máxima de pessoas em uma partida.
    },
}

addEventHandler('onPlayerResourceStart', root, function(nameResource)
    if nameResource == resource then
        triggerClientEvent(source, 'richPresence', source, config)
    end
end)