screenW, screenH = guiGetScreenSize()
x,y = (screenW/1920), (screenH/1080);

fonts = {
    [1] = dxCreateFont("core/fonts/Montserrat-Bold.ttf", y*11, true, "cleartype_natural"),
    [2] = dxCreateFont("core/fonts/Montserrat-SemiBold.ttf", y*9, true, "cleartype_natural"),
    [3] = dxCreateFont("core/fonts/Montserrat-SemiBold.ttf", y*10, true, "cleartype_natural"),
    [4] = dxCreateFont("core/fonts/Montserrat-SemiBold.ttf", y*14, true, "cleartype_natural")
}

painel = false

selectvalue = 1
selectgenvalue = 1
playercolor = 1

selectgen = {
    [1] = {
        {x*1492,y*535,x*100,y*1}
    },
    [2] = {
        {x*1740,y*535,x*100,y*1}
    }
}

rostopos = {
    [1] = {
        {x*1509,y*440,x*5,y*16}
    },
    [2] = {
        {x*1607,y*440,x*8,y*16}
    },
    [3] = {
        {x*1707,y*440,x*8,y*16}
    },
    [4] = {
        {x*1807,y*440,x*8,y*16}
    }
}

select = {
    [1] = {
        x = 1473,
        y = 464,
        w = 75,
        h = 1
    },
    [2] = {
        x = 1575,
        y = 464,
        w = 75,
        h = 1
    },
    [3] = {
        x = 1674,
        y = 464,
        w = 75,
        h = 1
    },
    [4] = {
        x = 1778,
        y = 464,
        w = 75,
        h = 1
    }
}

selectcolor = {
    [1] = {
        {x*1582,y*588,x*30,y*30},
        tocolor(175,159,134,255)
    },
    [2] = {
        {x*1627,y*588,x*30,y*30},
        tocolor(210,195,171,255)
    },
    [3] = {
        {x*1672,y*588,x*30,y*30},
        tocolor(129,113,89,255)
    },
    [4] = {
        {x*1717,y*588,x*30,y*30},
        tocolor(104,92,73,255)
    }
}

function getSizeFontFigma (path, height)
    local Tamanhos = {}
    for size = 1, 60 do
        local Font = dxCreateFont(path, size)
        local Height = dxGetFontHeight(1, Font)
        destroyElement(Font)
        if Height == height then
            return size, "Normal"
        end
        Tamanhos[Height] = size
        if size == 60 then
            return Tamanhos[height - 1], "Modificado"
        end
    end
end
print (getSizeFontFigma ("core/fonts/Montserrat-SemiBold.otf", 18)) 

function isCursorOnElement (x, y, w, h)
    if isCursorShowing() then
        local mx, my = getCursorPosition()
        local resx, resy = guiGetScreenSize()
        mousex, mousey = mx * resx, my * resy
        if mousex > x and mousex < x + w and mousey > y and mousey < y + h then
            return true
        else
            return false
        end
    end
end

local svgRectangles = {}

function dxDrawRoundedRectangle(x, y, w, h, color, radius, post)
    if not svgRectangles[radius] then
        local Path = string.format([[
            <svg width="%s" height="%s" viewBox="0 0 %s %s" fill="none" xmlns="http://www.w3.org/2000/svg">
            <rect opacity="1" width="%s" height="%s" rx="%s" fill="#FFFFFF"/>
            </svg>
        ]], w, h, w, h, w, h, radius)
        svgRectangles[radius] = svgCreate(w, h, Path)
    end
    if svgRectangles[radius] then
        dxDrawImage(x, y, w, h, svgRectangles[radius], 0, 0, 0, color, post)
    end
end