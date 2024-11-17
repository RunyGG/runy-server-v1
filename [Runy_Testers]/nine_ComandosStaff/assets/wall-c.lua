

---------------/CONFIG UTTL\---------------
function convertNumber ( number )   
    local formatted = number   
    while true do       
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1.%2')     
        if ( k==0 ) then       
            break   
        end   
    end   
    return formatted 
end

function dxDrawTextOnElement(TheElement, text, height, distance, R, G, B, alpha, size, font, ...)
	local x, y, z = getElementPosition (TheElement)
	local x2, y2, z2 = getCameraMatrix()
	local distance = distance or 20
	local height = height or 1

	if (isLineOfSightClear(x, y, z+2, x2, y2, z2, ...)) then
		local sx, sy = getScreenFromWorldPosition(x, y, z+height)
        local xx = dxGetTextWidth(text, 1.00, font, true)
		if(sx) and (sy) then
			local distanceBetweenPoints = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
			if(distanceBetweenPoints < distance) then
                dxDrawRectangle(xx + rx[1] - 210, rx[2]-12, xx + 30, 20, tocolor(0, 0, 0, 100))
                dxDrawText(text, rx[1], rx[2]-1, rx[1], rx[2], color, scale, font, "center", "center", false, false, false, true, false)
            end
		end
    end
end

function dxDrawColorText(TheElement, text, height, distance, color, scale, font, life)
    local x, y, z = getElementPosition (TheElement)
	local x2, y2, z2 = getCameraMatrix()
	local distance = distance or 20
	local height = height or 1

    if (getDistanceBetweenPoints3D(x, y, z, getElementPosition(getLocalPlayer()))) < distance then
    local rx = {getScreenFromWorldPosition(x, y, z+height)}
    local xx = dxGetTextWidth(text, 1.00, font, true)
    if rx[1] and rx[2] and rx[3] then
        if life <= 1 then
            dxDrawRectangle(rx[1]-15, rx[2]+12, (xx + 30), 5, tocolor(255, 0, 0))
        else
            dxDrawRectangle(rx[1]-15, rx[2]+12, (xx + 30)/100*life, 5, tocolor(88, 101, 242))
        end
        dxDrawText(text, rx[1], rx[2]-1, rx[1], rx[2], tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, true, false)
        end    
    end
end

---------------/CONFIG UTTL\---------------

---------------/CONFIG RENDER\---------------

addEventHandler ("onClientRender", getRootElement (), function ()
    if getElementData(localPlayer, "onPlayerStaff") ~= true then return end
    local result = getElementsByType (config["ElementType"])
    if result and #result ~= 0 then
        for i = 1, #result do
            local other = result[i]
            if isElement (other) then
                if other ~= localPlayer then
                    local x, y, z = getElementPosition (localPlayer)
                    local ax, ay, az = getElementPosition (other)
                    if getDistanceBetweenPoints3D (x, y, z, ax, ay, az) <= config["Distance"] and getElementHealth (other) > 0 then
                        local vida = math.floor(getElementHealth(other))
                        local colete = math.floor(getPedArmor(other))
                        local name = "#ffffff"..getPlayerName(other).." #5865F2["..(getElementData(other, "ID") or "N/A").."]"

                        if config["ElementType"] ~= "player" then
                            dxDrawColorText(other, name, 1, config["Distance"], tocolor(10, 10, 10, 90), 1, "arial", vida)
                        else
                            dxDrawColorText(other, name, 1, config["Distance"], tocolor(10, 10, 10, 90), 1, "arial", vida)
                        end
                    end
                end
            else
                table.remove (result, i)
            end
        end
    end
end)