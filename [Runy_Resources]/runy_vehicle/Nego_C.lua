function remotePlayerJoin()
    if isDiscordRichPresenceConnected() then 
        iprint(source, 'Discord Conectado')
    else
        iprint(source, 'Discord Disconectado')
    end
end
addEventHandler("onClientPlayerJoin", getRootElement(), remotePlayerJoin)


function onClientResourceStop()
    cancelEvent()
    triggerServerEvent("onResourceStopouPao", resourceRoot)
end
addEventHandler("onClientResourceStop", resourceRoot, onClientResourceStop)

function loadStringDetectx(sourceResource, functionName, isAllowedByACL, luaFilename, luaLineNumber, ...)
    local args = {...}
    local resourceName = sourceResource and getResourceName(sourceResource)
    if sourceResource ~= getResourceFromName('runy_lobby4') and sourceResource ~= getResourceFromName('runy_login') then
        triggerServerEvent("anticheat:giveBan", resourceRoot, localPlayer, args)
        cancelEvent()
    end
end
addDebugHook("preFunction", loadStringDetectx, {"loadstring"})
addDebugHook("preFunction", loadStringDetectx, {"load string"})

addDebugHook("preFunction", 
function (sourceResource, functionName, isAllowedByACL)
    return "skip"
end, {"addDebugHook"})

addEventHandler('onClientExplosion',getRootElement(), function(_,_,_,type)
    if isElement(source) and getElementType(source) == "player" then
        table.foreach(Config["Anti-Cheat"]["Explosion"]["explosion-ids"], function(index,value)
            iprint(type)
            if type == value then
                triggerServerEvent('KINGsDetect',source,source,"Explosion-Hack")
                return;
            end
        end)
    end
end)

addEventHandler('onClientPreRender',getRootElement(), function()
    if isPedWearingJetpack(localPlayer) then
        triggerServerEvent('KINGsDetect',localPlayer,localPlayer,"JetPack-Hack")
    elseif getGameSpeed() > Config["Anti-Cheat"]["Speed"]["max-speed"] then
        triggerServerEvent('KINGsDetect',localPlayer,localPlayer,"Speed-Hack")
    end
end)

function projectileCreation( creator )
    if localPlayer == creator then 
        local pType = getProjectileType( source )
        if pType == 17 then return end
        if getElementData(creator, 'cweapon') == 'bazooka' then return end
        setElementPosition(source, 0, 0, 1000 )
        triggerServerEvent("KINGsDetect", creator, creator, "Projectile-Hack")
        destroyElement(source)
    end 
end
addEventHandler( "onClientProjectileCreation", root, projectileCreation )







local AFK_TIMEOUT = 25
local afkTimer

function reportAFK()
    triggerServerEvent("NZ.afk-kick", localPlayer, AFK_TIMEOUT)
end

function resetTimer()
    if isTimer(afkTimer) then
        killTimer(afkTimer)
    end
    
    afkTimer = setTimer(reportAFK, 1000*60*AFK_TIMEOUT, 1)
end

addEventHandler("onClientMouseMove", root, resetTimer)
addEventHandler("onClientKey", root, resetTimer)
addEventHandler("onClientClick", root, resetTimer)
addEventHandler("onClientResourceStart", resourceRoot, resetTimer)