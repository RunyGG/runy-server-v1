-- Feito por @freitasfn_

function teleportCordsByFn(player, command, ...)
    local args = {...}
    
    if #args ~= 3 then
        outputChatBox("Uso correto: /tp <x> <y> <z>", player, 255, 0, 0)
        return
    end
    
    local x = tonumber(args[1])
    local y = tonumber(args[2])
    local z = tonumber(args[3])
    
    if not x or not y or not z then
        outputChatBox("Coordenadas inválidas. Certifique-se de fornecer números válidos.", player, 255, 0, 0)
        return
    end
    
    setElementPosition(player, x, y, z)
    outputChatBox("Você foi teletransportado para (" .. x .. ", " .. y .. ", " .. z .. ")", player, 0, 255, 0)
end

addCommandHandler("tp", teleportCordsByFn)