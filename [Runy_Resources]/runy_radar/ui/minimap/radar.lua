local show_radar = false;
local radarShow = false

local function render( )
	if not radarShow then return end
	
	
	local position = { getElementPosition( localPlayer ) };
	
	dxSetRenderTarget( INTERFACE.Radar.render_targer, true );
	
	--dxDrawRectangle( 0, 0, INTERFACE.Radar.w, INTERFACE.Radar.h, tocolor( 94, 101, 107 ) );
	
	local map_size = INTERFACE.unit / ( 200 / 125 );
	local cx, cy, _, tx, ty = getCameraMatrix( );
	local north = findRotation( cx, cy, tx, ty );
	
	local map_x, map_y = -( reMap( position[ 1 ] + INTERFACE.unit, 0, 6000, 0, map_size ) - INTERFACE.Radar.w / 2 ), -( reMap( -position[ 2 ] + INTERFACE.unit, 0, 6000, 0, map_size ) - INTERFACE.Radar.h / 2 );
	
	dxDrawImage( map_x, map_y, map_size, map_size, map_texture, north, - map_size / 2 - map_x + INTERFACE.Radar.w / 2, - map_size / 2 - map_y + INTERFACE.Radar.h / 2, tocolor( 255, 255, 255 ) );
	
	for index, value in ipairs( INTERFACE.gps_lines ) do
		
		local NODE_X, NODE_Y = value.x, value.y;
		local w, h = 25, 25;
		
		local line_x, line_y, line_w, line_h = ( INTERFACE.unit + ( NODE_X - w + 10 ) ) / 6000 * map_size, ( INTERFACE.unit - ( NODE_Y - h ) ) / 6000 * map_size, w / 6000 * map_size, -( h / 6000 * map_size );
		
		line_x = line_x + map_x;
		line_y = line_y + map_y;
		
		dxSetBlendMode( "modulate_add" );
		
		dxDrawImage( line_x, line_y, line_w, line_h, "assets/minimap/radar_area.png", north, -line_w / 2 - line_x + INTERFACE.Radar.w / 2, -line_h / 2 - line_y + INTERFACE.Radar.h / 2, tocolor( 131, 112, 245 ) );
		
		dxSetBlendMode( "blend" );
		
	end
	
	for index, value in ipairs( getElementsByType( "radararea" ) ) do
		
		local area_pos = { getElementPosition( value ) };
		local w, h = getRadarAreaSize( value );
		local r, g, b, a = 255, 255, 255, 255;
		
		local area_x, area_y, area_w, area_h = ( INTERFACE.unit + area_pos[ 1 ] ) / 6000 * map_size, ( INTERFACE.unit - area_pos[ 2 ] ) / 6000 * map_size, w / 6000 * map_size, -( h / 6000 * map_size );
		
		area_x = area_x + map_x;
		area_y = area_y + map_y;
		
		r, g, b, a = getRadarAreaColor( value );
		
		if ( isRadarAreaFlashing( value ) ) then
			a = a * math.abs( getTickCount( ) % 1000 - 500 ) / 500;
		end
		
		dxSetBlendMode( "modulate_add" );
		
		dxDrawImage( area_x, area_y, area_w, area_h, "assets/minimap/radar_area.png", north, -area_w / 2 - area_x + INTERFACE.Radar.w / 2, -area_h / 2 - area_y + INTERFACE.Radar.h / 2, tocolor( r, g, b, a ) );
		
		dxSetBlendMode( "blend" );
		
	end
	
	for index, value in ipairs( getElementsByType( "blip" ) ) do
		
		local blip_pos = { getElementPosition( value ) };
		local blip_icon = getBlipIcon( value );
		local blip_x, blip_y = getRadarFromWorldPosition( blip_pos[ 1 ], blip_pos[ 2 ], -40, -40, INTERFACE.Radar.w + 80, INTERFACE.Radar.h + 80, map_size );
		local blip_color = { 255, 255, 255 };
		
		if ( blip_icon == 0 ) then
			blip_color = { getBlipColor( value ) };
		end
		
		if getElementData(value, 'safezone') then
			if getElementDimension(localPlayer) == (getElementData(value, 'dimension')) then
				local sizeSafe = getMarkerSize(getElementData(value, 'MarkerBliped'))
				local faseSafe = getElementData(value, 'fase')
				if sizeSafe then
					if faseSafe == 2 then
						if sizeSafe > 2737 then
							dxDrawImage( blip_x - ((2737 / 2.95)/ 2), blip_y - ((2737 / 2.95)/ 2), (2737 / 3), (2737 / 3), INTERFACE.blips[ blip_icon ], 0, 0, 0, tocolor( 100, 145, 255, 255 ) );
						end
					elseif faseSafe == 3 then
						if sizeSafe > 1972 then
							dxDrawImage( blip_x - ((1972 / 2.95)/ 2), blip_y - ((1972 / 2.95)/ 2), (1972 / 3), (1972 / 3), INTERFACE.blips[ blip_icon ], 0, 0, 0, tocolor( 100, 145, 255, 255 ) );
						end
					elseif faseSafe == 3 then
						if sizeSafe > 1204 then
							dxDrawImage( blip_x - ((1204 / 2.95)/ 2), blip_y - ((1204 / 2.95)/ 2), (1204 / 3), (1204 / 3), INTERFACE.blips[ blip_icon ], 0, 0, 0, tocolor( 100, 145, 255, 255 ) );
						end
					elseif faseSafe == 4 then
						if sizeSafe > 435 then
							dxDrawImage( blip_x - ((435 / 2.95)/ 2), blip_y - ((435 / 2.95)/ 2), (435 / 3), (435 / 3), INTERFACE.blips[ blip_icon ], 0, 0, 0, tocolor( 100, 145, 255, 255 ) );
						end
					end
					dxDrawImage( blip_x - ((sizeSafe / 2.95) / 2), blip_y - ((sizeSafe / 2.95) / 2), (sizeSafe / 2.95), (sizeSafe / 2.95), INTERFACE.blips[ blip_icon ], 0, 0, 0, tocolor( blip_color[ 1 ], blip_color[ 2 ], blip_color[ 3 ] ) );
				end
			end
		else
			if getElementData(value, 'dimension') then
				if getElementDimension(localPlayer) == (getElementData(value, 'dimension')) then
					dxDrawImage( blip_x - INTERFACE.blip_size / 2, blip_y - INTERFACE.blip_size / 2, INTERFACE.blip_size, INTERFACE.blip_size, INTERFACE.blips[ blip_icon ], 0, 0, 0, tocolor( blip_color[ 1 ], blip_color[ 2 ], blip_color[ 3 ] ) );
				end
			else
				dxDrawImage( blip_x - INTERFACE.blip_size / 2, blip_y - INTERFACE.blip_size / 2, INTERFACE.blip_size, INTERFACE.blip_size, INTERFACE.blips[ blip_icon ], 0, 0, 0, tocolor( blip_color[ 1 ], blip_color[ 2 ], blip_color[ 3 ] ) );
			end
		end
	end
	
	local blip_x, blip_y = ( INTERFACE.unit + position[ 1 ] ) / 6000 * map_size, ( INTERFACE.unit - position[ 2 ] ) / 6000 * map_size;
	
	blip_x = blip_x + map_x;
	blip_y = blip_y + map_y;
	
	dxDrawImage( blip_x - INTERFACE.blip_size / 2, blip_y - INTERFACE.blip_size / 2, INTERFACE.blip_size, INTERFACE.blip_size, arrow_player, north - getPedRotation( localPlayer ), 0, 0, tocolor( 255, 255, 255 ) );
	
	dxSetRenderTarget( );
	
	dxDrawRectangle( INTERFACE.Radar.x - 2, INTERFACE.Radar.y - 2, INTERFACE.Radar.w + 4, INTERFACE.Radar.h + 4, tocolor( 33, 33, 33, 40 ) );
	dxDrawImage( INTERFACE.Radar.x, INTERFACE.Radar.y, INTERFACE.Radar.w, INTERFACE.Radar.h, INTERFACE.Radar.render_targer, 0, 0, 0, tocolor( 255, 255, 255 ) );
	
	removePointMap( );
end

function setRadarVisible( bool )
	
	show_radar = not not bool;
	
	if ( show_radar ) then
		
		addEventHandler( "onClientRender", root, render );
		
	else
		
		removeEventHandler( "onClientRender", root, render );
		
	end
	
end

function getRadarVisible( )
	
	return show_radar;
	
end

function hideShowRadar()
	radarShow = false
end
addEvent("hideShowRadar", true)
addEventHandler("hideShowRadar", root, hideShowRadar)


function showShowRadar()
	radarShow = true
end
addEvent("showShowRadar", true)
addEventHandler("showShowRadar", root, showShowRadar)