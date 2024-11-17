function getLevelToPoints(points)
    if points and tonumber(points) > 0 then
        return getEloToLevel(math.floor(points/50))
    end
    return 'bronze4'
end

function getEloToLevel(level)
    local elo = 'bronze4'
    if tonumber(level) >= 1 and tonumber(level) < 2 then
        elo = 'bronze4'
    elseif tonumber(level) >= 2 and tonumber(level) < 3 then
        elo = 'bronze3'
    elseif tonumber(level) >= 3 and tonumber(level) < 4 then
        elo = 'bronze2'
    elseif tonumber(level) >= 4 and tonumber(level) < 5 then
        elo = 'bronze1'

    elseif tonumber(level) >= 5 and tonumber(level) < 6 then
        elo = 'prata4'
    elseif tonumber(level) >= 6 and tonumber(level) < 7 then
        elo = 'prata3'
    elseif tonumber(level) >= 7 and tonumber(level) < 8 then
        elo = 'prata2'
    elseif tonumber(level) >= 8 and tonumber(level) < 10 then
        elo = 'prata1'

    elseif tonumber(level) >= 10 and tonumber(level) < 12 then
        elo = 'ouro4'
    elseif tonumber(level) >= 12 and tonumber(level) < 14 then
        elo = 'ouro3'
    elseif tonumber(level) >= 14 and tonumber(level) < 16 then
        elo = 'ouro2'
    elseif tonumber(level) >= 16 and tonumber(level) < 18 then
        elo = 'ouro1'
        
    elseif tonumber(level) >= 18 and tonumber(level) < 20 then
        elo = 'platina4'
    elseif tonumber(level) >= 20 and tonumber(level) < 22 then
        elo = 'platina3'
    elseif tonumber(level) >= 22 and tonumber(level) < 24 then
        elo = 'platina2'
    elseif tonumber(level) >= 24 and tonumber(level) < 26 then
        elo = 'platina1'

    elseif tonumber(level) >= 26 and tonumber(level) < 32 then
        elo = 'diamante4'
    elseif tonumber(level) >= 32 and tonumber(level) < 36 then
        elo = 'diamante3'
    elseif tonumber(level) >= 36 and tonumber(level) < 40 then
        elo = 'diamante2'
    elseif tonumber(level) >= 40 and tonumber(level) < 44 then
        elo = 'diamante1'

    elseif tonumber(level) >= 44 and tonumber(level) < 60 then
        elo = 'mestre'
    elseif tonumber(level) >= 60 and tonumber(level) < 85 then
        elo = 'lenda'
    elseif tonumber(level) >= 85 then
        elo = 'global'
    end
    return elo
end


positionsRank = {
    {2185.208, 356.402, 64},
    {2190.306, 355.652, 64},
    {2180.631, 354.564, 64},
}