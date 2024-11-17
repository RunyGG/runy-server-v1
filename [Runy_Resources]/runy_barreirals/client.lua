-- Notifica o jogador quando ele atinge a barreira
function notifyPlayerOfBarrier()
    --[[ outputChatBox("#FF0000[AVISO]#FFFFFF Você atingiu os limites de Los Santos!", 255, 255, 255, true) ]]
end

addEvent("onPlayerHitLSBarrier", true)
addEventHandler("onPlayerHitLSBarrier", resourceRoot, notifyPlayerOfBarrier)