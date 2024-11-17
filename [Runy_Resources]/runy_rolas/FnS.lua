addEvent('fn > playAnim',true)
addEventHandler('fn > playAnim',root,function(player,anim)
    if anim then 
        triggerClientEvent(root,'startAnim',root,player,anim)
    end
end)