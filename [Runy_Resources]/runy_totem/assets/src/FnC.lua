local markers = {}
local objects = {}
local blips = {}
local holdingE = false
local holdingTime = 0
local lastTick = getTickCount()

function marker(x, y, z, size)
    local marker = createMarker(x + 5, y + 5, z, "cylinder", size, 255, 0, 0, 0) --// OPACIDADE É O ULTIMO, SO PRA LEMBRAR!!
    table.insert(markers, marker)

    local object = createObject(1313, x, y, z)
    table.insert(objects, object)

    local blip = createBlip(x, y, z, 22)
    setBlipVisibleDistance(blip, 0)
    table.insert(blips, blip)
end

addEvent("createMarkersTrigger", true)
addEventHandler("createMarkersTrigger", getRootElement(), function(dimension)
    for _, pos in ipairs(markesSpawns) do
        marker(pos[1] , pos[2], pos[3] - 1, 8)
        setElementDimension(markers[#markers], dimension)
        setElementDimension(objects[#objects], dimension)
        setElementDimension(blips[#blips], dimension)
    end
end)

addEvent("destroyMarkersTrigger", true)
addEventHandler("destroyMarkersTrigger", getRootElement(), function(dimension)
    for i = #markers, 1, -1 do
        if isElement(markers[i]) and getElementDimension(markers[i]) == dimension then
            destroyElement(markers[i])
            destroyElement(objects[i])
            destroyElement(blips[i])
            table.remove(markers, i)
            table.remove(objects, i)
            table.remove(blips, i)
        end
    end
end)

function updateBlipVisibility()
    local playerDimension = getElementDimension(localPlayer)
    for i, blip in ipairs(blips) do
        if isElement(blip) then
            local blipDimension = getElementDimension(blip)
            if blipDimension == playerDimension then
                setBlipVisibleDistance(blip, 9999)
            else
                setBlipVisibleDistance(blip, 0)
            end
        end
    end
end
addEventHandler("onClientRender", root, updateBlipVisibility)

addEventHandler("onClientKey", root, function(button, state)
    for _, marker in ipairs(markers) do
        if isElement(marker) then
            local dimension = getElementDimension(localPlayer)
            local playerX, playerY, playerZ = getElementPosition(localPlayer)
            local markerX, markerY, markerZ = getElementPosition(marker)
            local distance = getDistanceBetweenPoints3D(playerX, playerY, playerZ, markerX, markerY, markerZ)

            if button == "e" and state then
                if distance < 4.0 and getElementDimension(marker) == dimension then
                    holdingE = true
                    triggerEvent("progressBar", localPlayer, tempoHold)
                    holdingTime = 0
                    lastTick = getTickCount()
                end
            elseif button == "e" and not state then
                holdingE = false
                triggerEvent("progressBar", localPlayer, 0)
                holdingTime = 0
            end
        end
    end
end)

function updateHoldingTime()
    if holdingE then
        if not triggerServerEvent("fn:getItemForTotem", resourceRoot, localPlayer,  999) then 
            holdingE = false
            holdingTime = 0
            triggerEvent("progressBar", localPlayer, 0)
            print("nao tem filho da puta")
            return 
        end
        for _, marker in ipairs(markers) do
            if isElement(marker) and isElementWithinMarker(localPlayer, marker) then
                holdingTime = holdingTime + getTickCount() - lastTick
                lastTick = getTickCount()

                if holdingTime >= tempoHold then
                    triggerServerEvent("fn:RealivePlayerForTotem", resourceRoot, localPlayer)
                    holdingE = false
                    holdingTime = 0
                    triggerEvent("progressBar", localPlayer, 0)
                    return
                end
            end
        end
    else
        holdingE = false
        holdingTime = 0
        --[[ triggerEvent("progressBar", localPlayer, 0) ]]
    end
end
addEventHandler("onClientRender", root, updateHoldingTime)