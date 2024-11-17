function removeRecoilFromRifles()
    local rifleIDs = {30, 31, 32, 33}

    for _, weaponID in ipairs(rifleIDs) do
        setWeaponProperty(weaponID, "poor", "accuracy", 1000)
        setWeaponProperty(weaponID, "std", "accuracy", 1000)
        setWeaponProperty(weaponID, "pro", "accuracy", 1000)
    end
end

addEventHandler("onResourceStart", resourceRoot, function()
    removeRecoilFromRifles()
end)
