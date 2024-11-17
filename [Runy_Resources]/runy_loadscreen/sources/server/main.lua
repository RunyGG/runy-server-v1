addEventHandler("onResourceStart", resourceRoot,
function()
    if config["Mensagem Start"] then
        outputDebugString("["..getResourceName(getThisResource()).."] Startado com sucesso, qualquer bug contacte zJoaoFtw_#5562!")
    end
end)

addEvent('JOAO.offVoice', true)
addEventHandler('JOAO.offVoice', root,
function(player, state)
    if (state == true) then
        setPlayerVoiceIgnoreFrom(player, root)
    else
        setPlayerVoiceIgnoreFrom(player, nil)
    end
end)