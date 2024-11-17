screenW, screenH = guiGetScreenSize()
x, y = (screenW/1366), (screenH/768)

local font = dxCreateFont("files/Roboto-Regular.ttf", y * 11)
local font2 = dxCreateFont("files/Roboto-Regular.ttf", y * 10)
local texto = createElement("dxEditChatSystem")
local tick = getTickCount()

local renderTgt = dxCreateRenderTarget(x * 845, y * 115, true)
tablepos = {}
posx = {}
local count = 0

local animation1 = false
local animation2 = false
local animation3 = false

tipoc = false

amostra = {
    
    {x*723, y*329, x*50, y*50},
    {x*803, y*329, x*50, y*50},
    {x*883, y*329, x*50, y*50},
    {x*963, y*329, x*50, y*50},
    {x*1043, y*329, x*50, y*50},
    
    {x*723, y*398, x*50, y*50},
    {x*803, y*398, x*50, y*50},
    {x*883, y*398, x*50, y*50},
    {x*963, y*398, x*50, y*50},
    {x*1043, y*398, x*50, y*50},
    
    {x*723, y*467, x*50, y*50},
    {x*803, y*467, x*50, y*50},
    {x*883, y*467, x*50, y*50},
    {x*963, y*467, x*50, y*50},
    {x*1043, y*467, x*50, y*50},
}

for i= 1, 7 do 
    tablepos[i] = (1 + (i * 125))
end 
local rotate = 0

function dxDraw()
    dxDrawImage(x * 187, y * 108, x * 966, y * 550, 'files/base.png', 0, 0, 0, tocolor(255, 255, 255, 255))
    
    if tipoc then
        dxDrawImage(x * 294, y * 329, x * 250, y * 250, ":runy_equipamentos/assets/images/icons/"..tipoc..".png")
        for index, var in ipairs(config.itens[tipoc]) do
            local pos = amostra[index]
            dxDrawImage(pos[1], pos[2], pos[3], pos[4], config.slotsColor[var[1]], 0, 0, 0, tocolor(255,255,255,255))
            if var.diretory then
                dxDrawImage(pos[1], pos[2], pos[3], pos[4], var.diretory, 0, 0, 0, tocolor(255, 255, 255, 233))
            end
            if not var.diretory then
                dxDrawImage(pos[1], pos[2], pos[3], pos[4], ':runy_roupas-inventario/'..exports['runy_roupas-inventario']:getItemDiretory(var[2]))
            end
        end
        dxDrawImage(x * 881, y * 548, x * 134, y * 31, 'files/bg_2.png', 0, 0, 0, (isMouseInPosition(x * 881, y * 548, x * 134, y * 31) and tocolor(109, 40, 217, 255) or tocolor(40, 40, 40, 255)))
        dxDrawText((not RotateBox and 'ABRIR' or 'AGUARDE'), x * 929, y * 556, x * 40, y * 18, (isMouseInPosition(x * 881, y * 548, x * 134, y * 31) and tocolor(255, 255, 255, 255) or tocolor(144, 144, 144, 255)), (isMouseInPosition(x * 881, y * 548, x * 134, y * 31) and 1.0 or 1.0), font, 'left', 'top')
        if not RotateBox then
            dxDrawImage(x * 721, y * 548, x * 134, y * 31, 'files/bg_2.png', 0, 0, 0, (isMouseInPosition(x * 721, y * 548, x * 134, y * 31) and tocolor(109, 40, 217, 255) or tocolor(40, 40, 40, 255)))
            dxDrawText('GUARDAR', x * 756, y * 556, x * 64, y * 16, (isMouseInPosition(x * 721, y * 548, x * 134, y * 31) and tocolor(255, 255, 255, 255) or tocolor(144, 144, 144, 255)), (isMouseInPosition(x * 721, y * 548, x * 134, y * 31) and 1.0 or 1.0), font, 'left', 'top')
        end
    end
    
    if animation3 then
        up1 = interpolateBetween(300, 0, 0, 470, 0, 0, ((getTickCount() - tickLight) / 1000), "OutBack")
        up2 = interpolateBetween(0, 0, 0, 166, 0, 0, ((getTickCount() - tickLight) / 800), "OutBack")
        up3 = interpolateBetween(0, 0, 0, 400, 0, 0, ((getTickCount() - tickLight) / 800), "OutBack")
        
        rotate = rotate + 0.7
        local v = tableitens[4]
        dxDrawImage(x * up1, y * up2, x * up3, y * up3, "files/brilho.png", rotate, 0, 0, config.tocolorSlot[v[1]])
        if v.diretory then
            dxDrawImage(x * up1, y * up2, x * up3, y * up3, v.diretory)
        else
            dxDrawImage(x * up1, y * up2, x * up3, y * up3, ':runy_roupas-inventario/'..exports['runy_roupas-inventario']:getItemDiretory(v[2]))
        end
    end
    
    dxDrawImage(x * 248, y * 159, x * 845, y * 115, renderTgt)
    chamarDx()
end

function chamarDx()
    dxSetRenderTarget(renderTgt, true)
    for i,v in ipairs(tableitens) do
        if i <= #tablepos then 
            if i ~= 1 then 
                if not animation1 then 
                    posx[i] = interpolateBetween(tablepos[i], 0, 0, tablepos[i-1], 0, 0, ((getTickCount() - tick) / config.TimerAnimacao), (animation3 and "OutBack" or "InBack"))
                    setTimer(function ()
                        animation1 = true
                    end, config.TimerAnimacao, 1)
                else 
                    posx[i] = interpolateBetween(0, 0, 0, 176, 0, 0, ((getTickCount() - tick) / config.VelocidadeCaixas), "Linear")
                end 
                dxDrawImage(x * (animation1 and (tablepos[i] - (posx[i])) or posx[i])+50, y * 10, x * 95, y * 95, config.slotsColor[v[1]], 0, 0, 0, tocolor(255,255,255,255))
                
                if v.diretory then
                    dxDrawImage(x * (animation1 and (tablepos[i] - (posx[i])) or posx[i])+50, y * 10, x * 95, y * 79, v.diretory)
                else
                    dxDrawImage(x * (animation1 and (tablepos[i] - (posx[i])) or posx[i])+50, y * 10, x * 95, y * 79, ':runy_roupas-inventario/'..exports['runy_roupas-inventario']:getItemDiretory(v[2]))
                end
            else
                if not animation2 then 
                    posx[i] = interpolateBetween(tablepos[i], 0, 0, -100, 0, 0, ((getTickCount() - tick) / config.TimerAnimacao), (animation3 and "OutBack" or "InBack"))
                    setTimer(function ()
                        animation2 = true
                    end, config.TimerAnimacao, 1)
                else 
                    posx[i] = interpolateBetween(0, 0, 0, 176, 0, 0, ((getTickCount() - tick) / config.VelocidadeCaixas), "Linear")
                end  
                dxDrawImage(x * (animation2 and (tablepos[i] - (posx[i])) or posx[i])+50, y * 10, x * 95, y * 95, config.slotsColor[v[1]], 0, 0, 0, tocolor(255,255,255,255))
                
                if v.diretory then
                    dxDrawImage(x * (animation1 and (tablepos[i] - (posx[i])) or posx[i])+50, y * 10, x * 95, y * 79, v.diretory)
                else
                    dxDrawImage(x * (animation1 and (tablepos[i] - (posx[i])) or posx[i])+50, y * 10, x * 95, y * 79, ':runy_roupas-inventario/'..exports['runy_roupas-inventario']:getItemDiretory(v[2]))
                end
            end 
        end 
    end
    dxSetRenderTarget()
end


function iniciarRoleta(tipo)
    if not tipo then
        if isEventHandlerAdded("onClientRender", root, dxDraw) then 
            removeEventHandler("onClientRender", root, dxDraw)
            return
        end
    end
    if not isEventHandlerAdded("onClientRender", root, dxDraw) then 
        tableitens = config.itens[tipo]
        tipoc = tipo
        addEventHandler("onClientRender", root, dxDraw,true,"low-5")
    else 
        removeEventHandler("onClientRender", root, dxDraw)
    end 
end 
addEvent("NZ > openCrate", true)
addEventHandler("NZ > openCrate", root, iniciarRoleta)

RotateBox = false

function click(tipoc)
    if not RotateBox then
        RotateBox = true
        triggerServerEvent("NZ > takeItemEquipamments", localPlayer, localPlayer, tipoc)
        triggerEvent( 'NZ > closeEquipaments', localPlayer, localPlayer )
        randomtimer = math.random(config.TimerMin, config.TimerMax)
        tempo = setTimer(function()
            newtable = {}
            for i,v in ipairs(tableitens) do 
                if i == 1 then 
                    newtable[#tableitens] = v
                else 
                    newtable[i-1] = v
                end 
            end 
            tableitens = newtable
            
            tick = getTickCount()
            TimerCaixa = setTimer(function ()  
                newtable = {}
                for i,v in ipairs(tableitens) do 
                    if i == 1 then 
                        newtable[#tableitens] = v
                    else 
                        newtable[i-1] = v
                    end 
                end 
                tableitens = newtable
                local _,  quantidade = getTimerDetails(TimerCaixa)
                if quantidade == 1 then
                    tickLight = getTickCount()
                    triggerServerEvent("NZ > GiveItemCrate", localPlayer, localPlayer, tableitens[4][1], tableitens[4][2], tableitens[4][3], tableitens[4][4])
                    animation1 = false 
                    animation2 = false 
                    animation3 = true 
                    count = 0
                    setTimer(function  ()
                        animation3 = false
                        iniciarRoleta()
                        tipoc = false
                        rotate = 0
                        tickLight = nil
                        RotateBox = false
                    end, 8000, 1)
                end     
                tick = getTickCount()
            end, config.VelocidadeCaixas, randomtimer)
        end, config.TimerAnimacao, 1)
    end
end


addEventHandler("onClientClick", root,
function(button, state)
    if button == "left" and state == "up" then
        if isEventHandlerAdded("onClientRender", root, dxDraw) then
            if isMouseInPosition(x * 881, y * 548, x * 134, y * 31) and tipoc then
                if not RotateBox then
                    click(tipoc)
                end
            elseif isMouseInPosition(x * 721, y * 548, x * 134, y * 31) then
                if not RotateBox then
                    tipoc = false
                    iniciarRoleta()
                end
            end
        end
    end
end)

function isMouseInPosition ( x, y, width, height )
    if ( not isCursorShowing ( ) ) then
        return false
    end
    local sx, sy = guiGetScreenSize ( )
    local cx, cy = getCursorPosition ( )
    local cx, cy = ( cx * sx ), ( cy * sy )
    if ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) then
        return true
    else
        return false
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

addCommandHandler('open', function(_, type)
    iniciarRoleta(type)
end)