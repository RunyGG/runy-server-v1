local lsBounds = {
    minX = -44.01583, -- Oeste de Los Santos
    maxX = 2944.02051, -- Leste de Los Santos
    minY = -2770.47705, -- Sul de Los Santos
    maxY = -44.01583   -- Norte de Los Santos
}

function isPlayerWithinLS(x, y)
    return (x >= lsBounds.minX and x <= lsBounds.maxX and y >= lsBounds.minY and y <= lsBounds.maxY)
end

function keepPlayerWithinBounds(player, x, y, z)
    local clampedX = math.max(lsBounds.minX, math.min(x, lsBounds.maxX))
    local clampedY = math.max(lsBounds.minY, math.min(y, lsBounds.maxY))
    setElementPosition(player, clampedX, clampedY, z)
    triggerClientEvent(player, "onPlayerHitLSBarrier", resourceRoot)
end

function restrictPlayerMovement()
    for _, player in ipairs(getElementsByType("player")) do
        local x, y, z = getElementPosition(player)
        local dimension = getElementDimension(player)
        if getElementData(player, "battleRoyaleRunning") then
            if dimension >= 5000 and dimension <= 7000 then
                if not isPlayerWithinLS(x, y) then
                    keepPlayerWithinBounds(player, x, y, z)
                end
            end
        end
    end
end
setTimer(restrictPlayerMovement, 500, 0)
