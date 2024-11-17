--------------------------------------------------------------------

function getPlayerFromPartialName(name)
    local name = name and name:gsub("#%x%x%x%x%x%x", ""):lower() or nil
        if name then
            for _, player in ipairs(getElementsByType("player")) do
                local name_ = getPlayerName(player):gsub("#%x%x%x%x%x%x", ""):lower()
            if name_:find(name, 1, true) then
                return player
            end
        end
    end
end

--------------------------------------------------------------------

function isCursorOnElement( x,y,w,h )
    local mx,my = getCursorPosition ()
    local fullx,fully = guiGetScreenSize()
    cursorx,cursory = mx*fullx,my*fully
    if cursorx > x and cursorx < x + w and cursory > y and cursory < y + h then
        return true
    else
        return false
    end
end

--------------------------------------------------------------------