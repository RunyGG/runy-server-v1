local keyPressTimes = {
    w = 0,
    s = 0,
    d = 0,
    a = 0
}
local lastKeyPressed = nil
local delay = 1500
local rollingBugCooldown = 0
local rollingBugCooldownTime = 5000

local function checkKeyPressDelay()
    local currentTime = getTickCount()
    for key, lastTime in pairs(keyPressTimes) do
        if currentTime - lastTime >= delay then
            return false
        end
    end
    return true
end

local function updateKeyPressTime(key)
    keyPressTimes[key] = getTickCount()
    lastKeyPressed = key
end

addEventHandler("onClientResourceStart", resourceRoot, function()
    FnIFP = engineLoadIFP("files/rolas.ifp", "Rolling")
    if FnIFP then
        outputDebugString("[RunyGG] Animação De Rolamento Processada Com Sucesso")
    else
        outputDebugString("[RunyGG] Erro No Processamento Da Animação De Rolamento")
    end
end)

addEvent("startAnim", true)
addEventHandler("startAnim", getRootElement(), function(element, typeroll)
    local animBlock, animName = getPedAnimation(element)
    if animBlock ~= false and animName ~= false then return end
    if tonumber(typeroll) == 1 then
        setPedAnimation(element, "Rolling", "VRolling_Front", -1, false, true, false, false)
    elseif tonumber(typeroll) == 2 then
        setPedAnimation(element, "Rolling", "VRolling_Back", -1, false, true, false, false)
    elseif tonumber(typeroll) == 3 then
        setPedAnimation(element, "Rolling", "VRolling_Right", -1, false, true, false, false)
    elseif tonumber(typeroll) == 4 then
        setPedAnimation(element, "Rolling", "VRolling_Left", -1, false, true, false, false)
    elseif tonumber(typeroll) == 5 then
        if getTickCount() - rollingBugCooldown >= rollingBugCooldownTime then
            setPedAnimation(element, "Rolling", "VRolling_Bug", -1, false, true, false, false)
            rollingBugCooldown = getTickCount()
            for key, _ in pairs(keyPressTimes) do
                keyPressTimes[key] = 0
            end
            lastKeyPressed = nil
        else
            if getKeyState('mouse2') and (getKeyState('lalt')) and getPedMoveState(localPlayer) ~= 'jump' then
                if lastKeyPressed and keys[lastKeyPressed] then
                    --print("não da pra bugar safadinho")
                    triggerServerEvent('fn > playAnim', localPlayer, localPlayer, keys[lastKeyPressed])
                end
            end
        end
    end
end)

keys = {
    ['w'] = 1,
    ['s'] = 2,
    ['d'] = 3,
    ['a'] = 4
}

moveFunction = function(btn)
    if keys[btn] then
        updateKeyPressTime(btn)
        if getKeyState('mouse2') and (getKeyState('lalt')) and getPedMoveState(localPlayer) ~= 'jump' then
            local armas = weaponsAutorized(getPedWeapon(localPlayer))
            if armas then
                if not isPedInVehicle(localPlayer) then
                    if checkKeyPressDelay() then
                        triggerServerEvent('fn > playAnim', localPlayer, localPlayer, 5) -- VRolling_Bug
                    else
                        triggerServerEvent('fn > playAnim', localPlayer, localPlayer, keys[btn])
                    end
                end
            end
        end
    end
end

for i, v in pairs(keys) do
    bindKey(i, 'down', moveFunction)
end

weaponsAutorized = function(id)
    local armas_autorizadas = {20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 33}
    for i, v in ipairs(armas_autorizadas) do
        if id == v then
            return true
        end
    end
    return false
end