addEvent( "create > notification", true );

local notification = { };

local end_timer = 15000;

function renderNotification( )

	local PANEL_WIDTH = INTERFACE.Radar.w + 4;
	local POS_X = INTERFACE.Radar.x - 2;
	local POS_Y = screen[ 2 ] - ( 42 );

	if ( getRadarVisible( ) and isPedInVehicle( localPlayer ) ) then

		POS_Y = POS_Y - ( INTERFACE.Radar.h + 5 );

	end

	for i=#notification, 1, -1 do

		local v = notification[ i ];

		if ( v ) then

			local _, text_height = dxGetTextSize( v.text, PANEL_WIDTH, 1, main_font_interface, true );

			v.horizontal_align = "center";

			if ( utf8.len( v.text ) >= 40 ) then

				v.horizontal_align = "left";

			end

			if ( v.elapsed ) then

				v.fade_alpha = v.fade_alpha + 5;

				if ( v.fade_alpha > 255 ) then

					v.fade_alpha = 255;

				end

			else

				v.fade_alpha = v.fade_alpha - 5;

				if ( v.fade_alpha < 0 ) then

					v.fade_alpha = 0;

				end

			end

			POS_Y = POS_Y - text_height;

			local icon = INTERFACE_UTILS.NOTIFICATION_TYPES[ v.type ][ 4 ];

			drawRectangleAndIcon( icon, POS_X, POS_Y, PANEL_WIDTH, INTERFACE.Radar.x + text_height, { v.color[ 1 ], v.color[ 2 ], v.color[ 3 ], v.fade_alpha }, true );
			dxDrawText( utf8.gsub( v.text, "#%x%x%x%x%x%x", "" ), POS_X + 50, POS_Y + 10, POS_X + PANEL_WIDTH - 10, POS_Y + INTERFACE.Radar.x, tocolor( 255, 255, 255, v.fade_alpha ), 1, main_font_interface, "left", "top", false, true, true );

			POS_Y = POS_Y - 11 * 2;

			if ( getTickCount( ) - v.tick >= end_timer ) then

				v.elapsed = false;

				if ( v.fade_alpha == 0 ) then

					table.remove( notification, i );

				end

			end

		end

	end

end

function createNotification( text, type )

	if ( text ) then

		local data = { };

		data.text = text;
		data.type = type or 2;
		data.color = INTERFACE_UTILS.NOTIFICATION_TYPES[ data.type ];

		data.fade_alpha = 0;
		data.elapsed = true;

		data.tick = getTickCount( );
		data.horizontal_align = "center";

		if ( data ) then

			table.insert( notification, data );

		end

	end

end

function drawRectangleAndIcon( icon, x, y, width, height, color, postGUI )

	dxDrawRectangle( x, y, width, height, tocolor( 55, 55, 55, color[ 4 ] / 1.15 ), postGUI );
	dxDrawRectangle( x, y, 40, height, tocolor( color[ 1 ], color[ 2 ], color[ 3 ], color[ 4 ] ), postGUI );
	dxDrawImage( x + 10, y + 8, 20, 20, "assets/notification/icon-" .. icon .. ".png", 0, 0, 0, tocolor( 255, 255, 255, color[ 4 ] ), postGUI );

end

_dxGetTextSize = dxGetTextSize;
function dxGetTextSize( ... )
	local w, h = _dxGetTextSize( ... );
	if ( type( w ) == "table" ) then
		return w[ 1 ], w[ 2 ];
	end
	return w, h;
end