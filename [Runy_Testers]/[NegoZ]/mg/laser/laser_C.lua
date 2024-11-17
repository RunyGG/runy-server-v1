--[[Player Element Data	-- changing these to an invalid value can break this script
"laser.on"	-- tells you player has turned laser on
"laser.aim"  -- tells you player is aiming and laser is drawn
"laser.red", "laser.green", "laser.blue", "laser.alpha"

Exported Functions:
SetLaserEnabled(player, state)    -- (element:player, bool:state)    -- returns false if invalid params, true otherwise
IsLaserEnabled(player)    -- (element:player)    -- returns true or false
SetLaserColor(player, r,g,b,a)    -- (element:player, int:r, int:g, int:b, int:a)   -- returns true
GetLaserColor(player)    -- (element:player)   -- returns r,g,b,a (int:) or false but shouldnt happen.
IsPlayerWeaponValidForLaser(player)    -- (element:player)    -- returns true or false
]]

local img = dxCreateTexture('laser/laser.png')
local img2 = dxCreateTexture('laser/smoke.png')
local dots = {}
local smoked = {}
local startTick = {}
local both = {}
laserWidth = 1
localPlayer = getLocalPlayer()

addEventHandler( "onClientRender", root,
function()
	for k,players in ipairs(getElementsByType("player")) do
		if getElementData(players, "laser") then
			DrawLaser(players)
		end
		if smoked[players] then
			for i,v in ipairs(smoked[players]) do
				both[i] = interpolateBetween (0, 0, 0, 110, 0, 0, (getTickCount()-startTick[i]-100)/1000, "SineCurve")
				dxDrawMaterialLine3D(v[1], v[2], v[3], v[4], v[5], v[6], true, img2, 0.04, tocolor(255, 255, 255, both[i]), false)
			end
		end
	end
end
)


function smokeFire(ID, ammo, ammoInClip, hitX, hitY, hitZ, hitElement, startX, startY, startZ)
	if not smoked[localPlayer] then
		smoked[localPlayer] = {}
	end
	wpn1 = getElementData(source, "cweapon")
	x,y,z = getPedWeaponMuzzlePosition(source)
	if math.random(1, 30) > 26 then
	table.insert(smoked[localPlayer], {x, y, z, hitX, hitY, hitZ})
	startTick[#smoked[localPlayer]] = getTickCount()
		setTimer(function()
			if smoked[localPlayer] then
				table.remove(smoked[localPlayer], 1)
			end
		end, 1000, 1)
		
	end
end
addEventHandler("onClientPlayerWeaponFire",root, smokeFire)
addEventHandler("onClientPedWeaponFire", root, smokeFire)





function DrawLaser(player)
	if getElementData(player, "laser") then
		local targetself = getPedTarget(player)
		if targetself and targetself == player then
			targetself = true
		else
			targetself = false
		end		
		
		if isPedAiming(player) and IsPlayerWeaponValidForLaser(player) == true and targetself == false then
			local x,y,z = getPedWeaponMuzzlePosition(player)
			if not x then
				x,y,z = getPedTargetStart(player)
			end
			local x2,y2,z2 = getPedTargetEnd(player)
			if not x2 then
				return
			end			
			local x3,y3,z3 = getPedTargetCollision(player)
			if x3 then
				dxDrawMaterialLine3D(x, y, z, x3, y3, z3, true, img, 0.01, tocolor(255, 255, 255, 180), false)
				--dxDrawLine3D(x,y,z-0.01,x3,y3,z3, tocolor(r,g,b,a), laserWidth)
				DrawLaserDot(player, x3,y3,z3)
			else
				dxDrawMaterialLine3D(x, y, z, x3, y3, z3, true, img, 0.01, tocolor(255, 255, 255, 180), false)
				--dxDrawLine3D(x,y,z-0.01,x2,y2,z2, tocolor(r,g,b,a), laserWidth)
				DestroyLaserDot(player)
			end
		else
			DestroyLaserDot(player)
		end
	else
		DestroyLaserDot(player)
	end
end

function DrawLaserDot (player, x,y,z)
	if not dots[player] then
		dots[player] = createMarker(x,y,z, "corona", .05, 200, 0, 0, 200)
	else
		setElementPosition(dots[player], x,y,z)
	end
end
function DestroyLaserDot(player)
	if dots[player] and isElement(dots[player]) then
		destroyElement(dots[player])
		dots[player] = nil
	end
end

function IsPlayerWeaponValidForLaser(player)
	if getElementData(player, 'cweapon') then
		return true
	end
	return false
end

function isPedAiming (thePedToCheck)
    if isElement(thePedToCheck) then
        if getElementType(thePedToCheck) == "player" or getElementType(thePedToCheck) == "ped" then
            if getPedTask(thePedToCheck, "secondary", 0) == "TASK_SIMPLE_USE_GUN" or isPedDoingGangDriveby(thePedToCheck) then
                return true
            end
        end
    end
    return false
end