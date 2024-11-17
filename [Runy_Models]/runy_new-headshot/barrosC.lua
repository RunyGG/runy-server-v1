function sendHeadshot(attacker, weapon, bodypart, loss)
	if getElementData(source, "9:Caido") == true then return cancelEvent() end
	if attacker == getLocalPlayer() then
		if bodypart == 9 then

			if (getElementData(source, 'teleport.pvp') and getElementAlpha(source) ~= 255) then 

				cancelEvent()

			return end
			
			triggerServerEvent("9:CheckDamageSAMU", source, attacker, weapon, bodypart)
		end
		
		if bodypart == 255 then
		
			if (getElementData(source, 'onDriveBy') and getElementAlpha(source) ~= 255) then 
		
				triggerServerEvent("9:CheckDamageSAMU", source, attacker, weapon, bodypart)
		
			end
		end
	end
end
addEventHandler("onClientPedDamage", getRootElement(), sendHeadshot)
addEventHandler("onClientPlayerDamage", getRootElement(), sendHeadshot)
