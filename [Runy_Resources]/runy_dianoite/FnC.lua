local timesInicial = 12
local times = {
    ['dia'] = 12,
    ['noite'] = 00
}

local function mudartempo(command)
    if times[command] then
        timesInicial = times[command]
    end
end
addCommandHandler('dia', mudartempo)
addCommandHandler('noite', mudartempo)

addEventHandler('onClientRender', root, function()
    setTime(timesInicial, 0)
end)