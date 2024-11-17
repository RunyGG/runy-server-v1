config = {
    server_color = {187, 222, 30}, -- RGB

    notify = function(player, text, type)
   
        return triggerClientEvent(player, "Notify", player, text)
        
    end
}