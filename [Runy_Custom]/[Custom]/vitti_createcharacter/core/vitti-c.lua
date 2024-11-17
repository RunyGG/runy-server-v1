function RenderPainel()
    dxDrawRoundedRectangle(x*1440,y*355,x*450,y*370,tocolor(32,34,37,255),8)
    dxDrawText('Criação de Personagem', x*1560,y*375,x*401,y*20, tocolor(255,255,255,255),1.0,fonts[1])
    dxDrawRoundedRectangle(x*1460,y*435,x*401,y*30,tocolor(64,66,72,255),3)
    dxDrawText('Selecione um rosto:', x*1460,y*414,x*132,y*16, tocolor(255,255,255,255),1.0,fonts[2])
    dxDrawText('1', rostopos[1][1][1],rostopos[1][1][2],rostopos[1][1][3], rostopos[1][1][4], tocolor(255,255,255,255),1.0,fonts[3])
    dxDrawText('2',rostopos[2][1][1],rostopos[2][1][2],rostopos[2][1][3], rostopos[2][1][4], tocolor(255,255,255,255),1.0,fonts[3])
    dxDrawText('3', rostopos[3][1][1],rostopos[3][1][2],rostopos[3][1][3], rostopos[3][1][4], tocolor(255,255,255,255),1.0,fonts[3])
    dxDrawText('4', rostopos[4][1][1],rostopos[4][1][2],rostopos[4][1][3], rostopos[4][1][4], tocolor(255,255,255,255),1.0,fonts[3])
    dxDrawRectangle(x*select[selectvalue].x,y*select[selectvalue].y,x*select[selectvalue].w,y*select[selectvalue].h,tocolor(201,199,199,255))
    dxDrawRoundedRectangle(x*1460,y*506,x*401,y*30,tocolor(64,66,72,255),3)
    dxDrawText('Selecione seu gênero:', x*1587,y*485,x*147,y*16, tocolor(255,255,255,255),1.0,fonts[2])
    dxDrawText('Masculino', x*1508,y*513,x*69,y*16, tocolor(255,255,255,255),1.0,fonts[3])
    dxDrawText('Feminino', x*1761,y*513,x*64,y*16, tocolor(255,255,255,255),1.0,fonts[3])
    dxDrawRectangle(x*selectgen[selectgenvalue][1][1],y*selectgen[selectgenvalue][1][2],x*selectgen[selectgenvalue][1][3],y*selectgen[selectgenvalue][1][4],tocolor(201,199,199,255))
    dxDrawText('Selecione uma cor de pele:', x*1570,y*557,x*180,y*16, tocolor(255,255,255,255),1.0,fonts[2])
    dxDrawRoundedRectangle(x*1561,y*578,x*207,y*50,tocolor(64,66,72,255),3)
    for i=1,4 do
        dxDrawImage(selectcolor[i][1][1],selectcolor[i][1][2],selectcolor[i][1][3],selectcolor[i][1][4], "core/gfx/circle.png", 0,0,0,selectcolor[i][2])
    end
    dxDrawRoundedRectangle(x*1540,y*655,x*250,y*50,isCursorOnElement(x*1540,y*655,x*250,y*50) and tocolor(75,90,140,180) or tocolor(75,90,140,255),5)
    dxDrawText('Confirmar', x*1618,y*669,x*94,y*22, tocolor(255,255,255,255),1.0,fonts[4])
end


addEvent('Vitti:LoadPainel',true)
addEventHandler('Vitti:LoadPainel', getRootElement(), function()
    setElementDimension(source,3)
    setElementData(source, "createPersonGG", true)
    addEventHandler('onClientRender', getRootElement(), RenderPainel)
    playercolor = 1
    selectgenvalue = 1
    selectvalue = 1
    for i,v in pairs(Config["Default-Clothes"]["Masculine"]) do
        exports["customcharacter"]:setClothe(source, 1,i,unpack(v[1]))
    end
    painel = true
end)

addEventHandler('onClientClick',getRootElement(), function(button,state)
    if button == "left" and state == "down" then
        if painel then
            if isCursorOnElement(x*1508,y*513,x*69,y*16) then
                playercolor = 1
                selectgenvalue = 1
                selectvalue = 1
                setElementModel(localPlayer,1)
                for i,v in pairs(Config["Default-Clothes"]["Masculine"]) do
                    exports["customcharacter"]:setClothe(localPlayer, 1,i,unpack(v[1]))
                end
            elseif isCursorOnElement(x*1761,y*513,x*64,y*16) then
                playercolor = 1
                selectgenvalue = 2
                selectvalue = 1
                setElementModel(localPlayer,10)
                for i,v in pairs(Config["Default-Clothes"]["Female"]) do
                    exports["customcharacter"]:setClothe(localPlayer, 10, i, unpack(v[1]))
                end
            elseif isCursorOnElement(x*1540,y*655,x*250,y*50) then
                triggerServerEvent('Vitti:onConfirm',localPlayer,localPlayer,getElementModel(localPlayer),playercolor,selectvalue)
                removeEventHandler('onClientRender', getRootElement(), RenderPainel)
                painel = false
                playercolor = 1
                selectgenvalue = 2
                selectvalue = 1
            end
            for i=1,#rostopos do
                if isCursorOnElement(rostopos[i][1][1], rostopos[i][1][2],rostopos[i][1][3],rostopos[i][1][4]) then
                    selectvalue = i
                    exports["customcharacter"]:setClothe(localPlayer, getElementModel(localPlayer), "rosto", i, playercolor)
                    break;
                end
            end
            for i=1,4 do 
                if isCursorOnElement(selectcolor[i][1][1], selectcolor[i][1][2],selectcolor[i][1][3],selectcolor[i][1][4]) then
                    playercolor = i
                    if selectgenvalue == 1 then
                        exports["customcharacter"]:setClothe(localPlayer, 1, "rosto", selectvalue, playercolor)
                        exports["customcharacter"]:setClothe(localPlayer, 1, "perna", 1, playercolor)
                        exports["customcharacter"]:setClothe(localPlayer, 1, "corpo", 1, playercolor)
                        exports["customcharacter"]:setClothe(localPlayer, 1, "braco", 1, playercolor)
                        exports["customcharacter"]:setClothe(localPlayer, 1, "pe", 1, playercolor)
                        
                        exports["customcharacter"]:setClothe(localPlayer, 1, "corpo", 2, 2)
                        exports["customcharacter"]:setClothe(localPlayer, 1, "short", 2, 2)
                        
                        
                    elseif selectgenvalue == 2 then
                        exports["customcharacter"]:setClothe(localPlayer, 10,"rosto",selectvalue,playercolor)
                        exports["customcharacter"]:setClothe(localPlayer, 10,"perna",1,playercolor)
                        exports["customcharacter"]:setClothe(localPlayer, 10,"corpo",1,playercolor)
                        exports["customcharacter"]:setClothe(localPlayer, 10,"braco",1,playercolor)
                        exports["customcharacter"]:setClothe(localPlayer, 10,"pe",1,playercolor)
                        
                        exports["customcharacter"]:setClothe(localPlayer, 10, "corpo", 2, 2)
                        exports["customcharacter"]:setClothe(localPlayer, 10, "short", 2, 2)
                    end
                end
            end
        end
    end
end)