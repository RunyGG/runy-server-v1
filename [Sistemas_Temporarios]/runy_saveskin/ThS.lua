function savePlayerSkin()
  for _, player in ipairs(getElementsByType("player")) do
      if not (isGuestAccount(getPlayerAccount(player))) then
          local playerSkin = getElementModel(player)
          setAccountData(getPlayerAccount(player), "funmodev2-skin", 1)
      end
  end
end
setTimer(savePlayerSkin, 1000, 0)

function playerLogin(thePreviousAccount, theCurrentAccount, autoLogin)
  if not (isGuestAccount(getPlayerAccount(source))) then
      local playerSkin = getAccountData(theCurrentAccount, "funmodev2-skin")
      if playerSkin then
          setElementModel(source, 1)
      end
  else
      setElementModel(source, 1)
  end
end
addEventHandler("onPlayerLogin", getRootElement(), playerLogin)

function onQuit(quitType, reason, responsibleElement)
  if not (isGuestAccount(getPlayerAccount(source))) then
      local playerSkin = getElementModel(source)
      setAccountData(getPlayerAccount(source), "funmodev2-skin", 1)
  end
end
addEventHandler("onPlayerQuit", getRootElement(), onQuit)