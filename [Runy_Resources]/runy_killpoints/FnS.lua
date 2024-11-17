function isPlayer(element)
    return isElement(element) and getElementType(element) == "player"
end

function onPlayerWasted(totalAmmo, killer, killerWeapon, bodypart, stealth)
    if isPlayer(killer) and getElementData(killer, "battleRoyaleRunning", true) then
        local account = getPlayerAccount(killer)
        if not isGuestAccount(account) then
                local playerName = getAccountName(account)
                if isObjectInACLGroup("user." .. playerName, aclGetGroup("Vip")) or
                isObjectInACLGroup("user." .. playerName, aclGetGroup("Booster")) or
                isObjectInACLGroup("user." .. playerName, aclGetGroup("Beta")) or
                isObjectInACLGroup("user." .. playerName, aclGetGroup("2xPoints")) then
                  --  triggerEvent("addPoints", resourceRoot, killer, 2)
            else
           --     triggerEvent("addPoints", resourceRoot, killer, 1)
            end
        end
    end
end
addEventHandler("onPlayerWasted", root, onPlayerWasted)