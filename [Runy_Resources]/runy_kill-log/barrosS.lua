function logKill(totalAmmo, killer, killerWeapon, bodypart, stealth)
    local victim = source
    local killerName = "Queda ou Safezone"
    if isElement(killer) and getElementType(killer) == "player" then
        killerName = getPlayerName(killer) or "nenhum"
    end
    local victimName = getPlayerName(victim)
    local weaponName

    if type(killerWeapon) == "number" then
        if killerWeapon == 30 then
            weaponName = "G36c"
        elseif killerWeapon == 23 then
            weaponName = "Five-Seven"
        else
            weaponName = getWeaponNameFromID(killerWeapon) or "nenhum"
        end
    else
        weaponName = "nenhum"
    end

    local dimension = getElementDimension(source)
    if isElement(killer) and getElementType(killer) == "player" then
        dimension = getElementDimension(killer) or "nenhum"
    end

    local message = string.format("%s **morreu** para %s com a arma %s na dimensão %s", victimName, killerName, weaponName, dimension)
    
    triggerEvent("RunyLogsDiscord4", root, root, message, 1)
end

addEventHandler("onPlayerWasted", root, logKill)