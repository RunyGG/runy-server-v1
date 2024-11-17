local screen = {guiGetScreenSize ( )}
local resW, resH = 1366, 768
local sx, sy = (screen[1] / resW), (screen[2] / resH)
local rotate = 0

local createdFonts = {}
function getFont(font, size)
    if (createdFonts[font..':'..size]) then 
        return createdFonts[font..':'..size]
    else
        createdFonts[font..':'..size] = dxCreateFont('assets/fonts/'..font..'.ttf', sy * (size / 1.4))
        return createdFonts[font..':'..size]
    end
    
end

function drawScrollBar(x, y, width, height, scrollPos, scrollWidth)
    local thumbWidth = width * (width / scrollWidth)
    local thumbX = x + (scrollPos / (thumbWidth - width)) * (width - thumbWidth)
    dxDrawImage(x, y, width+scrollWidth, height, 'assets/images/scroll_fundo.png', 0, 0, 0, tocolor(255, 255, 255, 255))
    dxDrawImage(thumbX, y, thumbWidth+472, height, 'assets/images/scroll.png', 0, 0, 0, tocolor(255, 255, 255, 255))
end

function drawPerf()
    local rightX = interpolateBetween(open, 0, 0, stop, 0, 0, (getTickCount() - (tick or 0))/1200, "OutBack")
    local color = config.colors[(player['banner'] or 0)]
    dxDrawImage(rightX+32, 88, 503, 666, 'assets/images/icons/profile.png', 0, 0, 0, tocolor(255, 255, 255, 220))
    dxDrawImage(rightX+547, 374, 36, 89, 'assets/images/icons/arrow.png', 0, 0, 0, tocolor(255, 255, 255, 220))
    dxDrawImage(rightX+41, 97, 485, 135, 'assets/images/items/banner/'..(player['banner'] or 0)..'.png', 0, 0, 0, tocolor(255, 255, 255, alpha)) -- BANNER
    dxDrawImage(rightX+55, 112, 99, 99, 'assets/images/items/avatar/'..(player['avatar'] or 0)..'.png', 0, 0, 0, tocolor(255, 255, 255, alpha)) -- Avatar
    if player['verified'] then
        rotate = rotate + 1
        dxDrawImage(rightX+135, 101, 31, 31, 'assets/images/icons/v1.png', rotate, 0, 0, tocolor(255, 255, 255, alpha)) -- verified1
        dxDrawImage(rightX+135, 101, 31, 31, 'assets/images/icons/v2.png', 0, 0, 0, tocolor(255, 255, 255, alpha)) -- verified2
    end
    dxDrawImage(rightX+508, 211, 15, 13.71, 'assets/images/icons/likes.png', 0, 0, 0, color) -- likes
    dxDrawText((player['likes'] or 0), rightX+460, 211, 47, 16, color, 1, getFont('medium', 14), "right", "top")
    if player['acc'] ~= myacc then
        local friends = localPlayer:getData('friends') or {}
        if friends and #friends > 0 then
            for i,v in pairs(friends) do
                if v == player['acc'] then
                    dxDrawImage(rightX+194, 181, 20, 20, 'assets/images/icons/cnick.png', 0, 0, 0, color) -- trocanick
                else
                    dxDrawImage(rightX+500, 101, 20, 17, 'assets/images/icons/add.png', 0, 0, 0, color) -- add friend
                end
            end
        else
            dxDrawImage(rightX+500, 101, 20, 17, 'assets/images/icons/add.png', 0, 0, 0, color) -- add friend
        end
    end
    dxDrawImage(rightX+41, 312, 102, 103, ':runy_points-system/assets/elo/'..(player['patente'] or 'bronze4')..'.png', 0, 0, 0, tocolor(255, 255, 255, alpha)) -- RANK
    dxDrawText(''..string.upper(player['patente'] or 'bronze4')..'', rightX+143, 374, 140, 26, tocolor(200, 200, 200, alpha), 1.2, getFont('medium', 14), "left", "top")
    dxDrawText(player['positionRank']..'º', rightX+323, 330, 167, 81, tocolor(200, 200, 200, alpha), 1, getFont('medium', 45), "center", "center") -- POSIÇÃO ATUAL
    dxDrawImage(rightX+136, 489, 300, 80, ':runy_arsenal/assets/images/weapons/'..(player['arma'] or 'faca')..'.png', 0, 0, 0, tocolor(255, 255, 255, alpha)) -- ARMA
    dxDrawText(''..string.upper(player['arma'] or '0')..'', rightX+46, 463, 201, 26.37, tocolor(200, 200, 200, alpha), 1, getFont('medium', 14), "left", "top")
    dxDrawText('lv.'..(player['armalevel'] or '0')..'', rightX+480, 567, 39, 20, tocolor(200, 200, 200, alpha), 1, getFont('medium', 14), "right", "top")
    dxDrawText((player['kills'] or '0')..'', rightX+75, 664, 79, 45, tocolor(200, 200, 200, alpha), 1, getFont('medium', 36), "center", "center")
    dxDrawText((player['death'] or '0')..'', rightX+244, 664, 79, 45, tocolor(200, 200, 200, alpha), 1, getFont('medium', 36), "center", "center")
    dxDrawText(math.round((player['kills'] or 0)/(player['death'] or 0), 1), rightX+421, 664, 50, 45, tocolor(200, 200, 200, alpha), 1, getFont('medium', 36), "center", "center")
    dxDrawText(player['name'], rightX+174, 142, 90, 40.09, color, 1, getFont('medium', 22), "left", "top")
    dxDrawText('lv.'..(player['level'] or 0), rightX+41, 232, 59, 26.37, tocolor(200, 200, 200, alpha), 1, getFont('medium', 14), "left", "top")
    dxDrawText('UID: '..idString(tostring(player['ID'] or "0000000")), rightX+400, 232, 120, 26.37, tocolor(200, 200, 200, alpha), 1, getFont('medium', 14), "right", "top")
end

addEventHandler('onClientKey', root, function(key, press)
    if (isEventHandlerAdded('onClientRender', root, drawPerf) and press) then 
        if (key == 'mouse_wheel_down') then
            if (page > -35) then 
                page = page - 5
            end
        elseif (key == 'mouse_wheel_up') then 
            if (page < 0) then 
                page = page + 5
            end
        end
    end
end)

addEvent('NZ > perfil', true)
addEventHandler('NZ > perfil', root, function(dados, account)
    if not dados then 
        if (isEventHandlerAdded('onClientRender', root, drawPerf)) then 
            removeEventHandler('onClientRender', root, drawPerf)
            triggerEvent("returnToLobbyCancelMatch", root, localPlayer)
            return
        end
    end
    if not (isEventHandlerAdded('onClientRender', root, drawPerf)) then 
        tick, player, page, myacc, open, stop = getTickCount(), dados, 0, account, -700, 0
        addEventHandler('onClientRender', root, drawPerf)
        showCursor(true)
        window = 'Perfil'
        
        --if account == player['acc'] then
        --    itens = {}
        --    for index, variavel in pairs(config.categorys) do
        --        if not (itens[variavel]) then
        --            itens[variavel] = {}
        --        end
        --    end
        --    for i, v in ipairs(player['items']) do
        --        local cfg = config.itensX[v]
        --        table.insert(itens[cfg[1]], v)
        --    end
        --end
    end
end)

addEventHandler('onClientClick', root, function(b, s)
    if (b == 'left' and s == 'down') then 
        if (isEventHandlerAdded('onClientRender', root, drawPerf)) then 
            if (isMouseInPosition(500, 101, 20, 17)) then
                setElementData(localPlayer, 'friends', {player['acc']})
            elseif (isMouseInPosition(547, 374, 36, 89)) then
                removeArsenals()
            end
        end
    end
end)

function removeArsenals()
    if (isEventHandlerAdded('onClientRender', root, drawPerf)) then 
        open, stop = 0, -700
        tick = getTickCount()
        setTimer(function()
            removeEventHandler('onClientRender', root, drawPerf)
            showCursor(false)
            triggerEvent("returnToLobbyCancelMatch", root, localPlayer)
        end, 2000, 1)
    end
end
addEvent('NZ > RunyCloseArsenal', true)
addEventHandler('NZ > RunyCloseArsenal', localPlayer, removeArsenals)

function isMouseInPosition(x, y, w, h)
    if isCursorShowing() then
        local x, y, w, h = aToR (x, y, w, h)
        local sx,sy = guiGetScreenSize()
        local cx,cy = getCursorPosition()
        local cx,cy = (cx*sx),(cy*sy)
        if (cx >= (x) and cx <= x+w) and (cy >= y and cy <= y+h) then
            return true
        end
    end
end

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

function aToR (X, Y, sX, sY)
    local xd = X/resW or X
    local yd = Y/resH or Y
    local xsd = sX/resW or sX
    local ysd = sY/resH or sY
    return xd * screen[1], yd * screen[2], xsd * screen[1], ysd * screen[2]
end

_dxDrawRectangle = dxDrawRectangle
function dxDrawRectangle (x, y, w, h, color, postGUI, subPixelPositioning, realPosition)
    
    if (realPosition) then 
        return _dxDrawRectangle (x, y, w, h, color, postGUI, subPixelPositioning)
    else 
        local x, y, w, h = aToR (x, y, w, h)
        return _dxDrawRectangle (x, y, w, h, color, postGUI, subPixelPositioning)
    end 
end

_dxDrawText = dxDrawText
function dxDrawText (text, x, y, w, h, ...)
    local x, y, w, h = aToR (x, y, w, h)
    return _dxDrawText (text, x, y, (w + x), (h + y), ...)
end

_dxDrawImage = dxDrawImage
function dxDrawImage (x, y, w, h, ...)
    if (x == 0 and y == 0 and w == screen[1] or h == screen[2]) then 
        return _dxDrawImage (x, y, w, h, ...)
    else
        local x, y, w, h = aToR (x, y, w, h)
        return _dxDrawImage (x, y, w, h, ...)
    end
end

size = {}
function drawBorder ( radius, x, y, width, height, color, colorStroke, sizeStroke, postGUI )
    colorStroke = tostring(colorStroke)
    sizeStroke = tostring(sizeStroke)
    if (not size[height..':'..width]) then
        local raw = string.format([[
            <svg width='%s' height='%s' fill='none' xmlns='http://www.w3.org/2000/svg'>
                <mask id='path_inside' fill='#FFFFFF' >
                    <rect width='%s' height='%s' rx='%s' />
                </mask>
                <rect opacity='1' width='%s' height='%s' rx='%s' fill='#FFFFFF' stroke='%s' stroke-width='%s' mask='url(#path_inside)'/>
            </svg>
        ]], width, height, width, height, radius, width, height, radius, colorStroke, sizeStroke)
        size[height..':'..width] = svgCreate(width, height, raw)
    end
    if (size[height..':'..width]) then
        dxDrawImage(x, y, width, height, size[height..':'..width], 0, 0, 0, color, postGUI)
    end
end

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

function removeHex(s)
    local g, c = string.gsub, 0
    repeat
        s, c = g(s, '1', '')
    until c == 0
    return s
end

function formatNumber(number, sep)
    assert(type(tonumber(number))=='number', 'Bad argument @\'formatNumber\' [Expected number at argument 1 got '..type(number)..']')
    assert(not sep or type(sep)=='string', 'Bad argument @\'formatNumber\' [Expected string at argument 2 got '..type(sep)..']')
    local money = number
    for i = 1, tostring(money):len()/3 do
        money = string.gsub(money, '^(-?%d+)(%d%d%d)', '%1'..sep..'%2')
    end
    return money
end

function math.round(num, decimals)
    decimals = math.pow(10, decimals or 0)
    num = num * decimals
    if num >= 0 then num = math.floor(num + 0.5) else num = math.ceil(num - 0.5) end
    return num / decimals
end

function idString(num)
    local rad = ''
    if #num == 1 then rad = '00000'..num elseif #num == 2 then rad = '0000'..num
    elseif #num == 3 then rad = '000'..num elseif #num == 4 then rad = '00'..num
    elseif #num == 5 then rad = '0'..num elseif #num == 6 then rad = ''..num 
    end
    return rad
end