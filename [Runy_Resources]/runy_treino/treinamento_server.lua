-- Função para limpar todos os NPCs na dimensão do treino

function limparNPCs(playerID)
    for _, ped in ipairs(getElementsByType("ped")) do
        if getElementDimension(ped) == playerID then
            destroyElement(ped)
        end
    end
end

function iniciarTreino(player, command)
    local playerID = getElementData(player, "ID") or 0 -- Substitua por getElementID se existir uma função para obter um ID exclusivo
    setElementDimension(player, playerID)
    
    exports["runy_inventario"]:giveItem(player, 49, 1)
    exports["runy_inventario"]:giveItem(player, 32, 1)
    exports["runy_inventario"]:giveItem(player, 33, 1)
    exports["runy_inventario"]:giveItem(player, 19, 1)
    exports["runy_inventario"]:giveItem(player, 41, 600)

    triggerEvent("hideKillsMostrar", resourceRoot)
    triggerEvent("hideVivos", resourceRoot)
    triggerEvent("hideShowRadar", resourceRoot)
    
    -- Coordenadas fornecidas para o local de treino
    local x, y, z = 3474.751, -2111.172, 122.887
    
    -- Teleporta o jogador para o local de treino e dá armas
    setElementPosition(player, 3474.751, -2111.172, 122.887)
    setElementDimension(player, playerID)
    --giveWeapon(player, 23, 100, true) -- Dá uma pistola silenciada com 100 balas e define-a como arma selecionada
    --giveWeapon(player, 30, 300) -- Dá uma AK-47 com 300 balas
    
    spawnNPC(player, x, y, z, playerID) -- Cria o NPC imediatamente
end
addEvent("iniciarTreino", true)
addEventHandler("iniciarTreino", resourceRoot, iniciarTreino)

-- Função para spawnar o NPC
function spawnNPC(player, x, y, z, dimension)
    local dimension = getElementData(player, "ID") or 0
    local x, y, z = 3474.751, -2111.172, 122.887
    
    local npc = createPed(2, x, y, z) -- Modelo de NPC escolhido
    setElementDimension(npc, dimension)
    setPedAnimation(npc, "PED", "sprint_civi")
    
    -- Reinicia a animação quando o NPC for atingido
    addEventHandler("onPedDamage", npc, function()
        setTimer(setPedAnimation, 100, 1, source, "PED", "sprint_civi")
    end)
    
    -- Adiciona um ouvinte para quando o NPC for morto
    addEventHandler("onPedWasted", npc, function(ammo, attacker, weapon, bodypart)
        if attacker == player then
            destroyElement(source) -- Destrói o NPC morto
            local dimension = getElementData(player, "ID") or 0
            local x, y, z = 3474.751, -2111.172, 122.887
            spawnNPC(player, x, y, z, dimension) -- Spawna um novo NPC nas mesmas coordenadas
        end
    end)
end

-- Função para sair do treino
function sairDoTreino(player, command)
    local playerID = getElementData(player, "ID") or 0 -- Substitua por getElementID se existir uma função para obter um ID exclusivo
    setElementDimension(player, 0) -- Retorna o jogador para a dimensão padrão
    setElementPosition(player, 0, 0, 3) -- Coloca o jogador em algum lugar seguro, ajuste as coordenadas conforme necessário
    
    exports["runy_inventario"]:takeItem(player, 49, 1)
    exports["runy_inventario"]:takeItem(player, 32, 1)
    exports["runy_inventario"]:takeItem(player, 33, 1)
    exports["runy_inventario"]:takeItem(player, 19, 1)
    exports["runy_inventario"]:takeItem(player, 41, 600)

    limparNPCs(playerID) -- Deleta todos os NPCs na dimensão do treino
    triggerClientEvent(player, "returnToLobbyClientEventNPC", player)
end

addCommandHandler("sair", sairDoTreino)