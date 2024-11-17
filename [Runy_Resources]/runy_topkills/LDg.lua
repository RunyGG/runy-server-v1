--[[
    --» sᴄʀɪᴘᴛ ғᴇɪᴛᴏ ᴘᴏʀ » Pedro Developer
--]]

config = {

    notify = function(player, text, type)

        return triggerClientEvent(player, 'addBox', player, text, type);

    end;

    notifyC = function(text, type)

        return triggerEvent('addBox', localPlayer, text, type);

    end; 

    key = 'capslock'; --  // Comando para abrir o painel de musicas 
    
}