function kickAllPlayers(reason)
    local players = getElementsByType("player")
    local kickReason = reason or "Uma manutenção foi iniciada. Volte em breve."

    for _, player in ipairs(players) do
        kickPlayer(player, kickReason)
    end
end


addCommandHandler("kickall", function(player, command, reason)
    if isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(player)), aclGetGroup("Admin")) then

        setServerPassword("runygg2024")

        kickAllPlayers(reason)

        setTimer(function()
            shutdown("Manutenção em andamento. Volte em breve!")
        end, 5000, 1) 
    else
        outputChatBox("Você não tem permissões suficientes para usar este comando.", player, 255, 0, 0)
    end
end)
