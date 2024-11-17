Tempo = {}

-- {Arma, idObjeto, posX, posY, posZ, rotX, rotY, rotZ, Size},
armas = {
	{"m4", 50000, 0.04,0,0,0,0,0},
	{"imbel", 50001, 0.04,0,0,0,0,0},
	{"g36c", 50002, 0.04,0,0,0,0,0},
	{"ak", 50003, 0.04,0,0,0,0,0},
	{"m240", 50004, 0.04,0,0,0,0,0},
	{"five", 50005, 0.04,0,0,0,0,0},
	{"glock", 50006, 0.04,0,0,0,0,0, 1.01},
	{"magnum", 50007, 0.04,0,0,0,0,0},
	{"thompson", 50008, 0.04,0,0,0,0,0},
	{"mp5", 50009, 0.04,0,0,0,0,0},
	{"skorpion", 50010, 0.04,0,0,0,0,0},
	{"vector", 50011, 0.04,0,0,0,0,0},
	{"bazooka", 50012, 0.04,0,0,0,0,0},
	{"escopeta", 50013, 0.04,0,0,0,0,0},
	{"revolver", 50014, 0.04,0,0,0,0,0},
	{"p90", 50015, 0.04,0,0,0,0,0},
	{"tec9", 50016, 0.04,0,0,0,0,0},
	{"uzi", 50017, 0.04,0,0,0,0,0},
	{"kar98", 50025, 0.04,0,0,0,0,0},
	{"faca", 50021, 0.04,0,0,0,0,0},
}

elementWeaponRaplace = {}
function weaponReplace(previousWeaponID, currentWeaponID)
	for _, glitch in ipairs({'quickreload', 'fastmove', 'fastfire', 'crouchbug', 'highcloserangedamage', 'hitanim', 'fastsprint', 'baddrivebyhitbox', 'quickstand'}) do
		setGlitchEnabled(glitch, false)
	end
	local weapon = getElementData(source, "cweapon")
	if not weapon then return end
	local x,y,z = getElementPosition(source)
	local rx,ry,rz = getElementRotation(source)
	--if previousWeaponID and getPedWeaponSlot(source) == 0 then
	if isElement(elementWeaponRaplace[source]) then
		destroyElement(elementWeaponRaplace[source])
		elementWeaponRaplace[source] = false
	end
	for id,item in ipairs(armas)do
		if weapon == item[1] then
			elementWeaponRaplace[source] = createObject(921, x,y,z)
			ELEMENTOOBJ = elementWeaponRaplace[source]
			local newWeapon = getElementData(source, 'newModelWeapon_'..weapon)
			local skinWeapon = getElementData(source, 'AdesiveWeapon_'..weapon)
			local bocaWeapon = getElementData(source, 'attached_'..weapon)
			local penteWeapon = getElementData(source, 'clip_'..weapon)
			local coronhaWeapon = getElementData(source, 'butt_'..weapon)
			if skinWeapon then
				--triggerClientEvent(root, 'setArmaStickerC', resourceRoot, source, 'arma', 'files/weapons/skins/'..skinWeapon..".png", elementWeaponRaplace[source])
			end
			if bocaWeapon then
				loadWeaponAttach(source, _, removeHex(bocaWeapon), 'BOCA')
			end
			if penteWeapon then
				loadWeaponAttach(source, _, removeHex(penteWeapon), 'PENTE')
			end
			if coronhaWeapon then
				loadWeaponAttach(source, _, removeHex(coronhaWeapon), 'CORONHA')
			end
			setElementData(elementWeaponRaplace[source], 'objectID', (newWeapon and newWeapon or item[2]))
			setElementDimension(elementWeaponRaplace[source], getElementDimension(source))
			setElementCollisionsEnabled(elementWeaponRaplace[source], false )
			exports.pAttach:attach(elementWeaponRaplace[source], source, 24, 0, 0, 0, 0, 0, 0)
			if item[9] then
				setObjectScale(ELEMENTOOBJ, item[9])
			end
		end
	end
end
addEventHandler("onPlayerWeaponSwitch", getRootElement(), weaponReplace)
addEventHandler("onPedWeaponSwitch", getRootElement(), weaponReplace)

function removeHex (s)
	local g, c = string.gsub, 0
	repeat
		s, c = g(s, '1', '')
	until c == 0
	return s
end

function takewep()
	if isElement(elementWeaponRaplace[source]) then
		local account = getAccountName(getPlayerAccount(source))
		setElementData(source, 'cweapon', false)
		destroyElement(elementWeaponRaplace[source])
		elementWeaponRaplace[source] = false
	end
end

function removeQuit11(quitType)
	if quitType then
		if source then
			if isElement(elementWeaponRaplace[source]) then
				local account = getAccountName(getPlayerAccount(source))
				setElementData(source, 'cweapon', false)
				destroyElement(elementWeaponRaplace[source])
				elementWeaponRaplace[source] = false
			end
		end
	end
end
addEventHandler("onPlayerQuit",getRootElement(),removeQuit11)

function deathplayer()
	if isElement(elementWeaponRaplace[source]) then
		local account = getAccountName(getPlayerAccount(source))
		setElementData(source, 'cweapon', false)
		destroyElement(elementWeaponRaplace[source])
		elementWeaponRaplace[source] = false
	end
end
addEventHandler("onPlayerWasted",getRootElement(),deathplayer)

function removeQuit(source)
	if source then
		if isElement(elementWeaponRaplace[source]) then
			local account = getAccountName(getPlayerAccount(source))
			
			setElementData(source, 'cweapon', false)
			destroyElement(elementWeaponRaplace[source])
			elementWeaponRaplace[source] = false
		end
	end
end

function giveNewWeapon(playerSource, wep, muni)
	if not playerSource then return end
	setElementData(playerSource,"cweapon", wep)
	local weapon = wep
	if mainweap[weapon] then
		--triggerClientEvent(playerSource, 'setArmaStickerC', playerSource, mainweap[weapon], weapon)
		local bocaWeapon = getElementData(playerSource, 'attached_'..weapon)
		local penteWeapon = getElementData(playerSource, 'clip_'..weapon)
		local coronhaWeapon = getElementData(playerSource, 'butt_'..weapon)
		for _,skill in pairs({ "poor", "std", "pro" }) do
			setWeaponProperty(mainweap[weapon][1], skill, 'flag_move_and_shoot', mainweap[weapon][4])
			setWeaponProperty(mainweap[weapon][1], skill, 'maximum_clip_ammo', (penteWeapon and mainweap[weapon][7]+10 or mainweap[weapon][7]))
			setWeaponProperty(mainweap[weapon][1], skill, 'move_speed', mainweap[weapon][8])
			setWeaponProperty(mainweap[weapon][1], skill, 'damage', mainweap[weapon][2])
			setWeaponProperty(mainweap[weapon][1], skill, 'accuracy', (bocaWeapon and (coronhaWeapon and mainweap[weapon][3]*1.1 or mainweap[weapon][3]/1.1) or (coronhaWeapon and mainweap[weapon][3]*1.3 or mainweap[weapon][3])))
			setWeaponProperty(mainweap[weapon][1], skill, 'weapon_range', (bocaWeapon and mainweap[weapon][6]*1.3 or mainweap[weapon][6]))
			setWeaponProperty(mainweap[weapon][1], skill, 'target_range', mainweap[weapon][5])
		end
	end
	giveWeapon(playerSource, weaponID[wep][1], muni, true)
end

function giveWeaponMG(playerSource, objID)
	if isElement(elementWeaponRaplace[playerSource]) then
		destroyElement(elementWeaponRaplace[playerSource])
		elementWeaponRaplace[playerSource] = nil
		setElementData(playerSource, 'cweapon', false)
	end
	for idW,itemW in ipairs(armas)do
		if itemW[2] == objID then
			giveNewWeapon(playerSource, itemW[1], 9999, weaponID[itemW[1]][1])
		end
	end
end

function loadWeaponSkin(playerSource, _, adesivo)
	if (adesivo) then
		local arma = getElementData(playerSource, 'cweapon')
		if not arma then config.notifyS(playerSource, 'Equipe a arma para equipar a skin', 'error') return end
		--local v = config.armas[arma][adesivo]
		--if v then
		--	if adesivo == v.nameSkin then
		--triggerClientEvent(root, 'setArmaStickerC', resourceRoot, playerSource, 'arma', 'files/weapons/skins/'..adesivo..".png", elementWeaponRaplace[playerSource])
		--config.notifyS(playerSource, 'Você equipou a skin '..(adesivo)..' com sucesso.', 'success')
		--end
		--end
	end
end

function loadObjectSkin(playerSource, object, adesivo)
	if (adesivo) then
		--triggerClientEvent(root, 'setArmaStickerC', resourceRoot, playerSource, 'arma', 'files/weapons/skins/'..adesivo..".png", object)
	end
end

function loadWeaponAttach(playerSource, _, attach, part)
	if (attach) then
		local arma = getElementData(playerSource, 'cweapon')
		if not arma then config.notifyS(playerSource, 'Equipe a arma para equipar a skin', 'error') return end
		--triggerClientEvent(root, 'setArmaStickerC', resourceRoot, part, attach, 'files/weapons/skins/'..attach..".png", elementWeaponRaplace[playerSource])
	end
end

function isWeaponNameSkin(name)
	local table = config.armas
	value = false
	for i, v in ipairs(table) do 
		if name == v.nameSkin then
			value = true
		end
	end
	return value
end

Firetime = {}

function PlaySound3D(playerSource, som, distance)
	if isTimer(Firetime[playerSource]) then return end
	if distance == "all" then
		triggerClientEvent(root, "playSound", resourceRoot, som, playerSource)
	else
		for i, players in pairs(getElementsByType("player")) do
			local x, y, z = getElementPosition(playerSource)
			local ex, ey, ez = getElementPosition(players)
			if getDistanceBetweenPoints3D(x, y, z, ex, ey, ez) <= distance then
				Firetime[playerSource] = setTimer(function() end, 800,1)
				triggerClientEvent(players, "playSound", resourceRoot, som, playerSource)
			end
		end
	end
end
addEvent('soundb', true)
addEventHandler('soundb', getRootElement(), PlaySound3D)

weaponID = {
	['five'] = {23, '9mm', 2},
	['glock'] = {23, '44', 2},
	['magnum'] = {24, '9mm', 2},
	['revolver'] = {24, '45', 2},
	['escopeta'] = {25, '12', 3},
	['vector'] = {23, '40', 2},
	['mp5'] = {29, '40', 4},
	['tec9'] = {32, '45', 4},
	['p90'] = {29, '45', 4},
	['thompson'] = {29, '45', 4},
	['machine1'] = {29, '45', 4},
	['skorpion'] = {29, '45', 4},
	['kar98'] = {33, '45', 4},
	['ak'] = {30, '762', 5},
	['g36c'] = {31, '762', 5},
	['m4'] = {30, '556', 5},
	['imbel'] = {31, '556', 5},
	['m240'] = {33, '50', 6},
	['bazooka'] = {35, 'rocket', 7},
	['faca'] = {4, '', 1},
}

-- ['ARMA'] = {"nome",                dano, precisão, andar atirando?, dis proximo, dis arma, pente, move speed},
mainweap = {
	
	["five"] = {'silenced',    			10, 50,  true,  0,  90,  12,   1.3},
	
	["glock"] = {'silenced',   			11, 45,  true,  0,  90,  18,   1.5},
	
	["magnum"] = {'deagle',    			16, 60,  true,  0,  120,  8,   1.2 },
	
	["revolver"] = {'deagle',  			16, 125, true,  0,  190,  8,   1 },
	
	["tec9"] = {'tec-9',   	   			8, 35,  true,  0,  120,  22,  1.1 },
	
	["vector"] = {'tec-9',     			0, 30,  true,  40, 130,  25,  1.4 },
	
	["mp5"] = {'mp5',          			11, 60,  true,  0,  140,  30,  1.1 },
	
	["thompson"] = {'mp5',     			11, 60,  true,  0,  140,  25,  1.2 },
	
	["p90"] = {'mp5',     				11, 60,  true,  0,  170,  30,  1.4 },
	
	["machine1"] = {'mp5',     			10, 50,  true,  0,  140,  20,  1.5 },
	
	["machine2"] = {'mp5',     			10, 50,  true,  0,  150,  22,  1.5 },
	
	["imbel"] = {'ak-47',         			18, 50, true,  30,  230, 32,   1.4 },
	
	["m4"] = {'ak-47',      	   			16, 50, true,  30,  240, 32,   1.4 },
	
	["ak"] = {'ak-47',   	   			16, 50, true,  30,  240, 32,   1.4 },
	
	["g36c"] = {'ak-47',   	   			18, 50, true,  30,  230, 32,   1.4 },
	
	["m240"] = {'rifle',       			30, 45, true,  30,  300, 100,  1.3 },
	
	["kar98"] = {'rifle',       		35, 70, true,  30,  300, 1,  1.3 },
	
	["escopeta"] = {'shotgun', 			8,  30,  true,  15,  15,  2,    0.8 },
	
	["bazooka"] = {'rocket launcher', 	50, 100, false, 0,  220, 1,    0.5 },
	
	["faca"] = {'Chainsaw', 			10, 100, true, 11,  5, 5,     0.9 },
	
}
