local texture = {}
local myShader = {}
local mycharacter = {}

local myShader_raw_data = [[
texture tex;
technique replace {
		pass P0 {
			Texture[0] = tex;
		}
	}
]]

function pixels(player, pixel)
	for i,v in pairs(getElementsByType('texture')) do
		dxSetTexturePixels(0, v, tostring(pixel))
	end
end

createEvent = function(eventname, ...)
	addEvent(eventname, true)
	addEventHandler(eventname, ...)
end

function excluirShader(player, category)
	if not myShader[player] or not myShader[player][category] then return end
	if isElement(myShader[player][category]) then
		engineRemoveShaderFromWorldTexture(myShader[player][category], "*")
		destroyElement(myShader[player][category])
	end
	myShader[player][category] = nil
end
createEvent("excluirShader", localPlayer, excluirShader)

function applyTexture(element, shader, dir)
	texture[element] = dxCreateTexture(dir, "argb", true, "clamp", '2d')
	dxSetShaderValue(shader, "tex", texture[element])
	destroyElement(texture[element])
end

function clearShaderClothe(element, skin, variavel, stylo)
	if not myShader[element] then
		myShader[element] = {}
	end
	if not myShader[element][variavel] then
		myShader[element][variavel] = {}
	end
	excluirShader(element, variavel)
	if stylo then
		myShader[element][variavel] = dxCreateShader(myShader_raw_data, 0, 0, false, "ped")
		if class_clothes[skin][variavel][stylo] and #class_clothes[skin][variavel][stylo] > 0 then
			engineApplyShaderToWorldTexture(myShader[element][variavel], class_clothes[skin][variavel][stylo], element)
		end
	else
		if partsZ['addParts'][variavel] then
			local dt = partsZ['addParts'][variavel]
			if dt.part then
				myShader[element][variavel] = dxCreateShader(myShader_raw_data, 0, 0, false, "ped")
				engineApplyShaderToWorldTexture(myShader[element][variavel], class_clothes[skin][variavel][2], element)
				applyTexture(element, myShader[element][variavel], "assets/"..skin.."/"..variavel.."/"..dt[1].."/"..dt[2]..".png")
			else
				myShader[element][variavel] = dxCreateShader(myShader_raw_data, 0, 0, false, "ped")
				engineApplyShaderToWorldTexture(myShader[element][variavel], class_clothes[skin][variavel][dt[1]], element)
				applyTexture(element, myShader[element][variavel], "assets/"..skin.."/"..variavel.."/"..dt[1].."/"..dt[2]..".png")
			end
		end
	end
end

partsZ = {
	clearParts = {
		['short'] = {'perna'},
	},
	addParts = {
		['corpo'] = {1,1},
		['cabelo'] = {2,2},
		['short'] = {1,1, part = 'cueca'},
	},
}

function setClothe(element, skin, variavel, stylo, text)
	if element then
		stylo = tonumber(stylo)
		text = tonumber(text)
		if not class_clothes[1] then class_clothes[1] = {} end
		if not class_clothes[1][variavel] then class_clothes[skin][variavel] = {} end
		if not class_clothes[1][variavel][stylo] then class_clothes[skin][variavel][stylo] = {} end
		
		if class_clothes[1][variavel][stylo] and text > 0 then
			clearShaderClothe(element, 1, variavel, stylo)
			applyTexture(element, myShader[element][variavel],"assets/"..'1'.."/"..variavel.."/"..stylo.."/"..text..".png")
		elseif variavel and stylo < 1 then
			clearShaderClothe(element, 1, variavel)
		end
	end
end

function setPlayerClothe(element, skin, clothes)
	if localPlayer:getData('disableCustom') then return end
	if element then
		local skin = getElementModel(element)
		for clothe, _ in pairs(clothes) do
			if clothe ~= "skin" then
				setClothe(element, 1, clothe, clothes[clothe][1], clothes[clothe][2])
			end
		end
	end
end
createEvent("setPlayerClothe", localPlayer, setPlayerClothe)

createEvent("setPlayersClothes", localPlayer, function(clothe)
end)

addEventHandler( "onClientElementStreamIn", root, function ()
	if getElementType(source) ~= "player" or source == localPlayer then return end
	if getElementData(source, 'deadPlayer') or getElementData(source, 'telando') then return end
	triggerServerEvent('loadClothesElement', localPlayer, source)
end, true, "low-9999")

addEventHandler("onClientElementStreamOut", root, function() 
	if getElementType(source) ~= "player" or source == localPlayer then return end
	unloadCharacter(source)
end, true, "low-9999")

addEventHandler("onClientPlayerQuit", root, function()
	if myShader[source] then
		unloadCharacter(source)
	end
end)

function unloadCharacter(player)
	if player:getData('disableCustom') then return end
	if myShader[player] then
		for i,v in pairs(myShader[player]) do
			engineRemoveShaderFromWorldTexture(v, "*")
			destroyElement(v)
			myShader[player] = nil
		end
	end
end

function removeTexture(player, category)
	if player:getData('disableCustom') then return end
	if not myShader[player] or not myShader[player][category] then return end
	if isElement(myShader[player][category]) then
		engineRemoveShaderFromWorldTexture(myShader[player][category], "*")
		destroyElement(myShader[player][category])
	end
	myShader[player][category] = nil
end


function loadCustom(player, both)
	engineFreeModel(1)
	engineFreeModel(10)
	if both == true then
		setElementData(localPlayer, 'disableCustom', false)
		local txd = engineLoadTXD("models/female.txd" )
		engineImportTXD( txd, 10 )
		local txd = engineLoadTXD("models/male.txd" )
		engineImportTXD( txd, 1 )

		local dff = engineLoadDFF("models/female.dff", 10)
		engineReplaceModel( dff, 10 )
		local dff = engineLoadDFF("models/male.dff", 1)
		engineReplaceModel( dff, 1 )
	else
		setElementData(localPlayer, 'disableCustom', true)
		local dff = engineLoadDFF("models/10.dff", 10)
		engineReplaceModel( dff, 10 )
		local dff = engineLoadDFF("models/1.dff", 1)
		engineReplaceModel( dff, 1 )
	end
end

addEventHandler("onClientResourceStart", resourceRoot, function()
	engineStreamingFreeUpMemory(104857600)
	local txd = engineLoadTXD("models/female.txd" )
	engineImportTXD( txd, 10 )
	local txd = engineLoadTXD("models/male.txd" )
	engineImportTXD( txd, 1 )
	
	local dff = engineLoadDFF("models/female.dff", 10)
	engineReplaceModel( dff, 10 )
	local dff = engineLoadDFF("models/male.dff", 1)
	engineReplaceModel( dff, 1 )
end)
