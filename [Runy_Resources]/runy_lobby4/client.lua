local screenW, screenH = guiGetScreenSize()
local x, y = (screenW/1366), (screenH/768)

local drawButtonsFlag = true
local teleportX, teleportY, teleportZ = 2.316, 0.02, 498.414

cameraPosition = {
    {9.024456024169922, -0.227627010345459, 499.33740234375, -0.0, 0.0, -50.49891825112465, -99530.0, 2095, 320, 0, 0, 50, 1000000000000000},
    {2181.6395019531, 385.24499511719, 64.923301696777, 2177.4829101562, 361.60260009766, 64.96, 2204, 240, 60, 0, -760, 50, 2500}
}

activeCamera = 1
cameraTick = 0

modo = 'Solo/Duo'

addEventHandler("onClientResourceStart", resourceRoot, function( )
    shaderHUDMask = dxCreateShader('files/fx/hud_mask.fx');
    setAmbientSoundEnabled( "general", false );
    setAmbientSoundEnabled( "gunfire", false );
end)

PlayerClothes = {}
updated = {}

-- function ClothePlayerLobby(player,clothes)
--     PlayerClothes[player] = clothes
--     updated[player] = true
-- end
-- addEvent("ClothePlayerLobby", true)
-- addEventHandler("ClothePlayerLobby", localPlayer, ClothePlayerLobby)

-- function clothesClient(element)
--     if PlayerClothes[element] then
--         return PlayerClothes[element]
--     end
-- end

local ped = createPed(getElementModel(localPlayer), teleportX, teleportY, teleportZ)
setElementRotation( ped, 0, 0, 270 ) 
setElementFrozen(ped, true)

function addLabelOnClick ( button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedElement )
    if ( clickedElement ) then
        if ( clickedElement == ped ) then
            if button == 'left' then
                if state == 'down' then
                    rotPed = ped
                elseif state == 'up' then
                    rotPed = false
                end
            end
        else
            rotPed = false
        end
    else
        rotPed = false
    end
end
addEventHandler ( "onClientClick", root, addLabelOnClick )

addEventHandler( "onClientCursorMove", getRootElement(), 
function ( cursorX, cursorY, absoluteX, absoluteY, x,y,z)
    if rotPed and rotPed == ped then
        local curX, curY, curZ = getElementRotation(ped) 
        setElementRotation(ped, 0, 0, math.floor(absoluteX/600*100))
    end
end)

setTimer(function()
    if getElementData(localPlayer, 'battleRoyaleRunning') then return end
    setElementModel(ped, getElementModel(localPlayer))
    if not circleMaskTex then
        circleMaskTex = dxCreateTexture('files/cj.png');
    end
    mapPicture = dxCreateTexture(':runy_perfil/assets/images/items/avatar/'..(getElementData(localPlayer, 'avatar') or 0)..'.png');
    dxSetTextureEdge(mapPicture, "border", tocolor(60, 45, 0, 0));
    if PlayerClothes[localPlayer] and updated[localPlayer] then
        --[[ exports["customcharacter"]:setPlayerClothe(ped, getElementModel(localPlayer), PlayerClothes[localPlayer]) ]]
        updated[localPlayer] = false
    end
    local receiver = getElementData(localPlayer, 'myDuo')
    if (isElement(receiver)) then 
        if not circleMaskTexDuo then
            circleMaskTexDuo = dxCreateTexture('files/cj.png');
        end
        mapPictureDuo = dxCreateTexture(':runy_perfil/assets/images/items/avatar/'..(getElementData(receiver, 'avatar') or 0)..'.png');
        dxSetTextureEdge(mapPictureDuo, "border", tocolor(60, 45, 0, 0));
        
        if (isElement(duoPed)) then 
            setElementModel(duoPed, getElementModel(receiver))
            if PlayerClothes[receiver] and updated[receiver] then
                --[[ exports["customcharacter"]:setPlayerClothe(duoPed, getElementModel(receiver), PlayerClothes[receiver]) ]]
                updated[receiver] = false
            end
        else 
            duoPed = createPed(getElementModel(receiver), 1.869, 2.498, 498.414)
            setElementRotation( duoPed, 0, 0, 250 ) 
            setElementFrozen(duoPed, true)
            setPedAnimation(duoPed, "CRACK", "Bbalbat_Idle_02", -1, true, true, false, false)
        end 
    else 
        if (isElement(duoPed)) then 
            destroyElement(duoPed)
        end
    end
end, 5000, 0)

addCommandHandler("lobby", function(cmd, player)
    local comando = string.lower(cmd)
    
    if (comando == "lobby") then
        if (getElementData(localPlayer, 'battleRoyaleRunning')) then
            triggerServerEvent("onPlayerDropDamage", resourceRoot, localPlayer, false, false, false, 9999)
            return
        end
        if not localPlayer:getData('battleRoyaleMatch') then
            returnToLobby(localPlayer)
        end
    end
end)

-- addCommandHandler("lobby", function(cmd, player)

--     if (getElementData(localPlayer, 'battleRoyaleRunning')) then
--         triggerServerEvent("onPlayerDropDamage", resourceRoot, localPlayer, false, false, false, 9999)
--         return
--     end
--     if not localPlayer:getData('battleRoyaleMatch') then
--         returnToLobby(localPlayer)
--     end
-- end)

function returnLobbyFromNpc(player)   

    RenderHUD('hide')

    --if getElementData(player, "createPersonGG") then 
    --    setCameraMatrix(player)
    --    return 
    --end 
    --if getElementData(player, "spectatingPlayer") then
    --    triggerEvent("fn:sairTelagem > lobby", player, player)
    --    setElementData(player, "temporestantegas", nil)
    --    return
    --end
    --if isPedInVehicle(player) then
    --    destroyElement(getPedOccupiedVehicle( player ))
    --end

    unbindKey("tab", "down")
    unbindKey("tab", "up")
    drawButtonsFlag = true
    removeEventHandler("onClientRender", root, drawButtons)
    addEventHandler("onClientRender", root, drawButtons)
    --setElementData(player, "temporestantegas", nil)
    showCursor(true)
    --local playerID = getElementData(player, "ID")
    if playerID and type(playerID) == "number" then
        Lobby = "Aberto"
        aba = "Lobby"
        triggerServerEvent("JOAO.takeItem", player, player, "all", 0)
        triggerEvent("JOAO.attActionBar", player)
        if getElementData(player, "runyInPareamento", true) then
            triggerServerEvent("cancelMatchPlayer", root, player)
            setElementData(player, "temporestantegas", nil)
        end
        if getElementData(player, "teleport.pvp", true) then
            setElementData(player, "teleport.pvp", false)
            setElementData(player, "temporestantegas", nil)
            setElementAlpha(player, 255)
        end
        if getElementData(player, "fn:matamata.runy", true) then
            setElementData(player, "fn:matamata.runy", false)
        end
        triggerServerEvent('onPlayerLobbyDimension', resourceRoot, player)
        setElementPosition(player, -2932.6545, 961.566, 11.4986)
        setElementData(player, 'modo', 'Lobby')
        setElementRotation( player, 0, 0, 180 ) 
        cameraTick = getTickCount( )
        activeCamera = 1
        fadeCamera(true)
        triggerServerEvent("NPCSAIRTREINO", resourceRoot, player)
        exports.runy_treino2:removeTargets() 
        triggerServerEvent("colocarFrozenByFn", resourceRoot, player)
        setElementHealth(player, 100)
        showCursor(true)
        showChat(false)
        setPedAnimation(ped, "CRACK", "Bbalbat_Idle_02", -1, true, true, false, false) 
        setElementData(player, "battleRoyaleRunning", false)
        setElementData(player, "runyInPareamento", false)
        toggleControl('next_weapon', false)
        toggleControl('previous_weapon', false)
        --triggerServerEvent("resetPlayerStats", root, player)
        triggerServerEvent("onPlayerRemoveEffectSamu", resourceRoot, player, player)
        setElementData(player, "JOAO.podeAtirarSem", false)
        triggerServerEvent("removePlayerWeapons", resourceRoot, player)
    else
   --     outputChatBox("Erro: ID de um jogador não está definido ou não é válido.", 255, 0, 0)
    end
end

function returnToLobby(player)
    if getElementData(player, 'autoFormação') then
        if not getElementData(player, 'groupOwner') then
            local receiver = getElementData(player, 'myDuo')
            if (isElement(receiver)) and not getElementData(player, 'groupOwner') then 
                setElementData(receiver, 'myDuo', false)
                setElementData(receiver, 'groupOwner', false)
                setElementData(receiver, 'autoFormação', false)
                setElementData(player, 'myDuo', false)
                setElementData(player, 'groupOwner', false)
                setElementData(player, 'autoFormação', false)
            end
        end
    end
    if getElementData(player, "createPersonGG") then 
        setCameraMatrix(player)
        return 
    end 
    if getElementData(player, "spectatingPlayer") then
        triggerEvent("fn:sairTelagem > lobby", player, player)
        setElementData(player, "temporestantegas", nil)
        return
    end
    if isPedInVehicle(player) then
        destroyElement(getPedOccupiedVehicle( player ))
    end
    if getWeather() ~= 0 then
        setWeather ( 0 )
        setWeatherBlended ( 0 )
    end
    unbindKey("tab", "down")
    drawButtonsFlag = true
    removeEventHandler("onClientRender", root, drawButtons)
    addEventHandler("onClientRender", root, drawButtons)
    setElementData(player, "temporestantegas", nil)
    showCursor(true)
    local playerID = getElementData(player, "ID")
    if playerID and type(playerID) == "number" then
        Lobby = "Aberto"
        aba = "Lobby"
        triggerServerEvent("JOAO.takeItem", player, player, "all", 0)
        triggerEvent("JOAO.attActionBar", player)
        if getElementData(player, "runyInPareamento", true) then
            triggerServerEvent("cancelMatchPlayer", root, player)
            setElementData(player, "temporestantegas", nil)
        end
        if getElementData(player, "teleport.pvp", true) then
            setElementData(player, "teleport.pvp", false)
            setElementData(player, "temporestantegas", nil)
            setElementAlpha(player, 255)
        end
        if getElementData(player, "fn:matamata.runy", true) then
            setElementData(player, "fn:matamata.runy", false)
        end
        triggerServerEvent('onPlayerLobbyDimension', resourceRoot, player)
        setElementPosition(player, -2932.6545, 961.566, 11.4986)
        setElementData(player, 'modo', 'Lobby')
        setElementRotation( player, 0, 0, 180 ) 
        cameraTick = getTickCount( )
        activeCamera = 1
        fadeCamera(true)
        triggerServerEvent("NPCSAIRTREINO", resourceRoot, player)
        exports.runy_treino2:removeTargets() 
        triggerServerEvent("colocarFrozenByFn", resourceRoot, player)
        setElementHealth(player, 100)
        showCursor(true)
        showChat(false)
        setPedAnimation(ped, "CRACK", "Bbalbat_Idle_02", -1, true, true, false, false) 
        setElementData(player, "battleRoyaleRunning", false)
        setElementData(player, "runyInPareamento", false)
        RenderHUD('hide')
        toggleControl('next_weapon', false)
        toggleControl('previous_weapon', false)
        --triggerServerEvent("resetPlayerStats", root, player)
        triggerServerEvent("onPlayerRemoveEffectSamu", resourceRoot, player, player)
        setElementData(player, "JOAO.podeAtirarSem", false)
        triggerServerEvent("removePlayerWeapons", resourceRoot, player)
    else
        outputChatBox("Erro: ID de um jogador não está definido ou não é válido.", 255, 0, 0)
    end
end

addEvent("returnToLobbyClientEvent", true)
addEventHandler("returnToLobbyClientEvent", getRootElement(), returnToLobby)

addEvent("returnToLobbyClientEventNPC", true)
addEventHandler("returnToLobbyClientEventNPC", getRootElement(), returnLobbyFromNpc)

addEvent("returnToLobbyCancelMatch", true)
addEventHandler("returnToLobbyCancelMatch", localPlayer, returnToLobby)

function returnToLobbyLogin(player)
    if getElementData(localPlayer, "spectatingPlayer") then
        triggerEvent("fn:sairTelagem > lobby", localPlayer, localPlayer)
        setElementData(localPlayer, "temporestantegas", nil)
        return
    end
    if getWeather() ~= 0 then
        setWeather ( 0 )
        setWeatherBlended ( 0 )
    end
    if getElementData(localPlayer, "createPersonGG") then 
        local playerID = getElementData(localPlayer, "ID")
        if playerID and type(playerID) == "number" then
            setElementPosition(localPlayer, -2975.706, 469.841, 4.914)
            setElementDimension(localPlayer, playerID)
        end
        return 
    end 
    unbindKey("tab", "down")
    drawButtonsFlag = true
    removeEventHandler("onClientRender", root, drawButtons)
    addEventHandler("onClientRender", root, drawButtons)
    setElementData(localPlayer, "temporestantegas", nil)
    showCursor(true)
    local playerID = getElementData(localPlayer, "ID")
    if playerID and type(playerID) == "number" then
        Lobby = "Aberto"
        aba = "Lobby"
        triggerServerEvent("JOAO.takeItem", localPlayer, localPlayer, "all", 0)
        triggerEvent("JOAO.attActionBar", localPlayer)
        if getElementData(localPlayer, "runyInPareamento", true) then
            triggerServerEvent("cancelMatchPlayer", root, localPlayer)
        end
        if getElementData(localPlayer, "fn:matamata.runy", true) then
            setElementData(localPlayer, "fn:matamata.runy", false)
        end
        triggerServerEvent('onPlayerLobbyDimension', resourceRoot, player)
        setElementPosition(localPlayer, -2932.6545, 961.566, 11.4986)
        setElementRotation( localPlayer, 0, 0, 180 ) 
        cameraTick = getTickCount( )
        activeCamera = 1
        fadeCamera( true )
        setElementData(localPlayer, 'modo', 'Lobby')
        triggerServerEvent("NPCSAIRTREINO", resourceRoot, player)
        exports.runy_treino2:removeTargets() 
        triggerServerEvent("colocarFrozenByFn", resourceRoot, localPlayer)
        setElementHealth(localPlayer, 100)
        showCursor(true)
        showChat(false)
        setPedAnimation(ped, "CRACK", "Bbalbat_Idle_02", -1, true, true, false, false) 
        RenderHUD('hide')
        toggleControl('next_weapon', false)
        toggleControl('previous_weapon', false)
        --triggerServerEvent("resetPlayerStats", root, localPlayer)
        triggerServerEvent("onPlayerRemoveEffectSamu", resourceRoot, localPlayer, localPlayer)
        setElementData(localPlayer, "JOAO.podeAtirarSem", false)
        triggerServerEvent("removePlayerWeapons", resourceRoot, localPlayer)
    else
        outputChatBox("Erro: ID de um jogador não está definido ou não é válido.", 255, 0, 0)
    end
end
addEvent("returnToLobbyLoginEvent", true)
addEventHandler("returnToLobbyLoginEvent", getRootElement(), returnToLobbyLogin)

addEvent('lobby : login', true)
addEventHandler('lobby : login', localPlayer, function()
    Lobby = "Aberto"
    aba = "Lobby"
    setElementData(localPlayer, 'modo', 'Lobby')
    setElementPosition(localPlayer, -2932.6545, 961.566, 11.4986)
    setElementRotation( localPlayer, 0, 0, 180 ) 
    setElementData(localPlayer, "temporestantegas", nil)
    triggerServerEvent('onPlayerLobbyDimension', resourceRoot, localPlayer)
    RenderHUD('hide')
end)

Lobby = "Fechado"
aba = "Lobby"

local enabledHud = {"radar", "radio", "crosshair"}

local inviteEdit = guiCreateEdit(0, 0, 0, 0, 'ID', false)
guiEditSetMaxLength(inviteEdit, 10)
guiSetProperty(inviteEdit, 'ValidationString', '[0-9]*')

fontsPedro = {
    dxCreateFont('files/fonts/inter-regular.ttf', y * (10 / 1.25)),
    dxCreateFont('files/fonts/Outfit-SemiBold.ttf', y * (14 / 1.25)),
    dxCreateFont('files/fonts/Outfit-SemiBold.ttf', y * (12 / 1.25)),
    dxCreateFont('files/fonts/Outfit-SemiBold.ttf', y * (10 / 1.25)),
    dxCreateFont('files/fonts/inter-regular.ttf', y * (15 / 1.25)),
    dxCreateFont('files/fonts/Outfit-SemiBold.ttf', y * (8 / 1.25)),
    dxCreateFont('files/fonts/Outfit-SemiBold.ttf', y * (9 / 1.25)),
}

subaba = false

local alpha = 255
function drawButtons()
    if Lobby == "Aberto" then
        if not (getElementData(localPlayer, 'lobbyLogin')) then return end
        if not drawButtonsFlag then return end    
        local proposalReceiver = getElementData(localPlayer, 'lobbyInvite')
        if (isElement(proposalReceiver)) then 
            dxDrawImage(x * 553, y * 652, x * 261, y * 95, 'files/proposalBg.png', 0, 0, 0, tocolor(255, 255, 255, alpha))
            dxDrawImage(x * 743, y * 664, x * 41.61, y * 32.85, (isMouseInPosition(x * 743, y * 664, x * 41.61, y * 32.85) and 'files/acept.png' or 'files/acept2.png'), 0, 0, 0, tocolor(255, 255, 255, alpha))
            dxDrawImage(x * 743, y * 704, x * 41.61, y * 32.85, (isMouseInPosition(x * 743, y * 704, x * 41.61, y * 32.85) and 'files/decline.png' or 'files/decline2.png'), 0, 0, 0, tocolor(255, 255, 255, alpha))
            dxDrawText('Você deseja se agrupar à\n#C4C4C4'..getPlayerName(proposalReceiver)..' #6D28D9#'..(getElementData(proposalReceiver, 'ID') or '???'), x * 584, y * 704.45, x * 713, y * 724, tocolor(255, 255, 255, 255), 0.75, fontsPedro[2], "left", "top", false, false, false, true, false)
        end
        dxDrawImage(x*0, y*0, x*1366, y*81, "files/cage_lobby.png", 0, 0, 0, tocolor(255, 255, 255, 255))

        -- --// Premium Cima
         if getElementData(localPlayer, 'runy:premium') then
             dxDrawImage(x*1225, y*46, x*90, y*15, "files/nomePremium.png", 0, 0, 0, tocolor(255, 255, 255, 255))
             dxDrawImage(x*1245, y*35.5, x*54, y*11.5, "files/bgPremium.png", 0, 0, 0, tocolor(255, 255, 255, 255))
             dxDrawImage(x*1248, y*37, x*9, y*9, "files/logoPremium.png", 0, 0, 0, tocolor(255, 255, 255, 255))
             dxDrawText('PREMIUM', x * 1259, y * 36, x * 38, y * 10, tocolor(255, 255, 255, 255), 1.00, fontsPedro[6], "left", "top", false, false, false, true, false)
         else
             dxDrawImage(x*1225, y*46, x*90, y*15, "files/nomeSemPremium.png", 0, 0, 0, tocolor(255, 255, 255, 255))
         end
        dxDrawImage(x*1308, y*29, x*38, y*38, "files/logoRuny.png", 0, 0, 0, tocolor(255, 255, 255, 255))
        dxDrawImage(x*1317, y*59, x*20, y*10, "files/bgCima.png", 0, 0, 0, tocolor(255, 255, 255, 255))
        dxDrawText(getPlayerName(localPlayer).. ' #6D28D9#'.. getElementData(localPlayer, 'ID'), x * 1231, y * 47, x * 75, y * 13, tocolor(255, 255, 255, 255), 1.00, fontsPedro[7], "left", "top", false, false, false, true, false)
        dxDrawText('RNY', x * 1319, y * 59, x * 16, y * 10, tocolor(255, 255, 255, 255), 1.00, fontsPedro[6], "left", "top", false, false, false, true, false)
        -- --// Fim Premium Cima

        --  if isMouseInPosition(x*1215, y*546, x*110, y*18) or aba == "Lobby" then
        --      dxDrawImage(x*777, y*36, x*121.04, y*29.5, "files/base_inicio-select.png", 0, 0, 0, tocolor(255,255,255,255))
        --  else
        --      dxDrawImage(x*777, y*36, x*121.04, y*29.5, "files/base_inicio.png", 0, 0, 0, tocolor(255,255,255,255))
        --  end
        --  if isMouseInPosition(x*347, y*36, x*120.6, y*29.5) or aba == "Custom" then
        --      dxDrawImage(x*347, y*36, x*120.6, y*29.5, "files/base_custom-select.png", 0, 0, 0, tocolor(255,255,255,255))
        --  else
        --      dxDrawImage(x*347, y*36, x*120.6, y*29.5, "files/base_custom.png", 0, 0, 0, tocolor(255,255,255,255))
        --  end
        --  if isMouseInPosition(x*467, y*36, x*121.6, y*29.5) or aba == "Custom" then
        --      dxDrawImage(x*467, y*36, x*121.6, y*29.5, "files/base_ranking-select.png", 0, 0, 0, tocolor(255,255,255,255))
        --  else
        --      dxDrawImage(x*467, y*36, x*121.6, y*29.5, "files/base_ranking.png", 0, 0, 0, tocolor(255,255,255,255))
        --  end
        --  if isMouseInPosition(x*1023, y*36, x*120.04, y*30.5) or aba == "Equipamentos" then
        --      dxDrawImage(x*1023, y*36, x*120.04, y*30.5, "files/base_settings-select.png", 0, 0, 0, tocolor(255,255,255,255))
        --  else
        --     dxDrawImage(x*1023, y*36, x*120.04, y*30.5, "files/base_settings.png", 0, 0, 0, tocolor(255,255,255,255))
        --  end
        --  if isMouseInPosition(x*224, y*36, x*120.6, y*29.5) or aba == "Ranked" then
        --      dxDrawImage(x*224, y*36, x*120.6, y*29.5, "files/base_ranked-select.png", 0, 0, 0, tocolor(255,255,255,255))
        --  else
        --      dxDrawImage(x*224, y*36, x*120.6, y*29.5, "files/base_ranked.png", 0, 0, 0, tocolor(255,255,255,255))
        --  end
        --  if isMouseInPosition(x*900, y*35, x*120.04, y*30.5) or aba == "Groups" then
        --      dxDrawImage(x*900, y*35, x*120.04, y*30.5, "files/base_groups-select.png", 0, 0, 0, tocolor(255,255,255,255))
        --  else
        --      dxDrawImage(x*900, y*35, x*120.04, y*30.5, "files/base_groups.png", 0, 0, 0, tocolor(255,255,255,255))
        --  end
        
        --if subaba == "SelectModes" then
           dxDrawImage(x*1202.5, y*536, x*109.5, y*151.5, "files/select_mode.png")
            if isMouseInPosition(x*1228, y*600, x*110, y*18) or modo == "Solo/Duo" then
                dxDrawText("Solo/duo", x*1228, y*600, x*110, y*18, tocolor(109, 40, 217, 255), 1.00, fontsPedro[2], "left", "top")
                dxDrawImage(x*1228, y*618, x*63, y*2, "files/modo_selecionado.png", 0, 0, 0,  tocolor(255, 255, 255, 255))
          else
               dxDrawText("Solo/duo", x*1228, y*600, x*110, y*18, tocolor(255, 255, 255, 255), 1.00, fontsPedro[2], "left", "top")
           end
           if isMouseInPosition(x*1237, y*629, x*110, y*18) or modo == "Squad" then
               dxDrawText("Squad", x*1237, y*629, x*110, y*18, tocolor(109, 40, 217, 255), 1.00, fontsPedro[2], "left", "top")
               dxDrawImage(x*1237, y*647, x*44, y*2, "files/modo_selecionado.png", 0, 0, 0,  tocolor(255, 255, 255, 255))
           else
               dxDrawText("Squad", x*1237, y*629, x*110, y*18, tocolor(255, 255, 255, 255), 1.00, fontsPedro[2], "left", "top")
           end
           if isMouseInPosition(x*1215, y*546, x*110, y*18) or modo == "ARace" then
               dxDrawText("Armed-race", x*1215, y*546, x*110, y*18, tocolor(109, 40, 217, 255), 1.00, fontsPedro[2], "left", "top")
               dxDrawImage(x*1215, y*564, x*86, y*2, "files/modo_selecionado.png", 0, 0, 0,  tocolor(255, 255, 255, 255))
           else
               dxDrawText("Armed-race", x*1215, y*546, x*110, y*18, tocolor(255, 255, 255, 255), 1.00, fontsPedro[2], "left", "top")
           end
           if isMouseInPosition(x*1227, y*573, x*110, y*18) or modo == "Aimlab" then
               dxDrawText("Aim-Lab", x*1227, y*573, x*110, y*18, tocolor(109, 40, 217, 255), 1.00, fontsPedro[2], "left", "top")
               dxDrawImage(x*1227, y*591, x*61, y*2, "files/modo_selecionado.png", 0, 0, 0,  tocolor(255, 255, 255, 255))
           else
               dxDrawText("Aim-Lab", x*1227, y*573, x*110, y*18, tocolor(255, 255, 255, 255), 1.00, fontsPedro[2], "left", "top")
           end
           if isMouseInPosition(x*1243, y*658, x*110, y*18) or modo == "Npc" then
               dxDrawText("NPC", x*1243, y*658, x*110, y*18, tocolor(109, 40, 217, 255), 1.00, fontsPedro[2], "left", "top")
               dxDrawImage(x*1243, y*676, x*31, y*2, "files/modo_selecionado.png", 0, 0, 0,  tocolor(255, 255, 255, 255))
           else
               dxDrawText("NPC", x*1243, y*658, x*110, y*18, tocolor(255, 255, 255, 255), 1.00, fontsPedro[2], "left", "top")
           end
        --end
        if aba == "Lobby" then
            activeCamera = 1
            if getElementData(localPlayer, 'myDuo') then
                if getElementData(localPlayer, 'groupOwner') then
                    dxDrawImage(x*1115, y*680, x*213, y*66, "files/bg.png")
                else
                    dxDrawImage(x*1115, y*680, x*213, y*66, (getElementData(localPlayer, 'alreadyState') and "files/bgNo.png" or "files/bgYes.png"))
                end
            else
                dxDrawImage(x*1115, y*680, x*213, y*66, "files/bg.png")
            end
            if not getElementData(localPlayer, 'myDuo') then
                dxDrawImage(x*964, y*691, x*145, y*55, (getElementData(localPlayer, 'autoFormação') and "files/AFon.png" or "files/AFoff.png"), 0, 0, 0, (isMouseInPosition(x*964, y*691, x*145, y*55) and tocolor(180, 180, 180, 255) or tocolor(255, 255, 255, 255)))
            end
            dxDrawImage(x * 38, y * 577, x * 250, y * 79, 'files/invite.png', 0, 0, 0, tocolor(255, 255, 255, 255))
            dxDrawText('Convide um usuário', x * 51, y * 587, x * 94, y * 12, tocolor(255, 255, 255, 255), 1.00, fontsPedro[1], 'left', 'top', false, false, false, true, false)
            dxDrawImage(x*231, y*608, x*44, y*38, 'files/inviteButton.png', 0, 0, 0, (isMouseInPosition(x*231, y*608, x*44, y*38) and tocolor(255, 255, 255, 255) or tocolor(255, 255, 255, 200)))
            dxDrawText(selectEdit == 1 and guiGetText(inviteEdit)..'|' or guiGetText(inviteEdit), x*64, y*614, x*74, y*18, tocolor(55, 55, 55, 255), 1.00, fontsPedro[5], "left", "top", false, false, false, false, false)
            dxDrawText(getPlayerName(localPlayer).." #6D28D9#"..getElementData(localPlayer, "ID"), x * 189, y * 587, x * 93, y * 12, tocolor(255, 255, 255, 255), 1.00, fontsPedro[4], "left", "top", false, false, false, true, false)
            dxDrawImage(x * 38, y * 668, x * 321, y * 79, 'files/groupState.png', 0, 0, 0, tocolor(255, 255, 255, alpha))
             if (shaderHUDMask) and (mapPicture) and (circleMaskTex) then
                 dxSetShaderValue(shaderHUDMask, 'sMaskTexture', circleMaskTex);
                 dxSetShaderValue(shaderHUDMask, 'sPicTexture', mapPicture);
             end
            dxDrawImage(x * 45, y * 681, x * 55.5, y * 55, shaderHUDMask, 0, 0, 0, tocolor(255, 255, 255, alpha))
            local receiver = getElementData(localPlayer, 'myDuo')
            if (isElement(receiver)) then 
                if (shaderHUDMask) and (mapPictureDuo) and (circleMaskTexDuo) then
                    dxSetShaderValue(shaderHUDMask, 'sMaskTexture', circleMaskTexDuo);
                    dxSetShaderValue(shaderHUDMask, 'sPicTexture', mapPictureDuo);
                end
                if (getElementData(localPlayer, 'groupOwner')) then
                    dxDrawImage(x * 52, y * 670, x * 12, y * 10.67, 'files/crown.png', 0, 0, 0, tocolor(255, 255, 255, alpha))
                    dxDrawImage(x * 107, y * 681, x * 55.5, y * 55, shaderHUDMask, 0, 0, 0, tocolor(255, 255, 255, alpha))
                    dxDrawImage(x * 45, y * 681, x * 55.5, y * 55, 'files/cjStroke.png', 0, 0, 0, tocolor(255, 242, 104, alpha))
                    dxDrawImage(x * 121, y * 695, x * 28, y * 28, 'files/kick.png', 0, 0, 0, (isMouseInPosition(x * 107, y * 681, x * 55.5, y * 55) and tocolor(255, 255, 255, 200) or tocolor(255, 255, 255, 70)))
                    if getElementData(receiver, 'alreadyState') == true then
                        dxDrawImage(x * 115, y * 674, x * 8, y * 8, 'files/stateAlready-True.png', 0, 0, 0, tocolor(255, 255, 255, alpha))
                        dxDrawImage(x * 107, y * 681, x * 55.5, y * 55, 'files/cjStroke.png', 0, 0, 0, tocolor(112, 255, 138, alpha))
                    else
                        dxDrawImage(x * 115, y * 674, x * 8, y * 8, 'files/stateAlready-False.png', 0, 0, 0, tocolor(255, 255, 255, alpha))
                        dxDrawImage(x * 107, y * 681, x * 55.5, y * 55, 'files/cjStroke.png', 0, 0, 0, tocolor(255, 34, 34, alpha))
                    end
                    --dxDrawText(getPlayerName(receiver), x * 107, y * 737, x * 40, y * 8, tocolor(255, 255, 255, 255), 0.75, fontsPedro[2], "left", "top", false, false, false, true, false)
                else 
                    dxDrawImage(x * 107, y * 681, x * 55.5, y * 55, shaderHUDMask, 0, 0, 0, tocolor(255, 255, 255, alpha))
                    dxDrawImage(x * 114, y * 670, x * 12, y * 10.67, 'files/crown.png', 0, 0, 0, tocolor(255, 255, 255, alpha))
                    dxDrawImage(x * 107, y * 681, x * 55.5, y * 55, 'files/cjStroke.png', 0, 0, 0, tocolor(255, 242, 104, alpha))
                    if getElementData(localPlayer, 'alreadyState') == true then
                        dxDrawImage(x * 53, y * 674, x * 8, y * 8, 'files/stateAlready-True.png', 0, 0, 0, tocolor(255, 255, 255, alpha))
                        dxDrawImage(x * 45, y * 681, x * 55.5, y * 55, 'files/cjStroke.png', 0, 0, 0, tocolor(112, 255, 138, alpha))
                    else
                        dxDrawImage(x * 53, y * 674, x * 8, y * 8, 'files/stateAlready-False.png', 0, 0, 0, tocolor(255, 255, 255, alpha))
                        dxDrawImage(x * 45, y * 681, x * 55.5, y * 55, 'files/cjStroke.png', 0, 0, 0, tocolor(255, 34, 34, alpha))
                    end
                    --dxDrawText(getPlayerName(receiver), x * 107, y * 737, x * 40, y * 8, tocolor(255, 255, 255, 255), 0.75, fontsPedro[2], "left", "top", false, false, false, true, false)
                end
            else
                dxDrawImage(x * 52, y * 670, x * 12, y * 10.67, 'files/crown.png', 0, 0, 0, tocolor(255, 255, 255, alpha))
                dxDrawImage(x * 45, y * 681, x * 55.5, y * 55, 'files/cjStroke.png', 0, 0, 0, tocolor(255, 242, 104, alpha))
            end
            dxDrawText("Modo: ".. modo, x*1122, y*696, x*126, y*17, tocolor(255, 255, 255, 255), 1.00, fontsPedro[2], "left", "top")
            dxDrawText("Runy GG", x*1122, y*714, x*54, y*15, tocolor(95, 95, 95, 255), 1.00, fontsPedro[3], "left", "top")
        elseif aba == 'Ranked' then
            activeCamera = 2
        end 
        local renderCameraTick = getTickCount()
        local cameraProgress = renderCameraTick - cameraTick
        local cX, cY, cZ = interpolateBetween ( cameraPosition[activeCamera][1], cameraPosition[activeCamera][2], cameraPosition[activeCamera][3], cameraPosition[activeCamera][4], cameraPosition[activeCamera][5], cameraPosition[activeCamera][6], cameraProgress/cameraPosition[activeCamera][13], "Linear")
        local rX, rY, rZ = interpolateBetween ( cameraPosition[activeCamera][7], cameraPosition[activeCamera][8], cameraPosition[activeCamera][9],cameraPosition[activeCamera][10], cameraPosition[activeCamera][11], cameraPosition[activeCamera][12],cameraProgress/cameraPosition[activeCamera][13], "Linear")
        setCameraMatrix(cX, cY, cZ, rX, rY, rZ)
    end
end
addEvent("drawButtonsClientEvent", true)
addEventHandler("drawButtonsClientEvent", getRootElement(), drawButtons)

function Clicar(_, state)
    if (isEventHandlerAdded('onClientRender', root, drawButtons)) then
        if Lobby == "Aberto" then
            if state == "down" then
                if isMouseInPosition(x*1023, y*36, x*120.04, y*30.5) then
                    -- removeLobbyRoupasCustom()
                    -- setElementData(localPlayer, 'alreadyState', false)
                    -- triggerEvent("closeTopPlayers", resourceRoot)
                    -- triggerEvent("closeRankPanel", resourceRoot)
                    -- triggerEvent('onPlayerRemoveClothesInventory', localPlayer, localPlayer)
                    -- aba = 'Equipamentos'
                    -- triggerServerEvent('NZ > RunyEquipamentos', localPlayer, localPlayer)

                    triggerServerEvent( "NotifyServerForClient", resourceRoot, localPlayer, "Settings em desenvolvimento." )
                elseif isMouseInPosition(x*224, y*36, x*120.6, y*29.5) then
                    -- setElementData(localPlayer, 'alreadyState', false)
                    -- triggerEvent('NZ > closeEquipaments', localPlayer, localPlayer)
                    -- triggerEvent('onPlayerRemoveClothesInventory', localPlayer, localPlayer)
                    -- aba = 'Ranked'

                    triggerServerEvent( "NotifyServerForClient", resourceRoot, localPlayer, "Ranked em desenvolvimento." )
                end
                
                --if subaba == "SelectModes" then
                    if isMouseInPosition(x*1228, y*600, x*110, y*18) then
                        modo = "Solo/Duo"
                    elseif isMouseInPosition(x*1243, y*658, x*110, y*18) then
                        modo = "Npc"
                    elseif isMouseInPosition(x*1227, y*573, x*110, y*18) then
                        modo = "Aimlab"
                    elseif isMouseInPosition(x*1215, y*546, x*110, y*18) then
                        -- modo = 'ARace'
                        modo = 'Solo/Duo'
                    triggerServerEvent( "NotifyServerForClient", resourceRoot, localPlayer, "Armed Race desativado temporariamente." )
                    elseif isMouseInPosition(x*1237, y*629, x*110, y*18) then
                        aba = "Lobby"
                        triggerServerEvent( "NotifyServerForClient", resourceRoot, localPlayer, "Squad em desenvolvimento." )
                    end
                    --subaba = false
                --end
                selectEdit = 0 
                if (guiGetText(inviteEdit) == '') then 
                    guiSetText(inviteEdit, 'ID')
                end 
                triggerEvent("closeRankPanel", resourceRoot)
                triggerEvent("closeTopPlayers", resourceRoot)
                if isMouseInPosition(x*467, y*36, x*121.6, y*29.5) then
                    triggerEvent("closeRankPanel", resourceRoot)
                    triggerEvent("closeTopPlayers", resourceRoot)
                    triggerEvent('onPlayerRemoveClothesInventory', localPlayer, localPlayer)
                    
                    aba = "RanksTop"
                    triggerEvent("rankRunyGGTop10", resourceRoot)
                elseif isMouseInPosition(x*347, y*36, x*120.6, y*29.5) then
                    -- setElementData(localPlayer, 'alreadyState', false)
                    -- removeLobbyRoupasCustom()
                    -- triggerEvent("closeTopPlayers", resourceRoot)
                    -- triggerEvent("closeRankPanel", resourceRoot)
                    -- triggerEvent('NZ > closeEquipaments', localPlayer, localPlayer)
                    -- aba = "Custom"
                    -- triggerServerEvent('onPlayerOpenClothesInventory', localPlayer, localPlayer)

                    triggerServerEvent( "NotifyServerForClient", resourceRoot, localPlayer, "Sistema de Custom em desenvolvimento." )
                -- elseif isMouseInPosition(x*1300.65, y*662.38, x*11.18, y*5.59) then
                --     subaba = "SelectModes"
                --     triggerEvent("closeRankPanel", resourceRoot)
                --     triggerEvent("closeTopPlayers", resourceRoot)
                elseif (isMouseInPosition(x*64, y*614, x*74, y*18)) then
                    if (guiEditSetCaretIndex(inviteEdit, #guiGetText(inviteEdit))) then 
                        guiBringToFront(inviteEdit)
                        guiSetInputMode('no_binds_when_editing')
                        selectEdit = 1 
                        if (guiGetText(inviteEdit) == 'ID') then 
                            guiSetText(inviteEdit, '')
                        end
                    end
                elseif (isMouseInPosition(x*777, y*36, x*121.04, y*29.5)) then
                    triggerEvent('onPlayerRemoveClothesInventory', localPlayer, localPlayer)
                    aba = "Lobby"
                end
                if aba ~= "Ranked" and aba ~= "Custom" and aba ~= "Equipamentos" then
                    --[[ if isMouseInPosition(x*7, y*480, x*160, y*106) then
                        triggerServerEvent('OpenPass', localPlayer, localPlayer) ]]
                    if isMouseInPosition(x*964, y*691, x*145, y*55) then
                        setElementData(localPlayer, 'autoFormação', not getElementData(localPlayer, 'autoFormação') )
                    elseif (isMouseInPosition(x*231, y*608, x*44, y*38)) then 
                        if getElementData(localPlayer, "ID") == tonumber(guiGetText(inviteEdit)) then return triggerEvent('Notify', localPlayer, 'Você não pode se auto convidar. ', 'error') end
                        triggerServerEvent('onPlayerInviteReceiverToLobby', resourceRoot, localPlayer, guiGetText(inviteEdit))
                    elseif (isMouseInPosition(x * 299, y * 681, x * 54, y * 54)) then 
                        local receiver = getElementData(localPlayer, 'myDuo')
                        if (isElement(receiver)) then 
                            setElementData(receiver, 'myDuo', false)
                            setElementData(receiver, 'groupOwner', false)
                            setElementData(localPlayer, 'autoFormação', false)
                            setElementData(receiver, 'autoFormação', false)
                        end
                        setElementData(localPlayer, 'myDuo', false)
                        setElementData(localPlayer, 'groupOwner', false)
                    elseif (isMouseInPosition(x * 107, y * 681, x * 55.5, y * 55)) then 
                        local receiver = getElementData(localPlayer, 'myDuo')
                        if (isElement(receiver)) then 
                            if (getElementData(localPlayer, 'groupOwner')) then
                                setElementData(receiver, 'myDuo', false)
                                setElementData(receiver, 'groupOwner', false)
                                setElementData(localPlayer, 'autoFormação', false)
                                setElementData(receiver, 'autoFormação', false)
                                setElementData(localPlayer, 'myDuo', false)
                                setElementData(localPlayer, 'groupOwner', false)
                            end
                        end
                    end
                end
                local proposalReceiver = getElementData(localPlayer, 'lobbyInvite')
                if (isElement(proposalReceiver)) then
                    if (isMouseInPosition(x * 743, y * 664, x * 41.61, y * 32.85)) then
                        setElementData(localPlayer, 'lobbyInvite', false)
                        if (getElementData(localPlayer, 'myDuo')) then 
                            return
                        end
                        if (getElementData(proposalReceiver, 'myDuo')) then 
                            return
                        end
                        setElementData(proposalReceiver, 'myDuo', localPlayer)
                        setElementData(proposalReceiver, 'groupOwner', true)
                        setElementData(localPlayer, 'autoFormação', false)
                        setElementData(proposalReceiver, 'autoFormação', false)
                        setElementData(localPlayer, 'myDuo', proposalReceiver)
                        setElementData(localPlayer, 'groupOwner', false)
                    elseif (isMouseInPosition(x * 743, y * 704, x * 41.61, y * 32.85)) then 
                        setElementData(localPlayer, 'lobbyInvite', false)
                    end
                end
            end
        end
    end
end
addEventHandler("onClientClick", getRootElement(), Clicar)

addEventHandler("onClientClick", getRootElement(), function(button, state, clickX, clickY)
    if (isEventHandlerAdded('onClientRender', root, drawButtons)) then
        if button == "left" and state == "down" then
            if aba ~= "Lobby" then return end
            if isMouseInButton(clickX, clickY, x*1259, y*695, x*47, y*47) then
                if modo == "Npc" then
                    setElementData(localPlayer, 'modo', 'Treinando no: NPC')
                    triggerServerEvent("NPCTREINO", resourceRoot, localPlayer)
                    triggerEvent("SHOWHUD", resourceRoot, localPlayer)  
                    setCameraTarget(localPlayer)
                    triggerServerEvent("removeAnimation", resourceRoot, localPlayer)
                    drawButtonsFlag = false
                    triggerServerEvent("tirarFrozenByFn", resourceRoot, localPlayer)
                    triggerEvent("closeRankPanel", resourceRoot)
                    triggerEvent("closeTopPlayers", resourceRoot)
                    showCursor(false)
                    showChat(false)
                    setElementData(localPlayer, "JOAO.podeAtirarSem", true)
                    removeLobby()
                    setElementData(localPlayer, "temporestantegas", nil)
                elseif modo == "Aimlab" then
                    setElementData(localPlayer, 'modo', 'Treinando no: Aimlab')
                    setCameraTarget(localPlayer)
                    triggerServerEvent("removeAnimation", resourceRoot, localPlayer)
                    exports.runy_treino2:toggleTraining()
                    drawButtonsFlag = false
                    triggerServerEvent("tirarFrozenByFn", resourceRoot, localPlayer)
                    showCursor(false)
                    showChat(false)
                    triggerEvent("Mostrarkill", resourceRoot, player)
                    triggerEvent("closeRankPanel", resourceRoot)
                    triggerEvent("closeTopPlayers", resourceRoot)
                    setElementData(localPlayer, "JOAO.podeAtirarSem", true)
                    setElementData(localPlayer, "temporestantegas", nil)
                    removeLobby()
                elseif modo == 'ARace' then
                    local receiver = getElementData(localPlayer, 'myDuo')
                    if (isElement(receiver)) and not getElementData(localPlayer, 'groupOwner') then 
                        setElementData(receiver, 'myDuo', false)
                        setElementData(receiver, 'groupOwner', false)
                        setElementData(receiver, 'autoFormação', false)
                        setElementData(localPlayer, 'myDuo', false)
                        setElementData(localPlayer, 'groupOwner', false)
                        setElementData(localPlayer, 'autoFormação', false)
                    end
                    setElementData(localPlayer, 'modo', 'Jogando: Armed-race')
                    triggerServerEvent('onPlayerEnterInMataMata', localPlayer, localPlayer)
                    setCameraTarget(localPlayer)
                    triggerServerEvent("removeAnimation", resourceRoot, localPlayer)
                    triggerServerEvent("tirarFrozenByFn", resourceRoot, localPlayer)
                    triggerEvent("closeRankPanel", resourceRoot)
                    triggerEvent("closeTopPlayers", resourceRoot)
                    showChat(false)
                    setElementData(localPlayer, "JOAO.podeAtirarSem", false)
                    toggleControl('next_weapon', false)
                    toggleControl('previous_weapon', false)
                    setElementData(localPlayer, "temporestantegas", nil)
                    removeLobbyMataMata()
                elseif modo == "Solo/Duo" then
                    local duoPlayer = getElementData(localPlayer, 'myDuo')
                    if (isElement(duoPlayer)) then 
                        if (getElementData(localPlayer, 'groupOwner')) then 
                            if getElementDimension(duoPlayer) ~= 0 then return triggerEvent('Notify', localPlayer, 'O jogador não está na tela de lobby', 'error') end
                            if not (getElementData(duoPlayer, 'alreadyState')) then
                                return triggerEvent('Notify', localPlayer, 'O jogador não está pronto para iniciar a partida.', 'error')
                            end
                        else 
                            setElementData(localPlayer, 'alreadyState', (not getElementData(localPlayer, 'alreadyState')))
                            return
                        end
                    end
                    setElementData(localPlayer, 'modo', 'Em Solo/Duo')
                    triggerServerEvent('onPlayerStartJoinBattleRoyale', localPlayer, localPlayer)
                    triggerServerEvent('AutoFormar', localPlayer, localPlayer)
                    setCameraTarget(localPlayer)
                    triggerServerEvent("removeAnimation", resourceRoot, localPlayer)
                    triggerServerEvent("tirarFrozenByFn", resourceRoot, localPlayer)
                    triggerEvent("closeRankPanel", resourceRoot)
                    triggerEvent("closeTopPlayers", resourceRoot)
                    showChat(false)
                    setElementData(localPlayer, "JOAO.podeAtirarSem", false)
                    toggleControl('next_weapon', false)
                    toggleControl('previous_weapon', false)
                    setElementData(localPlayer, "temporestantegas", nil)
                    removeLobby()
                end
            end
        end
    end
end)

addEvent('removeLobbyOnEnterMatch', true)
addEventHandler('removeLobbyOnEnterMatch', root, function()
    setElementData(localPlayer, 'modo', 'Jogando: Battle Royale')
    setCameraTarget(localPlayer)
    triggerServerEvent("removeAnimation", resourceRoot, localPlayer)
    triggerServerEvent("tirarFrozenByFn", resourceRoot, localPlayer)
    triggerEvent("closeRankPanel", resourceRoot)
    triggerEvent("closeTopPlayers", resourceRoot)
    showChat(false)
    setElementData(localPlayer, "JOAO.podeAtirarSem", false)
    toggleControl('next_weapon', false)
    toggleControl('previous_weapon', false)
    setElementData(localPlayer, "temporestantegas", nil)
    removeLobby()
end)

function HideButtons()
    drawButtonsFlag = false
end
addEvent("HideButtonss", true)
addEventHandler("HideButtonss", getRootElement(), HideButtons)

function showButtons()
    drawButtonsFlag = true
end
addEvent("showButtons", true)
addEventHandler("showButtons", getRootElement(), showButtons)

function removeLobbySala()
    RenderHUD('show')
    setElementData(localPlayer, "temporestantegas", nil)
    setElementData(localPlayer, 'modo', 'Jogando: Battle Royale')
    setCameraTarget(localPlayer)
    triggerServerEvent("removeAnimation", resourceRoot, localPlayer)
    triggerEvent("closeRankPanel",  resourceRoot)
    triggerEvent("closeTopPlayers", resourceRoot)
    showChat(false)
    setElementData(localPlayer, "JOAO.podeAtirarSem", false)
    toggleControl('next_weapon', false)
    toggleControl('previous_weapon', false)
    drawButtonsFlag = false
    removeEventHandler("onClientRender", root, drawButtons)
    triggerServerEvent("tirarFrozenByFn", resourceRoot, localPlayer)
    showCursor(false)
    showChat(false)
end
addEvent("removeLobbySala", true)
addEventHandler("removeLobbySala", getRootElement(), removeLobbySala)

function removeLobby()
    showCursor(false)
    showChat(false)
    setElementData(localPlayer, "temporestantegas", nil)
    RenderHUD('show')
    drawButtonsFlag = false
    removeEventHandler("onClientRender", root, drawButtons)
    triggerServerEvent("tirarFrozenByFn", resourceRoot, localPlayer)
end
addEvent("removeLobby", true)
addEventHandler("removeLobby", getRootElement(), removeLobby)

function removeLobbyRoupasCustom()
    Lobby = "Fechado"
end
addEvent("removeLobbyRoupasCustom", true)
addEventHandler("removeLobbyRoupasCustom", getRootElement(), removeLobbyRoupasCustom)

function removeLobbyMataMata()
    showCursor(false)
    triggerEvent("showActionBar", resourceRoot)
    setElementData(localPlayer, "temporestantegas", nil)
    triggerEvent("showHudArma", resourceRoot)
    triggerEvent("showHud", resourceRoot)
    --[[ triggerEvent("showShowRadar", resourceRoot) ]]
    triggerEvent("showBussola", resourceRoot, localPlayer)  
    drawButtonsFlag = false
    removeEventHandler("onClientRender", root, drawButtons)
    triggerServerEvent("tirarFrozenByFn", resourceRoot, localPlayer)
    showChat(false)
end

function cameraTargetPlayer()
    setCameraTarget(localPlayer)
    triggerServerEvent("removeAnimation", resourceRoot, localPlayer)
end
addEvent("cameraTargetPlayer", true)
addEventHandler("cameraTargetPlayer", getRootElement(), cameraTargetPlayer)

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

function exportPicture(player)
    if shaderHUDMask then
        return shaderHUDMask
    end
end

function isMouseInPosition(x,y,w,h)
    if isCursorShowing() then
        local sx,sy = guiGetScreenSize()
        local cx,cy = getCursorPosition()
        local cx,cy = (cx*sx),(cy*sy)
        if (cx >= x and cx <= x+w) and (cy >= y and cy <= y+h) then
            return true
        end
    end
end

function isMouseInButton(mx, my, bx, by, bWidth, bHeight)
    return mx > bx and mx < bx + bWidth and my > by and my < by + bHeight
end

function RenderHUD(type)
    if type == 'show' then
        triggerEvent("showActionBar", resourceRoot)
        triggerEvent("showGroupDesign", resourceRoot)
        triggerEvent("showFundos", resourceRoot)
        triggerEvent("showHud", resourceRoot)
        triggerEvent("showHudArma", resourceRoot)
        triggerEvent("showKillsMostrar", resourceRoot)
        triggerEvent("showVivos", resourceRoot)
        --[[ triggerEvent("showShowRadar", resourceRoot) ]]
        triggerEvent("showBussola", resourceRoot, localPlayer)  
    elseif type == 'hide' then
        triggerEvent("hideActionBar", resourceRoot)
        triggerEvent("hideGroupDesign", resourceRoot)
        triggerEvent("hideFundos", resourceRoot)
        triggerEvent("hideHud", resourceRoot)
        triggerEvent("hideHudArma", resourceRoot)
        triggerEvent("hideKillsMostrar", resourceRoot)
        triggerEvent("hideVivos", resourceRoot)
        triggerEvent("hideShowRadar", resourceRoot)
        triggerEvent("hideShowBussola", resourceRoot)
    end
end