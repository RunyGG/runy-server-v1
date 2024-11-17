local screen = {guiGetScreenSize ( )}
local resW, resH = 1366, 768
local sx, sy = (screen[1] / resW), (screen[2] / resH)

windows = {
    {0, 153.31, 147.84, 44.35, 'FUZIS'};
    {0, 234.62, 147.84, 44.35, 'SMGS'};
    {0, 315.93, 147.84, 44.35, 'PISTOLAS'};
    {0, 397.24, 147.84, 44.35, 'FACAS'};
}

armas = {
    
    FUZIS = {
        {1189.34, 108.96, 170.01, 80, 'g36c'};
        {1189.34, 219.84, 170.01, 80, 'm4'};
        {1189.34, 331.46, 170.01, 80, 'ak'};
    },
    
    SMGS = {
        {1189.34, 108.96, 170.01, 80, 'mp5'};
        {1189.34, 219.84, 170.01, 80, 'tec9'};
        {1189.34, 331.46, 170.01, 80, 'skorpion'};
    },
    
    PISTOLAS = {
        {1189.34, 108.96, 170.01, 80, 'five'};
        {1189.34, 219.84, 170.01, 80, 'glock'};
    },
    
    FACAS = {
        {1189.34, 108.96, 170.01, 80, 'faca'};
    }
    
}

slots = {
    {140, 680, 100, 80, 255};
    {250, 680, 100, 80, 255};
    {360, 680, 100, 80, 255};
    {470, 680, 100, 80, 255};
    {580, 680, 100, 80, 255};
    {690, 680, 100, 80, 255};
    {800, 680, 100, 80, 255};
    {910, 680, 100, 80, 255};
    {1020, 680, 100, 80, 255};
    {1130, 680, 100, 80, 255};
}

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

function drawArsenals()
    drawScrollBar(40, 670, 350, 2.5, page * 20, 952)
    
    local x, y = 0, 0 
    for i, v in ipairs(windows) do 
        dxDrawImage(v[1], v[2], v[3], v[4], 'assets/images/bg_category.png', 0, 0, 0,((isMouseInPosition(v[1], v[2], v[3], v[4]) or window == v[5]) and tocolor(109, 40, 217, alpha) or tocolor(255, 255, 255, 20)))
        dxDrawText(v[5], v[1], v[2], v[3], v[4], ((isMouseInPosition(v[1], v[2], v[3], v[4]) or window == v[5]) and tocolor(255, 255, 255, 255) or tocolor(133, 133, 133, 255)), 1, getFont('medium', 14), "center", "center")
        x = x + 67 
        if (x >= 398) then 
            x = 0 
            y = y + 32 
        end
    end
    
    local wt = getWeaponPerson(weapon)
    dxDrawImage(1112, 577, 239, 90, 'assets/images/infoweapon.png', 0, 0, 0, tocolor(255, 255, 255, alpha))
    
    dxDrawImageSection(sx*1175, sy*598, sx*88/100*wt.damage, sy*3, 0, 0, 87, 3, 'assets/images/rect.png', 0, 0, 0, tocolor(109, 40, 217, alpha)) -- DANO
    dxDrawText(wt.damage, 1266, 594, 9, 10, tocolor(109, 40, 217, 255), 0.7, getFont('medium', 14), "left", "top")
    
    dxDrawImageSection(sx*1175, sy*619, sx*88/300*wt.distance, sy*3, 0, 0, 87, 3, 'assets/images/rect.png', 0, 0, 0, tocolor(109, 40, 217, alpha)) -- DISTANCIA
    dxDrawText(wt.distance, 1266, 615, 9, 10, tocolor(109, 40, 217, 255), 0.7, getFont('medium', 14), "left", "top")
    
    dxDrawImageSection(sx*1175, sy*640, sx*88/100*wt.precisao, sy*3, 0, 0, 87, 3, 'assets/images/rect.png', 0, 0, 0, tocolor(109, 40, 217, alpha)) -- PRECISAO
    dxDrawText(wt.precisao, 1266, 637, 9, 10, tocolor(109, 40, 217, 255), 0.7, getFont('medium', 14), "left", "top")
    
    
    dxDrawText(math.floor(getElementData(localPlayer, 'level_'..weapon) or 0), 1290, 608, 37, 38, tocolor(109, 40, 217, 255), 2, getFont('medium', 15), "center", "center") -- LEVEL
    
    
    
    dxDrawImage(30, 550, 147.84, 44.35, 'assets/images/bg_category.png', 0, 0, 0,((isMouseInPosition(30, 550, 147.84, 44.35) or (TYPE == 'ATTACHS')) and tocolor(109, 40, 217, alpha) or tocolor(255, 255, 255, 20)))
    dxDrawText('ATTACHS', 30, 550, 147.84, 44.35, ((isMouseInPosition(30, 550, 147.84, 44.35) or (TYPE == 'ATTACHS')) and tocolor(255, 255, 255, 255) or tocolor(133, 133, 133, 255)), 1, getFont('medium', 14), "center", "center")
    
    dxDrawImage(180, 550, 147.84, 44.35, 'assets/images/bg_category.png', 0, 0, 0,((isMouseInPosition(180, 550, 147.84, 44.35) or (TYPE == 'SKINS')) and tocolor(109, 40, 217, alpha) or tocolor(255, 255, 255, 20)))
    dxDrawText('SKINS', 180, 550, 147.84, 44.35, ((isMouseInPosition(180, 550, 147.84, 44.35) or (TYPE == 'SKINS')) and tocolor(255, 255, 255, 255) or tocolor(133, 133, 133, 255)), 1, getFont('medium', 14), "center", "center")
    
    if TYPE == 'SKINS' then
        dxDrawImage(30, 610, 147.84, 44.35, 'assets/images/bg_category.png', 0, 0, 0,((isMouseInPosition(30, 610, 147.84, 44.35) or (TYPE2 == 'SKINS')) and tocolor(109, 40, 217, alpha) or tocolor(255, 255, 255, 20)))
        dxDrawText('ADESIVOS', 30, 610, 147.84, 44.35, ((isMouseInPosition(30, 610, 147.84, 44.35) or (TYPE2 == 'SKINS')) and tocolor(255, 255, 255, 255) or tocolor(133, 133, 133, 255)), 1, getFont('medium', 14), "center", "center")
        
        dxDrawImage(180, 610, 147.84, 44.35, 'assets/images/bg_category.png', 0, 0, 0,((isMouseInPosition(180, 610, 147.84, 44.35) or (TYPE2 == 'MODELOS')) and tocolor(109, 40, 217, alpha) or tocolor(255, 255, 255, 20)))
        dxDrawText('MODELOS', 180, 610, 147.84, 44.35, ((isMouseInPosition(180, 610, 147.84, 44.35) or (TYPE2 == 'MODELOS')) and tocolor(255, 255, 255, 255) or tocolor(133, 133, 133, 255)), 1, getFont('medium', 14), "center", "center")
    elseif  TYPE == 'ATTACHS' then
        
        dxDrawImage(30, 610, 147.84, 44.35, 'assets/images/bg_category.png', 0, 0, 0,((isMouseInPosition(30, 610, 147.84, 44.35) or (TYPE2 == 'PENTE')) and tocolor(109, 40, 217, alpha) or tocolor(255, 255, 255, 20)))
        dxDrawText('PENTE', 30, 610, 147.84, 44.35, ((isMouseInPosition(30, 610, 147.84, 44.35) or (TYPE2 == 'PENTE')) and tocolor(255, 255, 255, 255) or tocolor(133, 133, 133, 255)), 1, getFont('medium', 14), "center", "center")
        
        dxDrawImage(180, 610, 147.84, 44.35, 'assets/images/bg_category.png', 0, 0, 0,((isMouseInPosition(180, 610, 147.84, 44.35) or (TYPE2 == 'CORONHA')) and tocolor(109, 40, 217, alpha) or tocolor(255, 255, 255, 20)))
        dxDrawText('CORONHA', 180, 610, 147.84, 44.35, ((isMouseInPosition(180, 610, 147.84, 44.35) or (TYPE2 == 'CORONHA')) and tocolor(255, 255, 255, 255) or tocolor(133, 133, 133, 255)), 1, getFont('medium', 14), "center", "center")
        
        dxDrawImage(330, 610, 147.84, 44.35, 'assets/images/bg_category.png', 0, 0, 0,((isMouseInPosition(330, 610, 147.84, 44.35) or (TYPE2 == 'BOCA')) and tocolor(109, 40, 217, alpha) or tocolor(255, 255, 255, 20)))
        dxDrawText('BOCA', 330, 610, 147.84, 44.35, ((isMouseInPosition(330, 610, 147.84, 44.35) or (TYPE2 == 'BOCA')) and tocolor(255, 255, 255, 255) or tocolor(133, 133, 133, 255)), 1, getFont('medium', 14), "center", "center")
        
    end
    
    for i,v in ipairs(armas[window]) do
        dxDrawImage(v[1], v[2], v[3], v[4], 'assets/images/bg_2.png', 0, 0, 0,((isMouseInPosition(v[1], v[2], v[3], v[4]) or (weapon == v[5])) and tocolor(109, 40, 217, alpha) or tocolor(255, 255, 255, 255)))
        if fileExists( 'assets/images/weapons/'..v[5]..'.png' ) then
            dxDrawImage(v[1]+15, v[2]+15, v[3]-30, v[4]-30, 'assets/images/weapons/'..v[5]..'.png', 0, 0, 0,((isMouseInPosition(v[1], v[2], v[3], v[4]) or (weapon == v[5])) and tocolor(255, 255, 255, alpha) or tocolor(255, 255, 255, 255)))
        else
            dxDrawText(v[5], v[1], v[2], v[3], v[4], ((isMouseInPosition(v[1], v[2], v[3], v[4]) or (weapon == v[5])) and tocolor(255, 255, 255, 255) or tocolor(133, 133, 133, 255)), 1, getFont('medium', 14), "center", "center")
        end
    end
    --getElementData(localPlayer, 'newModelWeapon_'..weapon)
    dxDrawImage(30, 680, 100, 80, 'assets/images/remove.png', 0, 0, 0, (isMouseInPosition(30, 680, 100, 80) and tocolor(240, 40, 40, alpha) or tocolor(255, 255, 255, alpha)))
    
    local line = 0
    if TYPE == 'SKINS' then
        for i, v in pairs(itens[window][TYPE2][weapon]) do 
            if (i > page and line < #slots) then 
                line2 = (line + 1)
                local conf = config.itensX[v]
                if TYPE2 == 'MODELOS' then
                    dxDrawImage(slots[i][1], slots[i][2], slots[i][3], slots[i][4], 'assets/images/slots.png', 0, 0, 0, ((isMouseInPosition(slots[i][1], slots[i][2], slots[i][3], slots[i][4]) or (getElementData(localPlayer, 'newModelWeapon_'..weapon) == conf.weaponID)) and tocolor(109, 40, 217, 255) or tocolor(255, 255, 255, alpha)))
                    dxDrawImage(slots[i][1], slots[i][2], slots[i][3], slots[i][4], 'assets/images/slots.png', 0, 0, 0, ((isMouseInPosition(slots[i][1], slots[i][2], slots[i][3], slots[i][4]) or (getElementData(localPlayer, 'newModelWeapon_'..weapon) == conf.weaponID)) and tocolor(109, 40, 217, 255) or tocolor(255, 255, 255, alpha)))
                    dxDrawImage(slots[i][1], slots[i][2]+3, slots[i][3]-8, slots[i][4]-3, 'assets/images/icons/'..v..'.png', 0, 0, 0, (isMouseInPosition(slots[i][1], slots[i][2], slots[i][3], slots[i][4]) or (getElementData(localPlayer, 'newModelWeapon_'..weapon) == conf.weaponID)) and tocolor(255, 255, 255, 255) or tocolor(255, 255, 255, 180))
                else
                    dxDrawImage(slots[i][1], slots[i][2], slots[i][3], slots[i][4], 'assets/images/slots.png', 0, 0, 0, ((isMouseInPosition(slots[i][1], slots[i][2], slots[i][3], slots[i][4]) or (getElementData(localPlayer, 'AdesiveWeapon_'..weapon) == v)) and tocolor(109, 40, 217, 255) or tocolor(255, 255, 255, alpha)))
                    dxDrawImage(slots[i][1], slots[i][2], slots[i][3], slots[i][4], 'assets/images/slots.png', 0, 0, 0, ((isMouseInPosition(slots[i][1], slots[i][2], slots[i][3], slots[i][4]) or (getElementData(localPlayer, 'AdesiveWeapon_'..weapon) == v)) and tocolor(109, 40, 217, 255) or tocolor(255, 255, 255, alpha)))
                    if conf.color then
                        dxDrawImage(slots[i][1], slots[i][2]+3, slots[i][3]-8, slots[i][4]-3, 'assets/images/icons/'..conf.textures..'.png', 0, 0, 0, (isMouseInPosition(slots[i][1], slots[i][2], slots[i][3], slots[i][4]) or (getElementData(localPlayer, 'AdesiveWeapon_'..weapon) == v) ) and tocolor(255, 255, 255, 255) or tocolor(255, 255, 255, 180))
                    else
                        dxDrawImage(slots[i][1], slots[i][2]+3, slots[i][3]-8, slots[i][4]-3, 'assets/images/icons/'..v..'.png', 0, 0, 0, (isMouseInPosition(slots[i][1], slots[i][2], slots[i][3], slots[i][4]) or (getElementData(localPlayer, 'AdesiveWeapon_'..weapon) == v) ) and tocolor(255, 255, 255, 255) or tocolor(255, 255, 255, 180))
                    end
                end
            end
        end
    elseif TYPE == 'ATTACHS' then
        for i, v in pairs(itens[window][TYPE2][weapon]) do 
            if (i > page and line < #slots) then 
                line2 = (line + 1)
                local conf = config.itensX[v]
                dxDrawImage(slots[i][1], slots[i][2], slots[i][3], slots[i][4], 'assets/images/slots.png', 0, 0, 0, (isMouseInPosition(slots[i][1], slots[i][2], slots[i][3], slots[i][4]) and tocolor(109, 40, 217, 255) or tocolor(255, 255, 255, alpha)))
                --dxDrawImage(slots[i][1], slots[i][2], slots[i][3], slots[i][4], 'assets/images/slots.png', 0, 0, 0, (isMouseInPosition(slots[i][1], slots[i][2], slots[i][3], slots[i][4]) and tocolor(109, 40, 217, 255) or tocolor(255, 255, 255, alpha)))
                dxDrawImage(slots[i][1], slots[i][2]+3, slots[i][3]-8, slots[i][4]-3, 'assets/images/icons/'..(conf.textures and conf.textures or v )..'.png', 0, 0, 0, (isMouseInPosition(slots[i][1], slots[i][2], slots[i][3], slots[i][4]) and tocolor(255, 255, 255, 255) or tocolor(255, 255, 255, 180)))
            end
        end
    end
end

addEventHandler('onClientKey', root, function(key, press)
    if (isEventHandlerAdded('onClientRender', root, drawArsenals) and press) then 
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

weaponModel = {
    ["m4"] = 50000,
    ["imbel"] = 50001,
    ["g36c"] = 50002,
    ["ak"] = 50003,
    ["m240"] = 50004,
    ["five"] = 50005,
    ["glock"] = 50006,
    ["magnum"] = 50007,
    ["thompson"] = 50008,
    ["mp5"] = 50009,
    ["skorpion"] = 50010,
    ["vector"] = 50011,
    ["bazooka" ] = 50012,
    ["escopeta"] = 50013,
    ["revolver"] = 50014,
    ["p90"] = 50015,
    ["tec9"] = 50016,
    ["machine2"] = 50017,
    ["faca"] = 50021,
}

addEventHandler('onClientClick', root, function(b, s)
    if (b == 'left' and s == 'down') then 
        if (isEventHandlerAdded('onClientRender', root, drawArsenals)) then 
            if (isMouseInPosition(30, 680, 100, 80)) then
                triggerServerEvent('NZ > RemoveWeaponSkin', resourceRoot, localPlayer, window, weapon, TYPE2)
                if TYPE == 'SKINS' then
                    if TYPE2 == 'SKINS' then
                        if isElement(objWeapon) then
                            triggerEvent('removerArmaStickerC', resourceRoot, localPlayer, objWeapon)
                        end
                    elseif TYPE2 == 'MODELOS' then
                        setElementData(objWeapon, 'objectID', weaponModel[weapon])
                    end
                elseif TYPE == 'ATTACHS' then
                    triggerEvent('removeWeaponAttach', localPlayer, TYPE2, objWeapon)
                end
            end
            local x, y = 0, 0 
            for i,v in ipairs(armas[window]) do
                if (isMouseInPosition(v[1], v[2], v[3], v[4])) then
                    if isElement(objWeapon) then
                        destroyElement(objWeapon)
                        objWeapon = createObject(921, 2176, 360.69, 64.88, 0, 0, 119)
                    end
                    weapon = v[5]
                    if objWeapon then
                        setElementData(objWeapon, 'objectID', (getElementData(localPlayer, 'newModelWeapon_'..weapon) and getElementData(localPlayer, 'newModelWeapon_'..weapon) or weaponModel[v[5]]))
                        
                        if getElementData(localPlayer, 'AdesiveWeapon_'..weapon) then
                            triggerEvent('setArmaStickerC', resourceRoot, localPlayer, 'arma', 'files/weapons/skins/'..getElementData(localPlayer, 'AdesiveWeapon_'..weapon)..".png", objWeapon)
                        end
                        if (getElementData(localPlayer, 'attached_'..weapon)) then
                            triggerEvent('setWeaponAttach', localPlayer, TYPE2, removeHex(getElementData(localPlayer, 'attached_'..weapon)), 'files/weapons/skins/'..removeHex(getElementData(localPlayer, 'attached_'..weapon))..".png", objWeapon)
                        end
                        if (getElementData(localPlayer, 'butt_'..weapon)) then
                            triggerEvent('setWeaponAttach', localPlayer, TYPE2, removeHex(getElementData(localPlayer, 'butt_'..weapon)), 'files/weapons/skins/'..removeHex(getElementData(localPlayer, 'butt_'..weapon))..".png", objWeapon)
                        end
                        if (getElementData(localPlayer, 'clip_'..weapon)) then
                            triggerEvent('setWeaponAttach', localPlayer, TYPE2, removeHex(getElementData(localPlayer, 'clip_'..weapon)), 'files/weapons/skins/'..removeHex(getElementData(localPlayer, 'clip_'..weapon))..".png", objWeapon)
                        end
                    end
                end
            end
            for i, v in ipairs(windows) do
                if (isMouseInPosition(v[1], v[2], v[3], v[4])) then 
                    window = v[5]
                    weapon = armas[window][1][5]
                    
                    if isElement(objWeapon) then
                        destroyElement(objWeapon)
                        objWeapon = createObject(921, 2176, 360.69, 64.88, 0, 0, 119)
                    end
                    if objWeapon then
                        setElementData(objWeapon, 'objectID', (getElementData(localPlayer, 'newModelWeapon_'..weapon) and getElementData(localPlayer, 'newModelWeapon_'..weapon) or weaponModel[weapon]))
                        if getElementData(localPlayer, 'AdesiveWeapon_'..weapon) then
                            triggerEvent('setArmaStickerC', resourceRoot, localPlayer, 'arma', 'files/weapons/skins/'..getElementData(localPlayer, 'AdesiveWeapon_'..weapon)..".png", objWeapon)
                        end
                        if (getElementData(localPlayer, 'attached_'..weapon)) then
                            triggerEvent('setWeaponAttach', localPlayer, TYPE2, removeHex(getElementData(localPlayer, 'attached_'..weapon)), 'files/weapons/skins/'..removeHex(getElementData(localPlayer, 'attached_'..weapon))..".png", objWeapon)
                        end
                        if (getElementData(localPlayer, 'butt_'..weapon)) then
                            triggerEvent('setWeaponAttach', localPlayer, TYPE2, removeHex(getElementData(localPlayer, 'butt_'..weapon)), 'files/weapons/skins/'..removeHex(getElementData(localPlayer, 'butt_'..weapon))..".png", objWeapon)
                        end
                        if (getElementData(localPlayer, 'clip_'..weapon)) then
                            triggerEvent('setWeaponAttach', localPlayer, TYPE2, removeHex(getElementData(localPlayer, 'clip_'..weapon)), 'files/weapons/skins/'..removeHex(getElementData(localPlayer, 'clip_'..weapon))..".png", objWeapon)
                        end
                    end
                    
                    page = 0
                    
                    return
                end
                x = x + 67 
                if (x >= 398) then 
                    x = 0 
                    y = y + 32 
                end
            end
            if (isMouseInPosition(180, 550, 147.84, 44.35)) then 
                TYPE = 'SKINS'
                TYPE2 = 'SKINS'
            elseif  (isMouseInPosition(30, 550, 147.84, 44.35)) then 
                TYPE = 'ATTACHS'
                TYPE2 = 'PENTE'
            end
            if TYPE == 'SKINS' then
                if isMouseInPosition(30, 610, 147.84, 44.35) then
                    TYPE2 = 'SKINS'
                elseif isMouseInPosition(180, 610, 147.84, 44.35) then
                    TYPE2 = 'MODELOS'
                end
            elseif TYPE == 'ATTACHS' then
                if isMouseInPosition(30, 610, 147.84, 44.35) then
                    TYPE2 = 'PENTE'
                elseif isMouseInPosition(180, 610, 147.84, 44.35) then
                    TYPE2 = 'CORONHA'
                elseif isMouseInPosition(330, 610, 147.84, 44.35) then
                    TYPE2 = 'BOCA'
                end
            end
            local line = 0
            for i, v in pairs(itens[window][TYPE2][weapon]) do 
                if (i > page and line < #slots) then 
                    line = (line + 1)
                    if (isMouseInPosition(slots[i][1], slots[i][2], slots[i][3], slots[i][4])) then
                        if TYPE == 'SKINS' then
                            if TYPE2 == 'SKINS' then
                                if objWeapon then
                                    triggerEvent('setArmaStickerC', resourceRoot, localPlayer, 'arma', 'files/weapons/skins/'..config.itensX[v]['textures']..".png", objWeapon)
                                end
                                triggerServerEvent('NZ > EquipWeaponSkin', resourceRoot, localPlayer, v, weapon, TYPE, TYPE2)
                            elseif TYPE2 == 'MODELOS' then
                                triggerServerEvent('NZ > EquipWeaponSkin', resourceRoot, localPlayer, v, weapon, TYPE, TYPE2)
                                if objWeapon then
                                    setElementData(objWeapon, 'objectID', config.itensX[v]['weaponID'])
                                end
                            end
                        elseif TYPE == 'ATTACHS' then
                            if TYPE2 == 'BOCA' then
                                if objWeapon then
                                    triggerEvent('setWeaponAttach', localPlayer, TYPE2, removeHex(config.itensX[v]['textures']), 'files/weapons/skins/'..config.itensX[v]['textures']..".png", objWeapon)
                                end
                                triggerServerEvent('NZ > EquipWeaponSkin', resourceRoot, localPlayer, v, weapon, TYPE, TYPE2)
                            elseif TYPE2 == 'CORONHA' then
                                if objWeapon then
                                    triggerEvent('setWeaponAttach', localPlayer, TYPE2, removeHex(config.itensX[v]['textures']), 'files/weapons/skins/'..config.itensX[v]['textures']..".png", objWeapon)
                                end
                                triggerServerEvent('NZ > EquipWeaponSkin', resourceRoot, localPlayer, v, weapon, TYPE, TYPE2)
                            elseif TYPE2 == 'PENTE' then
                                if objWeapon then
                                    triggerEvent('setWeaponAttach', localPlayer, TYPE2, removeHex(config.itensX[v]['textures']), 'files/weapons/skins/'..config.itensX[v]['textures']..".png", objWeapon)
                                end
                                triggerServerEvent('NZ > EquipWeaponSkin', resourceRoot, localPlayer, v, weapon, TYPE, TYPE2)
                            end
                        end
                        
                    end
                end
            end
        end
    end
end)

addEvent('NZ > openArsenal', true)
addEventHandler('NZ > openArsenal', root, function(Arsenals_)
    if not Arsenals_ then 
        if (isEventHandlerAdded('onClientRender', root, drawArsenals)) then 
            removeEventHandler('onClientRender', root, drawArsenals)
            triggerEvent("returnToLobbyCancelMatch", root, localPlayer)
            if isElement(objWeapon) then
                destroyElement(objWeapon)
            end
            return
        end
    end
    if not (isEventHandlerAdded('onClientRender', root, drawArsenals)) then 
        tick, Arsenals, camera, rotationProgress, page = getTickCount(), Arsenals_, 'corpo', config.spawnPlayer[4], 0
        addEventHandler('onClientRender', root, drawArsenals)
        showCursor(true)
        window = 'FUZIS'
        weapon = armas[window][1][5]
        TYPE = 'ATTACHS'     
        TYPE2 = 'PENTE'
        local x1, y1, z1 = getCameraMatrix()
        objWeapon = createObject(921, 2176, 360.69, 64.88, 0, 0, 119)
        createLight ( 0, 2177.771, 361.113, 64.9, 3, 255, 255, 255, 0, 0, 0 )
        setElementData(objWeapon, 'objectID', 50002)
        if getElementData(localPlayer, 'AdesiveWeapon_'..weapon) then
            triggerEvent('setArmaStickerC', resourceRoot, localPlayer, 'arma', 'files/weapons/skins/'..getElementData(localPlayer, 'AdesiveWeapon_'..weapon)..".png", objWeapon)
        end
        if (getElementData(localPlayer, 'attached_'..weapon)) then
            triggerEvent('setWeaponAttach', localPlayer, TYPE2, removeHex(getElementData(localPlayer, 'attached_'..weapon)), 'files/weapons/skins/'..removeHex(getElementData(localPlayer, 'attached_'..weapon))..".png", objWeapon)
        end
        if (getElementData(localPlayer, 'butt_'..weapon)) then
            triggerEvent('setWeaponAttach', localPlayer, TYPE2, removeHex(getElementData(localPlayer, 'butt_'..weapon)), 'files/weapons/skins/'..removeHex(getElementData(localPlayer, 'butt_'..weapon))..".png", objWeapon)
        end
        if (getElementData(localPlayer, 'clip_'..weapon)) then
            triggerEvent('setWeaponAttach', localPlayer, TYPE2, removeHex(getElementData(localPlayer, 'clip_'..weapon)), 'files/weapons/skins/'..removeHex(getElementData(localPlayer, 'clip_'..weapon))..".png", objWeapon)
        end
        itens = {}
        for ix, cfg in pairs(config['itensX']) do
            for index, variavel in pairs(config.categorys) do
                if not (itens[variavel]) then
                    itens[variavel] = {}
                end
                if not (itens[variavel][cfg.type[1]]) then
                    itens[variavel][cfg.type[1]] = {}
                end
                if not (itens[variavel][cfg.type[2]]) then
                    itens[variavel][cfg.type[2]] = {}
                end
                if not (itens[variavel][cfg.type[1]][cfg[2]]) then
                    itens[variavel][cfg.type[1]][cfg[2]] = {}
                end
                if not (itens[variavel][cfg.type[2]][cfg[2]]) then
                    itens[variavel][cfg.type[2]][cfg[2]] = {}
                end
            end
            for index, var in pairs(weaponModel) do
                if cfg[2] == 'all' then
                    if not (itens[cfg[1]][cfg.type[1]][index]) then
                        itens[cfg[1]][cfg.type[1]][index] = {}
                    end
                    if not (itens[cfg[1]][cfg.type[2]][index]) then
                        itens[cfg[1]][cfg.type[2]][index] = {}
                    end
                else
                    if not (itens[cfg[1]][cfg.type[1]][cfg[2]]) then
                        itens[cfg[1]][cfg.type[1]][cfg[2]] = {}
                    end
                    if not (itens[cfg[1]][cfg.type[2]][cfg[2]]) then
                        itens[cfg[1]][cfg.type[2]][cfg[2]] = {}
                    end
                end
            end
        end
        for i, v in ipairs(Arsenals) do
            local cfg = config.itensX[v]
            if cfg[2] == 'all' then
                for ind, var in pairs(weaponModel) do
                    table.insert(itens[cfg[1]][cfg.type[2]][ind], v)
                end
            else
                table.insert(itens[cfg[1]][cfg.type[2]][cfg[2]], v)
            end
        end
    end
end)

addEventHandler('onClientClick', root, function(b, s)
    if isElement(objWeapon) then
        if isMouseInPosition(330, 200, 720, 380) then
            if (b == 'left') then
                rotWeapon = (s == 'down' and true or false)
                exports['runy_outline']:createElementOutlineEffect(objWeapon, true)
                if s == 'up' then
                    exports['runy_outline']:createElementOutlineEffect(objWeapon, false)
                end
            end
        else
            rotWeapon = false
            exports['runy_outline']:createElementOutlineEffect(objWeapon, false)
        end
    end
end)

addEventHandler( "onClientCursorMove", getRootElement(), function ( cursorX, cursorY, absoluteX, absoluteY, x,y,z) 
    if rotWeapon and getKeyState('mouse1') then
        if objWeapon then
            local curX, curY, curZ = getElementRotation(objWeapon) 
            setElementRotation(objWeapon, curX, (absoluteY/3)-180, (absoluteX/3)-180) 
        end
    end
end) 

function removeArsenals()
    if (isEventHandlerAdded('onClientRender', root, drawArsenals)) then 
        
        removeEventHandler('onClientRender', root, drawArsenals)
        showCursor(false)
        
        triggerEvent("returnToLobbyCancelMatch", localPlayer, localPlayer)
        if isElement(objWeapon) then
            destroyElement(objWeapon)
        end
    end
    
end
addEvent('NZ > RunyCloseArsenal', true)
addEventHandler('NZ > RunyCloseArsenal', localPlayer, removeArsenals)

------------------------------------------------
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

-- ['ARMA'] = {"nome",                dano, precisão, andar atirando?, dis proximo, dis arma, pente, move speed},
mainweap = {
    
    ["five"] = {'silenced',    			10, 50,  true,  0,  90,  12,   1.3},
    
    ["glock"] = {'silenced',   			11, 45,  true,  0,  90,  18,   1.5},
    
    ["magnum"] = {'deagle',    			16, 60,  true,  0,  120,  8,   1.2 },
    
    ["revolver"] = {'deagle',  			16, 125, true,  0,  190,  8,   1 },
    
    ["skorpion"] = {'tec-9',   	   			8, 35,  true,  0,  120,  22,  1.1 },
    
    ["vector"] = {'tec-9',     			0, 30,  true,  40, 130,  25,  1.4 },
    
    ["mp5"] = {'mp5',          			11, 60,  true,  0,  140,  30,  1.1 },
    
    ["thompson"] = {'mp5',     			11, 60,  true,  0,  140,  25,  1.2 },
    
    ["p90"] = {'mp5',     				11, 60,  true,  0,  170,  30,  1.4 },
    
    ["tec9"] = {'mp5',     			10, 50,  true,  0,  140,  20,  1.5 },
    
    ["machine2"] = {'mp5',     			10, 50,  true,  0,  150,  22,  1.5 },
    
    ["imbel"] = {'m4',         			18, 50, true,  30,  230, 32,   1.4 },
    
    ["m4"] = {'m4',      	   			16, 50, true,  30,  240, 32,   1.4 },
    
    ["ak"] = {'ak-47',   	   			16, 50, true,  30,  240, 32,   1.4 },
    
    ["g36c"] = {'ak-47',   	   			18, 50, true,  30,  230, 32,   1.4 },
    
    ["m240"] = {'rifle',       			30, 45, true,  30,  300, 100,  1.3 },
    
    ["kar98"] = {'rifle',       		35, 70, true,  30,  300, 1,  1.3 },
    
    ["escopeta"] = {'shotgun', 			8,  30,  true,  15,  15,  2,    0.8 },
    
    ["bazooka"] = {'rocket launcher', 	50, 100, false, 0,  220, 1,    0.5 },
    
    ["faca"] = {'Chainsaw', 			10, 100, true, 11,  5, 5,     0.9 },
    
}

function getWeaponPerson(weapon)
    local bocaWeapon = localPlayer:getData('attached_'..weapon)
    local penteWeapon = localPlayer:getData('clip_'..weapon)
    local coronhaWeapon = localPlayer:getData('butt_'..weapon)
    local modules = mainweap[weapon]
    dados = {
        damage = modules[2],
        precisao = (bocaWeapon and modules[3]*1.2 or modules[3]),
        distance = (bocaWeapon and modules[6]*1.3 or modules[6])
    }
    return dados
end