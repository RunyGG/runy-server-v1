--[[
    --» sᴄʀɪᴘᴛ ғᴇɪᴛᴏ ᴘᴏʀ » Pedro Developer
--]]

screenW, screenH = guiGetScreenSize()
sW, sH = (screenW/1366), (screenH/768)
local screenScale = math.min(math.max(screenH / 768, 0.70), 2); -- Caso o painel seja muito grande, retirar o limite e deixar apenas o (screenH / 768).

parentW, parentH = (454 * screenScale), (197 * screenScale); -- Comprimento e Largura do painel.
parentX, parentY = ((screenW - parentW) / 2), ((screenH - parentH) / 2); -- Posição X e Y do painel.

------------------------------------------------
function respX (x)
    return (parentX + (x * screenScale));
end
    
function respY (y)
    return (parentY + (y * screenScale));
end
    
function respC (scale)
    return (scale * screenScale);
end

local _dxDrawRectangle = dxDrawRectangle;
function dxDrawRectangle(x, y, width, height, ...)
    return _dxDrawRectangle(respX(x), respY(y+(animationY or 0)), respC(width), respC(height), ...);
end

local _dxDrawImageSection = dxDrawImageSection;
function dxDrawImageSection(x, y, width, height, ...)
    return _dxDrawImageSection(respX(x), respY(y+(animationY or 0)), respC(width), respC(height), ...);
end

local cursor = {}
function isMouseInPosition (x, y, width, height)
    if (not cursor.state) then
        return false
    end
    if not (cursor.x and cursor.y) then
        return false;
    end
    x, y, width, height = respX(x), respY(y), respC(width), respC(height);
    return ((cursor.x >= x and cursor.x <= x + width) and (cursor.y >= y and cursor.y <= y + height));
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

function formatNumber(number, sep)
	assert(type(tonumber(number))=="number", "Bad argument @'formatNumber' [Expected number at argument 1 got "..type(number).."]")
	assert(not sep or type(sep)=="string", "Bad argument @'formatNumber' [Expected string at argument 2 got "..type(sep).."]")
	local money = number
	for i = 1, tostring(money):len()/3 do
		money = string.gsub(money, "^(-?%d+)(%d%d%d)", "%1"..sep.."%2")
	end
	return money
end

function Texto(text, x1, y1, w1, h1, ...)
    return dxDrawText(text, sW * x1, sH * y1, sW * w1, sH * h1, ...)
end

function Image(x1, y1, w1, h1, ...)
    return dxDrawImage(sW * x1, sH * y1, sW * w1, sH * h1, ...)
end

------------------------------------------------    

local effects = {}
local createdFonts = {}
function getFont(font, size)

    if (createdFonts[font..':'..size]) then 

        return createdFonts[font..':'..size] 

    else

        createdFonts[font..':'..size] = dxCreateFont('assets/fonts/'..font..'.ttf', respC(size))
        return createdFonts[font..':'..size]

    end

end

function drawTopKill()

    local alpha = interpolateBetween(interpolate[1], 0, 0, interpolate[2], 0, 0, ((getTickCount() - tick) / 150), 'Linear')
    animationY = interpolateBetween(animation[1], 0, 0, animation[2], 0, 0, ((getTickCount() - tick) / 150), 'Linear')

    Image(451, 253, 471, 256, 'assets/images/bg.png', 0, 0, 0, tocolor(255, 255, 255, alpha))

    for i = 1, 5 do 
        
        local v = scores[i]
        if (v) then 

            Image(472, 323 + (40 * (i - 1)), 60, 35, 'assets/images/base_2.png', 0, 0, 0, tocolor(255, 255, 255, alpha))
            Image(542, 323 + (40 * (i - 1)), 60, 35, 'assets/images/base_2.png', 0, 0, 0, tocolor(255, 255, 255, alpha))
            Image(609, 323 + (40 * (i - 1)), 150, 35, 'assets/images/base_1.png', 0, 0, 0, tocolor(255, 255, 255, alpha))
            Image(766, 323 + (40 * (i - 1)), 60, 35, 'assets/images/base_2.png', 0, 0, 0, tocolor(255, 255, 255, alpha))
            Image(836, 323 + (40 * (i - 1)), 60, 35, 'assets/images/base_2.png', 0, 0, 0, tocolor(255, 255, 255, alpha))

            Texto(i..'º', 496, 332 + (40 * (i - 1)), 45, 23, tocolor(255, 255, 255, alpha), 1, getFont('sbold', 14), 'left', 'top')
            Image(542, 323 + (40 * (i - 1)), 60, 35, 'assets/images/logo.png', 0, 0, 0, tocolor(255, 255, 255, alpha))
            Texto(v.name, 633, 332 + (40 * (i - 1)), 93, 15, tocolor(255, 255, 255, alpha), 1, getFont('sbold', 14), 'left', 'top', false, false, false, true)
            Texto(formatNumber(v.kills, '.'), 792, 332 + (40 * (i - 1)), 45, 23, tocolor(255, 255, 255, alpha), 1, getFont('sbold', 14), 'left', 'top')
            Texto(formatNumber(v.assists, '.'), 862, 332 + (40 * (i - 1)), 45, 23, tocolor(255, 255, 255, alpha), 1, getFont('sbold', 14), 'left', 'top')

        end

    end

end 

addEvent('onClientDrawRunyTopKill', true)
addEventHandler('onClientDrawRunyTopKill', root, 

    function(scores_)

        if not (isEventHandlerAdded('onClientRender', root, drawTopKill)) then 

            tick, interpolate, animation, scores = getTickCount(), {0, 255}, {150, 0}, scores_
            addEventHandler('onClientRender', root, drawTopKill)

        else

            removeTopKill()

        end

    end

)

function removeTopKill()

    if (isEventHandlerAdded('onClientRender', root, drawTopKill)) then 

        if (interpolate[1] == 0) then 

            tick, interpolate, animation = getTickCount(), {255, 0}, {0, 150}
            
            setTimer(function()

                removeEventHandler('onClientRender', root, drawTopKill)

            end, 150, 1)

        end

    end
    
end