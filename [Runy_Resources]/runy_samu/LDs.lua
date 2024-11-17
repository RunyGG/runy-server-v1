local dropped = {}

function getPlayerSquad(player)
    if (getElementData(player, 'myDuo')) then 
        for _, v in pairs(getElementData(player, 'myDuo')) do 
            return v
        end
    end
    return false
end

addEvent('onPlayerDropDamage', true)
addEventHandler('onPlayerDropDamage', root, function(player, responsible, weapon, headshot, loss)
    if loss == 9999 then
        killPed(player)
    end
    if player:getData('fn:matamata.runy') then
        if headshot then
            exports['runy_armedRace']:newPosition(player, responsible)
        else
            if getElementHealth(player) - loss > 1 then
                setElementHealth(player, getElementHealth(player)-loss)
            else
                exports['runy_armedRace']:newPosition(player, responsible)
            end
        end
        return
    end
    
    
    
    if getElementData(player, "runyInPareamento") then return end
    
    if responsible then
        if getElementData(responsible, 'battleRoyaleRunning') then
        end
        local damage = getElementData(responsible, 'Damage') or 0
        local damageall = getElementData(responsible, 'Damageall') or 0
        setElementData(responsible, 'Damage', damage + loss)
        setElementData(responsible, 'Damageall', damageall + loss)
        triggerEvent("NZ > updateMission", responsible, responsible, "damage1", loss)
        triggerEvent("NZ > updateMission", responsible, responsible, "damage2", loss)
        triggerEvent("NZ > updateMission", responsible, responsible, "damage3", loss)
    end
    if not headshot then
        local receiver = getElementData(player, 'myDuo')
        if (isElement(receiver)) then
            if not getElementData(receiver, "spectatingPlayer") and getElementData(receiver, "battleRoyaleRunning") then
                if dropped[receiver] then
                    if responsible then
                        if weapon then
                            setElementData(responsible, 'level_'..weapon, (getElementData(responsible, 'level_'..weapon) or 0)+0.3)
                        end
                        if getElementData(player, "battleRoyaleRunning") then
                            if getElementData(responsible, 'cweapon') == 'faca' then
                                triggerEvent("NZ > updateMission", responsible, responsible, "knife1", 1)
                                triggerEvent("NZ > updateMission", responsible, responsible, "knife2", 1)
                                triggerEvent("NZ > updateMission", responsible, responsible, "knife3", 1)
                            end
                        --    setElementData(responsible, "rankedkills", getElementData(responsible, 'rankedkills')+2)
                         --   setElementData(player, "rankeddeath", getElementData(player, 'rankeddeath')+1)
                       --     setElementData(receiver, "rankeddeath", getElementData(receiver, 'rankeddeath')+1)
                            triggerEvent("NZ > updateMission", responsible, responsible, "kills1", 2)
                            triggerEvent("NZ > updateMission", responsible, responsible, "kills2", 2)
                            triggerEvent("NZ > updateMission", responsible, responsible, "kills3", 2)
                            
                            triggerEvent("NZ > updateMission", responsible, responsible, "finalize1", 2)
                            triggerEvent("NZ > updateMission", responsible, responsible, "finalize2", 2)
                            triggerEvent("NZ > updateMission", responsible, responsible, "finalize3", 2)
                        else
                            triggerEvent("NZ > updateMission", responsible, responsible, "deathmath1", 1)
                            triggerEvent("NZ > updateMission", responsible, responsible, "deathmath2", 1)
                            triggerEvent("NZ > updateMission", responsible, responsible, "deathmath3", 1)
                        end
                        killPed(player, responsible)
                        killPed(receiver, responsible)
                        removeDroppedEffect(receiver)
                        removeDroppedEffect(player)
                    else
                        setElementData(receiver, "rankeddeath", getElementData(receiver, 'rankeddeath')+1)
                        setElementData(player, "rankeddeath", getElementData(player, 'rankeddeath')+1)
                        killPed(player)
                        killPed(receiver)
                        removeDroppedEffect(receiver)
                        removeDroppedEffect(player)
                        
                    end
                else
                    if not (getElementData(receiver, 'deadPlayer')) then
                        if not (dropped[player]) then 
                            toggleDroped(player, responsible)
                            if weapon then
                                setElementData(responsible, 'level_'..weapon, (getElementData(responsible, 'level_'..weapon) or 0)+0.1)
                            end
                            
                            if getElementData(player, 'myDuo') then
                                triggerEvent('ChangeBliped', receiver, receiver, 'change', 11)
                            end
                        else
                            if getElementHealth(player) - loss > 1 then
                                setElementHealth( player, getElementHealth(player)-loss)
                            else
                                killPed(player, responsible)
                                if getElementData(player, "battleRoyaleRunning") then
                                    if getElementData(responsible, 'cweapon') == 'faca' then
                                        triggerEvent("NZ > updateMission", responsible, responsible, "knife1", 1)
                                        triggerEvent("NZ > updateMission", responsible, responsible, "knife2", 1)
                                        triggerEvent("NZ > updateMission", responsible, responsible, "knife3", 1)
                                    end
                                  --  setElementData(responsible, "rankedkills", getElementData(responsible, 'rankedkills')+1)
                                  --  setElementData(player, "rankeddeath", getElementData(player, 'rankeddeath')+1)
                                    triggerEvent("NZ > updateMission", responsible, responsible, "kills1", 1)
                                    triggerEvent("NZ > updateMission", responsible, responsible, "kills2", 1)
                                    triggerEvent("NZ > updateMission", responsible, responsible, "kills3", 1)
                                    
                                    triggerEvent("NZ > updateMission", responsible, responsible, "finalize1", 1)
                                    triggerEvent("NZ > updateMission", responsible, responsible, "finalize2", 1)
                                    triggerEvent("NZ > updateMission", responsible, responsible, "finalize3", 1)
                                else
                                    triggerEvent("NZ > updateMission", responsible, responsible, "deathmath1", 1)
                                    triggerEvent("NZ > updateMission", responsible, responsible, "deathmath2", 1)
                                    triggerEvent("NZ > updateMission", responsible, responsible, "deathmath3", 1)
                                end
                            end
                        end
                    else
                        if weapon then
                            setElementData(responsible, 'level_'..weapon, (getElementData(responsible, 'level_'..weapon) or 0)+0.1)
                        end
                        if getElementData(player, "battleRoyaleRunning") then
                            if getElementData(responsible, 'cweapon') == 'faca' then
                                triggerEvent("NZ > updateMission", responsible, responsible, "knife1", 1)
                                triggerEvent("NZ > updateMission", responsible, responsible, "knife2", 1)
                                triggerEvent("NZ > updateMission", responsible, responsible, "knife3", 1)
                            end
                        --    setElementData(responsible, "rankedkills", getElementData(responsible, 'rankedkills')+1)
                        --    setElementData(player, "rankeddeath", getElementData(player, 'rankeddeath')+1)
                            triggerEvent("NZ > updateMission", responsible, responsible, "kills1", 1)
                            triggerEvent("NZ > updateMission", responsible, responsible, "kills2", 1)
                            triggerEvent("NZ > updateMission", responsible, responsible, "kills3", 1)
                        else
                            triggerEvent("NZ > updateMission", responsible, responsible, "deathmath1", 1)
                            triggerEvent("NZ > updateMission", responsible, responsible, "deathmath2", 1)
                            triggerEvent("NZ > updateMission", responsible, responsible, "deathmath3", 1)
                        end
                        killPed(player, responsible)
                    end
                end
            else
                if responsible then
                    if getElementData(player, "battleRoyaleRunning") then
                       -- setElementData(responsible, "rankedkills", getElementData(responsible, 'rankedkills')+1)
                      --  setElementData(player, "rankeddeath", getElementData(player, 'rankeddeath')+1)
                        triggerEvent("NZ > updateMission", responsible, responsible, "kills1", 1)
                        triggerEvent("NZ > updateMission", responsible, responsible, "kills2", 1)
                        triggerEvent("NZ > updateMission", responsible, responsible, "kills3", 1)
                    else
                        triggerEvent("NZ > updateMission", responsible, responsible, "deathmath1", 1)
                        triggerEvent("NZ > updateMission", responsible, responsible, "deathmath2", 1)
                        triggerEvent("NZ > updateMission", responsible, responsible, "deathmath3", 1)
                    end
                    if weapon then
                        setElementData(responsible, 'level_'..weapon, (getElementData(responsible, 'level_'..weapon) or 0)+0.1)
                    end
                end
                killPed(player, responsible)
                removeDroppedEffect(player)
                triggerEvent('ChangeBliped', player, player, 'destroy')
                triggerEvent('ChangeBliped', receiver, receiver, 'destroy')
            end
        end
        if responsible then
            if getElementData(player, "battleRoyaleRunning") then
                if getElementData(responsible, 'cweapon') == 'faca' then
                    triggerEvent("NZ > updateMission", responsible, responsible, "knife1", 1)
                    triggerEvent("NZ > updateMission", responsible, responsible, "knife2", 1)
                    triggerEvent("NZ > updateMission", responsible, responsible, "knife3", 1)
                end
                --setElementData(responsible, "rankedkills", getElementData(responsible, 'rankedkills')+1)
           --     setElementData(player, "rankeddeath", getElementData(player, 'rankeddeath')+1)
                triggerEvent("NZ > updateMission", responsible, responsible, "kills1", 1)
                triggerEvent("NZ > updateMission", responsible, responsible, "kills2", 1)
                triggerEvent("NZ > updateMission", responsible, responsible, "kills3", 1)
            else
                triggerEvent("NZ > updateMission", responsible, responsible, "deathmath1", 1)
                triggerEvent("NZ > updateMission", responsible, responsible, "deathmath2", 1)
                triggerEvent("NZ > updateMission", responsible, responsible, "deathmath3", 1)
            end
            if weapon then
                setElementData(responsible, 'level_'..weapon, (getElementData(responsible, 'level_'..weapon) or 0)+0.1)
            end
        end
    else
        givePlayerMoney(responsible, 6)
        local receiver = getElementData(player, 'myDuo')
        if (isElement(receiver)) then
            if not getElementData(receiver, "spectatingPlayer") and getElementData(receiver, "battleRoyaleRunning") then
                if (getElementData(receiver, 'dropped')) then 
                    if weapon then
                        setElementData(responsible, 'level_'..weapon, (getElementData(responsible, 'level_'..weapon) or 0)+0.1)
                    end
                    if getElementData(player, "battleRoyaleRunning") then
                        if getElementData(responsible, 'cweapon') == 'faca' then
                            triggerEvent("NZ > updateMission", responsible, responsible, "knife1", 1)
                            triggerEvent("NZ > updateMission", responsible, responsible, "knife2", 1)
                            triggerEvent("NZ > updateMission", responsible, responsible, "knife3", 1)
                        end
                   --     setElementData(responsible, "rankedkills", getElementData(responsible, 'rankedkills')+2)
                     --   setElementData(player, "rankeddeath", getElementData(player, 'rankeddeath')+1)
                       -- setElementData(player, "rankeddeath", getElementData(receiver, 'rankeddeath')+1)
                        triggerEvent("NZ > updateMission", responsible, responsible, "kills1", 2)
                        triggerEvent("NZ > updateMission", responsible, responsible, "kills2", 2)
                        triggerEvent("NZ > updateMission", responsible, responsible, "kills3", 2)
                    else
                        triggerEvent("NZ > updateMission", responsible, responsible, "deathmath1", 1)
                        triggerEvent("NZ > updateMission", responsible, responsible, "deathmath2", 1)
                        triggerEvent("NZ > updateMission", responsible, responsible, "deathmath3", 1)
                    end
                    killPed(player, responsible)
                    killPed(receiver, responsible)
                    removeDroppedEffect(receiver)
                    removeDroppedEffect(player)
                else
                    if not (dropped[player]) then 
                        toggleDroped(player, responsible)
                        if weapon then
                            setElementData(responsible, 'level_'..weapon, (getElementData(responsible, 'level_'..weapon) or 0)+0.1)
                        end
                        if getElementData(player, "battleRoyaleRunning") then
                            
                            triggerEvent("NZ > updateMission", responsible, responsible, "hs1", 1)
                            triggerEvent("NZ > updateMission", responsible, responsible, "hs2", 1)
                            triggerEvent("NZ > updateMission", responsible, responsible, "hs3", 1)
                            
                            --setElementData(responsible, "rankedkills", getElementData(responsible, 'rankedkills')+2)
                        --    setElementData(player, "rankeddeath", getElementData(player, 'rankeddeath')+1)
                        else
                            triggerEvent("NZ > updateMission", responsible, responsible, "deathmath1", 1)
                            triggerEvent("NZ > updateMission", responsible, responsible, "deathmath2", 1)
                            triggerEvent("NZ > updateMission", responsible, responsible, "deathmath3", 1)
                        end
                        if getElementData(player, 'myDuo') then
                            triggerEvent('ChangeBliped', receiver, receiver, 'change', 11)
                        end
                    else
                        if weapon then
                            setElementData(responsible, 'level_'..weapon, (getElementData(responsible, 'level_'..weapon) or 0)+0.1)
                        end
                        if getElementData(player, "battleRoyaleRunning") then
                            if getElementData(responsible, 'cweapon') == 'faca' then
                                triggerEvent("NZ > updateMission", responsible, responsible, "knife1", 1)
                                triggerEvent("NZ > updateMission", responsible, responsible, "knife2", 1)
                                triggerEvent("NZ > updateMission", responsible, responsible, "knife3", 1)
                            end
                          --  setElementData(responsible, "rankedkills", getElementData(responsible, 'rankedkills')+2)
                          --  setElementData(player, "rankeddeath", getElementData(player, 'rankeddeath')+1)
                            triggerEvent("NZ > updateMission", responsible, responsible, "kills1", 2)
                            triggerEvent("NZ > updateMission", responsible, responsible, "kills2", 2)
                            triggerEvent("NZ > updateMission", responsible, responsible, "kills3", 2)
                        else
                            triggerEvent("NZ > updateMission", responsible, responsible, "deathmath1", 1)
                            triggerEvent("NZ > updateMission", responsible, responsible, "deathmath2", 1)
                            triggerEvent("NZ > updateMission", responsible, responsible, "deathmath3", 1)
                        end
                        killPed(player, responsible)
                    end
                end
            end
        else
            if weapon then
                setElementData(responsible, 'level_'..weapon, (getElementData(responsible, 'level_'..weapon) or 0)+0.1)
            end
            if getElementData(player, "battleRoyaleRunning") then
                if getElementData(responsible, 'cweapon') == 'faca' then
                    triggerEvent("NZ > updateMission", responsible, responsible, "knife1", 1)
                    triggerEvent("NZ > updateMission", responsible, responsible, "knife2", 1)
                    triggerEvent("NZ > updateMission", responsible, responsible, "knife3", 1)
                end
                --setElementData(responsible, "rankedkills", getElementData(responsible, 'rankedkills')+2)
                --setElementData(player, "rankeddeath", getElementData(player, 'rankeddeath')+1)
                triggerEvent("NZ > updateMission", responsible, responsible, "kills1", 2)
                triggerEvent("NZ > updateMission", responsible, responsible, "kills2", 2)
                triggerEvent("NZ > updateMission", responsible, responsible, "kills3", 2)
            end
            killPed(player, responsible)
        end
    end
    if responsible then
        givePlayerMoney(responsible, 2)
    end
end)

function toggleDroped(player, responsible)
    dropped[player] = true
    setElementData(player, 'dropped', getTickCount())
    removePedFromVehicle(player)
    setElementHealth(player, config.status.vida_cair)  
    triggerClientEvent(player, 'onClientDrawTimeSamu', player, config.status.tempo[getElementData(player, 'reduceDesmaio') and 'reduzido' or headshot], responsible, weapon)    
    triggerClientEvent(root, 'caidoAnimation', root, player)
end

local saving = {}
addEvent('onPlayerSaveDropped', true) 
addEventHandler('onPlayerSaveDropped', root, function(player, receiver) 
    if (client ~= player) then cancelEvent() return end 
    if (getElementData(player, 'myDuo') == receiver) then 
        if not (isTimer(saving[player])) then 
            if (getElementData(receiver, 'dropped')) then 
                setPedAnimation(player, 'MEDIC', 'CPR', -1)
                triggerClientEvent(player, 'progressBar', player, 7000)
                givePlayerMoney(player, 1)
                saving[player] = setTimer(function(player, receiver) 
                    if (isElement(player) and isElement(receiver)) then 
                        setPedAnimation(player, nil) 
                        setElementHealth(receiver, 30)
                        removeDroppedEffect(receiver)
                        triggerEvent('ChangeBliped', player, player, 'change', 0)
                        
                        triggerEvent("NZ > updateMission", player, player, "reanimar1", 1)
                        triggerEvent("NZ > updateMission", player, player, "reanimar2", 1)
                        triggerEvent("NZ > updateMission", player, player, "reanimar3", 1)
                        
                    end 
                end, 7000, 1, player, receiver)
            end
        end
    end 
end)

local killanim = {}
addEvent('onPlayerAnimKill', true) 
addEventHandler('onPlayerAnimKill', root, function(player, receiver) 
    if (client ~= player) then cancelEvent() return end 
    if (getElementData(player, 'myDuo') ~= receiver) then 
        if not (isTimer(killanim[player])) then 
            if (getElementData(receiver, 'dropped')) then
                local silent = getElementData(player, 'stylekill')
                if silent then
                    local cfg = config.skill[silent]
                    triggerClientEvent(player, 'progressBar', player, cfg.time)
                    if cfg.animX2 then
                        setTimer(function(player)
                            triggerClientEvent(root, "animtgr", resourceRoot, player, cfg.animX, cfg.time)
                            setTimer(function()
                                triggerClientEvent(root, "animtgr", resourceRoot, player, cfg.animX2, cfg.time)
                            end, 1000, 1)
                        end, 100, 1, player)
                    else
                        triggerClientEvent(root, "animtgr", resourceRoot, player, cfg.animX, cfg.time)
                    end
                    triggerClientEvent(player, 'soundHit', player, receiver, cfg.time)
                    local px1, py1, pz1 = getElementPosition(receiver) 
                    local rx, ry, rz = getElementPosition(player) 
                    setElementPosition(player, px1, py1+1, pz1)		
                    setElementRotation(player, 0, 0, 180)
                    setElementRotation(receiver, 0, 0, 180)
                    killanim[player] = setTimer(function(player, receiver) 
                        if (isElement(player) and isElement(receiver)) then 
                            triggerClientEvent(root, 'animtgr', resourceRoot, receiver, cfg.animtarget, cfg.time)
                            triggerClientEvent(player, 'soundHit', player)
                            if cfg.effect then
                                setPedHeadless(receiver, true)
                            end
                            setTimer(function(player, receiver) 
                                killPed(receiver, player)
                                givePlayerMoney(player, 3)
                                removeDroppedEffect(receiver)
                                triggerEvent('ChangeBliped', receiver, receiver, 'destroy')
                                setPedAnimation(player, nil)
                            end, 1500, 1, player, receiver)
                            triggerEvent("NZ > updateMission", player, player, "killAnimation1", 1)
                            triggerEvent("NZ > updateMission", player, player, "killAnimation2", 1)
                            triggerEvent("NZ > updateMission", player, player, "killAnimation3", 1)
                        end 
                    end, cfg.time, 1, player, receiver)
                else
                    setPedAnimation(player, 'fight_b', 'fightb_g', 5000)
                    triggerClientEvent(player, 'progressBar', player, 5000)
                    triggerClientEvent(player, 'soundHit', player, receiver, 5000)
                    killanim[player] = setTimer(function(player, receiver) 
                        if (isElement(player) and isElement(receiver)) then 
                            triggerClientEvent(player, 'soundHit', player)
                            killPed(receiver, player)
                            givePlayerMoney(player, 3)
                            
                            removeDroppedEffect(receiver)
                            triggerEvent('ChangeBliped', receiver, receiver, 'destroy')
                            setPedAnimation(player, nil) 
                            triggerEvent("NZ > updateMission", player, player, "killAnimation1", 1)
                            triggerEvent("NZ > updateMission", player, player, "killAnimation2", 1)
                            triggerEvent("NZ > updateMission", player, player, "killAnimation3", 1)
                        end 
                    end, 5000, 1, player, receiver)
                end
            end
        end
    end 
end)

addEvent('onPlayerCancelAnimKill', true)
addEventHandler('onPlayerCancelAnimKill', root, function(player)
    if (isTimer(killanim[player])) then 
        killTimer(killanim[player])
        triggerClientEvent(player, 'progressBar', player, 0)
        setPedAnimation(player, nil) 
        triggerClientEvent(player, 'soundHit', player)
    end
end)

addEvent('onPlayerCancelSaveDropped', true)
addEventHandler('onPlayerCancelSaveDropped', root, function(player)
    if (isTimer(saving[player])) then 
        killTimer(saving[player])
        triggerClientEvent(player, 'progressBar', player, 0)
        setPedAnimation(player)
    end
end)

addEventHandler('onPlayerWasted', root, function()
    removeDroppedEffect(source)
end)

function removeDroppedEffect(player, suicide) 
    dropped[player] = false
    setPedHeadless(player, false)
    setPedAnimation(player, nil) 
    triggerClientEvent(player, 'onClientRemoveTimeSamu', player)
    removeElementData(player, 'dropped')
    setPedHeadless(player, false)
    for i, v in ipairs(config.status.controls) do 
        toggleControl(player, v, true)
    end
end
addEvent('onPlayerRemoveEffectSamu', true)
addEventHandler('onPlayerRemoveEffectSamu', root, removeDroppedEffect)

function getPlayerFromID(id)
    for i, v in ipairs(getElementsByType('player')) do
        if not isGuestAccount(getPlayerAccount(v)) and getElementData(v, 'ID') == tonumber(id) then
            return v
        end
    end
    return false
end

function getPlayerPermissions(player, acls) 
    for i, v in ipairs(acls) do 
        if (isObjectInACLGroup('user.'..getAccountName(getPlayerAccount(player)), aclGetGroup(v))) then 
            return true 
        end
    end
end

function startPlayerCrawlingAnimationS ()
    setElementData ( source, "liemove:crawling", true )
end
addEvent( "startPlayerCrawlingAnimation", true )
addEventHandler( "startPlayerCrawlingAnimation", getRootElement(), startPlayerCrawlingAnimationS )

function resetPlayerCrawlingAnimationS ()
    setPedAnimation ( source, false )
end
addEvent( "resetPlayerCrawlingAnimation", true )
addEventHandler( "resetPlayerCrawlingAnimation", getRootElement(), resetPlayerCrawlingAnimationS )


function damageing(target, table, player)
    if target and getElementType( target ) == 'player' then
        local v = table
        triggerClientEvent(target, 'DamageClientScreeam', target, v[1], v[2], v[3], v[4], v[5], player)
    end
end
addEvent("DamageServerScreeam", true)
addEventHandler("DamageServerScreeam", root, damageing)

local pedShotCount = {}

addEvent("onServerBodyshot", true)
function onServerHeadshot(ped)
    if isElement(ped) and getElementType(ped) == "ped" then
        local x, y, z = 3474.751, -2111.172, 122.887
        local model = getElementModel(ped)
        local dimension = getElementDimension(ped)
        local interior = getElementInterior(ped)
        destroyElement(ped)
        setTimer(function()
            local newPed = createPed(model, x, y, z)
            setElementDimension(newPed, dimension)
            setElementInterior(newPed, interior)
            setPedAnimation(newPed, "PED", "sprint_civi")
        end, 1000, 1)
    end
end
addEvent("onServerHeadshot", true)
addEventHandler("onServerHeadshot", resourceRoot, onServerHeadshot)

function onPedDamaged(attacker, weapon, bodypart)
    if not isElement(source) or getElementType(source) ~= "ped" then return end
    local isHeadshot = bodypart == 9
    local isBodyshot = bodypart == 3
    if isBodyshot then
        pedShotCount[source] = (pedShotCount[source] or 0) + 1
        if pedShotCount[source] < 8 then return end
    end
    if not pedShotCount[source] then
        pedShotCount[source] = 0
    end
    if isHeadshot or pedShotCount[source] >= 8 then
        pedShotCount[source] = nil
        local x, y, z = 3474.751, -2111.172, 122.887
        local model = getElementModel(source)
        local dimension = getElementDimension(source)
        local interior = getElementInterior(source)
        
        destroyElement(source)
        
        setTimer(function()
            local newPed = createPed(model, x, y, z)
            setElementDimension(newPed, dimension)
            setElementInterior(newPed, interior)
            setPedAnimation(newPed, "PED", "sprint_civi")
            local randomRotationZ = math.random() * 360
            setElementRotation(newPed, 0, 360, randomRotationZ)
        end, 1000, 1)
    end
end
addEventHandler("onPedDamage", getRootElement(), onPedDamaged)

--[[function increaseKnifeDamage(attacker, weapon, bodypart, loss)
if weapon == 4 then 
    local increasedDamage = loss * 7
    setElementHealth(source, getElementHealth(source) - increasedDamage)
end
end
addEventHandler("onPlayerDamage", root, increaseKnifeDamage)]]