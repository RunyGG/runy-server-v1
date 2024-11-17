system = {
    
    core = {

	logs = {
		['WebHook'] = 'https://discord.com/api/webhooks/1270932378503745618/209ZSbvIbqQn1ewlWfWcD3HFICX1_rt-jWHTGsm70ik_d_Md5GI1kPhV8WiZ_bxJRtSU',  -- (PT-BR) Aqui você adicionará sua WebHook do discord
		['UserName'] = 'runygg AC', -- (PT-BR) Aqui você adicionará o nome da integração
		['Avatar'] = 'https://media.discordapp.net/attachments/1272314573092950118/1272623541417803787/logo.jpg?ex=66bba688&is=66ba5508&hm=98d2be636368c77e9598db967bec466903b1548418089d2522310d8b77b4feb0&=&format=webp&width=473&height=473', -- (PT-BR) Aqui você adicionará a imagem da integração
		['FooterText'] = 'Direitos Reservados', -- (PT-BR) Aqui você o rodapé da log
		['Icon'] = 'https://media.discordapp.net/attachments/1272314573092950118/1272623541417803787/logo.jpg?ex=66bba688&is=66ba5508&hm=98d2be636368c77e9598db967bec466903b1548418089d2522310d8b77b4feb0&=&format=webp&width=473&height=473', -- (PT-BR) Aqui você adicionará sua imagem de icone das logs
		['EmbedColor'] = 15844367 -- (PT-BR) https://gist.github.com/thomasbnt/b6f455e2c7d743b796917fa3c205f812
	},


	screenShots = {
		status = true, -- (PT-BR) Se desejar que screeshots da dela do jogador sejam enviadas ao Discord via WebHooks
		['ClientID'] = 'b9b8766717a5bb2'; -- Seu Client ID do Imgur (https://api.imgur.com/oauth2/addclient)
	},


	bypass = {
		getPermissions = function(element) -- (PT-BR) Defina abaixo os usuários que contenham permissões para utilizar as funções (Desenvolvedores, Fundadores)
			if element then 
				return isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(element)), aclGetGroup("Admin"))
			end
		end
	},


	language = {
		['PT-BR'] = true,
		['EN-US'] = false
	},


	commands = {
		['takeScreenShot'] = 'print' -- (PT-BR) Comando para tirar print da tela de um jogador específico por seu ID
	},

    modules = { -- (PT-BR) Aqui você selecionará as funções do Anticheat
        --['Weapon >> Fake'] = true, -- Modulo de detecção de armas puxadas em cheat
        --['Fly >> Detect'] = true, -- Modulo de detecção de jogadores voando com cheats
		['Explosion >> Detect'] = true, -- Detecção de explosões maliciosas
		['Lua >> Executor'] = true, -- Detecção de utilzação externa de execução Lua (Client-Side)
		['Speed >> Cheat >> Detect'] = true, -- Detecção de Alteração de velocidade
		['Anti >> Serial >> Change'] = true -- Detecção quando há uma alteração de Serial (Spoofer)
    },


	allowed_resources = { -- (PT-BR) Lista de Resources que podem utilizar GUI
		['admin'] = true,
		['runy_lobby4'] = true,
	},


	special = { -- (PT-BR) Detecção de propriedas especiais
		['aircars'] = true,
		['extrajump'] = true,
		['hovercars'] = true,
		['extrabunny'] = true,
		['snipermoon'] = true,
		['vehiclesunglare'] = true
	},
        
    elements = {    -- (PT-BR) Element's Data que serão protegidos pelo sistema
	    ['Nome'] = true,
		['SobreNome'] = true,
	    ['ID'] = true,
        ["HS:Coins"] = true,  
        ["HS:Saldo"] = true,
		['TS:Bank'] = true
    },

    blocked_functions = { -- (PT-BR) Funções protegidas pelo sistema
        "loadstring", 
        "setElementData",
        "setElementPosition",
        "triggerServerEvent",
        "killPed",
        "dxDrawLine",
        "dxDrawLine3D",
        "setElementHealth",
        "createExplosion",
        "setVehicleHandling",
        "setCameraTarget",
        "setVehicleLocked",
        "setVehicleDamageProof",
        "setPedOnFire",
        "createVehicle",
    },

	utils = {
		['getPlayerName'] = function(element) -- (PT-BR) Função para retornar o nome do(a) Jogador(a)
			if element then
				return getPlayerName(element) or 'Não idêntificado' 
			end
		end,
		['getPlayerID'] = function(element)
			if element then
				return getElementData(element, 'ID') or  'Não idêntificado' -- (PT-BR) Função para retornar o ID do(a) Jogador(a)
			end
		end,
	},

	forbidden_words = {
		
	["cheat"] = true,

	["hack"] = true,

	["rack"] = true,

	["hacker"] = true,

	["hax"] = true,

	["hacks"] = true,

	["haxs"] = true,

	["xit"] = true,

	["xiter"] = true,

	["xitado"] = true,

	["xitando"] = true,

	["0xcheat"] = true,

	["0xcheats"] = true,

	["vbr"] = true,

	["menu"] = true,

	["antirp"] = true,

	["rdm"] = true,

	["explodir"] = true,

	["wecheat"] = true,

	["wecheats"] = true,

	["gna"] = true,

	["gnaplay"] = true,

	["mych"] = true,

	["prz"] = true,

	["massivo"] = true,

	["masivo"] = true,

	["dupar"] = true,

	["dup"] = true,

	["dupando"] = true,

	["bypass"] = true,

	["injetar"] = true,

	["aimbot"] = true,

	["aimb0t"] = true,

	["paozin"] = true,

	[".gg"] = true,

	[".net"] = true
	},
  }
}

function dump(o)

	if type(o) == "table" then

		local s = "{ "

		for k, v in pairs(o) do

			if type(k) ~= "number" then k = '"'..k..'"' end

			s = s .. '['..k..'] = ' .. dump (v) .. ','

		end

		return s .. "} "

	else

		return tostring(o)

	end

end

function getPlayerIdentifier(player)

    local playerIdentifier =  getPlayerName(player) .. " (" .. (getElementData(player, "ID") or "?") .. ")"

    return playerIdentifier

end



function encryptEventName(eventName)

	return md5(eventName)

end