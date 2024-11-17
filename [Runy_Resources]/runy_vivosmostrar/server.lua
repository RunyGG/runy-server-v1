local playersInDimensions = {}

function updatePlayerCount(element)
    if not isElement(element) then
        return
    end
    
    local dimension = getElementDimension(element)
    if not dimension then
        return
    end
    
    playersInDimensions[dimension] = 0
    local players = getElementsByType("player")
    for i, player in ipairs(players) do
        if getElementDimension(player) == dimension and dimension >= 5000 and dimension <= 7000 and getElementHealth(player) > 0 then
            local battleRoyaleRunning = getElementData(player, "battleRoyaleRunning") or false
            if battleRoyaleRunning then
                playersInDimensions[dimension] = playersInDimensions[dimension] + 1
            end
        end
    end
    
    for dimension, count in pairs(playersInDimensions) do
        triggerClientEvent(element, "onPlayerCountUpdate", element, count, dimension)
    end
    
    if next(playersInDimensions) == nil then
        triggerClientEvent(element, "onPlayerCountUpdate", element, 0, 0)
    end
end

addEventHandler("onPlayerWasted", root, function()
    updatePlayerCount(source)
end)

setTimer(function()
    local players = getElementsByType("player")
    for _, player in ipairs(players) do
        updatePlayerCount(player)
    end
end, 1000, 0)