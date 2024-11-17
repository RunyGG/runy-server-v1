local ClothesInUsing = {}

database = dbConnect( "sqlite", "database.db")

addEventHandler("onResourceStart", resourceRoot, function()
	if database then
		dbExec(database, "CREATE TABLE IF NOT EXISTS clothes (conta, clothes)")
		print("Database Custom Characters Conectada com Sucesso")
	else 
		print("Fail ERROR Db Conect Custom")
	end
	setTimer(function()
		for i,v in pairs(getElementsByType('player')) do
			onLogin(v)
		end
	end, 2000, 1)
end)

function UpdatePedClothes(ped, user)
	if ped then
		local result = dbPoll(dbQuery(database, "SELECT * FROM clothes WHERE conta = ?", user), -1)
		local clothes
		if type(result) == "table" and #result ~= 0 then
			clothes = fromJSON(result[1]["clothes"])
			ClothesInUsing[ped] = clothes
			triggerClientEvent(ped, "setPlayersClothes", ped, ClothesInUsing)
			for i,v in pairs(getElementsByType('player')) do
				if getElementData(v, 'modo') == 'Lobby' then
					triggerClientEvent(v, "setPlayerClothe", resourceRoot, ped, ClothesInUsing[ped]["skin"], ClothesInUsing[ped])
				end
			end
		end
	end
end
addEvent('UpdatePedClothes', true)
addEventHandler('UpdatePedClothes', root, UpdatePedClothes)

createEvent = function(eventname, ...)
	addEvent(eventname, true)
	addEventHandler(eventname, ...)
end

function checkAccountName(element)
	if element then
		return getAccountName(getPlayerAccount(element))
	end
end

function getPlayerClothes(element)
	return ClothesInUsing[element]
end

function getPlayerClothesCustom(element)
	local clothes
	local result = dbPoll(dbQuery(database, "SELECT * FROM clothes WHERE conta = ?", checkAccountName(element)), -1)
	if type(result) == "table" and #result ~= 0 then
		local clothes = fromJSON(result[1]["clothes"])
		return clothes
	end
end

function refeshPlayerClothes(target)
	local user = checkAccountName(target)
	local result = dbPoll(dbQuery(database, "SELECT * FROM clothes WHERE conta = ?", user), -1)
	if type(result) == "table" and #result ~= 0 then
		local clothes = fromJSON(result[1]["clothes"])
		ClothesInUsing[target] = clothes
		triggerClientEvent(source, "setPlayerClothe", source, target, clothes["skin"], ClothesInUsing[target])
	end
end
createEvent("loadClothesElement", root, refeshPlayerClothes)


function onLogin(element)
	if element then source = element end
	local user = checkAccountName(source)
	local result = dbPoll(dbQuery(database, "SELECT * FROM clothes WHERE conta = ?", user), -1)
	local clothes
	if type(result) == "table" and #result ~= 0 then
		clothes = fromJSON(result[1]["clothes"])
		ClothesInUsing[source] = clothes
		triggerClientEvent(source, "setPlayersClothes", source, ClothesInUsing)
		triggerClientEvent(source, "setPlayerClothe", source, source, clothes["skin"], ClothesInUsing[source])
	else
		local clothes = defaultClothes[getPedSkin(element)]
		if clothes then
			UpdatePlayerClothes(source, clothes)
			ClothesInUsing[source] = clothes
		end
	end
end

function UpdatePlayerClothes(element, clothes)
	local user = checkAccountName(element)
	if clothes then
		local result = dbPoll(dbQuery(database, "SELECT * FROM clothes WHERE conta = ?", user), -1)
		if result and #result ~= 0 then
			dbExec(database, "UPDATE clothes SET clothes = ? WHERE conta = ?", toJSON(clothes), user)
		else
			dbExec(database, "INSERT INTO clothes (conta, clothes) VALUES(?, ?)", user, toJSON(clothes))
		end
		ClothesInUsing[element] = clothes
	else
		clothes = defaultClothes[getPedSkin(element)]
		if clothes then
			dbExec(database, "UPDATE clothes SET clothes = ? WHERE conta = ?", toJSON(clothes), user)
			ClothesInUsing[element] = clothes
		end
	end
	triggerClientEvent(element, "setPlayerClothe", element, element, ClothesInUsing[element]["skin"], ClothesInUsing[element])
end
createEvent("UpdatePlayerClothes", root, UpdatePlayerClothes)

addEventHandler("onPlayerLogin", getRootElement(), 
function(_,acc)
	local user = checkAccountName(source)
	local result = dbPoll(dbQuery(database, "SELECT * FROM clothes WHERE conta = ?", user), -1)
	local clothes
	
	if type(result) == "table" and #result ~= 0 then
		clothes = fromJSON(result[1]["clothes"])
		ClothesInUsing[source] = clothes
		triggerClientEvent(source, "setPlayersClothes", source, ClothesInUsing)
		triggerClientEvent(source, "setPlayerClothe", source, source, clothes["skin"], ClothesInUsing[source])
	else
		local clothes = defaultClothes[getPedSkin(source)]
		
		if clothes then
			UpdatePlayerClothes(source, clothes)
		end
	end
end)

addEventHandler("onPlayerQuit", getRootElement(), function()
	UpdatePlayerClothes(source, ClothesInUsing[source])
end)

addEventHandler( "onResourceStop", getRootElement(), function()
	for i,v in pairs(getElementsByType('player')) do
		UpdatePlayerClothes(v, ClothesInUsing[v])
	end
end)