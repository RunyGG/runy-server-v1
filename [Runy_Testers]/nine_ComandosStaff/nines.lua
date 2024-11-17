function getPlayerID(id)
	v = false
	for i, player in ipairs (getElementsByType("player")) do
		if getElementData(player, "ID") == id then
			v = player
			break
		end
	end
	return v
end

function getNearestVehicle(player,distance)
    local lastMinDis = distance-0.0001
    local nearestVeh = false
    local px,py,pz = getElementPosition(player)
    local pint = getElementInterior(player)
    local pdim = getElementDimension(player)

    for _,v in pairs(getElementsByType("vehicle")) do
        local vint,vdim = getElementInterior(v),getElementDimension(v)
        if vint == pint and vdim == pdim then
            local vx,vy,vz = getElementPosition(v)
            local dis = getDistanceBetweenPoints3D(px,py,pz,vx,vy,vz)
            if dis < distance then
                if dis < lastMinDis then 
                    lastMinDis = dis
                    nearestVeh = v
                end
            end
        end
    end
    return nearestVeh
end

function sendMessage(thePlayer, type, msg)
    triggerClientEvent(thePlayer, "9:Notify", thePlayer, type, msg, 5)
end

addCommandHandler("car", function(playerSource, commandName, id, quant)
    if getElementData(playerSource, "9.admin") == true then
        if (id) and (quant) then
            local playerID = tonumber(id)
            local vahicle = tonumber(quant)
		    if (playerID) then
				local targetPlayer, targetPlayerName = getPlayerID(playerID)
				if targetPlayer then
					local vehicle = getPedOccupiedVehicle(targetPlayer)
					if (vehicle) then
						setElementModel(vehicle, vahicle)
						fixVehicle(vehicle)
					else
						local x, y, z = getElementPosition(targetPlayer)
						local r = getPedRotation(targetPlayer)
						local vx, vy, vz = getElementVelocity(targetPlayer)
						vehicle = createVehicle(vahicle, x, y, z, 0, 0, r)
						setElementDimension(vehicle, getElementDimension(targetPlayer))
						setElementInterior(vehicle, getElementInterior(targetPlayer))
						warpPedIntoVehicle(targetPlayer, vehicle)
						setElementVelocity(vehicle, vx, vy, vz)
					end
				end
			end
		end
    end
end)

-----------------------------------------------------------------------------------------------------------------------
-- VIDA/COLETE --------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------

addCommandHandler("vida", function(playerSource, commandName, id, quant)
    if getElementData(playerSource, "9.admin") == true then
        if (id) and (quant) then
            local playerID = tonumber(id)
            local valor = tonumber(quant)
		    if (playerID) then
				local targetPlayer, targetPlayerName = getPlayerID(playerID)
				if targetPlayer then
					if valor < 0 then
						sendMessage(playerSource, "info", "O valor minimo é 0")
					elseif valor > 100 then
						sendMessage(playerSource, "info", "O valor maximo é 100")
					else
					    setElementHealth(targetPlayer, valor)
						sendMessage(playerSource, "success", "Vida do "..getPlayerName(targetPlayer).." alterada para "..valor.."")
				    end
				end
			end
		end
    end
end)

-----------------------------------------------------------------------------------------------------------------------
-- TELEPORTE ----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------

addCommandHandler("tp", function(playerSource, commandName, id)
	if getElementData(playerSource, "9.admin") == true then
        if (id) then
            local playerID = tonumber(id)
		    if (playerID) then
				local targetPlayer, targetPlayerName = getPlayerID(playerID)
				if targetPlayer then
					local x, y, z = getElementPosition(targetPlayer)
					local interior = getElementInterior(targetPlayer)
					local dimension = getElementDimension(targetPlayer)
					local r = getPedRotation(targetPlayer)
					setCameraInterior(playerSource, interior)

					if (isPedInVehicle(playerSource)) then
						local veh = getPedOccupiedVehicle(playerSource)
						setVehicleTurnVelocity(veh, 0, 0, 0)
						setElementInterior(playerSource, interior)
						setElementDimension(playerSource, dimension)
						setElementInterior(veh, interior)
						setElementDimension(veh, dimension)
						setElementPosition(veh, x, y+2, z+2)
						warpPedIntoVehicle ( playerSource, veh ) 
						setTimer(setVehicleTurnVelocity, 50, 20, veh, 0, 0, 0)
					else
						setElementPosition(playerSource, x, y+2, z+2)
						setElementInterior(playerSource, interior)
						setElementDimension(playerSource, dimension)
					end
				end
			end
	    end
	end
end)

-----------------------------------------------------------------------------------------------------------------------

addCommandHandler("puxar", function(playerSource, commandName, id)
	if getElementData(playerSource, "9.admin") == true then
        if (id) then
            local playerID = tonumber(id)
		    if(playerID) then
				local targetPlayer = getPlayerID(playerID)
				if targetPlayer then
				    local x, y, z = getElementPosition(playerSource)
				    local interior = getElementInterior(playerSource)
				    local dimension = getElementDimension(playerSource)
				    local r = getPedRotation(playerSource)

				    setCameraInterior(targetPlayer, interior)

				    if (isPedInVehicle(targetPlayer)) then
					    local veh = getPedOccupiedVehicle(targetPlayer)
					    setVehicleTurnVelocity(veh, 0, 0, 0)
					    setElementPosition(veh, x, y+2, z+2)
					    setTimer(setVehicleTurnVelocity, 50, 10, veh, 0, 0, 0)
					    setElementInterior(veh, interior)
					    setElementDimension(veh, dimension)	
				    else
					    setElementPosition(targetPlayer, x, y+2, z+2)
					    setElementInterior(targetPlayer, interior)
					    setElementDimension(targetPlayer, dimension)
				    end
				end
			end
	    end
	end
end)

-----------------------------------------------------------------------------------------------------------------------
-- VOAR/FLY -----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------

function toggleInvisibility(playerSource)
	local arena = getElementData(playerSource, "9:Arena") or "lobby"

	if getElementData(playerSource, "9.admin") == true then
		local enabled = getElementData(playerSource, "invisible")
		if (enabled == true) then
			setElementAlpha(playerSource, 255)
			setElementData(playerSource, "reconx", false)
			setElementData(playerSource, "invisible", false)
		elseif (enabled == false or enabled == nil) then
			setElementAlpha(playerSource, 0)
			setElementData(playerSource, "reconx", true)
			setElementData(playerSource, "invisible", true)
		end
	end
end
addCommandHandler("v", toggleInvisibility)

function fly(playerSource, commandName)
	local arena = getElementData(playerSource, "9:Arena") or "lobby"

	if getElementData(playerSource, "9.admin") == true then
		triggerClientEvent(playerSource, "onClientFlyToggle", playerSource)
	end
end
addCommandHandler("fly", fly, false, false)

function onNc(playerSource)
	local arena = getElementData(playerSource, "9:Arena") or "lobby"

	if getElementData(playerSource, "9.admin") == true then
		local enabled = getElementData(playerSource, "invisible")
		if (enabled == true) then
			setElementAlpha(playerSource, 255)
			setElementData(playerSource, "reconx", false)
			setElementData(playerSource, "invisible", false)
			triggerClientEvent(playerSource, "onClientFlyToggle", playerSource)
		elseif (enabled == false or enabled == nil) then
			removePedFromVehicle(playerSource)
			setElementAlpha(playerSource, 0)
			setElementData(playerSource, "reconx", true)
			setElementData(playerSource, "invisible", true)
			triggerClientEvent(playerSource, "onClientFlyToggle", playerSource)	
		end
	elseif getElementData(playerSource, "9:PREMIUM") or getElementData(playerSource, "9:VIPFREE") == true then
		if arena == "fuzil" or arena == "pistola" or arena == "ffa" then return end
		if getElementData(playerSource, "9:Corridas") == true then return end
		
		local enabled = getElementData(playerSource, "invisible")
		if (enabled == true) then
			setElementAlpha(playerSource, 255)
			setElementData(playerSource, "reconx", false)
			setElementData(playerSource, "invisible", false)
			triggerClientEvent(playerSource, "onClientFlyToggle", playerSource)
		elseif (enabled == false or enabled == nil) then
			removePedFromVehicle(playerSource)
			setElementAlpha(playerSource, 0)
			setElementData(playerSource, "reconx", true)
			setElementData(playerSource, "invisible", true)
			triggerClientEvent(playerSource, "onClientFlyToggle", playerSource)	
		end
	end
end
addCommandHandler("nc", onNc)

function tpway(playerSource)
	local arena = getElementData(playerSource, "9:Arena") or "lobby"

    if getElementData(playerSource, "9.admin") == true then
        local posx = getElementData(playerSource, "9:Marcação1") or 0
        local posy = getElementData(playerSource, "9:Marcação2") or 0
        if posx ~= 0 and posy ~= 0 then
            setElementPosition(playerSource, tonumber(posx), tonumber(posy), 13)
            triggerClientEvent(playerSource, "9:TPway", playerSource, tonumber(posx), tonumber(posy)) 
            if isPedInVehicle(playerSource) then
                local theVehicle = getPedOccupiedVehicle(playerSource)
                setElementPosition(theVehicle, tonumber(posx), tonumber(posy), 13)
            end   
        end 
	elseif getElementData(playerSource, "9:PREMIUM") == true or getElementData(playerSource, "9:VIPFREE") == true then
		if arena == "fuzil" or arena == "pistola" or arena == "ffa" then return end
		if getElementData(playerSource, "9:Corridas") == true then return end

		local posx = getElementData(playerSource, "9:Marcação1") or 0
        local posy = getElementData(playerSource, "9:Marcação2") or 0
        if posx ~= 0 and posy ~= 0 then
            setElementPosition(playerSource, tonumber(posx), tonumber(posy), 13)
            triggerClientEvent(playerSource, "9:TPway", playerSource, tonumber(posx), tonumber(posy)) 
            if isPedInVehicle(playerSource) then
                local theVehicle = getPedOccupiedVehicle(playerSource)
                setElementPosition(theVehicle, tonumber(posx), tonumber(posy), 13)
            end   
        end 
    end
end
addCommandHandler("tpway", tpway)

-----------------------------------------------------------------------------------------------------------------------
-- POSIÇÃO ------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------

function Pos(playerSource)
	if getElementData(playerSource, "9.admin") == true then
    	local x,y,z = getElementPosition(playerSource)
    	outputChatBox("\{"..x..", "..y..", "..z.."\},", playerSource, 255, 255, 255, true )
    end
end
addCommandHandler("pos", Pos)

function Pos2(playerSource)
	if getElementData(playerSource, "9.admin") == true then
    	local x,y,z = getElementPosition(playerSource)
    	outputChatBox("x = "..x..", y = "..y..", z = "..z, playerSource, 255, 255, 255, true )
    end
end
addCommandHandler("pos2", Pos2)

function Rot(playerSource)
	if getElementData(playerSource, "9.admin") == true then
    	local x,y,z = getElementRotation(playerSource)
    	outputChatBox("x = "..x..", y = "..y..", z = "..z, playerSource, 255, 255, 255, true )
    end
end
addCommandHandler("rot", Rot)

function ad(playerSource, commandName)
	if isObjectInACLGroup("user." ..getAccountName(getPlayerAccount(playerSource)), aclGetGroup("Squad")) then
		if getElementData(playerSource, "9.admin") == true then
			setElementData(playerSource, "9.Squad", nil)
			setElementData(playerSource, "9.admin", nil)
			sendMessage(playerSource, "error", "Você saiu do modo administrador")
		else
			setElementData(playerSource, "9.Squad", true)
			setElementData(playerSource, "9.admin", true)
			sendMessage(playerSource, "success", "Você entrou do modo administrador")
		end
	else
		if getPlayerACLGroupFromTable(playerSource, config["Acls"]) then
			if getElementData(playerSource, "9.admin") == true then
				setElementData(playerSource, "9.admin", nil)
				sendMessage(playerSource, "error", "Você saiu do modo administrador")
			else
				setElementData(playerSource, "9.admin", true)
				sendMessage(playerSource, "success", "Você entrou do modo administrador")
			end
		end
	end
end
addCommandHandler("ad", ad, false, false)

function gravar(playerSource, commandName)
	local insignia = getElementData(playerSource, "9:Insignia") or {}
	for i2 = 1, #insignia do
		local ival = insignia[i2]
		if ival["insignia"] == "youtuber" then
			if getElementData(playerSource, "9:Gravando") == true then
				setElementData(playerSource, "9:Gravando", nil)
				sendMessage(playerSource, "error", "Você saiu do modo gravando")
			else
				setElementData(playerSource, "9:Gravando", true)
				sendMessage(playerSource, "success", "Você entrou no modo gravando")
			end
		end
	end
end
addCommandHandler("gravar", gravar, false, false)

function transmitir(playerSource, commandName)
	local insignia = getElementData(playerSource, "9:Insignia") or {}
	for i2 = 1, #insignia do
		local ival = insignia[i2]
		if ival["insignia"] == "streamer" then
			if getElementData(playerSource, "9:Transmitindo") == true then
				setElementData(playerSource, "9:Transmitindo", nil)
				sendMessage(playerSource, "error", "Você saiu do modo gravando")
			else
				setElementData(playerSource, "9:Transmitindo", true)
				sendMessage(playerSource, "success", "Você entrou no modo gravando")
			end
		end
	end
end
addCommandHandler("transmitir", transmitir, false, false)

addCommandHandler("tpcds", function(playerSource, commandName, x,y,z)
    if getElementData(playerSource, "9.admin") == true then
        local x, y, z = string.gsub(x or "", ",", " "), string.gsub(y or "", ",", " "), string.gsub(z or "", ",", " ")
        if tonumber(x) and tonumber(y) and tonumber(z) then 
            setElementPosition(playerSource, tonumber(x),tonumber(y),tonumber(z))
        else 
			sendMessage(playerSource, "error", "Você não colocou a posição")
        end
    end
end)

-------------------------------------------------------------------------------------------------------------------

function getPlayerACLGroupFromTable(player, table)
    for i, v in ipairs(table) do
        if aclGetGroup(v) then
            local accName = getAccountName(getPlayerAccount(player))
            return isObjectInACLGroup("user." ..accName, aclGetGroup(v))
        else
            outputDebugString("Crie a ACL "..v.." no seu Painel P.", 4, 255, 0, 0)
            return false
        end
    end
end

addCommandHandler("anunciar", function(playerSource, cmd, ...)
    if getElementData(playerSource, "9.admin") == true then
		local msg = table.concat({...}, " ")
		if msg:gsub(" ", "") ~= "" then
			sendMessage(root, "info", msg)
		end
	end
end)
	
addCommandHandler("anunciar2", function(playerSource, cmd, ...)
    if getElementData(playerSource, "9.admin") == true then
		local msg = table.concat({...}, " ")
		if msg:gsub(" ", "") ~= "" then
			sendMessage(root, "success", msg)
		end
	end
end)


addCommandHandler("ts", function(playerSource, commandName, x,y,z)
    if getElementData(playerSource, "9.admin") == true then
		for i = 50001, 50027 do
			outputChatBox("<map src=\"nine_aimnpcMap.map\" dimension=\""..tostring(i).."\"></map>", playerSource, 255, 255, 255, true )
		end
    end
end)