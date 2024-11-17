local safezonesRunning = {};
local safezoneMarker = {};
local safezoneBlip = {};
local damageTimer = {};
local damageIndex = {};
local objectMarker = {};
local shopings = {};
local waitSafeTimer = {};
local movimentSafeTimer = {};
local r, g, b, a = 255, 215, 0, 10

function getPlayerSquad(player)
    if (getElementData(player, 'myDuo')) then 
        for _, v in pairs(getElementData(player, 'myDuo')) do 
            return v
        end
    end
    return false
end

addEvent('iniciarSafezoneNoServidor', true)
addEventHandler('iniciarSafezoneNoServidor', root, function(dimensao)
    if not (safezonesRunning[dimensao]) then 
        safezonesRunning[dimensao] = true 
        damageIndex[dimensao] = 1 
        createDamageTimer(dimensao)
        createSafeMoviment(dimensao)
        local randomIndex = math.random(1, #config.positions)
        randomPosition = config.positions[randomIndex]
        if (isElement(safezoneMarker[dimensao])) then 
            if isElement(objectMarker[safezoneMarker[dimensao]]) then
                destroyElement(objectMarker[safezoneMarker[dimensao]])
                objectMarker[safezoneMarker[dimensao]] = nil
            end
            destroyElement(safezoneMarker[dimensao])
        end
        if (isElement(safezoneBlip[dimensao])) then 
            destroyElement(safezoneBlip[dimensao])
        end
        safezoneMarker[dimensao] = createMarker(Vector3(unpack(randomPosition)), 'cylinder', config.initial_size, r, g, b, a)
        local pos = config.positionsFinal[math.random(1, 6)][math.random(1, 6)]
        objectMarker[safezoneMarker[dimensao]] = createObject(1945, pos[1], pos[2], pos[3])
        attachElements( safezoneMarker[dimensao], objectMarker[safezoneMarker[dimensao]], 0, 0, 0 )
        setElementAlpha(objectMarker[safezoneMarker[dimensao]], 0)
        safezoneBlip[dimensao] = createBlip(Vector3(unpack(randomPosition)), 21)
        setBlipVisibleDistance ( safezoneBlip[dimensao], 15000 )
        attachElements( safezoneBlip[dimensao], objectMarker[safezoneMarker[dimensao]], 0, 0, 0 )
        setElementData(safezoneBlip[dimensao], 'MarkerBliped', safezoneMarker[dimensao])
        setElementData(safezoneBlip[dimensao], 'fase', damageIndex[dimensao])
        setElementData(safezoneBlip[dimensao], 'safezone', true)
        setElementData(safezoneBlip[dimensao], 'tamanhoGas', config.initial_size)
        setElementData(safezoneBlip[dimensao], 'dimension', dimensao)
        setElementDimension(safezoneMarker[dimensao], dimensao)
        setElementDimension(safezoneBlip[dimensao], dimensao)
        setElementData(safezoneMarker[dimensao], 'safezoneMarker', true)
        for i, v in ipairs(getElementsByType('player')) do 
            if (getElementDimension(v) == tonumber(dimensao)) then 
                setElementData(v, 'temporestantegas', config.timerGas * 60)
            end
        end
    end
end)

addEventHandler( "onElementClicked", root, function( button, state, player )
    if button == "left" and state == "down" then
        if getElementType( source ) == "object" and getElementModel(source) == 1776 then
            local x, y, z = getElementPosition( player )
            local x1, y1, z1 = getElementPosition( source )
            if getDistanceBetweenPoints3D( x, y, z, x1, y1, z1 ) < 6 then
                exports['runy_shop']:openShop(player, 1)
            end
        end
    end
end)

function realivePlayer(player, both)
    if exports['runy_inventario']:getItem(player, 999) > 0 then
        local duo = getElementData(player, 'myDuo')
        if duo then
            if getElementData(duo, "spectatingPlayer") == player and not getElementData(duo, "battleRoyaleRunning") then
                triggerEvent("NZ > updateMission", player, player, "ressuscite1", 1)
                triggerEvent("NZ > updateMission", player, player, "ressuscite2", 1)
                triggerEvent("NZ > updateMission", player, player, "ressuscite3", 1)
                triggerClientEvent(duo, 'onPlayerWasted2', duo, duo)
                triggerEvent('onPlayerRemoveEffectSamu', duo, duo)
                setElementHealth(duo, 100)
                fadeCamera(duo, true, 1000, 0, 0, 0)
                triggerEvent('ChangeBliped', player, player, 'attach')
                setElementData(duo, 'temporestantegas', getElementData(player, 'temporestantegas'))
                setElementDimension(duo, getElementDimension(player))
                setTimer(function(duo)
                    triggerEvent('onPlayerRemoveEffectSamu', duo, duo)
                    fadeCamera(duo, false, 3000, 0, 0, 0)
                    setElementData(duo, 'battleRoyaleRunning', true)
                    removeElementData(duo, "telando")
                    removeElementData(duo, "deadPlayer")
                    removeElementData(duo, "spectatingPlayer")
                    setElementFrozen(duo, false)
                    toggleAllControls(duo, true )
                    showCursor(duo, false)
                    setCameraTarget( duo, duo)
                    setElementAlpha(duo, 255)
                    giveWeapon(duo, 46, 1, true)
                    local x1, y1, z1 = getElementPosition( player )
                    setElementPosition(duo, x1, y1, z1+450)
                end, 1000, 1, duo)
                exports['runy_inventario']:takeItem(player, 999, 1)
            end
        end
    end
end

function createDamageTimer(dimensao)
    if not (safezonesRunning[dimensao]) then
        return
    end
    if (isTimer(damageTimer[dimensao])) then 
        killTimer(damageTimer[dimensao])
    end
    damageTimer[dimensao] = setTimer(function()
        if (config.damages[damageIndex[dimensao]]) then 
            for _, player in ipairs(getElementsByType('player')) do 
                if (getElementDimension(player) == tonumber(dimensao)) then 
                    if (getElementData(player, 'runyInPareamento')) or (getElementData(player, 'battleRoyaleMatch')) or (getElementData(player, 'telando')) then 
                        return 
                    end 
                    local x, y, z = getElementPosition(safezoneMarker[dimensao])
                    local tamanhoGas = getMarkerSize(safezoneMarker[dimensao])
                    local radius = tamanhoGas/2
                    if not (isPlayerInCircle(player, x, y, radius)) then 
                        setElementHealth(player, (getElementHealth(player) - config.damages[damageIndex[dimensao]]))
                    end
                end
            end
        end
    end, config.damageTime * 1000, 0)
end

function createSafeMoviment(dimensao)
    if not (safezonesRunning[dimensao]) then
        return
    end
    if (isTimer(waitSafeTimer[dimensao])) then 
        killTimer(waitSafeTimer[dimensao])
    end
    waitSafeTimer[dimensao] = setTimer(function()
        changeSizeFromSafe(dimensao)
    end, config.timerGas * 60000, 1)
    setTimer(function()
        if isElement(safezoneBlip[dimensao]) then
            damageIndex[dimensao] = damageIndex[dimensao] + 1
            setElementData(safezoneBlip[dimensao], 'fase', damageIndex[dimensao])
        end
        for i, v in ipairs(getElementsByType('player')) do 
            if (getElementDimension(v) == tonumber(dimensao)) then 
                triggerClientEvent(v, "Notify", v, "Faltam 15 segundos para o gás andar!")
                triggerClientEvent(v, "playGasMoveAudio", v, "assets/sounds/15s.mp3")
            end
        end
    end, (config.timerGas * 60000) - 15000, 1)
    for i, v in ipairs(getElementsByType('player')) do 
        if (getElementDimension(v) == tonumber(dimensao)) then 
            triggerClientEvent(v, 'onClientRefreshTickGas', v)
        end
    end
end

function changeSizeFromSafe(dimensao)
    if not (safezonesRunning[dimensao]) then
        return
    end
    if (isTimer(movimentSafeTimer[dimensao])) then 
        killTimer(movimentSafeTimer[dimensao])
    end
    movimentSafeTimer[dimensao] = setTimer(function()
        if (isElement(safezoneMarker[dimensao])) then  
            if (getMarkerSize(safezoneMarker[dimensao]) >= 1) then 
                setMarkerSize(safezoneMarker[dimensao], (getMarkerSize(safezoneMarker[dimensao]) - config.reduce_amount*1.5))
            end
        end
    end, 30 - (damageIndex[dimensao]), 0)

    if damageIndex[dimensao] == config.safeMove then
        local pos = config.positionsFinal[math.random(1, 6)][math.random(1, 6)]
        attachElements( safezoneBlip[dimensao], objectMarker[safezoneMarker[dimensao]], 0, 0, 0 )
    end
    for i, v in ipairs(getElementsByType('player')) do 
        if (getElementDimension(v) == tonumber(dimensao)) then 
            triggerClientEvent(v, 'onClientRefreshTickGas', v)
        end
    end
    setTimer(function()
        if (isTimer(movimentSafeTimer[dimensao])) then 
            killTimer(movimentSafeTimer[dimensao])
        end
        createSafeMoviment(dimensao)
    end, config.timerGas * 60000, 1)
end

function isPlayerInCircle(player, x, y, radius)
    local px, py = getElementPosition(player);
    if ((x-px)^2+(y-py)^2 <= radius^2) then return true; end
    return false;
end

function countPlayersInDimension(dimensao)
    local count = 0
    for _, player in ipairs(getElementsByType('player')) do
        if getElementDimension(player) == dimensao then                                
            count = count + 1
        end
    end 
    return count    
end

function checkAndResetSafezone(dimensao)
    for dimensao, running in pairs(safezonesRunning) do
        if (running) then 
            if countPlayersInDimension(dimensao) == 0 then
                safezonesRunning[dimensao] = false 
                if isElement(objectMarker[safezoneMarker[dimensao]]) then
                    destroyElement(objectMarker[safezoneMarker[dimensao]])
                    objectMarker[safezoneMarker[dimensao]] = nil
                end
                if (isElement(safezoneMarker[dimensao])) then
                    destroyElement(safezoneMarker[dimensao])
                end
                if (isElement(safezoneBlip[dimensao])) then 
                    destroyElement(safezoneBlip[dimensao])
                end
                if (isTimer(damageTimer[dimensao])) then 
                    killTimer(damageTimer[dimensao])
                end
                if (isTimer(waitSafeTimer[dimensao])) then 
                    killTimer(waitSafeTimer[dimensao])
                end
                if (isTimer(movimentSafeTimer[dimensao])) then 
                    killTimer(movimentSafeTimer[dimensao])
                end
            end
        end
    end
end
setTimer(checkAndResetSafezone, 5000, 0)