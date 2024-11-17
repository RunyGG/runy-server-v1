screen = { guiGetScreenSize( ) };

occupiedVehicle = false;

addEventHandler( "onClientResourceStart", resourceRoot, 
	function( ) 

		main_font_interface = dxCreateFont("assets/fonts/regular.ttf", 10, false, "proof");
		fade_image_hud = dxCreateTexture("assets/images/fade.png", "argb", false, "wrap")

		-- MINI MAP;
		map_texture = dxCreateTexture("assets/images/radar.png", "argb", false, "wrap");
		size_minimap = dxGetMaterialSize( map_texture );
		dxSetTextureEdge( map_texture, "border", tocolor( 100, 100, 100, 0 ) );

		arrow_player = dxCreateTexture("assets/minimap/arrow.png", "argb", false, "wrap");

		for i=0, 22 do

			INTERFACE.blips[ i ] = dxCreateTexture("assets/minimap/blips/" .. tostring( i ) .. ".png", "argb", false, "wrap" );

		end

		addEventHandler( "onClientRender", root, renderNotification );
		addEventHandler( "create > notification", root, createNotification );

		setup();
	end
);