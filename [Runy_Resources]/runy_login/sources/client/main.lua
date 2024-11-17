local font = dxCreateFont("files/fonts/semibold.ttf", 14)
local font2 = dxCreateFont("files/fonts/medium.ttf", 9)
local font3 = dxCreateFont("files/fonts/medium.ttf", 10)
local font4 = dxCreateFont("files/fonts/semibold.ttf", 9)

edits = {}

function dx()
    if indexMusicPlay and isElement(sound) then
        if isSoundPaused(sound) then
            if lastMusicCount then
                musicCount = lastMusicCount
            else
                musicCount = 0
            end
        else
            local musicConvertTime = convertTimestamp(indexMusicPlay[2])
            if lastMusicCount then
                musicCount = interpolateBetween(lastMusicCount, 0, 0, 203, 0, 0, ((getTickCount() - tickMusicRestart) / musicConvertTime), "Linear")
            else
                musicCount = interpolateBetween(0, 0, 0, 203, 0, 0, ((getTickCount() - tickMusicRestart) / musicConvertTime), "Linear")
            end
        end
    end
    if window == "login" then
        dxDrawRectangle(0,0,1366,768, tocolor(0, 0, 0, 255))
        dxDrawImage(0, 0, 1366, 768, "files/imgs/login.png")
        
        dxDrawImage(19, 51, 45, 45, "files/imgs/discord.png")
        if isMouseInPosition(19, 51, 45, 45) then
            dxDrawImage(19, 51, 45, 45, "files/imgs/discord2.png")
        end
        dxDrawImage(18, 189, 45, 45, "files/imgs/tiktok.png")
        if isMouseInPosition(18, 189, 45, 45) then
            dxDrawImage(18, 189, 45, 45, "files/imgs/tiktok2.png")
        end
        dxDrawImage(17, 258, 45, 45, "files/imgs/site.png")
        if isMouseInPosition(17, 258, 45, 45) then
            dxDrawImage(17, 258, 45, 45, "files/imgs/site2.png")
        end    
        dxDrawImage(19, 120, 45, 45, "files/imgs/youtube.png")
        if isMouseInPosition(19, 120, 45, 45) then
            dxDrawImage(19, 120, 45, 45, "files/imgs/youtube2.png")    
        end
        
        createEditBox(792.2, 304.33, 200, 26.58, tocolor(255, 255, 255, 60), font3, 1)
        createEditBox(792, 409, 200, 33.23, tocolor(255, 255, 255, 60), font3, 2)
        if isMouseInPosition(777.58, 514.36, 281.79, 67.79) then
            dxDrawImage(777.58, 514.36, 281.79, 67.79, "files/imgs/button2.png")
        else
            dxDrawImage(777.58, 514.36, 281.79, 67.79, "files/imgs/button.png")
        end
    
elseif window == "register" then
    dxDrawRectangle(0,0,1366,768, tocolor(0, 0, 0, 255))
    dxDrawImage(0, 0, 1366, 768, "files/imgs/register.png")
    createEditBox(799, 260, 200, 25, tocolor(255, 255, 255, 60), font3, 1)
    createEditBox(799, 361, 200, 25, tocolor(255, 255, 255, 60), font3, 2)
    createEditBox(799, 460, 200, 25, tocolor(255, 255, 255, 60), font3, 3)
    if isMouseInPosition(783.62, 529, 281.79, 67.79) then
        dxDrawImage(783.62, 529, 281.79, 67.79, "files/imgs/button4.png")
        --dxDrawText("Registrar Conta", 863, 528.46, 142, 25, tocolor(116, 116, 116, 255), 1.00, font, "left", "top", false, false, false, false, false)
    else
        dxDrawImage(783.62, 529, 281.79, 67.79, "files/imgs/button5.png", 0, 0, 0, tocolor(255, 255, 255, 255))
        --dxDrawText("Registrar Conta", 863, 528.46, 142, 25, tocolor(255, 255, 255, 255), 1.00, font, "left", "top", false, false, false, false, false)
    end
    
    dxDrawImage(19, 51, 45, 45, "files/imgs/discord.png")
    if isMouseInPosition(19, 51, 45, 45) then
        dxDrawImage(19, 51, 45, 45, "files/imgs/discord2.png")
    end
    dxDrawImage(18, 189, 45, 45, "files/imgs/tiktok.png")
    if isMouseInPosition(18, 189, 45, 45) then
        dxDrawImage(18, 189, 45, 45, "files/imgs/tiktok2.png")
    end
    dxDrawImage(17, 258, 45, 45, "files/imgs/site.png")
    if isMouseInPosition(17, 258, 45, 45) then
        dxDrawImage(17, 258, 45, 45, "files/imgs/site2.png")
    end    
    dxDrawImage(19, 120, 45, 45, "files/imgs/youtube.png")
    if isMouseInPosition(19, 120, 45, 45) then
        dxDrawImage(19, 120, 45, 45, "files/imgs/youtube2.png")    
    end

elseif window == "recover" then
    dxDrawImage(0, 0, 1366, 768, "files/imgs/recover.png")
    dxDrawText("Recuperar senha", 71, 315, 77, 18, tocolor(255, 255, 255, 90), 1.00, font, "left", "center", false, false, false, false, false)
    dxDrawText("#9F99B1Caso não precise de recuperação, #BEBACAvolte para tela inicial", 21, 435, 389, 15, tocolor(255, 255, 255, 255), 1.00, font2, "center", "center", false, false, false, true, false)
    if isMouseInPosition(83, 435, 276, 15) then
        dxDrawRectangle(255, 448, 104, 1, tocolor(255, 255, 255, 60))
    end
    if isMouseInPosition(358, 376, 39, 39) then
        dxDrawImage(356, 376, 39, 39, "files/imgs/send.png")
    else
        dxDrawImage(356, 376, 39, 39, "files/imgs/send.png", 0, 0, 0, tocolor(255, 255, 255, 50))
    end
    if isMouseInPosition(240, 47, 13, 13) then
        dxDrawImage(240, 47, 13, 13, "files/imgs/back.png", 0, 0, 0, tocolor(255, 255, 255, 40))
    else
        dxDrawImage(240, 47, 13, 13, "files/imgs/back.png", 0, 0, 0, tocolor(255, 255, 255, 20))
    end
    if isMouseInPosition(264, 49, 9, 9) then
        dxDrawImage(264, 49, 9, 9, "files/imgs/pause.png", 0, 0, 0, tocolor(255, 255, 255, 100))
    else
        dxDrawImage(264, 49, 9, 9, "files/imgs/pause.png", 0, 0, 0, tocolor(255, 255, 255, 60))
    end
    if isMouseInPosition(283, 47, 13, 13) then
        dxDrawImage(283, 47, 13, 13, "files/imgs/pass.png", 0, 0, 0, tocolor(255, 255, 255, 40))
    else
        dxDrawImage(283, 47, 13, 13, "files/imgs/pass.png", 0, 0, 0, tocolor(255, 255, 255, 20))
    end
    
    if indexMusicPlay and isElement(sound) then
        dxDrawText(indexMusicPlay[3], 105, 66, 203, 13, tocolor(109, 40, 217, 255), 1.00, font2, "left", "center", true, false, false, false, false)
    else
        dxDrawText("Nenhuma música tocando", 105, 66, 203, 13, tocolor(109, 40, 217, 255), 1.00, font2, "left", "center", true, false, false, false, false)
    end
elseif window == "code" then
    dxDrawImage(0, 0, 1366, 768, "files/imgs/recover.png")
    dxDrawText("Código de recuperação", 71, 315, 77, 18, tocolor(255, 255, 255, 90), 1.00, font, "left", "center", false, false, false, false, false)
    dxDrawText("Olhe seu e-mail para poder recuperar a senha", 71, 331, 264, 18, tocolor(255, 255, 255, 35), 1.00, font2, "left", "center", false, false, false, true, false)
    createEditBox(86, 365, 260, 60, tocolor(255, 255, 255, 60), font3, 5)
    dxDrawText("#9F99B1Caso não precise de recuperação, #BEBACAvolte para tela inicial", 21, 435, 389, 15, tocolor(255, 255, 255, 255), 1.00, font2, "center", "center", false, false, false, true, false)
    if isMouseInPosition(83, 435, 276, 15) then
        dxDrawRectangle(255, 448, 104, 1, tocolor(255, 255, 255, 60))
    end
    if isMouseInPosition(358, 376, 39, 39) then
        dxDrawImage(356, 376, 39, 39, "files/imgs/send.png")
    else
        dxDrawImage(356, 376, 39, 39, "files/imgs/send.png", 0, 0, 0, tocolor(255, 255, 255, 50))
    end
    if isMouseInPosition(240, 47, 13, 13) then
        dxDrawImage(240, 47, 13, 13, "files/imgs/back.png", 0, 0, 0, tocolor(255, 255, 255, 40))
    else
        dxDrawImage(240, 47, 13, 13, "files/imgs/back.png", 0, 0, 0, tocolor(255, 255, 255, 20))
    end
    if isMouseInPosition(264, 49, 9, 9) then
        dxDrawImage(264, 49, 9, 9, "files/imgs/pause.png", 0, 0, 0, tocolor(255, 255, 255, 100))
    else
        dxDrawImage(264, 49, 9, 9, "files/imgs/pause.png", 0, 0, 0, tocolor(255, 255, 255, 60))
    end
    if isMouseInPosition(283, 47, 13, 13) then
        dxDrawImage(283, 47, 13, 13, "files/imgs/pass.png", 0, 0, 0, tocolor(255, 255, 255, 40))
    else
        dxDrawImage(283, 47, 13, 13, "files/imgs/pass.png", 0, 0, 0, tocolor(255, 255, 255, 20))
    end
    
    if indexMusicPlay and isElement(sound) then
        dxDrawText(indexMusicPlay[3], 105, 66, 203, 13, tocolor(109, 40, 217, 255), 1.00, font2, "left", "center", true, false, false, false, false)
    else
        dxDrawText("Nenhuma música tocando", 105, 66, 203, 13, tocolor(109, 40, 217, 255), 1.00, font2, "left", "center", true, false, false, false, false)
    end
elseif window == "pass" then
    dxDrawImage(0, 0, 1366, 768, "files/imgs/changepass.png")
    dxDrawText("Recuperação de senha", 61, 264, 353, 18, tocolor(255, 255, 255, 90), 1.00, font, "left", "center", false, false, false, false, false)
    dxDrawText("Digite a nova senha da sua conta", 61, 282, 206, 18, tocolor(255, 255, 255, 35), 1.00, font2, "left", "center", false, false, false, true, false)
    createEditBox(792.2, 304.33, 200, 26.58, tocolor(255, 255, 255, 60), font3, 2)
    createEditBox(603, 355, 200, 14, tocolor(255, 255, 255, 60), font3, 3)
    if isMouseInPosition(26, 443, 389, 60) then
        dxDrawImage(26, 443, 389, 60, "files/imgs/button.png")
        dxDrawImage(368, 463, 22, 22, "files/imgs/enter.png")
        dxDrawText("Trocar senha", 43, 443, 291, 60, tocolor(29, 20, 54, 255), 1.00, font, "left", "center", false, false, false, false, false)
    else
        dxDrawImage(26, 443, 389, 60, "files/imgs/button.png", 0, 0, 0, tocolor(255, 255, 255, 50))
        dxDrawImage(368, 463, 22, 22, "files/imgs/enter.png", 0, 0, 0, tocolor(255, 255, 255, 50))
        dxDrawText("Trocar senha", 43, 443, 291, 60, tocolor(29, 20, 54, 50), 1.00, font, "left", "center", false, false, false, false, false)
    end
    if isMouseInPosition(240, 47, 13, 13) then
        dxDrawImage(240, 47, 13, 13, "files/imgs/back.png", 0, 0, 0, tocolor(255, 255, 255, 40))
    else
        dxDrawImage(240, 47, 13, 13, "files/imgs/back.png", 0, 0, 0, tocolor(255, 255, 255, 20))
    end
    if isMouseInPosition(264, 49, 9, 9) then
        dxDrawImage(264, 49, 9, 9, "files/imgs/pause.png", 0, 0, 0, tocolor(255, 255, 255, 100))
    else
        dxDrawImage(264, 49, 9, 9, "files/imgs/pause.png", 0, 0, 0, tocolor(255, 255, 255, 60))
    end
    if isMouseInPosition(283, 47, 13, 13) then
        dxDrawImage(283, 47, 13, 13, "files/imgs/pass.png", 0, 0, 0, tocolor(255, 255, 255, 40))
    else
        dxDrawImage(283, 47, 13, 13, "files/imgs/pass.png", 0, 0, 0, tocolor(255, 255, 255, 20))
    end
    
    if indexMusicPlay and isElement(sound) then
        dxDrawText(indexMusicPlay[3], 105, 66, 203, 13, tocolor(109, 40, 217, 255), 1.00, font2, "left", "center", true, false, false, false, false)
    else
        dxDrawText("Nenhuma música tocando", 105, 66, 203, 13, tocolor(109, 40, 217, 255), 1.00, font2, "left", "center", true, false, false, false, false)
    end
end
end

addEventHandler("onClientResourceStart", resourceRoot,
function()
    if not isEventHandlerAdded("onClientRender", root, dx) then
        window = "login"
        select = false
        showChat(false)
        tocarSom()
        EditBox("add")
        addEventHandler("onClientRender", root, dx)
        showCursor(true)
        user, password = loadLoginFromXML()
        if (user) and (password) then 
            guiSetText(edits[1], user)
            guiSetText(edits[2], password)
        end
        setElementData(localPlayer, 'BloqHud', true)
    end
end)

Discord = {}

addEventHandler("onClientClick", root, function(_, state)
    if state == "up" then
        Discord[localPlayer] = getDiscordRichPresenceUserID()
        if isEventHandlerAdded("onClientRender", root, dx) then
            select = false
            if guiGetText(edits[1]) == "" then guiSetText(edits[1], "Usuário") end
            if guiGetText(edits[2]) == "" then guiSetText(edits[2], "Senha") end
            if guiGetText(edits[3]) == "" then guiSetText(edits[3], "Confirmação de senha") end
            if guiGetText(edits[4]) == "" then guiSetText(edits[4], "E-mail") end
            if guiGetText(edits[5]) == "" then guiSetText(edits[5], "Código") end
            if window == "login" then
                if isMouseInPosition(1069.4, 529, 50.51, 67.79) then
                    window = "register"
                    guiSetText(edits[1], "Usuário")
                    guiSetText(edits[2], "Senha")
                    guiSetText(edits[3], "Confirmação de senha")
                    guiSetText(edits[4], "E-mail")
                    guiSetText(edits[5], "Código")
                end
                if isMouseInPosition(792.2, 304.33, 200, 26.58) then
                    select = false
                    if guiEditSetCaretIndex(edits[1], string.len(guiGetText(edits[1]))) then
                        select = 1
                        guiBringToFront(edits[1])
                        guiSetInputMode("no_binds_when_editing") 
                        if (guiGetText(edits[1]) == "Usuário") then 
                            guiSetText(edits[1], "")
                        end
                    end
                end
                if isMouseInPosition(792, 401, 200, 25) then
                    select = false
                    if guiEditSetCaretIndex(edits[2], string.len(guiGetText(edits[2]))) then
                        select = 2
                        guiBringToFront(edits[2])
                        guiSetInputMode("no_binds_when_editing") 
                        if (guiGetText(edits[2]) == "Senha") then 
                            guiSetText(edits[2], "")
                        end
                    end
                end
                if isMouseInPosition(777.58, 514.36, 281.79, 67.79) then
                    if guiGetText(edits[1]) == "" or guiGetText(edits[1]) == "Usuário" then
                        notifyC("Digite o nome de usuário!", "error")
                        return
                    end
                    if guiGetText(edits[2]) == "" or guiGetText(edits[2]) == "Senha" then
                        notifyC("Digite a senha!", "error")
                        return
                    end
                    triggerServerEvent("JOAO.loginAccount", localPlayer, localPlayer, guiGetText(edits[1]), guiGetText(edits[2]), Discord[localPlayer])
                end
                if isMouseInPosition(19, 51, 45, 45) then
                    setClipboard("discord.gg/runygg");
                end
                if isMouseInPosition(18, 189, 45, 45) then
                    setClipboard("https://www.tiktok.com/@runygg");
                end
                if isMouseInPosition(19, 120, 45, 45) then
                    setClipboard("N/A");
                end
            elseif window == "register" then
                if isMouseInPosition(799, 260, 200, 25) then
                    select = false
                    if guiEditSetCaretIndex(edits[1], string.len(guiGetText(edits[1]))) then
                        select = 1
                        guiBringToFront(edits[1])
                        guiSetInputMode("no_binds_when_editing") 
                        if (guiGetText(edits[1]) == "Usuário") then 
                            guiSetText(edits[1], "")
                        end
                    end
                end
                if isMouseInPosition(799, 361, 200, 25) then
                    select = false
                    if guiEditSetCaretIndex(edits[2], string.len(guiGetText(edits[2]))) then
                        select = 2
                        guiBringToFront(edits[2])
                        guiSetInputMode("no_binds_when_editing") 
                        if (guiGetText(edits[2]) == "Senha") then 
                            guiSetText(edits[2], "")
                        end
                    end
                end
                if isMouseInPosition(799, 460, 200, 25) then
                    select = false
                    if guiEditSetCaretIndex(edits[3], string.len(guiGetText(edits[3]))) then
                        select = 3
                        guiBringToFront(edits[3])
                        guiSetInputMode("no_binds_when_editing") 
                        if (guiGetText(edits[3]) == "Confirmação de senha") then 
                            guiSetText(edits[3], "")
                        end
                    end
                end
                if isMouseInPosition(783.62, 529, 281.79, 67.79) then
                    if guiGetText(edits[1]) == "" or guiGetText(edits[1]) == "Usuário" then
                        notifyC("Digite o nome de usuário!", "error")
                        return
                    end
                    if guiGetText(edits[2]) == "" or guiGetText(edits[2]) == "Senha" then
                        notifyC("Digite a senha!", "error")
                        return
                    end
                    
                    if guiGetText(edits[3]) == "" or guiGetText(edits[3]) == "Confirmação de senha" then
                        notifyC("Digite a confirmação de senha!", "error")
                        return
                    end
                    if guiGetText(edits[2]) ~= guiGetText(edits[3]) then
                        notifyC("As senhas não são iguais!", "error")
                        return
                    end
                    
                    triggerServerEvent("JOAO.registerAccount", localPlayer, localPlayer, guiGetText(edits[1]), guiGetText(edits[2]), guiGetText(edits[3]))
                end
                
                if isMouseInPosition(1063.36, 514.36, 50.51, 67.79) then
                    window = "login"
                    guiSetText(edits[1], "Usuário")
                    guiSetText(edits[2], "Senha")
                    guiSetText(edits[3], "Confirmação de senha")
                    guiSetText(edits[4], "E-mail")
                    guiSetText(edits[5], "Código")
                end
                
                if isMouseInPosition(1287, 32, 6, 10) then
                    tocarSom()
                end
                
                if isMouseInPosition(19, 51, 45, 45) then
                    setClipboard("discord.gg/ANp9pAnmkh");
                end
                if isMouseInPosition(18, 189, 45, 45) then
                    setClipboard("https://www.tiktok.com/@runygg");
                end
                if isMouseInPosition(19, 120, 45, 45) then
                    setClipboard("N/A");
                end
                
                if isMouseInPosition(1302, 28, 10, 18) then
                    if isElement(sound) then
                        if isSoundPaused(sound) then
                            tickMusicRestart = getTickCount()
                            renderStop = false
                            setSoundPaused(sound, false)
                        else
                            renderStop = true
                            lastMusicCount = math.floor(musicCount)
                            tickMusicRestart = false
                            setSoundPaused(sound, true)
                        end
                    end
                end
                if isMouseInPosition(1321, 32, 6, 10) then
                    tocarSom()
                end
            elseif window == "recover" then
                if isMouseInPosition(86, 365, 260, 60) then
                    select = false
                    if guiEditSetCaretIndex(edits[4], string.len(guiGetText(edits[4]))) then
                        select = 4
                        guiBringToFront(edits[4])
                        guiSetInputMode("no_binds_when_editing") 
                    end
                end
                if isMouseInPosition(83, 435, 276, 15) then
                    window = "login"
                    guiSetText(edits[1], "Usuário")
                    guiSetText(edits[2], "Senha")
                    guiSetText(edits[3], "Confirmação de senha")
                    guiSetText(edits[4], "E-mail")
                    guiSetText(edits[5], "Código")
                end
                if isMouseInPosition(1287, 32, 6, 10) then
                    tocarSom()
                end
                if isMouseInPosition(1302, 28, 10, 18) then
                    if isElement(sound) then
                        if isSoundPaused(sound) then
                            tickMusicRestart = getTickCount()
                            renderStop = false
                            setSoundPaused(sound, false)
                        else
                            renderStop = true
                            lastMusicCount = math.floor(musicCount)
                            tickMusicRestart = false
                            setSoundPaused(sound, true)
                        end
                    end
                end
                if isMouseInPosition(1321, 32, 6, 10) then
                    tocarSom()
                end
            elseif window == "code" then
                if isMouseInPosition(86, 365, 260, 60) then
                    select = false
                    if guiEditSetCaretIndex(edits[4], string.len(guiGetText(edits[5]))) then
                        select = 5
                        guiBringToFront(edits[5])
                        guiSetInputMode("no_binds_when_editing") 
                        if (guiGetText(edits[5]) == "Código") then 
                            guiSetText(edits[5], "")
                        end
                    end
                end
                if isMouseInPosition(83, 435, 276, 15) then
                    window = "login"
                    guiSetText(edits[1], "Usuário")
                    guiSetText(edits[2], "Senha")
                    guiSetText(edits[3], "Confirmação de senha")
                    guiSetText(edits[4], "E-mail")
                    guiSetText(edits[5], "Código")
                end
                if isMouseInPosition(1287, 32, 6, 10) then
                    tocarSom()
                end
                if isMouseInPosition(1302, 28, 10, 18) then
                    if isElement(sound) then
                        if isSoundPaused(sound) then
                            tickMusicRestart = getTickCount()
                            renderStop = false
                            setSoundPaused(sound, false)
                        else
                            renderStop = true
                            lastMusicCount = math.floor(musicCount)
                            tickMusicRestart = false
                            setSoundPaused(sound, true)
                        end
                    end
                end
                if isMouseInPosition(1321, 32, 6, 10) then
                    tocarSom()
                end
            elseif window == "pass" then
                if isMouseInPosition(792, 401, 200, 25) then
                    select = false
                    if guiEditSetCaretIndex(edits[2], string.len(guiGetText(edits[2]))) then
                        select = 2
                        guiBringToFront(edits[2])
                        guiSetInputMode("no_binds_when_editing") 
                        if (guiGetText(edits[2]) == "Senha") then 
                            guiSetText(edits[2], "")
                        end
                    end
                end
                if isMouseInPosition(603, 355, 200, 14) then
                    select = false
                    if guiEditSetCaretIndex(edits[3], string.len(guiGetText(edits[3]))) then
                        select = 3
                        guiBringToFront(edits[3])
                        guiSetInputMode("no_binds_when_editing") 
                        if (guiGetText(edits[3]) == "Confirmação de senha") then 
                            guiSetText(edits[3], "")
                        end
                    end
                end
                if isMouseInPosition(26, 443, 389, 60) then
                    if guiGetText(edits[2]) == "" or guiGetText(edits[2]) == "Senha" then
                        notifyC("Digite a senha!", "error")
                        return
                    end
                    if guiGetText(edits[3]) == "" or guiGetText(edits[3]) == "Confirmação de senha" then
                        notifyC("Digite a confirmação de senha!", "error")
                        return
                    end
                    if guiGetText(edits[2]) ~= guiGetText(edits[3]) then
                        notifyC("As senhas não são iguais!", "error")
                        return
                    end
                    triggerServerEvent("JOAO.recoverAccount", localPlayer, localPlayer, guiGetText(edits[2]), guiGetText(edits[3]), isCode)
                end
                if isMouseInPosition(1287, 32, 6, 10) then
                    tocarSom()
                end
                if isMouseInPosition(1302, 28, 10, 18) then
                    if isElement(sound) then
                        if isSoundPaused(sound) then
                            tickMusicRestart = getTickCount()
                            renderStop = false
                            setSoundPaused(sound, false)
                        else
                            renderStop = true
                            lastMusicCount = math.floor(musicCount)
                            tickMusicRestart = false
                            setSoundPaused(sound, true)
                        end
                    end
                end
                if isMouseInPosition(1321, 32, 6, 10) then
                    tocarSom()
                end
            end
        end
    end
end)

addEvent("JOAO.changeWindowLogin", true)
addEventHandler("JOAO.changeWindowLogin", root,
function(window_, isCode_)
    window = window_
    if window == "pass" then
        isCode = isCode_
    end
end)

function closeMenu()
    if isEventHandlerAdded("onClientRender", root, dx) then
        EditBox("destroy")
        removeEventHandler("onClientRender", root, dx)
        showCursor(false)
        showChat(true)
        if isElement(sound) then
            destroyElement(sound)
        end
    end
    setElementData(localPlayer, 'BloqHud', false)
end
addEvent("JOAO.closeMenuLogin", true)
addEventHandler("JOAO.closeMenuLogin", root, closeMenu)

function tocarSom()
    if isElement(sound) then destroyElement(sound) end
    indexMusicPlay = config["Musics"][math.random(1, #config["Musics"])]
    tickMusicRestart = getTickCount()
    if config["Type download"] == "youtube" then
        sound = playSound("https://server1.mtabrasil.com.br/youtube/play?id="..indexMusicPlay[1], false)
    else
        sound = playSound(indexMusicPlay[1], false)
    end
    setSoundVolume(sound, 0.5)
end

addEventHandler("onClientSoundStopped", root,
function(reason)
    if isElement(sound) then
        if source == sound then
            if isEventHandlerAdded("onClientRender", root, dx) then
                if reason == "finished" then
                    tocarSom()
                end
            end
        end
    end
end)

function EditBox(tipo)
    if tipo == 'destroy' then
        for i=1, #edits do
            if isElement(edits[i]) then 
                destroyElement(edits[i])
            end
        end
    elseif tipo == 'add' then
        edits[1] = guiCreateEdit(-1000, -1000, 325, 50, 'Usuário', false)
        guiEditSetMaxLength(edits[1], 32)
        edits[2] = guiCreateEdit(-1000, -1000, 325, 50, 'Senha', false)
        guiEditSetMaxLength(edits[2], 32) 
        edits[3] = guiCreateEdit(-1000, -1000, 325, 50, 'Confirmação de senha', false)
        guiEditSetMaxLength(edits[3], 32)
        edits[4] = guiCreateEdit(-1000, -1000, 325, 50, 'E-mail', false)
        guiEditSetMaxLength(edits[4], 32)
        edits[5] = guiCreateEdit(-1000, -1000, 325, 50, 'Código', false)
        guiEditSetMaxLength(edits[5], 1000)
    end 
end


function loadLoginFromXML()
    local xml_save_log_File = xmlLoadFile('assets/xml/userdata.xml')
    if not xml_save_log_File then
        xml_save_log_File = xmlCreateFile('assets/xml/userdata.xml', 'Login')
    end
    local usernameNode = xmlFindChild(xml_save_log_File, 'username', 0)
    local passwordNode = xmlFindChild(xml_save_log_File, 'password', 0)
    if usernameNode and passwordNode then
        return xmlNodeGetValue(usernameNode), xmlNodeGetValue(passwordNode)
    end
    xmlUnloadFile(xml_save_log_File)
end

function saveLoginToXML(username, password)
    local xml_save_log_File = xmlLoadFile('assets/xml/userdata.xml')
    if not xml_save_log_File then
        xml_save_log_File = xmlCreateFile('assets/xml/userdata.xml', 'Login')
    end
    if (username ~= '') then
        local usernameNode = xmlFindChild(xml_save_log_File, 'username', 0)
        if not usernameNode then
            usernameNode = xmlCreateChild(xml_save_log_File, 'username')
        end
        xmlNodeSetValue(usernameNode, tostring(username))
    end
    if (password ~= '') then
        local passwordNode = xmlFindChild(xml_save_log_File, 'password', 0)
        if not passwordNode then
            passwordNode = xmlCreateChild(xml_save_log_File, 'password')
        end
        xmlNodeSetValue(passwordNode, tostring(password))
    end
    xmlSaveFile(xml_save_log_File)
    xmlUnloadFile(xml_save_log_File)
end
addEvent('JOAO.saveLoginToXML', true)
addEventHandler('JOAO.saveLoginToXML', getRootElement(), saveLoginToXML)

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
