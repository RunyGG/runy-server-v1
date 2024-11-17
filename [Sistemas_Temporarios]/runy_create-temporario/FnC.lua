local sW, sH = guiGetScreenSize()
local resW, resH = 1366,768
local x, y = (sW/resW), (sH/resH)

local font_name = dxCreateFont('assets/font_regular.ttf', 7) 
local currentText = ""

function draw_identidade()
    local alpha = interpolateBetween(0, 0, 0, 255, 0, 0, ((getTickCount() - tick) / 500), 'Linear') 
    dxDrawImage(sW * (14/1366), sH * (134/768), sW * (430/1366), sH * (466/768), 'assets/base.png') 
    dxDrawText(select == 1 and guiGetText(edit_name)..' |' or guiGetText(edit_name2), sW * (66/1366), sH * (310/768), sW * (0/1366), sH * (0/768), tocolor(255, 255, 255, 255), 1, font_name)

    -- Skin Masculina
    
    if isMouseInPosition(sW * (124/1366), sH * (370/768), sW * (75/1366), sH * (75/768)) then
        dxDrawImage(sW * (124/1366), sH * (370/768), sW * (75/1366), sH * (75/768), 'assets/male_select.png') 
    else
        dxDrawImage(sW * (124/1366), sH * (370/768), sW * (75/1366), sH * (75/768), 'assets/male.png') 
    end

    -- Skin Feminina

    if isMouseInPosition(sW * (257/1366), sH * (370/768), sW * (75/1366), sH * (75/768)) then
        dxDrawImage(sW * (257/1366), sH * (370/768), sW * (75/1366), sH * (75/768), 'assets/female_select.png') 
    else
        dxDrawImage(sW * (257/1366), sH * (370/768), sW * (75/1366), sH * (75/768), 'assets/female.png') 
    end

    -- Finish

    if isMouseInPosition(sW * (54/1366), sH * (500/768), sW * (350/1366), sH * (50/768)) then
        dxDrawImage(sW * (54/1366), sH * (500/768), sW * (350/1366), sH * (50/768), 'assets/finish_select.png') 
    else
        dxDrawImage(sW * (54/1366), sH * (500/768), sW * (350/1366), sH * (50/768), 'assets/finish.png') 
    end
end

addEvent('onClientDrawIdentidade', true)
addEventHandler('onClientDrawIdentidade', root, 
    function() 
        if not isEventHandlerAdded('onClientRender', root, draw_identidade) then 
            tick = getTickCount()
            addEventHandler('onClientRender', root, draw_identidade) 
            showCursor(true)

            if isElement(edit_name) then destroyElement(edit_name2) end 
            edit_name2 = guiCreateEdit(1000, 1000, 0, 0, 'Digite aqui', false) 
            edit_name = guiCreateEdit(1000, 1000, 0, 0, '', false) 
            guiEditSetMaxLength(edit_name, 8)
        end 
    end
)

addEvent('onClientRemoveIdentidade', true)
addEventHandler('onClientRemoveIdentidade', root, 
    function() 
        removeEventHandler('onClientRender', root, draw_identidade) 
        showCursor(false)     
    end
)

addEventHandler('onClientClick', root, 
    function(b, s) 
        if ( b == 'left' ) and ( s == 'down' ) then 
            if isEventHandlerAdded('onClientRender', root, draw_identidade) then 
                select = 0 
                if isMouseInPosition(sW * (66/1366), sH * (310/768), sW * (71/1366), sH * (10/768)) then 
                    if guiEditSetCaretIndex(edit_name, string.len(guiGetText(edit_name))) then
                        guiBringToFront(edit_name)
                        guiSetInputMode('no_binds_when_editing')

                        select = 1
                    end
                elseif isMouseInPosition(sW * (54/1366), sH * (500/768), sW * (350/1366), sH * (50/768)) then 
                    triggerServerEvent('onPlayerRegisterIdentidade', localPlayer, localPlayer, guiGetText(edit_name))
                end
            end
        end
    end
)

addEventHandler('onClientClick', root, 
    function(b, s) 
        if ( b == 'left' ) and ( s == 'down' ) then 
            if isEventHandlerAdded('onClientRender', root, draw_identidade) then 
                select = 0 
                if isMouseInPosition(sW * (66/1366), sH * (310/768), sW * (71/1366), sH * (10/768)) then 
                    if guiEditSetCaretIndex(edit_name, string.len(guiGetText(edit_name))) then
                        guiBringToFront(edit_name)
                        guiSetInputMode('no_binds_when_editing')

                        select = 1
                    end
                elseif isMouseInPosition(sW * (124/1366), sH * (370/768), sW * (75/1366), sH * (75/768)) then 
                    if guiEditSetCaretIndex(edit_name, string.len(guiGetText(edit_name))) then
                        select = 1
                    end
                    triggerServerEvent('onPlayerSetSkin', localPlayer, localPlayer, 81)
                elseif isMouseInPosition(sW * (257/1366), sH * (370/768), sW * (75/1366), sH * (75/768)) then 
                    if guiEditSetCaretIndex(edit_name, string.len(guiGetText(edit_name))) then
                        select = 1
                    end
                    triggerServerEvent('onPlayerSetSkin', localPlayer, localPlayer, 79)
                end
            end
        end
    end
)

------------------------------------------------
function isEventHandlerAdded( sEventName, pElementAttachedTo, func )
    if type( sEventName ) == 'string' and isElement( pElementAttachedTo ) and type( func ) == 'function' then
        local aAttachedFunctions = getEventHandlers( sEventName, pElementAttachedTo )
        if type( aAttachedFunctions ) == 'table' and #aAttachedFunctions > 0 then
            for i, v in ipairs( aAttachedFunctions ) do
                if v == func then
                    return true
                end
            end
        end
    end
    return false
end

function isMouseInPosition ( x, y, width, height )
	if ( not isCursorShowing( ) ) then
		return false
	end
	local sx, sy = guiGetScreenSize ( )
	local cx, cy = getCursorPosition ( )
	local cx, cy = ( cx * sx ), ( cy * sy )
	
	return ( ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) )
end
------------------------------------------------
