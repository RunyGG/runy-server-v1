--------------------------------------------------------------------

addCommandHandler (config["Command"], function (player, cmd)
    if getElementData(player, "9.admin") == true then
        local data = getElementData (player, "onPlayerStaff")
        if not data then
            setElementData(player, "onPlayerStaff", true)
        else
            removeElementData(player, "onPlayerStaff")
        end
    end
end)
