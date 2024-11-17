scripts = {
	[1] = {
		"runy_login",
		"runy_lobby4",
		--"customcharacter",
		"runy_aviao",
		--"runy_roupas-inventario",
		"runy_lobby-model2",
		"pAttach",
		"runy_lobby-map",
		"runy_totem",
		"runy_totem-model",
		"runy_model-lobby",
		"runy_new-headshot",
		"runy_call",
		"runy_rpc",
		"runy_barreirals",
		"runy_carros",
		"runy_norecoil",
		--"runy_bussola",
		"runy_cursor",
		"runy_ant-explosion",
		--"runy_agachar-animation",
		--"runy_anticlouds",
		"runy_correrarmado",
		"runy_dropItem",
		"runy_semsomambiente",
		--"runy_aviao-model",
		--"halloween",
		"runy_correcaoaq",
		"runy_nospeedblur",
		--"runy_skinzika",
		--"runy_skinvt",
		--"runy_skinversat",
		--"runy_skinTerneta$",
		--"runy_anuncio",
		--"runy_aq",
		--"runy_liberarF",
		"runy_knife-damage",
		"runy_showarmor",
		--"runy_dianoite",
		--"runy_norecoil",
		--"runy_bf400",		
		"runy_dropitens",
		"runy_fundos",
		"runy_group-design",
		"runy_headshot-npc_treino",
		"runy_hud",
		"runy_idsysteam",
		"runy_idtag",
		"runy_indicador-tiro",
		"runy_inventario",
		--"runy_itenslist",
		"runy_join-quit",
		"runy_kill-log",
		"runy_killfeed",
		--"runy_killpoints",
		--"runy_killsmostrar",
		"runy_loadscreen",
		"runy_logs",
		"runy_loot",
		"runy_mira",
		"runy_morte",
		--"runy_mostrararma",
		"runy_notify",
		--"runy_points-system",
		"runy_progessbar",
		"runy_radar",
		"runy_removerhudmta",
		--"runy_richpresence",
		"runy_safezone",
		"runy_meters",
		"runy_rolas",
		"runy_telagem",
		--"runy_telagem-staff",
		"runy_treino",
		--"runy_tpaq",
		"runy_treino2",
		--"runy_veiculo",
		"runy_vivosmostrar",
		"runy_winner",
		"runy_winner-dimension",
		--"runy_sonsarma",
		--"runy_create-temporario",
		"runy_salvar-skin_morte",
		"runy_saveskin",
		"runy_skin",
		"mg",

		"reload",
		"parachute",
		--"runy_armedRace",
		"runy_samu",
		"runy_paraquedas-2",
		"runy_television",
		--"runy_opencrate",
		"runy_tracer",
		"defaultstats",
		"admin",
		"runy_perfil",
		"runy_notify-kill",
		"runy_map-lobby",
		--"vitti_createcharacter",
		"runy_showfps",
		"runy_topkills",
		"runy_spawn-veiculos",
		"runy_objects",
		--"runy_arsenal",
		--"runy_equipamentos",
		"runy_trainer",
		"[NEGO]animifp",
		--"runy_outline",
		--"runy_inventario_custom",
		--"runy_jetdoor_txd",
		"runy_lobby-model",
		"runy_model-caixa",
		"runy_model-parachute",
		"runy_model-treino",
	},
}

function startServer(id)
	local sucess = 0
	local fail = 0
	local att = 0
	local size = #scripts[tonumber(id)]	
	for i = 1, size do
		local resource = getResourceFromName(scripts[tonumber(id)][i])
		if resource then
			local resstate = startResource(resource, true)
			if resstate then
				sucess = sucess + 1
				outputDebugString("* Resource: '" .. scripts[tonumber(id)][i] .. "' Iniciado!" )	
			else
				att = att + 1
			end
		else
			fail = fail + 1
			outputDebugString("* Resource: '" .. scripts[tonumber(id)][i] .. "' não encontrado, indo para o próximo...")
		end
	end
end

function displayLoadedRes(res)
	local thisResource = getThisResource()
	if res == thisResource then
		startServer(1)
	end
end
addEventHandler("onResourceStart", getRootElement(), displayLoadedRes)
