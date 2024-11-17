function triggerProgressBar(player, duration)
    triggerClientEvent(player, "progressBar", resourceRoot, 10000)
end

addCommandHandler("progressBar",
    function(player, cmd, duration)
        triggerProgressBar(player, 10000)
    end
)