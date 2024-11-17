local db = dbConnect("sqlite", "database.db")

addEventHandler("onResourceStart", resourceRoot, function()
	if db then
		dbExec(db, "CREATE TABLE IF NOT EXISTS banimento (dc INTEGER)")
	end
end)

timer = {}

--[[ addEventHandler("onPlayerLogin", root,function()
	-- SOURCE
	timer[source] = setTimer(function(source)
		local discord = getElementData(source, 'DiscordID')
		if discord then
			local result = dbPoll(dbQuery(db, "SELECT * FROM banimento WHERE dc = ?", discord), -1)
			iprint(result)
			if result and #result ~= 0 then
				local serial = puxarSerial(player)	
				local ip = getPlayerIP(player)
				sendDiscordMessage(hook, getPlayerName(player), getAccountName(getPlayerAccount(player)), serial, 'SPOOFER', getElementData(player, 'ID') or "N/A", ip, discord)
				banPlayer(source,true,false,true,'runy AntiCheat', "Foi detectado spoofer\nANTICHEAT RUNY GG", 0)
			end
		end
	end, 2000, 1, source)
end) ]]

hook = 'https://discord.com/api/webhooks/1270932378503745618/209ZSbvIbqQn1ewlWfWcD3HFICX1_rt-jWHTGsm70ik_d_Md5GI1kPhV8WiZ_bxJRtSU'

addEventHandler("onResourceStart", resourceRoot, function( )
	local version = getVersion( )
	local sortable = version.sortable
	setServerConfigSetting( "minclientversion", versaominima, true )
	print( ( "VERSÃO ATUAL: %s // VERSÃO DEFINIDA: %s" ):format( sortable, versaominima ) )
end)

addEvent("anticheat:giveBan", true)
addEventHandler("anticheat:giveBan", root, 
function (thePlayer, code)
	if luaexec1 == true then
		local serial = puxarSerial(thePlayer)	
		local ip = getPlayerIP ( thePlayer )
		local discord = getElementData(thePlayer, 'DiscordID') or 0
		local acc = getPlayerAccount(thePlayer)
		sendDiscordMessage(hook, getPlayerName(thePlayer), getAccountName(getPlayerAccount(thePlayer)), serial, 'Lua-Executor: '..tostring(code[1]), getElementData(thePlayer, 'ID') or "N/A", ip, discord)
		if isObjectInACLGroup("user." ..getAccountName(getPlayerAccount(thePlayer)), aclGetGroup ("Admin")) or isObjectInACLGroup("user." ..getAccountName(getPlayerAccount(thePlayer)), aclGetGroup ("Console")) then
		else
			dbExec(db, 'INSERT INTO banimento VALUES (?)', discord)
			banPlayer(thePlayer,true,false,true,'runy AntiCheat', "Foi detectado atividades suspeitas\nANTICHEAT RUNY GG", 0)
		end
	end
end)

function puxarNome(source)
	if source and isElement(source) then
		return removeHex(getPlayerName(source))
	end
	return 'N/A'
end

function puxarSerial(source)
	if source and isElement(source) then
		return getPlayerSerial(source)
	end
	return 'N/A'
end

function sendDiscordMessage (urlWebhook, nick, conta, serial, motivo, id, ip, dc)
	discordData = {
		connectionAttempts = 10,
		connectionTimeout = 20000,
		content = "";
		username = "KING's Anti-Cheat";
		avatar_url = "";
		embeds = {
			{
				title = "LUA EXECUTOR";
				color = 9848758;
				footer = {
					text = "KING's | Anti-Cheat";
					icon_url = "";
				};
				fields = {
					{
						name= "Nick:",
						value= nick,
						inline=false,
					},
					{
						name= "ID:",
						value= id,
						inline=false,
					},
					{
						name= "Login:",
						value= conta,
						inline=false,
					},
					{
						name= "Serial:",
						value= serial,
						inline=false,
					},
					{
						name= "IP:",
						value= ip,
						inline=true,
					},
					{
						name= "Discord:",
						value= '<@'..dc..'>',
						inline=true,
					},
					{
						name= "Motivo:",
						value= motivo,
						inline=true,
					},
					{
						name= "Banimento:",
						value= "Permanente",
						inline=false,
					},
				},
				thumbnail = {
					url = "";
				};
			};
			
		};
	}
	local jsonData = toJSON (discordData)
	jsonData = string.sub (jsonData, 3, #jsonData - 2)
	
	local sendOptions = {
		headers = {
			["Content-Type"] = "application/json";
		};
		postData = jsonData;
	};
	fetchRemote (urlWebhook, sendOptions, callBack)
end

function callBack()
end

addEvent('KINGsDetect', true)
addEventHandler('KINGsDetect',getRootElement(), function(player,reason)
	if reason == "Function-Hack" then
		sendDiscordMessage(Config["Anti-Cheat"]["webhook"], getPlayerName(player), getAccountName(getPlayerAccount(player)), getPlayerSerial(player), reason, getElementData(player, 'ID') or "N/A", getPlayerIP(player), getElementData(player, 'DiscordID'))
		kickPlayer(player, 'Você está com suspeitas de programas ilegais, nossa equipe irá analizar o caso logo logo, entre novamente!')
	else
		local verify = VerifyAclDetect(player, reason)
		if not verify then
			local discord = getElementData(player, 'DiscordID') or 0
			dbExec(db, 'INSERT INTO banimento VALUES (?)', discord)
			sendDiscordMessage(Config["Anti-Cheat"]["webhook"], getPlayerName(player), getAccountName(getPlayerAccount(player)), getPlayerSerial(player), reason, getElementData(player, 'ID') or "N/A", getPlayerIP(player), getElementData(player, 'DiscordID'))
			banPlayer(player,true,false,true,Config["Anti-Cheat"]["name"], "Foi detectado atividades suspeitas\nANTICHEAT RUNY GG", 0)
		end
	end
end)

addEvent('Inject', true)
addEventHandler('Inject',getRootElement(), function(player,reason)
	sendDiscordMessage(Config["Anti-Cheat"]["webhook"],getPlayerName(player),getAccountName(getPlayerAccount(player)),getPlayerSerial(player),reason.." TESTE DE DETECÇÃO INJECT",(getElementData(player, 'ID') or "N/A"), getPlayerIP(player), getElementData(player, 'DiscordID'))
	outputConsole(getPlayerName(player), (getElementData(player, 'ID') or "N/A"), 'SUSPEITO DE INJECT')
	local discord = getElementData(player, 'DiscordID') or 0
	dbExec(db, 'INSERT INTO banimento VALUES (?)', discord)
	banPlayer(player,true,false,true,Config["Anti-Cheat"]["name"], "Foi detectado atividades suspeitas\n caso ache injusto abra um ticket informando\nANTICHEAT RUNY GG", 0)
end)

function VerifyAclDetect(player,reason)
	if reason == "Explosion-Hack" then
		for i=1,#Config["Anti-Cheat"]["Explosion"]["explosion-acls-allowed"] do
			if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(player)),aclGetGroup(Config["Anti-Cheat"]["Explosion"]["explosion-acls-allowed"][i])) then
				return true
			end
		end
		for i=1,#Config["Anti-Cheat"]["Explosion"]["Explosion-data-allowed"] do
			if getElementData(player, Config["Anti-Cheat"]["Explosion"]["Explosion-data-allowed"][i]) == "bazooka" then
				return true
			end
		end
		return false
	elseif reason == "Projectile-Hack" then
		for i=1,#Config["Anti-Cheat"]["Projectile"]["Projectile-acls-allowed"] do
			if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(player)),aclGetGroup(Config["Anti-Cheat"]["Projectile"]["Projectile-acls-allowed"][i])) then
				return true
			end
		end
		return false
	elseif reason == "Fire-Hack" then
		for i=1,#Config["Anti-Cheat"]["Fire-Hack"]["Fire-acls-allowed"] do
			if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(player)),aclGetGroup(Config["Anti-Cheat"]["Fire-Hack"]["Fire-acls-allowed"][i])) then
				return true
			end
		end
		for i=1,#Config["Anti-Cheat"]["Fire-Hack"]["Fire-weapons-allowed"] do
			if exports["MODInventario"]:GiveAndTakeAndGetItem("get", player, Config["Anti-Cheat"]["Fire-Hack"]["Fire-data-allowed"][i]) > 0 then
				return true
			end
		end
		for i=1,#Config["Anti-Cheat"]["Fire-Hack"]["Fire-data-allowed"] do
			if getElementData(player, Config["Anti-Cheat"]["Fire-Hack"]["Fire-data-allowed"][i]) then
				return true
			end
		end
		return false
	elseif reason == "Speed-Hack" then
		for i=1,#Config["Anti-Cheat"]["Speed"]["speed-acls-allowed"] do
			if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(player)),aclGetGroup(Config["Anti-Cheat"]["Speed"]["speed-acls-allowed"][i])) then
				return true
			end
		end
		for i=1,#Config["Anti-Cheat"]["Speed"]["speed-data-allowed"] do
			if getElementData(player, Config["Anti-Cheat"]["Speed"]["speed-data-allowed"][i]) then
				return true
			end
		end
		return false
	elseif reason == "JetPack-Hack" then
		for i=1,#Config["Anti-Cheat"]["JetPack"]["jetpack-acls-allowed"] do
			if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(player)),aclGetGroup(Config["Anti-Cheat"]["JetPack"]["jetpack-acls-allowed"][i])) then
				return true
			end
		end
		for i=1,#Config["Anti-Cheat"]["JetPack"]["JetPack-data-allowed"] do
			if getElementData(player, Config["Anti-Cheat"]["JetPack"]["JetPack-data-allowed"][i]) then
				return true
			end
		end
		return false
	elseif reason == "Gravity-Hack" then
		for i=1,#Config["Anti-Cheat"]["Gravity"]["gravity-acls-allowed"] do
			if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(player)),aclGetGroup(Config["Anti-Cheat"]["Gravity"]["Gravity-acls-allowed"][i])) then
				return true
			end
		end
		for i=1,#Config["Anti-Cheat"]["Gravity"]["Gravity-data-allowed"] do
			if getElementData(player, Config["Anti-Cheat"]["Gravity"]["Gravity-data-allowed"][i]) then
				return true
			end
		end
		return false
	elseif reason == "Fly-Hack" then
		for i=1,#Config["Anti-Cheat"]["Fly"]["Fly-acls-allowed"] do
			if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(player)),aclGetGroup(Config["Anti-Cheat"]["Fly"]["Fly-acls-allowed"][i])) then
				return true
			end
		end
		for i=1,#Config["Anti-Cheat"]["Fly"]["Fly-data-allowed"] do
			if getElementData(player, Config["Anti-Cheat"]["Fly"]["Fly-data-allowed"][i]) then
				return true
			end
		end
		return false
	elseif reason == "Pro-Hack" then
		for i=1,#Config["Anti-Cheat"]["Pro"]["Pro-acls-allowed"] do
			if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(player)),aclGetGroup(Config["Anti-Cheat"]["Pro"]["Pro-acls-allowed"][i])) then
				return true
			end
		end
		for i=1,#Config["Anti-Cheat"]["Pro"]["Pro-data-allowed"] do
			if getElementData(player, Config["Anti-Cheat"]["Pro"]["Pro-data-allowed"][i]) then
				return true
			end
		end
		return false
		
	end
end

addEvent("NZ.afk-kick", true)
addEventHandler("NZ.afk-kick", root, function(minutes)
   setTimer(redirectPlayer, 1000, 1, source, "181.214.48.17", 22363)
end)