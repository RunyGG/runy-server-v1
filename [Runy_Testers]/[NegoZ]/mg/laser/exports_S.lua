--[[Exported Functions:
	SetLaserEnabled(player, state)    -- (element:player, bool:state)    -- returns false if invalid params, true otherwise
	IsLaserEnabled(player)    -- (element:player)    -- returns true or false
	IsPlayerWeaponValidForLaser(player)    -- (element:player)    -- returns true or false
]]


function SetLaserEnabled(player, state)
	if not player or not isElement(player) or getElementType(player) ~= "player" then return false end
	if not state then return false end
	
	if state == true then
		setElementData(player, "laser.on", true, true)
		setElementData(player, "laser.aim", false, true)
		return true
	elseif state == false then
		setElementData(player, "laser.on", false, true)
		setElementData(player, "laser.aim", false, true)
		return true
	end
	return false
end

function IsLaserEnabled(player)
	if getElementData(player, "laser.on") == true then
		return true
	else
		return false
	end
end

function IsPlayerWeaponValidForLaser(player)
	local weapon = getPedWeapon(player)
	if weapon and weapon > 21 and weapon < 39 and weapon ~= 35 and weapon ~= 36 then
		return true
	end
	return false
end

