-- Função para enviar notificação do servidor para o cliente
function sendNotification(player, messageText)
    triggerClientEvent(player, "Notify", player, messageText)
end

-- Exemplo de uso:
addCommandHandler("enviarNotificacao", function (player, cmd, messageText)
    if player and messageText then
        sendNotification(player, messageText)
    end
end)
