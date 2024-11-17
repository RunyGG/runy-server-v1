Itens = {}
edits = {}
ItensAction = {}
local screenW, screenH = guiGetScreenSize()
local sW, sH = (screenW / 1366), (screenH / 768)

local actionBarVisible = false

local font = dxCreateFont("files/fonts/medium.ttf", 8)
local font2 = dxCreateFont("files/fonts/medium.ttf", 7)
local font3 = dxCreateFont("files/fonts/medium.ttf", 9)
local font4 = dxCreateFont("files/fonts/medium.ttf", 24)
local font5 = dxCreateFont("files/fonts/medium.ttf", 28)
local font6 = dxCreateFont("files/fonts/medium.ttf", 5)
local font7 = dxCreateFont("files/fonts/medium.ttf", 6)

Slots = {
    {482, 316, 74, 74},
    {565, 316, 74, 74},
    {648, 316, 74, 74},
    {731, 316, 74, 74},
    {814, 316, 74, 74},
}

local slotAction = {
    {1035, 685, 50.5, 50},
    {1094, 685, 50.5, 50},
    {1152, 685, 50.5, 50},
    {1211, 685, 50.5, 50},
    {1270, 685, 50.5, 50},
}

addEvent("fn:animKitMedic > Server", true)
addEventHandler("fn:animKitMedic > Server", localPlayer, function()
    if IFP then
        setPedAnimation(localPlayer, customBlockName, "WALK_heal", 10000, true, true, false, false)
    end
end)

aba = 4

function dx()
    dxDrawImage(466, 280, 438, 198, "files/imgs/base.png")

    local slotsOcupados = {}
    local imageSettings = {
        --[[ ["125.png"] = { width = 50, height = 26.38, offsetX = 14, offsetY = 25 },
        ["32.png"] = { width = 65, height = 22.2, offsetX = 4, offsetY = 27 },
        ["33.png"] = { width = 65, height = 25.16, offsetX = 4, offsetY = 27 },
        ["34.png"] = { width = 60, height = 20.5, offsetX = 6, offsetY = 26 },
        ["36.png"] = { width = 50, height = 34.72, offsetX = 12, offsetY = 22 }, ]]
        --[[ ["19.png"] = { width = 50, height = 10.9, offsetX = 14, offsetY = 32 } ]]
    }

    for i, v in ipairs(Itens) do
        if aba == v[4] then
            slotsOcupados[v[5]] = v
            if (selectSlot ~= v[5]) then

                if (Slots[v[5]]) then 

                    local imageWidth, imageHeight = 34, 34
                    local imageName = v[1] .. ".png"
                    
                    if imageSettings[imageName] then
                        imageWidth = imageSettings[imageName].width
                        imageHeight = imageSettings[imageName].height
                    end

                    local offsetX, offsetY = 20, 20

                    if imageSettings[imageName] then
                        offsetX = imageSettings[imageName].offsetX
                        offsetY = imageSettings[imageName].offsetY
                    end

                    if isMouseInPosition(Slots[v[5]][1], Slots[v[5]][2], 57, 57) or itemSelect == i then
                        if itemSelect == i then
                            dxDrawImage(Slots[v[5]][1], Slots[v[5]][2], 80, 70, "files/imgs/base_select.png")
                        end

                        dxDrawImage(Slots[v[5]][1]+offsetX, Slots[v[5]][2]+offsetY, imageWidth, imageHeight, "files/imgs/itens/"..v[1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
                        dxDrawImage(Slots[v[5]][1]+12.8, Slots[v[5]][2]-5, 10.5, 7, "files/imgs/qntd.png", 0, 0, 0, tocolor(255, 255, 255, 100), false)
                        dxDrawText(v[3], Slots[v[5]][1] + 1.3, Slots[v[5]][2]-18.5, 34, 34, tocolor(255, 255, 255,255), 1.00, font7, "center", "center", false, false, false, true, false)
                    else
                        dxDrawImage(Slots[v[5]][1]+12.8, Slots[v[5]][2]-5, 10.5, 7, "files/imgs/qntd.png", 0, 0, 0, tocolor(255, 255, 255, 100), false)
                        dxDrawText(v[3], Slots[v[5]][1] + 1.3, Slots[v[5]][2]-18.5, 34, 34, tocolor(255, 255, 255), 1.00, font7, "center", "center", false, false, false, true, false)
                        dxDrawImage(Slots[v[5]][1]+offsetX, Slots[v[5]][2]+offsetY  , imageWidth, imageHeight, "files/imgs/itens/"..v[1]..".png", 0, 0, 0, tocolor(255, 255, 255, 100), false)
                    end

                end
            else
                
                if isCursorShowing() then
                
                    local imageWidth, imageHeight = sW * 34, sH * 34
                    local imageName = v[1] .. ".png"
                    
                    if imageSettings[imageName] then
                        imageWidth = imageSettings[imageName].width * sW
                        imageHeight = imageSettings[imageName].height * sH
                    end
                    
                    local mx, my = getCursorPosition()
                    local cursorx, cursory = (mx * 1920), (my * 1080)
                    dxDrawImage(cursorx/1.47, cursory/1.4, imageWidth, imageHeight, "files/imgs/itens/" .. v[1] .. ".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
                
                end
                
            end
        end
    end

    for i, Slots in ipairs(Slots) do
        if not slotsOcupados[i] then
            dxDrawText(tostring(i), Slots[1]+32, Slots[2] + 23, 9, 29, tocolor(107, 107, 107, 255), 1.00, font5, "center", "center", false, false, false, true, false)
        end
    end

    local imageActionSettings = {
        --[[ ["125.png"] = { width = 30, height = 15.83, offsetX = 3, offsetY = 15 },
        ["32.png"] = { width = 35, height = 11.95, offsetX = 0.5, offsetY = 16 },
        ["33.png"] = { width = 35, height = 13.55, offsetX = 0.5, offsetY = 16.5 },
        ["34.png"] = { width = 35, height = 11.96, offsetX = 0.5, offsetY = 16 },
        ["36.png"] = { width = 30, height = 20.83, offsetX = 3, offsetY = 13 }, ]]
        --[[ ["19.png"] = { width = 35, height = 4.78, offsetX = 8, offsetY = 22 } ]]
    }

    for i, v in ipairs(slotAction) do


        if (slotsOcupados[i]) then 

            v.item = slotsOcupados[i][1]
            ItensAction[slotsOcupados[i][2]] = true 
            v.category = aba
            v.qnt = slotsOcupados[i][3]
            v.nameItem = slotsOcupados[i][2]

        else 

            v.item = false
            v.category = false
            v.nameItem = false
            v.qnt = false

        end 
        if v.item and v.qnt then
            local imageName = v.item .. ".png"
            local imageWidth, imageHeight, offsetX, offsetY = 30, 30, 10, 9
            if imageActionSettings[imageName] then
                imageWidth = imageActionSettings[imageName].width
                imageHeight = imageActionSettings[imageName].height
                offsetX = imageActionSettings[imageName].offsetX
                offsetY = imageActionSettings[imageName].offsetY
            end
            if v.qnt > 1 then
                dxDrawImage(v[1], v[2], v[3], v[4], "files/imgs/slotaction_select.png")
                dxDrawImage(v[1]+7, v[2]-4, 8, 6, "files/imgs/qntd_action.png", 0, 0, 0, tocolor(255, 255, 255, 100), false)
                dxDrawImage(v[1]+offsetX, v[2]+offsetY, imageWidth, imageHeight, 'files/imgs/itens/'..(v.item)..'.png')
                dxDrawText(v.qnt, v[1]-13, v[2]-7, 47, 13, tocolor(255, 255, 255), 1.00, font6, "center", "center", false, false, false, true, false)
            else 
                dxDrawImage(v[1], v[2], v[3], v[4], "files/imgs/slotaction_select-2.png")
                dxDrawImage(v[1]+offsetX, v[2]+offsetY, imageWidth, imageHeight, 'files/imgs/itens/'..(v.item)..'.png')
            end
        else
            dxDrawImage(v[1], v[2], v[3], v[4], "files/imgs/slotaction.png")
            dxDrawText(i, v[1], v[2]+1, v[3], v[4], tocolor(77, 77, 77, 255), 1.00, font5, "center", "center", false, false, false, true, false)
        end
    end
        dxDrawImage(482, 421, 149, 40, "files/imgs/manageedits.png") 
        dxDrawImage(648, 420, 118, 40, "files/imgs/button.png", 0, 0, 0, tocolor(255, 255, 255, 255))
        dxDrawImage(775, 420, 118, 40, "files/imgs/button2.png", 0, 0, 0, tocolor(255, 255, 255, 255))
        --[[ if isMouseInPosition(775, 420, 118, 40) then
            dxDrawText("Usar", 806, 423, 30, 18, tocolor(255, 255, 255, 255), 1, font3, "left", "center", false, false, false, true, false)
        else
            dxDrawText("Usar", 806, 423, 30, 18, tocolor(255, 255, 255, 255), 1, font3, "left", "center", false, false, false, true, false)
        end
        if isMouseInPosition(648, 420, 118, 40) then
            dxDrawText("Dropar", 668, 423, 46, 18, tocolor(255, 255, 255, 255), 1, font3, "left", "center", false, false, false, true, false)
        else
            dxDrawText("Dropar", 668, 423, 46, 18, tocolor(255, 255, 255, 255), 1, font3, "left", "center", false, false, false, true, false)
        end ]]
        createEditBox(520, 432, 75, 18, tocolor(124, 124, 124, 255), font3, 1)
end

function actionBar()
    local imageActionSettings = {
--[[         ["125.png"] = { width = 30, height = 15.83, offsetX = 3, offsetY = 15 },
        ["32.png"] = { width = 35, height = 11.95, offsetX = 0.5, offsetY = 16 },
        ["33.png"] = { width = 35, height = 13.55, offsetX = 0.5, offsetY = 16.5 },
        ["34.png"] = { width = 35, height = 11.96, offsetX = 0.5, offsetY = 16 },
        ["36.png"] = { width = 30, height = 20.83, offsetX = 3, offsetY = 13 }, ]]
        --[[ ["19.png"] = { width = 35, height = 4.78, offsetX = 8, offsetY = 22 } ]]
    }

    if not actionBarVisible then return end
    for i, v in ipairs(slotAction) do
        if v.item and v.qnt then
            local imageName = v.item .. ".png"
            local imageWidth, imageHeight, offsetX, offsetY = 30, 30, 10, 9
            if imageActionSettings[imageName] then
                imageWidth = imageActionSettings[imageName].width
                imageHeight = imageActionSettings[imageName].height
                offsetX = imageActionSettings[imageName].offsetX
                offsetY = imageActionSettings[imageName].offsetY
            end
            if v.qnt > 1 then
                dxDrawImage(v[1], v[2], v[3], v[4], "files/imgs/slotaction_select.png")
                dxDrawImage(v[1]+7, v[2]-4, 8, 6, "files/imgs/qntd_action.png", 0, 0, 0, tocolor(255, 255, 255, 100), false)
                dxDrawImage(v[1]+offsetX, v[2]+offsetY, imageWidth, imageHeight, 'files/imgs/itens/'..(v.item)..'.png')
                dxDrawText(v.qnt, v[1]-13, v[2]-7, 47, 13, tocolor(255, 255, 255), 1.00, font6, "center", "center", false, false, false, true, false)
            else 
                dxDrawImage(v[1], v[2], v[3], v[4], "files/imgs/slotaction_select-2.png")
                dxDrawImage(v[1]+offsetX, v[2]+offsetY, imageWidth, imageHeight, 'files/imgs/itens/'..(v.item)..'.png')
            end
        else
            dxDrawImage(v[1], v[2], v[3], v[4], "files/imgs/slotaction.png")
            dxDrawText(i, v[1], v[2]+1, v[3], v[4], tocolor(77, 77, 77, 255), 1.00, font5, "center", "center", false, false, false, true, false)
        end
    end
end
addEventHandler('onClientRender', root, actionBar)

function hideActionBar()
    actionBarVisible = false
end
addEvent("hideActionBar", true)
addEventHandler("hideActionBar", root, hideActionBar)


function showActionBar()
    actionBarVisible = true
end
addEvent("showActionBar", true)
addEventHandler("showActionBar", root, showActionBar)

--[[ function openInv()
    if not isEventHandlerAdded("onClientRender", root, dx) then
        addEventHandler("onClientRender", root, dx)
        removeEventHandler("onClientRender", root, actionBar)
        showCursor(true, false)
        selectSlot = false
        quantitySelect = 1
        manageEdits = false
        select = false
        EditBox("add")
        itemSelect = false
        subWindow = false
        aba = 4
        toggleControl("fire", false)
        toggleControl("aim_weapon", false)
    else
        removeEventHandler("onClientRender", root, dx)
        addEventHandler('onClientRender', root, actionBar)
        EditBox("destroy")
        toggleControl("fire", true)
        toggleControl("aim_weapon", true)
        showCursor(false)
    end
end
addEvent("JOAO.openInv", true)
addEventHandler("JOAO.openInv", root, openInv)
bindKey("tab", "down", openInv) ]]

function onDrinkEnergy()
    setElementData(localPlayer, "JOAO.bypass", true)
    setGameSpeed(1.3)
    setTimer(function()
        setGameSpeed(1)
        setElementData(localPlayer, "JOAO.bypass", false)
        setElementData(localPlayer, "UseEnergy", false)
        notifyC(localPlayer, "O efeito do energetico acabou.", "error")
    end, 8000, 1)
end
addEvent("useEnergy", true)
addEventHandler("useEnergy", getRootElement(), onDrinkEnergy)

addEventHandler("onClientKey", root, 
function(button, state)
    if (button == 'tab' and state) then
      --  if not getElementData(localPlayer, "battleRoyaleRunning") then return end
        if not isEventHandlerAdded("onClientRender", root, dx) then

            addEventHandler("onClientRender", root, dx)
            removeEventHandler("onClientRender", root, actionBar)
            showCursor(true, false)
            selectSlot = false
            quantitySelect = 1
            manageEdits = false
            select = false
            EditBox("add")
            itemSelect = false
            subWindow = false
            aba = 4
            toggleControl("fire", false)
            toggleControl("aim_weapon", false)

        end
        
    elseif (button == 'tab' and not state) then

        removeEventHandler("onClientRender", root, dx)
        addEventHandler('onClientRender', root, actionBar)
        EditBox("destroy")
        toggleControl("fire", true)
        toggleControl("aim_weapon", true)
        showCursor(false)

    end
end
);

addEvent("JOAO.soundItem", true)
addEventHandler("JOAO.soundItem", root,
function(item, time)
    if isElement(sound) then destroyElement(sound) end
    local sound = playSound("files/sounds/"..item..".mp3")
    setTimer(function()
        if isElement(sound) then 
            destroyElement(sound)
        end
    end, time, 1)
end)

function pressedAction(button, press)
    if press and tonumber(button) then
        if tonumber(button) >= 1 and tonumber(button) <= 5 then
            if not isEventHandlerAdded("onClientRender", root, dx) then
                local i = tonumber(button)
                local id = slotAction[i].item

                if id and config["Itens weapon"][id] then
                    if isTimer(TimerAC) then
                        local timerSeconds = getTimerDetails(TimerAC)
                    else
                        toggleControl('next_weapon', false)
                        toggleControl('previous_weapon', false)
                        triggerServerEvent('JOAO.useItem', localPlayer, localPlayer, id, tonumber(1), slotAction[i].category, slotAction[i].nameItem) 
                        updateAction(slotAction[i].nameItem)
                        bloqueado = true
                        TimerAC = setTimer(function()
                            bloqueado = false
                            toggleControl('next_weapon', false)
                            toggleControl('previous_weapon', false)
                        end, 800, 1)
                    end
                else
                    triggerServerEvent('JOAO.useItem', localPlayer, localPlayer, id, tonumber(1), slotAction[i].category, slotAction[i].nameItem)
                end
            end
        end
    end
end
addEventHandler('onClientKey', root, pressedAction)

addEvent("JOAO.attActionBar", true)
addEventHandler("JOAO.attActionBar", root,
function()
    ItensAction = {}
    for i,v in ipairs(slotAction) do 
        v.item = false 
        v.qnt = false
        v.nameItem = false
        v.category  = false 
    end 
end)

addEvent("JOAO.copyTable", true)
addEventHandler("JOAO.copyTable", root,
function(table_K)
    setClipboard(toJSON(table_K))
end)

function updateAction(iditem)
    for i,v in ipairs(slotAction) do 
        if not verifyItemInventory(iditem) then
            if v.nameItem == iditem then
                ItensAction[v.nameItem] = false
                v.qnt = false
                v.item = false 
                v.nameItem = false
                v.category  = false
            end
        end 
    end 
end
addEvent('JOAO.updateAction', true)
addEventHandler('JOAO.updateAction', root, updateAction)

function verifyItemInventory(idItem)
    if Itens then
        for i, v in pairs(Itens) do
            if v[2] == idItem then
                return true
            end
        end
    end
    return false
end

function setItemSlot(newslot)
    
    for i,v  in ipairs(Itens) do
        if aba == v[4] then
            if itemSelect == i and selectSlot ~= newslot then
                

                local occupied = verifySlotLivre(newslot, v[4])
                if not occupied then

                    v[5] = newslot
                    identity = false
                    if Itens[itemSelect][6] then
                        local jsonData = fromJSON(Itens[itemSelect][6])
                        identity = jsonData.identity
                    end
                    triggerServerEvent("JOAO.updateSlot", localPlayer, localPlayer, v[1], newslot, v[2], tostring(identity))

                else 


                    Itens[occupied][5] = selectSlot
                    identity = false
                    if Itens[occupied][6] then
                        local jsonData = fromJSON(Itens[occupied][6])
                        identity = jsonData.identity
                    end


                    v[5] = newslot
                    identity = false
                    if Itens[itemSelect][6] then
                        local jsonData = fromJSON(Itens[itemSelect][6])
                        identity = jsonData.identity
                    end

                    triggerServerEvent("JOAO.updateSlot", localPlayer, localPlayer, Itens[occupied][1], selectSlot, Itens[occupied][2], tostring(identity))
                    triggerServerEvent("JOAO.updateSlot", localPlayer, localPlayer, v[1], newslot, v[2], tostring(identity))
                    
                end

                selectSlot = false
                itemSelect = false

                
                break
            elseif itemSelect == i and selectSlot == newslot then
                selectSlot = false
                itemSelect = false
                break
            end 
        end
    end 
end

addEventHandler("onClientClick", root,
function(button, state)
    if button == "left" and state == "up" then
        if isEventHandlerAdded("onClientRender", root, dx) then
            select = false
            if guiGetText(edits[1]) == "" then guiSetText(edits[1], "Quantidade") end
            for i,v in ipairs(slotAction) do
                if isMouseInPosition(v[1], v[2], v[3], v[4]) and itemSelect and not v.item and not ItensAction[Itens[itemSelect][2]] then 
                    v.item = Itens[itemSelect][1]
                    ItensAction[Itens[itemSelect][2]] = true 
                    v.category = aba
                    v.qnt = Itens[itemSelect][3]
                    v.nameItem = Itens[itemSelect][2]
                    itemSelect = nil
                    selectSlot = nil
                    return
                elseif isMouseInPosition(v[1], v[2], v[3], v[4]) and v.item then 
                    ItensAction[v.nameItem] = nil 
                    v.item = false 
                    v.qnt = false
                    v.nameItem = false
                    v.category = false
                    return
                end
            end
            if manageEdits then
                if isMouseInPosition(775, 420, 118, 40) then
                    if guiGetText(edits[1]) == "" or guiGetText(edits[1]) == "Quantidade" then
                        notifyC(localPlayer, "Digite a quantidade!", "error")
                        itemSelect = false
                        manageEdits = false
                        selectSlot = false
                        return
                    end
                    local quantity = tonumber(guiGetText(edits[1]))
                    if not quantity then
                        notifyC(localPlayer, "A quantidade precisa ser em número!", "error")
                        itemSelect = false
                        manageEdits = false
                        selectSlot = false
                        return
                    end
                    if verifyNumber(quantity) then
                        notifyC(localPlayer, "Algo de errado com a quantidade!", "error")
                        itemSelect = false
                        manageEdits = false
                        selectSlot = false
                        return
                    end
                    identity = false
                    if Itens[itemSelect][6] then
                        local jsonData = fromJSON(Itens[itemSelect][6])
                        identity = jsonData.identity
                    end
                    triggerServerEvent("JOAO.useItem", localPlayer, localPlayer, Itens[itemSelect][1], quantity, Itens[itemSelect][2], tostring(identity))
                    itemSelect = false
                    manageEdits = false
                    selectSlot = false
                    return
                end
                if isMouseInPosition(648, 420, 118, 40) then
                    if guiGetText(edits[1]) == "" or guiGetText(edits[1]) == "Quantidade" then
                        quantity = Itens[itemSelect][3]
                    else
                        quantity = tonumber(guiGetText(edits[1]))
                        if not quantity then
                            notifyC(localPlayer, "A quantidade precisa ser em número!", "error")
                            itemSelect = false
                            manageEdits = false
                            selectSlot = false
                            return
                        end
                        if verifyNumber(quantity) then
                            notifyC(localPlayer, "Algo de errado com a quantidade!", "error")
                            itemSelect = false
                            manageEdits = false
                            selectSlot = false
                            return
                        end
                    end
                    identity = false
                    if Itens[itemSelect][6] then
                        local jsonData = fromJSON(Itens[itemSelect][6])
                        identity = jsonData.identity
                    end
                    triggerServerEvent("JOAO.dropItem", localPlayer, localPlayer, Itens[itemSelect][1], quantity, Itens[itemSelect][2], tostring(identity))
                    itemSelect = false
                    selectSlot = false
                    manageEdits = false
                    return
                end
              end
                if not manageEdits then
                  if isMouseInPosition(482, 421, 149, 40) then
                    select = false
                    if guiEditSetCaretIndex(edits[1], string.len(guiGetText(edits[1]))) then
                        select = 1
                        guiBringToFront(edits[1])
                        guiSetInputMode("no_binds_when_editing") 
                        if (guiGetText(edits[1]) == "Quantidade") then 
                            guiSetText(edits[1], "")
                        end
                    end
                    return
                  end
                end
                for i, v in ipairs(Slots) do
                  if isMouseInPosition(v[1], v[2], 57, 57) and selectSlot then
                      setItemSlot(i)
                      manageEdits = false
                      return
                  end
              end
              if manageEdits then
                  itemSelect = false
                  selectSlot = false
                  manageEdits = false
              end
          end
    -- elseif button == "right" and state == "up" then
    --     if isEventHandlerAdded("onClientRender", root, dx) then
    --         for i, v in ipairs(Itens) do
    --             if aba == v[4] then
    --                 if itemSelect ~= i then
    --                     if isMouseInPosition(Slots[v[5]][1], Slots[v[5]][2], 63, 63) and not subWindow then
    --                         if (getElementData(localPlayer, "usandoItem") or false) then
    --                             notifyC(localPlayer, "Aguarde para mexer no item!", "error")
    --                             return
    --                         end
    --                         manageEdits = true
    --                         itemSelect = i
    --                         playSound("files/sounds/release.mp3")
    --                         return
    --                     end
    --                 end
    --             end
    --         end
    --     end
    elseif button == "left" and state == "down" then
        if isEventHandlerAdded("onClientRender", root, dx) then
            for i, v in ipairs(Itens) do
                if aba == v[4] then
                    if itemSelect ~= i then

                        if (Slots[v[5]]) then 

                            if isMouseInPosition(Slots[v[5]][1], Slots[v[5]][2], 57, 57) and not manageEdits then
                                --[[ if (getElementData(localPlayer, "usandoItem") or false) then
                                    notifyC(localPlayer, "Aguarde para mexer no item!", "error")
                                    return
                                end ]]
                                manageEdits = true
                                selectSlot = v[5]
                                itemSelect = i
                                playSound("files/sounds/release.mp3")
                                return
                            end

                        end
                        
                    end
                end
            end
        end
    end
end)

function dxLixo()
    dxDrawText("Aperte \"K\" para pegar o loot do chão!", 484, 620, 377, 57, tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, true, true, false)
end

addEvent("JOAO.openLixo", true)
addEventHandler("JOAO.openLixo", root,
function(state)
    if not state then
        removeEventHandler("onClientRender", root, dxLixo)
    else
        addEventHandler("onClientRender", root, dxLixo)
    end
end)

addEvent("JOAO.inserirItem", true)
addEventHandler("JOAO.inserirItem", root,
function(tabela)

    Itens = {}
    for i, v in ipairs(tabela) do
        Itens[i] = {v.itemID, v.nameItem, v.qnt, v.category, tonumber(v.slot), v.dataItem, (v.qnt*config["Itens"][v.itemID][3])}
    end

    local slotsOcupados = {}
    for i, v in ipairs(Itens) do
        if aba == v[4] then
            slotsOcupados[v[5]] = v
        end
    end

    for i, v in ipairs(slotAction) do

        if (slotsOcupados[i]) then 

            v.item = slotsOcupados[i][1]
            ItensAction[slotsOcupados[i][2]] = true 
            v.category = aba
            v.qnt = slotsOcupados[i][3]
            v.nameItem = slotsOcupados[i][2]

        else 


            v.item = false
            v.category = false
            v.nameItem = false
            v.qnt = false

        end 
        
    end

end)

function verifySlotLivre(newslot, newAba)
    for i, v in ipairs(Itens) do
        if v[4] == newAba then
            if v[5] == newslot then
                return i
            end
        end
    end
    return false
end

function closeMenu()
    if isEventHandlerAdded("onClientRender", root, dx) then
        if manageEdits then
            select = false
            guiSetText(edits[1], "Quantidade")
            itemSelect = false
            manageEdits = false
            return
        end
        removeEventHandler("onClientRender", root, dx)
        showCursor(false)
    end
end
addEvent("JOAO.closeInvC", true)
addEventHandler("JOAO.closeInvC", root, closeMenu)
--[[ bindKey("backspace", "down", closeMenu) ]]

function isEventHandlerAdded( sEventName, pElementAttachedTo, func )
    if type( sEventName ) == "string" and isElement( pElementAttachedTo ) and type( func ) == "function" then
        local aAttachedFunctions = getEventHandlers( sEventName, pElementAttachedTo )
        if type( aAttachedFunctions ) == "table" and #aAttachedFunctions > 0 then
            for i, v in ipairs( aAttachedFunctions ) do
                if v == func then
                    return true
                end
            end
        end
    end
    return false
end

function EditBox(tipo)
    if tipo == 'destroy' then
        for i=1, #edits do
            if isElement(edits[i]) then 
                destroyElement(edits[i])
            end
        end
    elseif tipo == 'add' then
        edits[1] = guiCreateEdit(-1000, -1000, 325, 50, 'Quantidade', false)
        guiEditSetMaxLength(edits[1], 1000)
        guiSetProperty(edits[1], 'ValidationString', '[0-9]*')
	end 
end

--// Animações

local customBlockName = "animAndando"
local customBlockName2 = "animParado"
local customBlockName3 = "animCorrendo"

setTimer(function()
local IFP = engineLoadIFP("files/anim.ifp", customBlockName)
local IFP2 = engineLoadIFP("files/anim_parado.ifp", customBlockName2)
local IFP3 = engineLoadIFP("files/anim_correndo.ifp", customBlockName3)
if not IFP and IFP2 and IFP3 then
        print("Falha ao carregar a animação!")
    else
        print("Animação carregada com sucesso!")
    end
end, 1000, 1)

--// Colete .Anim

addEvent('runy_coleteAnim', true)
addEventHandler('runy_coleteAnim', root, 
    function(player, cancel)
        if cancel then
            engineRestoreAnimation(player, 'ped', 'run_player')
            engineRestoreAnimation(player, 'ped', 'IDLE_stance')
            engineRestoreAnimation(player, 'ped', 'sprint_civi')
            return
        end
            engineReplaceAnimation(player, 'ped', 'run_player', customBlockName, 'WALK_vest')
            engineReplaceAnimation(player, 'ped', 'IDLE_stance', customBlockName2, 'WALK_vest')
            engineReplaceAnimation(player, 'ped', 'sprint_civi', customBlockName3, 'sprint_vest')
    end
)

--// Bandagem .Anim

addEvent('runy_bandagemAnim', true)
addEventHandler('runy_bandagemAnim', root, 
    function(player, cancel)
        if cancel then
            engineRestoreAnimation(player, 'ped', 'run_player')
            engineRestoreAnimation(player, 'ped', 'IDLE_stance')
            engineRestoreAnimation(player, 'ped', 'sprint_civi')
            return
        end
            engineReplaceAnimation(player, 'ped', 'run_player', customBlockName, 'WALK_heal')
            engineReplaceAnimation(player, 'ped', 'IDLE_stance', customBlockName2, 'WALK_heal')
            engineReplaceAnimation(player, 'ped', 'sprint_civi', customBlockName3, 'sprint_heal')
    end
)