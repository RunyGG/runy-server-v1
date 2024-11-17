--[[
    --» sᴄʀɪᴘᴛ ғᴇɪᴛᴏ ᴘᴏʀ » Pedro Developer
--]]

config = {

	markerColor = {48, 161, 242, 90};

    notify = function(player, text, type)
        return exports['dx-messages']:addBox(player, text, type);
    end; 

    notifyC = function(text, type)
        return exports['dx-messages']:addBox(text, type)
    end; 

	model = 1579;

}