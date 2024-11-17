addEventHandler( 'onPlayerVoiceStart', root,function()
    if not getElementData(source, 'myDuo') or not getElementData(source, 'mic') then 
        cancelEvent() 
    end
end)

addEvent('mic', true)
addEventHandler('mic', root, function(player, type)
    setElementData(player, 'mic', (not type))
end)

addEvent('sound', true)
addEventHandler('sound', root, function(player, type)
    setElementData(player, 'sound', (not type))
end)

addEventHandler("onPlayerLogin", root,function()
    source:setData('sound', true)
end)