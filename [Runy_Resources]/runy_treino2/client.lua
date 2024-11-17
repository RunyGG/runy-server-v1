screenW, screenH = guiGetScreenSize()
sW, sH = (screenW/1366), (screenH/768)

local targetModel = 1598
local targetRadius = 10
local targets = {}
local maxTargets = 8
local inTraining = false
local originalDim = 0
local originalPos = {}
local trainingPos = {3474.751, -2111.172, 122.887}
local timerDuration = 90000 -- 1 minuto em milissegundos
local timer = nil
local points = 0
local isTimerActive = false

function Texto(text, x1, y1, w1, h1, ...)
    return dxDrawText(text, sW * x1, sH * y1, sW * w1, sH * h1, ...)
end

function Image(x1, y1, w1, h1, ...)
    return dxDrawImage(sW * x1, sH * y1, sW * w1, sH * h1, ...)
end

local font = dxCreateFont("assets/fonts/font.ttf", sW * 20)

function createTarget()
    if #targets >= maxTargets then return end
    local angle = math.random() * 2 * math.pi
    local x, y = trainingPos[1] + math.cos(angle) * targetRadius, trainingPos[2] + math.sin(angle) * targetRadius
    local z = (math.random(1, 5))+122
    local target = createObject(targetModel, x, y, z)
    setElementDimension(target, getElementDimension(localPlayer))
    
    table.insert(targets, target)
end

function removeTargets()
    for _, target in ipairs(targets) do
        if isElement(target) then
            destroyElement(target)
        end
    end
    targets = {}
    inTraining = false
end
addEvent("removeTargets", true)
addEventHandler("removeTargets", resourceRoot, removeTargets)

function toggleTraining()
    inTraining = not inTraining

    if inTraining then
        originalDim = getElementDimension(localPlayer)
        originalPos = {getElementPosition(localPlayer)}

        local playerDimensionId = getElementData(localPlayer, "ID")
        if type(playerDimensionId) ~= "number" then
            outputChatBox("Erro: ID de dimensão inválido.")
            return
        end

        setElementDimension(localPlayer, playerDimensionId)
        setElementPosition(localPlayer, 3473.054, -2131.53, 122.887)

        triggerServerEvent("givePlayerWeapons", resourceRoot, localPlayer)

        for i = 1, maxTargets do
            createTarget()
        end
    else
        setElementDimension(localPlayer, originalDim)
        setElementPosition(localPlayer, unpack(originalPos))
        triggerServerEvent("takePlayerWeapons", resourceRoot, localPlayer)
        removeTargets()
        resetTimer()
    end
end

addEvent("BALAOTREINO", true)
addEventHandler("BALAOTREINO", resourceRoot, toggleTraining)
addCommandHandler("balao", toggleTraining)

function onWeaponFire(weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement)
    if inTraining then
        --[[ if not isTimerActive then
            startTimer()
        end ]]

        local hit = false
        for i, target in ipairs(targets) do
            if hitElement == target then
                destroyElement(target)
                table.remove(targets, i)
                createTarget()
                hit = true
                break
            end
        end
        if isTimerActive then
            if hit then
                points = points + 1
            else
                points = points - 1
            end
        end
    end
end

addEventHandler("onClientPlayerWeaponFire", localPlayer, onWeaponFire)

function startTimer()
    if not isTimerActive then
        timer = setTimer(resetTimer, timerDuration, 1)
        isTimerActive = true
    end
end

function resetTimer()
    if isTimerActive then
        if isTimerActive then
            killTimer(timer)
        end
        points = 0
        isTimerActive = false
    end
end

addEventHandler('onClientKey', root, 

    function(key, press)

        if (press) then 
            

            if (key == 'e' or key == 'E') then 

                if inTraining then 

                    if isTimerActive then 

                        resetTimer()

                    else 

                        startTimer()
                        
                    end

                end

            end

        end

    end

)

function drawPoints()
    if inTraining then
        if isTimerActive then
            Image(755, 29, 265, 49, 'assets/base_parar.png', 0, 0, 0, tocolor(255, 255, 255, alpha))
            Image(346, 29, 265, 49, "assets/base_pontos.png")
            Texto(points, 900, 41 * 2, 42, 27, tocolor(255, 255, 255, 255), 1.0, font, "center", "center")
        else
            Image(346, 29, 265, 49, "assets/base_pontos.png")
            Texto(points, 900, 41 * 2, 42, 27, tocolor(255, 255, 255, 255), 1.0, font, "center", "center")
            Image(755, 29, 265, 49, 'assets/base_iniciar.png', 0, 0, 0, tocolor(255, 255, 255, alpha))
        end

        if isTimerActive then
            local timeLeft = getTimerDetails(timer)
            local minutes = math.floor(timeLeft / 60000) -- Converte milissegundos para minutos
            local seconds = math.floor((timeLeft % 60000) / 1000) -- Converte o restante para segundos

            local formattedTime = string.format("%02d:%02d", minutes, seconds)

            Image(611.5, 33, 143.5, 42, "assets/base_tempo.png")
            Texto(formattedTime, 650, 37, 77, 38, tocolor(255, 255, 255, 255), 1.0, font)
        end
    end
end


addEventHandler("onClientRender", root, drawPoints)

function table.removevalue(tab, val)
    for i, v in ipairs(tab) do
        if v == val then
            table.remove(tab, i)
            break
        end
    end
end