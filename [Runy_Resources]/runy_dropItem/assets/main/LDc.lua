addEvent("colletItemByFN2", true)
addEventHandler("colletItemByFN2", resourceRoot, function(audioPath)
    playSound(audioPath)
end)


addEventHandler("onClientRender", root, function()
    for index, card in pairs(getElementsByType('colshape', resourceRoot)) do
        if isElement(card) and getElementDimension(card) == getElementDimension(localPlayer) then
            if getElementData(card, 'save') then
                local data = getElementData(card, 'save')
                if data == localPlayer then
                    local x, y, z = getElementPosition(card)
                    local cx, cy, cz = getCameraMatrix()
                    if getDistanceBetweenPoints3D(cx, cy, cz, x, y, z) < 400 then
                        local sx, sy = getScreenFromWorldPosition(x, y, z + 1.5)
                        if sx and sy then
                            --dxDrawText(data.name..' #FFFFFF#'..data.id, sx, sy, sx, sy, patenteCores[getLevelToPoints(math.ceil(data.points))], 1, 'default-bold', "center", "bottom", false, false, false, true)
                            dxDrawImage(sx-40, sy-40, 55, 55, 'assets/card.png')
                        end
                    end
                end
            end
        end
    end
end)