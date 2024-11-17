ArmaEquipada = {}
UsouFaca = {}
UsouPa = {}
UsouBastao = {}
UsouPicareta = {}
UsouParaqueda = {}
trashs = {}
weaponStates = {}
useJBL = {}
mochilinha = {}
bag = {}
timerSend = {}
mascara = {}

local MuniIDS = { --ID arma jogo, ID munição
[34] = 41,
[32] = 41,
[31] = 41,
[30] = 41,
[33] = 41,
[29] = 41,
[25] = 41,
[23] = 41,
[24] = 41,
}

local weaponMuni = { --ID arma jogo, elementdata munição
[34] = "JOAO.MUNI9MM",
[32] = "JOAO.MUNI9MM",
[31] = "JOAO.MUNI9MM",
[33] = "JOAO.MUNI9MM",
[30] = "JOAO.MUNI9MM",
[29] = "JOAO.MUNI9MM",
[25] = "JOAO.MUNI9MM",
[23] = "JOAO.MUNI9MM",
[24] = "JOAO.MUNI9MM",
[19] = "JOAO.MUNI9MM",
}


local itemGiveMuni = { --elementdata munição, id munição
["JOAO.MUNI556"] = 39,
["JOAO.MUNI762"] = 40,
["JOAO.MUNI9MM"] = 41,
["JOAO.MUNI12MM"] = 42,
}

addEventHandler("onResourceStart", resourceRoot,
function()
    db = dbConnect("sqlite", "dados.sqlite")
    dbExec(db, "CREATE TABLE IF NOT EXISTS Itens (id INTEGER PRIMARY KEY AUTOINCREMENT, account, itemID, nameItem, qnt, category, slot, dataItem)")
    timerGive = setTimer(function()
        for i, v in ipairs(getElementsByType("player")) do
            attInv(v)
            attPeso(v)
            setElementData(v, "pesoMax", config["Weight Template"])
            setElementData(v, "usandoItem", false)
        end
    end, 5000, 1)
    for i, v in ipairs(config["Trash's"]) do
        trashs[i] = createObject(unpack(v))
        setElementData(trashs[i], "JOAO.trash", true)
    end
end)

mascara = {}
mochilinha = {}
timer = {}

addEvent("JOAO.useItem", true)
addEventHandler("JOAO.useItem", root,
function(player, id, qnt, nameItem, identity)
    if player then
        local qnt = tonumber(qnt)
        if not qnt then
            notifyS(player, "A quantidade precisa ser em números!", "error")
            return
        end
        if verifyNumber(qnt) then
            notifyS(player, "Algo de errado com a quantidade!", "error")
            return
        end
        if qnt >= 1 then
            setElementData(player, "usandoItem", true)
            setTimer(function()
                if isElement(player) then
                    if (getElementData(player, "usandoItem") or false) then
                        setElementData(player, "usandoItem", false)
                    end
                end
            end, 700, 1)
            if config["Itens"][id] and config["Itens"][id][2] == 4 and config["Itens weapon"][id] then
                if (getElementData(player, "fn:usandoBandagem")) or (getElementData(player, "fn:usandoColete"))then
                    return notifyS(player, "Você não pode equipar uma arma utilizando outro item.", "error")
                end
                if not ArmaEquipada[player] then 
                    ArmaEquipada[player] = {}
                end 
                local WeaponID = tonumber(config["Itens"][id][4])
                if config["Itens"][id][1] ~= 'faca' then
                    if getItem(player, MuniIDS[WeaponID]) <= 0 and not ArmaEquipada[player][WeaponID] then
                        return
                    else
                        EquipGun(player, id, WeaponID)
                    end
                else
                    EquipKnife(player, id, WeaponID)
                end
            end
            
            if (id == 11) then 
                local NomeItem = config['Itens'][id][1]
                local Health = getElementHealth(player) or 0
                if getElementData(player, "fn:usandoBandagem") then
                    notifyS(player, 'Você ja esta usando uma bandagem!', 'error')
                elseif getElementData(player, "fn:usandoColete") then
                    notifyS(player, 'Você ja esta usando um item!', 'error')
                elseif Health > 99 then
                    notifyS(player, 'Você não precisa de '..NomeItem..'!', 'error')
                else
                    setElementData(player, "fn:usandoBandagem", true)
                    triggerClientEvent(player, "progressBar", root, 8000)
                    toggleControl(player, "fire", false)
                    toggleControl(player, "jump", false)
                    toggleControl(player, "previous_weapon", false)
                    toggleControl(player, "next_weapon", false)
                    takeItem(player, id, qnt)
                    triggerClientEvent(root, "runy_bandagemAnim", root, player)
                    timer[player] = setTimer(function()
                        setElementData(player, "fn:usandoBandagem", false)
                        setElementHealth(player, 100)
                        setPedAnimation(player, nil)
                        setElementFrozen(player, false)
                        toggleControl(player, "fire", true)
                        toggleControl(player, "jump", true)
                        toggleControl(player, "aim_weapon", true)
                        triggerClientEvent(root, "runy_bandagemAnim", root, player, true)
                        triggerEvent("NZ > updateMission", player, player, "bandagem1", 1)
                        triggerEvent("NZ > updateMission", player, player, "bandagem2", 1)
                        triggerEvent("NZ > updateMission", player, player, "bandagem3", 1)
                    end, 8000, 1)
                end
            elseif (id == 19) then 
                exports['mg']:removeQuit(player, player)
                if UsouFaca[player] then 
                    UsouFaca[player] = false 
                    takeWeapon(player, 4)
                else
                    UsouFaca[player] = true
                    --giveWeapon(player, 4, 1, true)
                    setPlayerItemWeapon(player, id, config["Itens"][id][1])
                end
            elseif (id == 20) then 
                if UsouPa[player] then 
                    UsouPa[player] = false 
                    takeWeapon(player, 6)
                    exports['FR_DxMessages']:addBox(player, "Pá desequipado com sucesso!", "success")
                else
                    UsouPa[player] = true
                    giveWeapon(player, 6, 1, true)
                    exports['FR_DxMessages']:addBox(player, "Pá equipado com sucesso!", "success")
                end
            elseif (id == 114) then 
                if UsouParaqueda[player] then 
                    UsouParaqueda[player] = false 
                    takeWeapon(player, 46)
                    exports['FR_DxMessages']:addBox(player, "Pá desequipado com sucesso!", "success")
                else  
                    UsouParaqueda[player] = true
                    giveWeapon(player, 46, 1, true)
                    exports['FR_DxMessages']:addBox(player, "Pá equipado com sucesso!", "success")
                end
            elseif (id == 12) then 
                local NomeItem = config.Itens[id][1]
                local Armour = getPedArmor(player) or 0
                if getElementData(player, "fn:usandoColete") then
                    notifyS(player , 'Você ja esta usando um colete!', 'error')
                elseif getElementData(player, "fn:usandoBandagem") then
                    notifyS(player, 'Você ja esta usando um item!', 'error')
                elseif Armour > 80 then 
                    notifyS(player , 'Você não precisa de um colete!', 'error')
                else
                    setElementData(player, "fn:usandoColete", true)
                    triggerClientEvent(player, "progressBar", root, 8000)
                    toggleControl(player, "fire", false)
                    toggleControl(player, "jump", false)
                    toggleControl(player, "next_weapon", false)
                    toggleControl(player, "previous_weapon", false)
                    takeItem(player, id, qnt)
                    triggerClientEvent(root, "runy_coleteAnim", root, player)
                    timer[player] = setTimer(function()
                        triggerEvent("NZ > updateMission", player, player, "colete1", 1)
                        triggerEvent("NZ > updateMission", player, player, "colete2", 1)
                        triggerEvent("NZ > updateMission", player, player, "colete3", 1)
                        setElementData(player, "fn:usandoColete", false)
                        setPedAnimation(player, nil)
                        setPedArmor(player, 100)
                        setElementFrozen(player, false)
                        toggleControl(player, "fire", true)
                        toggleControl(player, "jump", true)
                        toggleControl(player, "aim_weapon", true)
                        --toggleAllControls(player, true)
                        triggerClientEvent(root, "runy_coleteAnim", root, player, true)
                        --notifyS(player, ''..NomeItem..' utilizado com sucesso!', 'success')
                    end, 8000, 1)
                end
                
            end
        else
            notifyS(player, "Precisa ser acima de 1 item para usar.", "error")
        end
        toggleControl(player, "previous_weapon", false)
        toggleControl(player, "next_weapon", false)
    end
end)

addEvent("JOAO.desequipArmaInvCaido", true)
addEventHandler("JOAO.desequipArmaInvCaido", root,
function(player)

    local QuantiaMun = getElementData(player, weaponMuni[25]) or 0
    if (QuantiaMun >= 1) then
        giveItem(player, itemGiveMuni[weaponMuni[19]], QuantiaMun, {})
        setElementData(player, weaponMuni[19], 0)
    end
    local QuantiaMun = getElementData(player, 'JOAO.MUNI9MM') or 0
    if (QuantiaMun >= 1) then
        giveItem(player, itemGiveMuni['JOAO.MUNI9MM'], QuantiaMun, {})
        setElementData(player, 'JOAO.MUNI9MM', 0)
    end
    local QuantiaMun = getElementData(player, weaponMuni[25]) or 0
    if (QuantiaMun >= 1) then
        giveItem(player, itemGiveMuni[weaponMuni[25]], QuantiaMun, {})
        setElementData(player, weaponMuni[25], 0)
    end
    local QuantiaMun = getElementData(player, weaponMuni[22]) or 0
    if (QuantiaMun >= 1) then
        giveItem(player, itemGiveMuni[weaponMuni[22]], QuantiaMun, {})
        setElementData(player, weaponMuni[22], 0)
    end
    local QuantiaMun = getElementData(player, weaponMuni[31]) or 0
    if (QuantiaMun >= 1) then
        giveItem(player, itemGiveMuni[weaponMuni[31]], QuantiaMun, {})
        setElementData(player, weaponMuni[31], 0)
    end
    local QuantiaMun = getElementData(player, weaponMuni[29]) or 0
    if (QuantiaMun >= 1) then
        giveItem(player, itemGiveMuni[weaponMuni[29]], QuantiaMun, {})
        setElementData(player, weaponMuni[29], 0)
    end
    local QuantiaMun = getElementData(player, weaponMuni[32]) or 0
    if (QuantiaMun >= 1) then
        giveItem(player, itemGiveMuni[weaponMuni[32]], QuantiaMun, {})
        setElementData(player, weaponMuni[32], 0)
    end
    local QuantiaMun = getElementData(player, weaponMuni[33]) or 0
    if (QuantiaMun >= 1) then
        giveItem(player, itemGiveMuni[weaponMuni[33]], QuantiaMun, {})
        setElementData(player, weaponMuni[33], 0)
    end
    local QuantiaMun = getElementData(player, weaponMuni[34]) or 0
    if (QuantiaMun >= 1) then
        giveItem(player, itemGiveMuni[weaponMuni[34]], QuantiaMun, {})
        setElementData(player, weaponMuni[34], 0)
    end
    setElementData(player, "JOAO.AK-47", 0)
    setElementData(player, "JOAO.DOZE", 0)
    setElementData(player, "JOAO.SUBANDPISTOL", 0)
    setElementData(player, "JOAO.MUNIM4ANDSNIPER", 0)
    takeAllWeapons(player)
    ArmaEquipada[player] = {}
    weaponStates[player] = false
    toggleControl(player, "previous_weapon", false)
    toggleControl(player, "next_weapon", false)
    
end)


local AmmoUsed = {}

function EquipGun(player, item, WeaponID)
    local QuantiaMun = getElementData(player, weaponMuni[WeaponID]) or 0
    local AmmoID = config["Itens"][item][5]
    
    if not ArmaEquipada[player] then
        ArmaEquipada[player] = {}
    end
    
    if not AmmoUsed[player] then
        AmmoUsed[player] = {}
    end
    
    exports['mg']:removeQuit(player, player)
    if not ArmaEquipada[player][WeaponID] then 
        local currentAmmo = getItem(player, MuniIDS[WeaponID])
        setElementData(player, weaponMuni[WeaponID], currentAmmo)
        setPlayerItemWeapon(player, WeaponID, config["Itens"][item][1])
        ArmaEquipada[player][WeaponID] = true 
        toggleControl(player, "next_weapon", false)
        toggleControl(player, "previous_weapon", false)
    elseif QuantiaMun >= 1 then
        setPlayerItemWeapon(player, WeaponID, config["Itens"][item][1])
        setElementData(player, weaponMuni[WeaponID], 0)
        toggleControl(player, "next_weapon", false)
        toggleControl(player, "previous_weapon", false)
    end
    
    AmmoUsed[player][WeaponID] = 0
    
    updateAmmoInInventory(player, WeaponID)
    
end

function EquipKnife(player, item, WeaponID)
    if not ArmaEquipada[player] then
        ArmaEquipada[player] = {}
    end
    if not AmmoUsed[player] then
        AmmoUsed[player] = {}
    end
    exports['mg']:removeQuit(player, player)
    if not ArmaEquipada[player][WeaponID] then 
        setPlayerItemWeapon(player, WeaponID, config["Itens"][item][1])
        ArmaEquipada[player][WeaponID] = true 
        toggleControl(player, "next_weapon", false)
        toggleControl(player, "previous_weapon", false)
    end
    
    AmmoUsed[player][WeaponID] = 0
end

function updateAmmoInInventory(player, WeaponID)
    local currentAmmo = getItem(player, MuniIDS[WeaponID]) or 0
    local ammoUsed = AmmoUsed[player][WeaponID] or 0
    local newAmmo = math.max(currentAmmo - ammoUsed, 0)
    local QuantiaMun = getElementData(player, weaponMuni[WeaponID]) or 0
    
    if newAmmo <= 0 then
        setElementData(player, weaponMuni[WeaponID], 0)
        takeItem(player, MuniIDS[WeaponID], currentAmmo)
        if ArmaEquipada[player] then
            ArmaEquipada[player][WeaponID] = nil
        end 
        weaponStates[player] = false
        takeAllWeapons(player)
        exports['mg']:removeQuit(player, player)
        --notifyS(player, "Sua munição acabou.", "info")
    else
        setElementData(player, weaponMuni[WeaponID], newAmmo)
        giveItem(player, MuniIDS[WeaponID], -ammoUsed)
    end
    
    AmmoUsed[player][WeaponID] = 0
    toggleControl(player, "previous_weapon", false)
    toggleControl(player, "next_weapon", false)
end

function onPlayerShoot(player, WeaponID)
    if ArmaEquipada[player] and ArmaEquipada[player][WeaponID] then
        AmmoUsed[player][WeaponID] = (AmmoUsed[player][WeaponID] or 0) + 1
        updateAmmoInInventory(player, WeaponID)
    end
end

addEventHandler("onPlayerWeaponFire", root, function(weaponID)
    local player = source
    onPlayerShoot(player, weaponID)
end)

function setPlayerItemWeapon(player, weapon, name)
    local isWeapon = getPedWeapon(player)
    if weapon then 
        if weaponStates[player] then
            takeAllWeapons(player)
            weaponStates[player] = false
            giveWeapon(player, 0)
            toggleControl(player, "next_weapon", false)
            toggleControl(player, "previous_weapon", false) 
            exports['mg']:removeQuit(player, player)
        else
            weaponStates[player] = true
            takeAllWeapons(player)
            exports['mg']:removeQuit(player, player)
            exports['mg']:giveNewWeapon(player, name, ( name == 'faca' and 1 or (getElementData(player, weaponMuni[weapon]) or 0)), weapon)
            toggleControl(player, "next_weapon", false)
            toggleControl(player, "previous_weapon", false)
        end
    end
end

function giveItem1(player, _, id, item, quantia) 
    if isPlayerAdmin(player) then
        if not tonumber(id) and not tonumber(item) and not tonumber(quantia) then
            notifyS(player, "Digite corretamente. /giveitem [ID] [Item] [Quantia]", "info")
        else
            if config["Itens Special"][tonumber(item)] then notifyS(player, "Esse item não pode ser givado!", "error") return end
            local receiver = getPlayerFromID(tonumber(id))
            if not isElement(receiver) then
                notifyS(player, "Este jogador está ausente!", "info")
            else
                quantiaitem = tonumber(quantia)
                if quantiaitem == nil then 
                    notifyS(player, "Quantia de item invalida!", "error")
                else
                    if (item == nil) then
                        notifyS(player, "Ocorreu algum erro!", "error")
                    else
                        if not (config["Itens"][tonumber(item)]) then
                            notifyS(player, "Este item não existe!", "error")
                        else
                            local weight = math.floor(getElementData(receiver, "pesoInv")) or 0
                            if ((config["Itens"][tonumber(item)][3] * tonumber(quantiaitem)) + weight > (getElementData(player, "pesoMax") or config["Weight Template"])) then
                                notifyS(player, "A mochila do jogador está cheia.", "error")
                                else
                                    local NameItem = tostring(config["Itens"][tonumber(item)][1])
                                    notifyS(player, "Você adicionou "..formatNumber(quantia).."x do item ("..NameItem..") para "..getPlayerName(receiver).."!", "info")
                                        giveItem(receiver, item, tonumber(quantia))
                                        --exports['[BVR]Util']:messageDiscord('O staff '..puxarConta(player)..'('..puxarID(player)..') givou o item '..NameItem..'('..id..') com a quantia '..quantia..' para o jogador '..puxarNome(receiver)..' ', 'https://discord.com/api/webhooks/1025908837330464808/t3HUMBPMO1HAPPHAgR0XbJSKVcBEdMDbCbu6JrUe9g5np8PWsJPPiy7BhTAZkx5TuylT')
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        addCommandHandler("giveitem", giveItem1)
        
        function giveItem(target, item, quantia, dataItem)
            if isTimer(timerGive) then return end
            if target and isElement(target) and getElementType(target) == "player" and tonumber(item) and tonumber(quantia) then
                local NomeItem = tostring(config["Itens"][tonumber(item)][1])
                local weight = math.floor(getElementData(target, "pesoInv")) or 0
                if not isElement(target) then
                    notifyS(target, "O jogador não está online!", "error")
                    return false
                else
                    if (tonumber(quantia) == nil) then 
                        notifyS(target, "Ocorreu algum erro a receber algum item!", "error")
                        return false
                    else
                        if (item == nil) then
                            notifyS(target, "Ocorreu algum erro a receber algum item!", "error")
                            return false
                        else
                            if ((config["Itens"][tonumber(item)][3] * tonumber(quantia)) + weight > (getElementData(target, "pesoMax") or config["Weight Template"])) then
                                notifyS(target, "A sua mochila está cheia.", "error")
                                return false
                            else    
                                
                                local rowItemIndex = dbPoll(dbQuery(db, "SELECT * FROM Itens WHERE account = ? AND itemID = ? LIMIT 1", puxarConta(target), tonumber(item)), -1)
                                if dataItem and config["Itens Special"][item] then
                                    local slotFree = getFreeSlot(puxarConta(target), config["Itens"][tonumber(item)][2])
                                    
                                    dbExec(db, "INSERT INTO Itens(account, itemID, nameItem, qnt, category, slot, dataItem) VALUES(?,?,?,?,?,?,?)", puxarConta(target), tonumber(item), NomeItem..""..dataItem.nameItem, tonumber(quantia), config["Itens"][tonumber(item)][2], slotFree, toJSON(dataItem))
                                else
                                    if #rowItemIndex > 0 then
                                        dbExec(db, "UPDATE Itens SET qnt = ? WHERE itemID = ? AND account = ?", rowItemIndex[1].qnt + tonumber(quantia), tonumber(item), puxarConta(target))
                                    else
                                        
                                        local slotFree = getFreeSlot(puxarConta(target), config["Itens"][tonumber(item)][2])
                                        local itens = getItensPlayer(target)
                                        
                                        if (#itens >= 5) then
                                            
                                            notifyS(target, "A sua mochila está cheia.", "error")
                                            return false
                                            
                                        end
                                        
                                        
                                        dbExec(db, "INSERT INTO Itens(account, itemID, nameItem, qnt, category, slot, dataItem) VALUES(?,?,?,?,?,?,?)", puxarConta(target), tonumber(item), NomeItem, tonumber(quantia), config["Itens"][tonumber(item)][2], slotFree, nil)
                                    end
                                end
                                
                                attInv(target)
                                attPeso(target)
                                
                                return true
                            end 
                        end
                    end
                end
            end
            return false
        end
        addEvent("JOAO.giveItem", true)
        addEventHandler("JOAO.giveItem", root, giveItem)
        
        function checkBackpack(player)
            local itens = getItensPlayer(player)
            if (#itens >= 5) then
                setElementData(player, "backpackFull", true)
                return false
            else
                setElementData(player, "backpackFull", false)
                return true
            end
        end
        
        addEvent("fn:checkbackpack", true)
        addEventHandler("fn:checkbackpack", root, function(player)
            checkBackpack(player)
        end)
        
        function getItensPlayer(player)
            if isElement(player) then
                local rowItemIndex = dbPoll(dbQuery(db, "SELECT * FROM Itens WHERE account = ?", puxarConta(player)), -1)
                if #rowItemIndex > 0 then
                    return rowItemIndex
                end
            end
            return {}
        end
        
        function giveDataItem(account, item, quantia, dataItem)
            if isTimer(timerGive) then return end
            if account and item and quantia and dataItem then
                local receiverByAccount = getPlayerFromAccountName(account)
                if isElement(receiverByAccount) then
                    giveItem(receiverByAccount, item, quantia, dataItem)
                else
                    local NomeItem = tostring(config["Itens"][tonumber(item)][1])
                    local slotFree = getFreeSlot(account, config["Itens"][tonumber(item)][2])
                    dbExec(db, "INSERT INTO Itens(account, itemID, nameItem, qnt, category, slot, dataItem) VALUES(?,?,?,?,?,?,?)", account, tonumber(item), NomeItem..""..dataItem.nameItem, tonumber(quantia), config["Itens"][tonumber(item)][2], slotFree, toJSON(dataItem))
                end
            end
        end
        
        function giveItemRegister(target, item, quantia)
            if isTimer(timerGive) then return end
            if target and isElement(target) and getElementType(target) == "player" and tonumber(item) and tonumber(quantia) then
                local NomeItem = tostring(config["Itens"][tonumber(item)][1])
                local weight = math.floor(getElementData(target, "pesoInv")) or 0
                if not isElement(target) then
                    notifyS(target, "O jogador não está online!", "error")
                else
                    if (tonumber(quantia) == nil) then 
                        notifyS(target, "Ocorreu algum erro a receber algum item!", "error")
                    else
                        if (item == nil) then
                            notifyS(target, "Ocorreu algum erro a receber algum item!", "error")
                        else
                            if ((config["Itens"][tonumber(item)][3] * tonumber(quantia)) + weight > (getElementData(target, "pesoMax") or config["Weight Template"])) then
                                notifyS(target, "A sua mochila está cheia.", "error")
                            else 
                                local rowItemIndex = dbPoll(dbQuery(db, "SELECT * FROM Itens WHERE account = ? AND itemID = ? LIMIT 1", puxarConta(target), tonumber(item)), -1)
                                if #rowItemIndex > 0 then
                                    dbExec(db, "UPDATE Itens SET qnt = ? WHERE itemID = ? AND account = ?", rowItemIndex[1].qnt + tonumber(quantia), tonumber(item), puxarConta(target))
                                else
                                    local slotFree = getFreeSlot(puxarConta(target), config["Itens"][tonumber(item)][2])
                                    dbExec(db, "INSERT INTO Itens(account, itemID, nameItem, qnt, category, slot, dataItem) VALUES(?,?,?,?,?,?,?)", puxarConta(target), tonumber(item), NomeItem, tonumber(quantia), config["Itens"][tonumber(item)][2], slotFree, nil)
                                end
                                attInv(target)
                                attPeso(target)
                                return true
                            end 
                        end
                    end
                end
            end
            return false
        end
        
        function takeItem(target, item, quantia)
            if isTimer(timerGive) then return end
            if target and isElement(target) and getElementType(target) == "player" and tonumber(quantia) then
                if isElement(target) then
                    if item == "all" then -- Verifica se todos os itens devem ser removidos
                        dbExec(db, "DELETE FROM Itens WHERE account = ?", puxarConta(target)) -- Remove todos os itens do jogador
                        attInv(target)
                        attPeso(target)
                        return true
                    else
                        if (tonumber(quantia) == nil) then 
                            notifyS(target, "Ocorreu algum erro a receber algum item!", "error")
                        else
                            if (item == nil) then
                                notifyS(target, "Ocorreu algum erro a receber algum item!", "error")
                            else
                                local itemVerify = tonumber(item)
                                if itemVerify then
                                    local rowItemIndex = dbPoll(dbQuery(db, "SELECT * FROM Itens WHERE account = ? AND itemID = ? LIMIT 1", puxarConta(target), tonumber(item)), -1)
                                    if #rowItemIndex > 0 then
                                        if (rowItemIndex[1].qnt - tonumber(quantia)) > 0 then 
                                            dbExec(db, "UPDATE Itens SET qnt = ? WHERE itemID = ? AND account = ?", rowItemIndex[1].qnt - tonumber(quantia), item, puxarConta(target))
                                        else 
                                            dbExec(db, "DELETE FROM Itens WHERE itemID = ? AND account = ?", item, puxarConta(target))
                                        end
                                        attInv(target)
                                        attPeso(target)
                                        return true 
                                    else 
                                        return false
                                    end
                                else
                                    local rowItemIndex = getInventoryRowByData(puxarConta(target), item)
                                    if rowItemIndex then
                                        dbExec(db, "DELETE FROM Itens WHERE id = ? AND account = ?", rowItemIndex[2], puxarConta(target))
                                        attInv(target)
                                        attPeso(target)
                                        return true 
                                    else 
                                        return false
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        addEvent("JOAO.takeItem", true)
        addEventHandler("JOAO.takeItem", root, takeItem)
        
        
        function takeItemByPlate(target, plate, quantia)
            if isTimer(timerGive) then return end
            if target and isElement(target) and getElementType(target) == "player" and tonumber(quantia) and plate then
                if isElement(target) then
                    if (tonumber(quantia) == nil) then 
                        notifyS(target, "Ocorreu algum erro a receber algum item!", "error")
                    else
                        if (plate == nil) then
                            notifyS(target, "Ocorreu algum erro a receber algum item!", "error")
                        else
                            local rowItemIndex = getInventoryRowByPlate(puxarConta(target), plate)
                            if rowItemIndex then
                                dbExec(db, "DELETE FROM Itens WHERE id = ? AND account = ?", rowItemIndex[2], puxarConta(target))
                                attInv(target)
                                attPeso(target)
                                return true 
                            else 
                                return false
                            end
                        end
                    end
                end
            end
        end
        
        function getItem(player, item)
            amount = 0
            local infosInv = dbPoll(dbQuery(db, "SELECT * FROM Itens WHERE account = ?", puxarConta(player)), -1)
            if type(infosInv) == "table" then
                if #infosInv ~= 0 then
                    for i, v in ipairs(infosInv) do
                        if (item == v.itemID) then
                            amount = amount + tonumber(v.qnt)
                            break
                        end
                    end
                end
            end
            return amount
        end
        addEvent("JOAO.getItem", true)
        addEventHandler("JOAO.getItem", root, getItem)
        
        function getPlayerItems(player)
            local infosInv = dbPoll(dbQuery(db, "SELECT * FROM Itens WHERE account = ?", puxarConta(player)), -1)
            if type(infosInv) == "table" then
                if #infosInv ~= 0 then
                    local items = {}
                    for i, v in ipairs(infosInv) do
                        table.insert(items, {id = v.nameItem, name = v.itemID, quantity = v.qnt})
                    end
                    return items
                end
            end
            return false
        end
        
        function getItemByName(player, item)
            amount = 0
            local infosInv = dbPoll(dbQuery(db, "SELECT * FROM Itens WHERE account = ?", puxarConta(player)), -1)
            if type(infosInv) == "table" then
                if #infosInv ~= 0 then
                    for i, v in ipairs(infosInv) do
                        if (item == v.nameItem) then
                            amount = amount + tonumber(v.qnt)
                            break
                        end
                    end
                end
            end
            return amount
        end
        addEvent("JOAO.getItemByName", true)
        addEventHandler("JOAO.getItemByName", root, getItemByName)
        
        function getItemByData(player, identity)
            amount = 0
            local infosInv = dbPoll(dbQuery(db, "SELECT * FROM Itens WHERE account = ?", puxarConta(player)), -1)
            if type(infosInv) == "table" then
                if #infosInv ~= 0 then
                    for i, v in ipairs(infosInv) do
                        if v.dataItem then
                            local jsonData = fromJSON(v.dataItem)
                            if jsonData.identity == identity then
                                amount = amount + 1
                            end
                        end
                    end
                end
            end
            return amount
        end
        addEvent("JOAO.getItemByData", true)
        addEventHandler("JOAO.getItemByData", root, getItemByData)
        
        function getItemDataByData(player, identity)
            local infosInv = dbPoll(dbQuery(db, "SELECT * FROM Itens WHERE account = ?", puxarConta(player)), -1)
            if type(infosInv) == "table" then
                if #infosInv ~= 0 then
                    for i, v in ipairs(infosInv) do
                        if v.dataItem then
                            local jsonData = fromJSON(v.dataItem)
                            if jsonData.identity == identity then
                                return v.dataItem
                            end
                        end
                    end
                end
            end
            return false
        end
        addEvent("JOAO.getItemDataByData", true)
        addEventHandler("JOAO.getItemDataByData", root, getItemDataByData)
        
        LixosJogados = {}
        LixosRua = {}
        TimerLimparLixo = {}
        
        addEvent("JOAO.dropItem", true)
        addEventHandler("JOAO.dropItem", root, 
        function(player, item, qnt, nameItem, identity)
            
            if getElementDimension(player) == getElementData(player, 'ID') then return end
            
            local qnt = tonumber(qnt)
            if qnt >= 1 then
                if not LixosJogados[(getElementData(player, "ID") or 0)] then 
                    LixosJogados[(getElementData(player, "ID") or 0)] = {}
                end 
                if not LixosJogados[(getElementData(player, "ID") or 0)] or #LixosJogados[(getElementData(player, "ID") or 0)] < 1000000000 then 
                    if config["Itens Special"][item] then
                        itemA = getItemByData(player, identity)
                    else
                        itemA = getItem(player, item)
                    end
                    if itemA >= qnt then
                        LixosJogados[(getElementData(player, "ID") or 0)][#LixosJogados[(getElementData(player, "ID") or 0)]+1] = true
                        returnDataItem = nil
                        if config["Itens Special"][item] then
                            returnDataItem = getItemDataByData(player, identity)
                            takeItem(player, identity, qnt)
                        else
                            takeItem(player, item, qnt)
                        end
                        local x, y, z = getElementPosition(player)
                        local playerDimension = getElementDimension(player)
                        setPedAnimation(player, "carry", "putdwn05", 1000, false, false, false, false)
                        setTimer(function()
                            setPedAnimation(player)
                        end, 1000, 1)
                        
                        exports['runy_loot']:createDroppedItem({ id = nameItem, name = item, quantity = qnt }, x, y, z - 1, playerDimension)
                    else
                        notifyS(player, "Você não tem a quantidade que quer dropar!", "error")
                    end
                else 
                    notifyS(player, "Você já jogou 1000000000 lixos no chão, aguarde o carro do lixo passar!", "error")
                    end
                else
                    notifyS(player, "A quantidade precisa ser maior que 1.", "error")
                end 
            end)
            
            addEventHandler("onMarkerHit", root, 
            function (thePlayer)
                for i, v in pairs(LixosRua) do 
                    if source == i and thePlayer and isElement(thePlayer) and getElementType(thePlayer) == "player" then 
                        triggerClientEvent(thePlayer, "JOAO.openLixo", thePlayer, true)
                        bindKey(thePlayer, "k", "down", pegarItemRua, thePlayer, source, v.item, v.quantidade, v.objeto)
                        break
                    end 
                end 
            end)
            
            function pegarItemRua(player,_,_,thePlayer, Marker, item, quantidade, lixo)
                if thePlayer and isElement(thePlayer) and getElementType(thePlayer) == "player" and thePlayer == player and Marker and isElement(Marker) and isElementWithinMarker(thePlayer, Marker) then 
                    if LixosRua[Marker].responsavel and LixosJogados[LixosRua[Marker].responsavel] then table.remove(LixosJogados[LixosRua[Marker].responsavel]) end
                    if LixosRua[Marker].dataItem then
                        local jsonData = fromJSON(LixosRua[Marker].dataItem)
                        giveItem(thePlayer, item, quantidade, jsonData)
                        notifyS(thePlayer, "Você pegou "..config["Itens"][item][1]..jsonData.nameItem.."("..(quantidade).."x) com sucesso!", "success")
                    else
                        giveItem(thePlayer, item, quantidade)
                        notifyS(thePlayer, "Você pegou "..config["Itens"][item][1].."("..(quantidade).."x) com sucesso!", "success")
                        --exports['[BVR]Util']:messageDiscord('O jogador '..puxarConta(thePlayer)..'('..puxarID(thePlayer)..') pegou o item '..quantidade..'x ('..item..') do chão', 'https://discordapp.com/api/webhooks/1111393480569262090/YF_eZ0nm840uTT5J0GznxwIGSmpcsiPHyhUcrtZd7mp1_aohtRgW6bOij15M7_dZmT8f')
                    end
                    LixosRua[Marker] = nil
                    setPedAnimation(player, "carry", "liftup05", 1000, false, false, false, false)  
                    setTimer(
                    function ()
                        setPedAnimation(player)   
                    end, 1000, 1
                ) 
                for i, v in ipairs(getElementsByType("player")) do
                    if isElementWithinMarker(v, Marker) then
                        triggerClientEvent(v, "JOAO.openLixo", v, false)
                    end
                end
                destroyElement(Marker)
                destroyElement(lixo)
                triggerClientEvent(thePlayer, "JOAO.openLixo", thePlayer, false)
                unbindKey(thePlayer, "k", "down", pegarItemRua)
            end 
        end 
        
        addEventHandler("onMarkerLeave", root, 
        function (thePlayer)
            for i, v in pairs(LixosRua) do 
                if source == i and thePlayer and isElement(thePlayer) and getElementType(thePlayer) == "player" then 
                    triggerClientEvent(thePlayer, "JOAO.openLixo", thePlayer, false)
                    unbindKey(thePlayer, "k", "down", pegarItemRua)
                    break
                end 
            end 
        end)
        
        addCommandHandler("resetinventory",
        function(player, cmd, id)
            if aclGetGroup("Console") and isObjectInACLGroup("user."..puxarConta(player), aclGetGroup("Console")) then
                local id = tonumber(id)
                if id then
                    local receiver = getPlayerFromID(id)
                    if isElement(receiver) then
                        dbExec(db, "DELETE FROM Itens WHERE account = ?", puxarConta(receiver))
                        attInv(receiver)
                        attPeso(receiver)
                        notifyS(player, "Inventário do jogador "..puxarNome(receiver).." #"..puxarID(receiver).." resetado com sucesso!", "success")
                        else
                            notifyS(player, "Jogador inexistente!", "error")
                        end
                    else
                        notifyS(player, "Utilize /resetinventory [ID]", "info")
                    end
                end
            end)
                                
                    function onPlayerWasted()
                        
                        setTimer(function(source)
                            
                            if (isElement(source)) then 
                                
                                triggerClientEvent(source, "JOAO.attActionBar", source)
                                local infosInv = dbPoll(dbQuery(db, "SELECT * FROM Itens WHERE account = ?", puxarConta(source)), -1)
                                if infosInv then
                                    for i, v in ipairs(infosInv) do
                                        if not config["Itens death"][v.itemID] then
                                            dbExec(db, "DELETE FROM Itens WHERE itemID = ? AND account = ?", v.itemID, puxarConta(source))
                                            attInv(source)
                                            attPeso(source)
                                        end
                                    end
                                end
                                takeAllWeapons(source)
                                setElementData(source, "JOAO.MUNI556", 0)
                                setElementData(source, "JOAO.MUNI762", 0)
                                setElementData(source, "JOAO.MUNI9MM", 0)
                                setElementData(source, "JOAO.MUNI12MM", 0)
                                weaponStates[source] = false
                                ArmaEquipada[source] = {}
                                
                            end
                            
                        end, 400, 1, source)
                        -- giveMuni(source)
                    end
                    addEventHandler("onPlayerWasted", root, onPlayerWasted)
                    
                    function getFreeSlot(acc, tab)
                        local result = dbPoll(dbQuery(db, "SELECT slot FROM Itens WHERE account = ? AND category = ? ORDER BY slot ASC", acc, tab), -1)
                        newID = false
                        for i, id in ipairs(result) do
                            if id.slot ~= i then
                                newID = i
                                break
                            end
                        end
                        if not (newID) then
                            newID = #result + 1 
                        end
                        return newID 
                    end
                    
                    function attInv(player)
                        local infosInv = dbPoll(dbQuery(db, "SELECT * FROM Itens WHERE account = ?", puxarConta(player)), -1)
                        triggerClientEvent(player, "JOAO.inserirItem", player, infosInv)
                        
                    end
                    
                    function attPeso(player)
                        if player then
                            setElementData(player, "pesoInv", getPesoInv(player))
                        end
                    end
                    addEvent("JOAO.attPeso", true)
                    addEventHandler("JOAO.attPeso", root, attPeso)
                    
                    function updateSlot(player, item, slot, itemName, identity)
                        local infosInv = dbPoll(dbQuery(db, "SELECT * FROM Itens WHERE account = ?", puxarConta(player)), -1)
                        if identity ~= "false" then
                            local rowItemIndex = getInventoryRowByData(puxarConta(player), identity)
                            local slotLivre = false
                            if rowItemIndex and not slotLivre then
                                dbExec(db, "UPDATE Itens SET slot=? WHERE account = ? AND id = ?", tonumber(slot), puxarConta(player), rowItemIndex[2])
                            end
                        else
                            local rowItemIndex = getInventoryRowItemName(puxarConta(player), itemName)
                            local slotLivre = false
                            if rowItemIndex and not slotLivre then
                                dbExec(db, "UPDATE Itens SET slot=? WHERE account = ? AND nameItem = ?", tonumber(slot), puxarConta(player), itemName)
                            end 
                        end
                        attInv(player)
                    end
                    addEvent("JOAO.updateSlot", true)
                    addEventHandler("JOAO.updateSlot", root, updateSlot)
                    
                    addEventHandler("onPlayerLogin", root,
                    function()
                        attInv(source)
                        attPeso(source)
                    end)
                    
                    function isPlayerAdmin(player)
                        if not isGuestAccount(getPlayerAccount(player)) then
                            if isObjectInACLGroup("user."..puxarConta(player), aclGetGroup("Console")) then
                                return true
                            end    
                        end
                        return false
                    end
                    
                    function verifySlotLivre(accountPlayer, slotItem, aba)
                        local infosInv = dbPoll(dbQuery(db, "SELECT * FROM Itens WHERE account = ?", accountPlayer), -1)
                        if infosInv then
                            for i, v in ipairs(infosInv) do
                                if v.slot == slotItem and v.category == aba then
                                    return true
                                end
                            end
                        end
                        return false
                    end
                    
                    function getIdentityByID(player, idItem)
                        local infosInv = dbPoll(dbQuery(db, "SELECT * FROM Itens WHERE account = ?", puxarConta(player)), -1)
                        if infosInv then
                            for i, v in ipairs(infosInv) do
                                if idItem == v.itemID then
                                    local data = fromJSON(v.dataItem)
                                    return data.identity
                                end
                            end
                        end
                        return false
                    end
                    
                    function getInventoryRowByData(accountPlayer, identity)
                        local infosInv = dbPoll(dbQuery(db, "SELECT * FROM Itens WHERE account = ?", accountPlayer), -1)
                        if infosInv then
                            for i, v in ipairs(infosInv) do
                                if v.dataItem then
                                    local jsonData = fromJSON(v.dataItem)
                                    if jsonData.identity == identity then
                                        return {i, v.id}
                                    end
                                end
                            end
                        end
                        return false
                    end
                    
                    function getInventoryRowByPlate(accountPlayer, plate)
                        local infosInv = dbPoll(dbQuery(db, "SELECT * FROM Itens WHERE account = ?", accountPlayer), -1)
                        if infosInv then
                            for i, v in ipairs(infosInv) do
                                if v.dataItem then
                                    local jsonData = fromJSON(v.dataItem)
                                    if jsonData.plate == plate then
                                        return {i, v.id}
                                    end
                                end
                            end
                        end
                        return false
                    end
                    
                    function getInventoryRowItemName(accountPlayer, itemName)
                        local infosInv = dbPoll(dbQuery(db, "SELECT * FROM Itens WHERE account = ?", accountPlayer), -1)
                        if infosInv then
                            for i, v in ipairs(infosInv) do
                                if v.nameItem == itemName then
                                    return i
                                end
                            end
                        end
                        return false
                    end
                    
                    function getInventoryRowItem(accountPlayer, itemID)
                        local infosInv = dbPoll(dbQuery(db, "SELECT * FROM Itens WHERE account = ?", accountPlayer), -1)
                        if infosInv then
                            for i, v in ipairs(infosInv) do
                                if v.itemID == itemID then
                                    return i
                                end
                            end
                        end
                        return false
                    end
                    
                    function getPesoInv(player)
                        pesoTotal = 0
                        local infosInv = dbPoll(dbQuery(db, "SELECT * FROM Itens WHERE account = ?", getAccountName(getPlayerAccount(player))), -1)
                        if type(infosInv) == "table" then
                            if #infosInv ~= 0 then
                                for i, v in ipairs(infosInv) do
                                    local quantia = tonumber(v.qnt)
                                    local iditem = tonumber(v.itemID)
                                    pesoTotal = pesoTotal + (quantia * config["Itens"][iditem][3])
                                end
                            end
                        end
                        return pesoTotal
                    end
                    
                    function getPlayerFromID(id)
                        if (id) then
                            for i, v in ipairs(getElementsByType("player")) do
                                if not isGuestAccount(getPlayerAccount(v)) then
                                    if (getElementData(v, "ID") == tonumber(id)) then
                                        return v
                                    end
                                end
                            end
                        end
                        return false
                    end
                    
                    function getWeightPlayer(player) 
                        pesoTotal = 0
                        local infosInv = dbPoll(dbQuery(db, "SELECT * FROM Itens WHERE account = ?", puxarConta(player)), -1)
                        if type(infosInv) == "table" then
                            if #infosInv ~= 0 then
                                for i, v in ipairs(infosInv) do
                                    local quantia = tonumber(v.qnt)
                                    local iditem = tonumber(v.itemID)
                                    pesoTotal = pesoTotal + (quantia * config["Itens"][iditem][3])
                                end
                            end
                        end
                        return pesoTotal
                    end
                    
                    function getWeightBau(itens)
                        pesoTotal = 0
                        if type(itens) == "table" then
                            if #itens ~= 0 then
                                for i, v in ipairs(itens) do
                                    local quantia = tonumber(v["quantity"])
                                    local iditem = v.itemID
                                    pesoTotal = pesoTotal + (quantia * config["Itens"][iditem][3])
                                end
                            end
                        end
                        return pesoTotal
                    end
                    
                    function getTablePlayer(accountPlayer)
                        local infosInv = dbPoll(dbQuery(db, "SELECT * FROM Itens WHERE account = ?", accountPlayer), -1)
                        return infosInv
                    end
                    
                    function getItemBlacklist(idItem)
                        if idItem then 
                            if config["BlackList"][idItem] then
                                return config["BlackList"][idItem]
                            end
                        end
                        return false
                    end
                    
                    function getPlayerFromAccountName(name) 
                        local acc = getAccount(name)
                        if not acc or isGuestAccount(acc) then
                            return false
                        end
                        return getAccountPlayer(acc)
                    end