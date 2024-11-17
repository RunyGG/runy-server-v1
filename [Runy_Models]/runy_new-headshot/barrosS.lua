
local timer = {}
local headshots = {}
function CheckDamage(atacker, causing, body)
   -- if isPedInVehicle(source) then return end
--[[     if getElementData(source, "9:Caido") == true then return cancelEvent() end ]]
	
    if body == 9 then

        if not (headshots[source]) then 

            headshots[source] = 0

        end 

        headshots[source] = headshots[source] + 1
        
        if not (isTimer(timer[source])) then 

            timer[source] = setTimer(function(player)
                
                if (isElement(player)) then 
                    
                    headshots[player] = 0

                end
            
            end, 45 * 1000, 1, source)

        end

        if (headshots[source] >= 2) then 

            if atacker then
                --[[ triggerClientEvent(atacker, '9.SoundHS', atacker) ]]
                killPed(source, atacker, causing, body)
            else
                killPed(source)
            end

            headshots[source] = 0 

            if (isTimer(timer[source])) then 

                killTimer(timer[source])

            end

        end
    end
	
	if body == 255 then
	if getElementData(source, "onDriveBy") == true then
	    if not (headshots[source]) then 
            headshots[source] = 0
        end 
        headshots[source] = headshots[source] + 1
        if not (isTimer(timer[source])) then 
            timer[source] = setTimer(function(player)
                if (isElement(player)) then 
                    headshots[player] = 0
					end
           end, 45 * 1000, 1, source)
       end
       if (headshots[source] >= 2) then 
	   if atacker then
        killPed(source, atacker, causing, body)
		else
        killPed(source)
        end
        headshots[source] = 0 
        if (isTimer(timer[source])) then 
        killTimer(timer[source])
				end
           end
        end
    end
end 
addEvent("9:CheckDamageSAMU", true)
addEventHandler("9:CheckDamageSAMU", root, CheckDamage)
addEventHandler('onPlayerDamage', root, CheckDamage)