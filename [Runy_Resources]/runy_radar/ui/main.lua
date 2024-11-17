INTERFACE_UTILS = { 

	SHOW = true,

	NOTIFICATION_TYPES = { 
		{ 175, 214, 111, "success" }, -- success;
		{ 98, 169, 209, "info" }, -- info;
		{ 221, 44, 44, "error" }, -- error;
		{ 209, 192, 102, "warning" } -- warning;
	}, 

	BLIPS = {

		--[[[ 1 ] = { name = "Destino" },
		[ 2 ] = { name = "Mercado" },
		[ 3 ] = { name = "Drogaria" },
		[ 4 ] = { name = "Ilha" },
		[ 5 ] = { name = "Park diverções" },
		[ 6 ] = { name = "Mecanico" },
		[ 7 ] = { name = "Academia" },
		[ 8 ] = { name = "Paraquedista" },
		[ 10 ] = { name = "Garagem" },
		[ 11 ] = { name = "Hospital" },
		[ 12 ] = { name = "Lanchonete" },
		[ 13 ] = { name = "Loja de roupas" },
		[ 15 ] = { name = "Minerador" },
		[ 16 ] = { name = "Açogueiro" },
		[ 17 ] = { name = "Ammu nation" },
		[ 18 ] = { name = "Agencia" },
		[ 19 ] = { name = "Problema" },
		[ 20 ] = { name = "Aero porto" },
		[ 21 ] = { name = "Concessionaria" },
		[ 22 ] = { name = "Safezone" },]]--

	},

};

screenW, screenH = guiGetScreenSize()
sW, sH = (screenW/1366), (screenH/768)

INTERFACE = { 


	Radar = { 


		x = sW * 16,
		y = sH * 89,
		w = sW * 260,
		h = sH * 150,

		-- UTILS;

		-- FULL:( INTERFACE.Radar.w, INTERFACE.Radar.h );
		render_targer = dxCreateRenderTarget( sW * 260, sH * 150, true )

	},

	GPS = {

		x = 0,
		y = 0,
		w = screen[ 1 ],
		h = screen[ 2 ],

		-- UTILS;

		-- FULL:( INTERFACE.GPS.w, INTERFACE.GPS.h );
		render_targer = dxCreateRenderTarget( screen[ 1 ], screen[ 2 ], true )

	},


	-- MINIMAP;
	unit = 3000,

	gps_lines = { },
	blips = { },
	blip_size = 25

};

function setInterfaceVisible( ui, bool )

	if ( ui == "all" ) then

		setRadarVisible( bool );
	

	elseif ( ui == "radar" ) then

		setRadarVisible( bool );

	elseif ( ui == "interface" ) then

		INTERFACE_UTILS.SHOW = not not bool;

	end

end

function setup( )
	setupGPS( );
	setInterfaceVisible("all", true)
end