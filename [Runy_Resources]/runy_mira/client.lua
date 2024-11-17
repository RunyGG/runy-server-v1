Crosshair = {
    crosshairs = {},
    shader = {},
    default = dxCreateTexture("siteM16.png"),
    currentMira = "siteM16.png",
}

function Crosshair.register(weaponid, crosshairpath)
    if not crosshairpath:find(":") then
        crosshairpath = (":%s/%s"):format(getResourceName(sourceResource), crosshairpath)
    end
    assert(fileExists(crosshairpath), "Invalid File for Crosshair.register")
    
    if Crosshair.crosshairs[weaponid] then destroyElement(Crosshair.crosshairs[weaponid]) end
    Crosshair.crosshairs[weaponid] = dxCreateTexture(crosshairpath)
end

function Crosshair.unregister(weaponid)
    if Crosshair.crosshairs[weaponid] then destroyElement(Crosshair.crosshairs[weaponid]) end
    Crosshair.crosshairs[weaponid] = nil
end

function Crosshair.init()
    Crosshair.shader = dxCreateShader("texreplace.fx")
    assert(Crosshair.shader, "Could not create Crosshair Replacement Shader")
    engineApplyShaderToWorldTexture(Crosshair.shader, "siteM16")
    dxSetShaderValue(Crosshair.shader, "gTexture", Crosshair.default)
    addEventHandler("onClientPlayerWeaponSwitch", localPlayer, Crosshair.weaponSwitch)

    bindKey("k", "down", function()
        if Crosshair.currentMira == "siteM16.png" then
            Crosshair.currentMira = "siteM17.png"
        else
            Crosshair.currentMira = "siteM16.png"
        end
        local weapon = getPedWeapon(localPlayer)
        dxSetShaderValue(Crosshair.shader, "gTexture", Crosshair.crosshairs[weapon] or dxCreateTexture(Crosshair.currentMira))
    end)
end

function Crosshair.weaponSwitch(prev, now)
    local weapon = getPedWeapon(localPlayer)
    dxSetShaderValue(Crosshair.shader, "gTexture", Crosshair.crosshairs[weapon] or dxCreateTexture(Crosshair.currentMira))
end

function FnOnPlayerWasted(ammo, killer)
    --if killer == localPlayer then
        playSound("hitmarker-sound.wav")
        local currentTexture = Crosshair.currentMira
        local textureToShow = nil
        
        if currentTexture == "siteM16.png" then
            textureToShow = "hitmarker.png"
        elseif currentTexture == "siteM17.png" then
            textureToShow = "hitmarker2.png"
        end
        
        if textureToShow then
            dxSetShaderValue(Crosshair.shader, "gTexture", dxCreateTexture(textureToShow))

            setTimer(function()
                local weapon = getPedWeapon(localPlayer)
                dxSetShaderValue(Crosshair.shader, "gTexture", Crosshair.crosshairs[weapon] or dxCreateTexture(currentTexture))
            end, 1500, 1)
        end
    --end
end
addEvent('Fn > MatarPlayer',true)
addEventHandler('Fn > MatarPlayer',root,FnOnPlayerWasted)

Crosshair.init()

register = Crosshair.register
unregister = Crosshair.unregister
