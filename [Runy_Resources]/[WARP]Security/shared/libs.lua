function isElementPlayer(element)
    if (element and isElement(element) and getElementType(element) == "player") then
        return true;
    end
    return false;
end

function getPedWeapons(element)
    local playerWeapons = {};
    if (isElementPlayer(element)) then
        for i = 2, 9 do
            local weapon = getPedWeapon(element, i);
            if (weapon and weapon ~= 0) then
                table.insert(playerWeapons, weapon);
            end
        end
    end
	return playerWeapons;
end


function sendDiscordMessage(imgData, titleEmbed, discordMessage, hook, lua)
    if hook then
        local name = lua and "\nCódigo abaixo:" or ""
        local lua = lua and lua or ""
        local discordData = {
            content = "";
            username = system.core.logs['UserName'];
            avatar_url = system.core.logs['Avatar'];
            embeds = {
                {
                    title = titleEmbed;
                    color = system.core.logs['EmbedColor'];
                    description = discordMessage;
                    footer = {
                        text =  system.core.logs['FooterText'];
                        icon_url = system.core.logs['Icon'];
                    };
                    thumbnail = {
                        url = imgData;
                    };
                    fields = {
                        {
                            name = name;
                            value = lua;
                        }
                    }
                };
            };
        }
        local jsonData = toJSON(discordData)
        jsonData = string.sub(jsonData, 3, #jsonData - 2)

        local sendOptions = {
            headers = {
                ["Content-Type"] = "application/json";
            };
            postData = jsonData;
        };
        fetchRemote(hook, sendOptions, function ()
        end)
    end
end


function getPlayerID(id)
	v = false
	for i, player in ipairs (getElementsByType("player")) do
		if getElementData(player, "ID") == id then
			v = player
			break
		end
	end
	return v
end