local x, y = guiGetScreenSize()
local fonts = {}

function draw_timer() 
    local alpha = interpolateBetween(0, 0, 0, 255, 0, 0, ((getTickCount() - tick_time) / 250), 'Linear') 
    local time_current = interpolateBetween(90000, 0, 0, 0, 0, 0, ((getTickCount() - tick_time) / 90000), 'Linear') 
    min, sec = convertTime(time_current)
    --dxDrawText('Você está caido e tem '..min..':'..sec..' de vida', x / 2, y - 100, x / 2, 0, tocolor(255, 255, 255, alpha * 0.9), 1, 'default', 'center', 'top')
    for i, v in ipairs(config.status.controls) do 
        if (isControlEnabled(v)) then 
            toggleControl(v, false)
        end
    end  
    if (time_current == 0) then 
        removeEventHandler('onClientRender', root, draw_timer)
        startMovingLie(localPlayer, false)
        killPed(localPlayer, responsible)
        showChat(false)
    end
end

addEventHandler('onClientKey', root, function(key, press) 
    if (key == 'e' or key == 'E') then 
        local receiver = localPlayer:getData('myDuo')
        if (isElement(receiver) and getDistanceBetweenPoints3D(Vector3(receiver:getPosition()), Vector3(localPlayer:getPosition())) <= 3) then 
            if (press) then 
                triggerServerEvent('onPlayerSaveDropped', root, localPlayer, receiver)
                localPlayer:setData('saving', true)
            else 
                triggerServerEvent('onPlayerCancelSaveDropped', root, localPlayer)
                localPlayer:setData('saving', false)
            end
        end
        for i, recives in pairs(getElementsByType('player')) do
            if localPlayer ~= recives then
                if localPlayer:getData('dropped') then return end
                if recives:getData('dropped') then
                    if (getDistanceBetweenPoints3D(Vector3(recives:getPosition()), Vector3(localPlayer:getPosition())) <= 3) then 
                        if (press) then 
                            triggerServerEvent('onPlayerAnimKill', root, localPlayer, recives)
                            localPlayer:setData('saving', true)
                        else 
                            triggerServerEvent('onPlayerCancelAnimKill', root, localPlayer)
                            localPlayer:setData('saving', false)
                        end
                    end
                end
            end
        end
    end
end)

addEvent('onClientDrawTimeSamu', true) 
addEventHandler('onClientDrawTimeSamu', root, function(time_, responsible_, weapon_)  
    if not (isEventHandlerAdded('onClientRender', root, draw_timer)) then 
        tick_time, time, responsible, finish, weapon = getTickCount(), time_, responsible_, false, weapon_   
        addEventHandler('onClientRender', root, draw_timer)
        showChat(false)
        startMovingLie(localPlayer, true)
    end
end)

sound = {}

addEvent('soundHit', true) 
addEventHandler('soundHit', root, function(target, time)
    if not target then
        if isElement(sound[localPlayer]) then
            destroyElement(sound[localPlayer])
            sound[localPlayer] = nil
        end
        if isTimer(timerStop) then
            killTimer(timerStop)
            timerStop = nil
        end
        return
    end
    
    local px, py, pz = getElementPosition(target)
    sound[localPlayer] = playSound3D( 'assets/hit1.wav', px, py, pz, true)
    timerStop = setTimer(function()
        if isElement(sound[localPlayer]) then
            destroyElement(sound[localPlayer])
            sound[localPlayer] = nil
        end
    end, time, 1)
end)


addEvent('onClientRemoveTimeSamu', true)
addEventHandler('onClientRemoveTimeSamu', root, 
function() 
    removeEventHandler('onClientRender', root, draw_timer) 
    showChat(false)
    startMovingLie(localPlayer, false)
    for k, v in ipairs(fonts) do
        if (v and isElement(v)) then
            destroyElement(v);
        end
    end
end)

addEventHandler('onClientPlayerDamage', localPlayer, function(attacker, _, bodypart, loss)
    if source:getData("runyInPareamento") then cancelEvent() return end
    if getElementAlpha(source) == 200 then cancelEvent() return end
    if (source:getData('telagem')) then cancelEvent() return end
    
    local receiver = source:getData('myDuo')
    if receiver then
        if attacker then
            if attacker == receiver then 
                cancelEvent() 
                return 
            end
        end
    end
    if bodypart ~= 9 then
        if getPedArmor ( localPlayer ) > 0 then
            local colete = getPedArmor ( localPlayer )
            if colete - loss > 0 then
                setPedArmor(localPlayer, colete - loss)
                cancelEvent()
            else
                if getElementHealth(localPlayer) - loss >= config.status.vida_cair then
                    --setElementHealth(localPlayer, getElementHealth(localPlayer) - (loss)) 
                    setPedArmor(localPlayer, 0)
                    cancelEvent()
                end
            end
        end
        if receiver then
            if attacker then
                if attacker == receiver then cancelEvent() return end
                if (getElementHealth(source) <= config.status.vida_cair) then
                    triggerServerEvent('onPlayerDropDamage', source, source, attacker, attacker:getData('cweapon'), false, loss)
                    cancelEvent()
                end
            else
                if (getElementHealth(source) <= config.status.vida_cair) then
                    triggerServerEvent('onPlayerDropDamage', source, source, attacker, attacker:getData('cweapon'), false, loss)
                    cancelEvent()
                end
            end
        else
            if attacker then
                local xx,yy,zz = getElementPosition(localPlayer)
                triggerServerEvent("DamageServerScreeam", attacker, attacker, {bodypart, loss, xx, yy, zz+1.2}, localPlayer)
            end
        end
    else
        loser = loss
        if attacker then
            loser = loss*6
            triggerServerEvent("onPlayerDropDamage", source, source, attacker, attacker:getData('cweapon'), true, loss)
            local xx,yy,zz = getElementPosition(localPlayer)
            triggerServerEvent("DamageServerScreeam", attacker, attacker, {bodypart, loser, xx, yy, zz+1.2}, localPlayer)
        end
    end
end)

function isEventHandlerAdded( sEventName, pElementAttachedTo, func )
    if type( sEventName ) == 'string' and isElement( pElementAttachedTo ) and type( func ) == 'function' then
        local aAttachedFunctions = getEventHandlers( sEventName, pElementAttachedTo )
        if type( aAttachedFunctions ) == 'table' and #aAttachedFunctions > 0 then
            for i, v in ipairs( aAttachedFunctions ) do
                if v == func then
                    return true
                end
            end
        end
    end
    return false
end

function convertTime(ms) 
    local min = math.floor ( ms/60000 ) 
    local sec = math.floor( (ms/1000)%60 ) 
    if (min < 10) then 
        min = '0'..min 
    end 
    if (sec < 10) then 
        sec = '0'..sec 
    end
    return min, sec 
end

------------------------------------------------       

addEvent("caidoAnimation", true)
addEventHandler("caidoAnimation", root, function(element)
    if not isElement(element) then return end
    setPedAnimation(element, 'CRACK', 'crckdeth2', 0, false, true, false, true)
end) 

addEvent("animtgr", true )
addEventHandler("animtgr", root, function(element, arg, time)
    --iprint(element, arg, time)
    setPedAnimation(element, 'fs.carry', arg, -1, false, true, false, true)
end)

local lie = false

function updateCamera ()
    local state = getKeyState( 'w' )
    if state and localPlayer:getData('liemove:crawling') then
        local x,y,z = getElementPosition ( localPlayer )
        local rot2_x, rot_y, rot2_z = getCameraRotation()
        if not localPlayer:getData('dropped') then
            lie = false
            localPlayer:setData("liemove:crawling", false )
        end
        if isLineOfSightClear ( x, y, z, x - math.sin(math.rad(-rot2_z)) * 1, y + math.cos(math.rad(-rot2_z)) * 1, z ) then
            setElementRotation ( localPlayer, 0,0,-rot2_z )
            setElementPosition ( localPlayer, x - math.sin(math.rad(-rot2_z)) * 0.005, y + math.cos(math.rad(-rot2_z)) * 0.005,z,false)
        end
        if localPlayer:getData('myDuo'):getData('saving') then
            triggerServerEvent('onPlayerCancelSaveDropped', localPlayer:getData('myDuo'), localPlayer:getData('myDuo'))
        end
    end
end
addEventHandler ( "onClientRender", root, updateCamera )

function abortAllStealthKills(player)
    if player:getData('fn:matamata.runy') then
        triggerServerEvent('newPosition', player, player, localPlayer)    
        cancelEvent()
        return
    end
end
addEventHandler("onClientPlayerStealthKill", localPlayer, abortAllStealthKills)
    
    
    function startMovingLie(player, both)
        if both == true then
            lie = true
            player:setData("liemove:crawling", true )
            triggerServerEvent ("startPlayerCrawlingAnimation",player)
        else
            lie = false
            player:setData("liemove:crawling", false )
            --triggerServerEvent ("resetPlayerCrawlingAnimation",player)
        end
    end
    
    addEventHandler( "onClientElementStreamIn", getRootElement( ),function ( )
        if getElementType( source ) == "player" then
            if source:getData("liemove:crawling" ) then
                setPedAnimation(source, 'fs.carry', 'wounded', -1, false, false, true)
            end
        end
    end);
    
    function getPositionInfrontOfElement(element, rot)
        if not element or not isElement(element) then
            return false
        end
        if not meters then
            meters = 3
        end
        local posX, posY, posZ = getElementPosition(element)
        local _, _, rotation = getElementRotation(element)
        posX = posX - math.sin(math.rad(rotation)) * meters
        posY = posY + math.cos(math.rad(rotation)) * meters
        return posX, posY, posZ
    end
    
    function getCameraRotation ()
        local px, py, pz, lx, ly, lz = getCameraMatrix()
        local rotz = 6.2831853071796 - math.atan2 ( ( lx - px ), ( ly - py ) ) % 6.2831853071796
        local rotx = math.atan2 ( lz - pz, getDistanceBetweenPoints2D ( lx, ly, px, py ) )
        rotx = math.deg(rotx)
        rotz = -math.deg(rotz)	
        return rotx, 180, rotz
    end
    
    local loser = 0	
    
    losseX = {}
    TimerX = {}
    function DamageClientScreeam(bodypart, lossX, x1, y1, z1, target)
        if x1 and y1 and z1 then
            if bodypart then
                local losser = (bodypart == 9 and tocolor(200, 30, 30, 180) or tocolor(255, 149, 0, 150))
                tickCount = getTickCount()
                if not losseX[target] then
                    losseX[target] = 0
                end
                losseX[target] = losseX[target] + lossX
                if not isTimer(TimerX[target]) then
                    TimerX[target] = setTimer(function()
                        losseX[target] = 0
                    end, 8000, 1)
                end
                damageing = {x1, y1, z1, losseX[target], losser}
                setTimer(function()
                    tickCount = nil
                    damageing = nil
                end, 500, 1)
            end
        end
    end
    addEvent("DamageClientScreeam", true)
    addEventHandler("DamageClientScreeam", root, DamageClientScreeam)
    
    addEventHandler("onClientRender", root, function()
        if tickCount then
            if damageing then
                local v = damageing
                local px,py,pz = getCameraMatrix()
                local distance = getDistanceBetweenPoints3D(v[1],v[2],v[3],px,py,pz)
                local up = interpolateBetween(0, 0, 0, 25, 0, 0, (getTickCount() - (tickCount))/400, "OutQuad")
                local sx,sy = getScreenFromWorldPosition(v[1],v[2],v[3]) 
                if sx and sy then
                    dxDrawText(math.floor(v[4]), (sx+280), (sy+300)-up, (sx+280), (sy+300)-up, v[5], 2, "default-bold", "center", "bottom", false, false, false ) 
                end 
            end
        end
    end)
    
    function sendHeadshot(attacker, weapon, bodypart)
        if attacker == getLocalPlayer() and bodypart == 9 then
            triggerServerEvent("onServerHeadshot", resourceRoot, source)
        end
    end
    addEventHandler("onClientPedDamage", getRootElement(), sendHeadshot)
    
    function sendBodyshot(attacker, weapon, bodypart)
        if attacker == getLocalPlayer() and bodypart == 3 then
            triggerServerEvent("onServerBodyshot", resourceRoot, source, bodypart)
        end
    end
    addEventHandler("onClientPedDamage", getRootElement(), sendBodyshot)
