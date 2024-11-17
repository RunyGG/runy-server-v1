function onPlayerPosCommand()
    local x, y, z = getElementPosition(localPlayer)
    --local outputString = "{ x = " .. x .. ", y = " .. y .. ", z = " .. z .. " },"
    local outputString = math.round( x, 3 )..', '..math.round( y, 3 )..', '..math.round( z, 3 )
    outputChatBox(outputString)
    --setClipboard(outputString)
    setClipboard(outputString)
end
addCommandHandler("pos", onPlayerPosCommand)

function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end