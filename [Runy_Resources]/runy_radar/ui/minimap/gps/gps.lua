addEvent( "gps > insert_blip", true );

local show_gps = false;

local zoom = 1.5;
local target_zoom = zoom;

local min_zoom = 1;
local max_zoom = 5;
local radio_zoom = 3;

local off_pos = { 0, 0 };
local off_set_pos = { 0, 0 };

local scroll_blips = 0;
local max_blips_view = 10;

local blip_gps;

function setupGPS( )
	
	addEventHandler( "onClientKey", root, toggleGPSKey );
	addEventHandler( "gps > insert_blip", root, checkCoords );
	
end

local function render( )
	
	if ( not show_gps or not INTERFACE_UTILS.SHOW ) then
		
		return;
		
	end
	
	if ( off_set_pos[ 1 ] ~= 0 or off_set_pos[ 2 ] ~= 0 ) then
		
		local cursor = { getCursorPosition( ) };
		
		if ( cursor[ 1 ] and cursor[ 2 ] ) then
			
			cursor[ 1 ], cursor[ 2 ] = cursor[ 1 ] * screen[ 1 ], cursor[ 2 ] * screen[ 2 ];
			
			off_pos = { cursor[ 1 ] - off_set_pos[ 1 ], cursor[ 2 ] - off_set_pos[ 2 ] };
			off_pos = { math.max( math.min( -off_pos[ 1 ], 6000 ), -6000 ), math.max( math.min( off_pos[ 2 ], 6000 ), -6000 ) };
			
		end
		
	end
	
	local position = { getElementPosition( localPlayer ) };
	local rot = getPedRotation( localPlayer );
	
	position[ 1 ], position[ 2 ] = position[ 1 ] + off_pos[ 1 ], position[ 2 ] + off_pos[ 2 ];
	
	local MAP_SIZE = 3072;
	local map_x, map_y, map_w, map_h = ( ( ( INTERFACE.unit ) + position[ 1 ] ) / ( 6000 ) * ( MAP_SIZE ) ) - ( ( INTERFACE.GPS.w / 2 ) * zoom ), ( ( INTERFACE.unit - position[ 2 ] ) / ( 6000 ) * MAP_SIZE ) - ( ( INTERFACE.GPS.h / 2 ) * zoom ), INTERFACE.GPS.w * zoom, INTERFACE.GPS.h * zoom
	local off_pos_x, off_pos_y = 0, 0;
	
	if ( map_y + ( INTERFACE.GPS.h * zoom ) >= MAP_SIZE ) then
		
		off_pos_y = MAP_SIZE - ( map_y + ( INTERFACE.GPS.h * zoom ) );
		
	end
	
	if ( map_y <= 0 ) then
		
		off_pos_y = 0 - map_y;
		
	end
	
	if ( map_x + ( INTERFACE.GPS.w * zoom ) >= MAP_SIZE ) then
		
		off_pos_x = MAP_SIZE - ( map_x + ( INTERFACE.GPS.w * zoom ) );
		
	end
	
	if ( map_x <= 0 ) then
		
		off_pos_x = 0 - map_x;
		
	end
	
	dxDrawRectangle( INTERFACE.GPS.x, INTERFACE.GPS.y, INTERFACE.GPS.w, INTERFACE.GPS.h, tocolor( 0, 0, 0, 150 ) );
	
	dxSetRenderTarget( INTERFACE.GPS.render_targer, true );
	
	dxDrawImageSection( ( off_pos_x / zoom ), ( off_pos_y / zoom ), INTERFACE.GPS.w, INTERFACE.GPS.h, map_x + off_pos_x, map_y + off_pos_y, map_w, map_h, map_texture, 0, 0, 0, tocolor( 255, 255, 255 ) );
	
	local line_x, line_y = nil, nil;
	
	for index, value in ipairs( INTERFACE.gps_lines ) do
		
		local x, y = value.x, value.y;
		
		local node_x = ( ( ( ( ( INTERFACE.unit ) + x ) / ( 6000 ) * ( MAP_SIZE ) ) - ( ( INTERFACE.GPS.w / 2 ) * zoom ) - map_x ) + ( ( INTERFACE.GPS.w / 2 ) * zoom ) ) / zoom;
		local node_y = ( ( ( ( INTERFACE.unit - y ) / ( 6000 ) *  MAP_SIZE ) - ( (  INTERFACE.GPS.h / 2 ) * zoom ) - map_y ) + ( ( INTERFACE.GPS.h / 2 ) * zoom ) ) / zoom;
		
		if ( line_x and line_y ) then
			
			dxDrawLine( line_x, line_y, node_x, node_y, tocolor( 131, 112, 245 ), 10 );
			
			line_x, line_y = node_x, node_y;
			
		else
			
			line_x, line_y = node_x, node_y;
			
		end
		
	end
	
	for index, value in ipairs( getElementsByType( "radararea" ) ) do
		
		local x, y = getRadarAreaSize( value );
		local size = 2;
		
		x = x / size;
		y = y / size;
		
		local position = { getElementPosition( value ) };
		local blip_x = ( ( ( ( ( INTERFACE.unit ) + position[ 1 ] ) / ( 6000 ) * ( MAP_SIZE ) ) - ( ( INTERFACE.GPS.w / 2 ) * zoom ) - map_x ) + ( ( INTERFACE.GPS.w / 2 ) * zoom ) ) / zoom;
		local blip_y = ( ( ( ( INTERFACE.unit - position[ 2 ] ) / ( 6000 ) * MAP_SIZE ) - ( ( INTERFACE.GPS.h / 2 ) * zoom ) - map_y ) + ( ( INTERFACE.GPS.h / 2 ) * zoom ) ) / zoom;
		local r, g, b, a = 255, 255, 255, 255;
		
		
		r, g, b, a = getRadarAreaColor( value );
		
		if ( isRadarAreaFlashing( value ) ) then
			
			a = a * math.abs( getTickCount( ) % 1000 - 500 ) / 500;
			
		end
		
		dxDrawRectangle( blip_x - x / size + x / 1.8, blip_y - y / size - y / 1.8, x, y, tocolor( r, g, b, a ) );
		
	end
	
	local position = { getElementPosition( localPlayer ) };
	local blip_x = ( ( ( ( ( INTERFACE.unit ) + position[ 1 ] ) / ( 6000 ) * ( MAP_SIZE ) ) - ( ( INTERFACE.GPS.w / 2 ) * zoom ) - map_x ) + ( ( INTERFACE.GPS.w / 2 ) * zoom ) ) / zoom;
	local blip_y = ( ( ( ( INTERFACE.unit - position[ 2 ] ) / ( 6000 ) * MAP_SIZE ) - ( ( INTERFACE.GPS.h / 2 ) * zoom ) - map_y ) + ( ( INTERFACE.GPS.h / 2 ) * zoom ) ) / zoom;
	
	for index, value in ipairs( getElementsByType( "blip" ) ) do
		
		local blip_icon = getBlipIcon( value );
		local x, y = getElementPosition( value );
		local blip_name = getElementData( value, "blip > name" ) or "?";
		
		local blip_x = ( ( ( ( ( INTERFACE.unit ) + x ) / ( 6000 ) * ( MAP_SIZE ) ) - ( ( INTERFACE.GPS.w / 2 ) * zoom ) - map_x ) + ( ( INTERFACE.GPS.w / 2 ) * zoom ) ) / zoom;
		local blip_y = ( ( ( ( INTERFACE.unit - y) / ( 6000 ) * MAP_SIZE ) - ( ( x / 2 ) * zoom ) - map_y ) + ( ( x / 2 ) * zoom ) ) / zoom;
		
		local blip_color = { 255, 255, 255 };
		
		if ( blip_icon == 0 ) then
			
			blip_color = { getBlipColor( value ) };
			
		end
		
		if (INTERFACE.blips[ blip_icon ] ~= nil) then
			if getElementData(value, 'safezone') then
				
				if getElementDimension(localPlayer) == getElementData(value, 'dimension') then
					local sizeSafe = getMarkerSize(getElementData(value, 'MarkerBliped'))
					local faseSafe = getElementData(value, 'fase')
			--		iprint(sizeSafe, faseSafe)
					if sizeSafe then
						
						if faseSafe == 2 then
							if sizeSafe > 3319 then
								dxDrawImage( blip_x - ((3319 / 2.95)/ 2), blip_y - ((3319 / 2.95)/ 2), (3319 / 3), (3319 / 3), INTERFACE.blips[ blip_icon ], 0, 0, 0, tocolor( 100, 145, 255, 255 ) );
							end
						elseif faseSafe == 3 then
							if sizeSafe > 2581 then
								dxDrawImage( blip_x - ((2581 / 2.95)/ 2), blip_y - ((2581 / 2.95)/ 2), (2581 / 3), (2581 / 3), INTERFACE.blips[ blip_icon ], 0, 0, 0, tocolor( 100, 145, 255, 255 ) );
							end
						elseif faseSafe == 3 then
							if sizeSafe > 1204 then
								dxDrawImage( blip_x - ((1204 / 2.95)/ 2), blip_y - ((1204 / 2.95)/ 2), (1204 / 3), (1204 / 3), INTERFACE.blips[ blip_icon ], 0, 0, 0, tocolor( 100, 145, 255, 255 ) );
							end
						elseif faseSafe == 4 then
							if sizeSafe > 1802 then
								dxDrawImage( blip_x - ((1802 / 2.95)/ 2), blip_y - ((1802 / 2.95)/ 2), (1802 / 3), (1802 / 3), INTERFACE.blips[ blip_icon ], 0, 0, 0, tocolor( 100, 145, 255, 255 ) );
							end
						end
						dxDrawImage( blip_x - (sizeSafe / 2.69) / 2, blip_y - (sizeSafe / 2.69) / 2, (sizeSafe / 2.69), (sizeSafe / 2.69), INTERFACE.blips[ blip_icon ], 0, 0, 0, tocolor( blip_color[ 1 ], blip_color[ 2 ], blip_color[ 3 ] ) );
					end
				end
			else
				if getElementData(value, 'dimension') then
					if getElementDimension(localPlayer) == getElementData(value, 'dimension') then
						dxDrawImage( blip_x - INTERFACE.blip_size / 2, blip_y - INTERFACE.blip_size / 2, INTERFACE.blip_size, INTERFACE.blip_size, INTERFACE.blips[ blip_icon ], 0, 0, 0, tocolor( blip_color[ 1 ], blip_color[ 2 ], blip_color[ 3 ] ) );
					end
				else
					dxDrawImage( blip_x - INTERFACE.blip_size / 2, blip_y - INTERFACE.blip_size / 2, INTERFACE.blip_size, INTERFACE.blip_size, INTERFACE.blips[ blip_icon ], 0, 0, 0, tocolor( blip_color[ 1 ], blip_color[ 2 ], blip_color[ 3 ] ) );
				end
			end
		end
	end
	
	dxDrawImage( blip_x - INTERFACE.blip_size / 2, blip_y - INTERFACE.blip_size / 2, INTERFACE.blip_size, INTERFACE.blip_size, arrow_player, -rot, 0, 0, tocolor( 255, 255, 255 ) );
	
	dxSetRenderTarget( );
	
	dxDrawImage( INTERFACE.GPS.x, INTERFACE.GPS.y, INTERFACE.GPS.w, INTERFACE.GPS.h, INTERFACE.GPS.render_targer );
	
	local ammount = 0;
	
	for k, v in pairs( INTERFACE_UTILS.BLIPS ) do
		
		if ( k > scroll_blips and ammount < max_blips_view ) then
			
			ammount = ammount + 1;
			
			local text_width = dxGetTextWidth( v.name, 1, main_font_interface );
			
			dxDrawRectangle( screen[ 1 ] - ( text_width + 70 ), INTERFACE.GPS.y + 31 * ammount - 15, text_width + 50, 30, tocolor( 33, 33, 33, 200 ) )
			dxDrawImage( math.floor( screen[ 1 ] - 50 ), math.floor( INTERFACE.GPS.y + 31 * ammount - 15 ), 30, 30, INTERFACE.blips[ k ] );
			dxDrawText( v.name, INTERFACE.GPS.x, INTERFACE.GPS.y + 31 * ammount + 5 - 14, INTERFACE.GPS.w - 60, 0, tocolor( 233, 233, 233 ), 1, main_font_interface, "right", "top" );
			
		end
		
	end
	
end

local function click( b, s, x, y )
	
	if ( show_gps ) then
		
		if ( b == "right" ) then
			
			if ( s == "down" ) then
				
				if ( x > INTERFACE.GPS.x and x < INTERFACE.GPS.x + INTERFACE.GPS.w and y > INTERFACE.GPS.y and y < INTERFACE.GPS.y + INTERFACE.GPS.h ) then
					
					if ( table.maxn( INTERFACE.gps_lines ) == 0 ) then
						
						local blip_x, blip_y, coords = calculatePathCoords( x, y );
						
						if ( not coords ) then
							
							return;
							
						end
						
						INTERFACE.gps_lines = { };
						
						for index, value in ipairs( coords ) do
							
							table.insert( INTERFACE.gps_lines, { x = value.x, y = value.y, id = index } );
							
						end
						
						if ( getPedOccupiedVehicle( localPlayer ) ) then
							
							for seat, occupant in pairs( getVehicleOccupants( getPedOccupiedVehicle( localPlayer ) ) ) do
								
								triggerServerEvent( "gps > insert_vehicle", occupant, occupant, blip_x, blip_y, kz );
								
							end
							
						end
						
						blip_gps = createBlip( blip_x, blip_y, 0, 1, 0, 0, 0 );
						
					else
						
						INTERFACE.gps_lines = { };
						
						if ( blip_gps ) then
							
							destroyElement( blip_gps );
							blip_gps = nil;
							
						end
						
						triggerServerEvent( "gps > remove_blip", localPlayer, localPlayer );
						
					end
					
				end
				
			end
			
		elseif ( b == "left" ) then
			
			if ( s == "down" ) then
				
				off_set_pos = { x + off_pos[ 1 ], y - off_pos[ 2 ] };
				
			end
			
			if ( s == "up" ) then
				
				off_set_pos = { 0, 0 };
				
			end
			
		end
		
	end
	
end

local function mouseWheel( w )
	
	if ( not show_gps ) then
		
		return;
		
	end
	
	if ( w == 1 ) then
		
		if ( zoom < max_zoom ) then
			
			zoom = zoom + radio_zoom;
			
		end
		
	elseif ( w == -1 ) then
		
		if ( zoom > min_zoom ) then
			
			zoom = zoom - radio_zoom;
			
		end
		
	end
	
end

local function bigmapZoomHandler( timeSlice )
	
	zoom = zoom + ( target_zoom - zoom ) * timeSlice * 0.010;
	
end

function toggleGPSKey( k, p )
	
	if ( k == "'" and p ) then
		if not getElementData(localPlayer, 'battleRoyaleRunning') then toggleControl('radar', false) return end

		toggleGPS( );
		cancelEvent( );
		
		
	end
	
end

function toggleGPS( )
	
	if ( not INTERFACE_UTILS.SHOW ) then
		
		return;
		
	end
	
	if ( show_gps ) then
		
		show_gps = false;
		
		removeEventHandler( "onClientMouseWheel", root, mouseWheel );
		removeEventHandler( "onClientPreRender", root, bigmapZoomHandler );
		removeEventHandler( "onClientRender", root, render );
		removeEventHandler( "onClientClick", root, click );
		
	else
		
		show_gps = not show_gps;
		off_pos = { 0, 0 };
		
		addEventHandler( "onClientMouseWheel", root, mouseWheel );
		addEventHandler( "onClientPreRender", root, bigmapZoomHandler );
		addEventHandler( "onClientRender", root, render );
		addEventHandler( "onClientClick", root, click );
		
	end
	
	showCursor( show_gps, false );
	
end

function checkCoords( x, y, z, hx, hy, hz )
	
	local check = calculatePathByCoords( x, y, z, hx, hy, hu );
	
	INTERFACE.gps_lines = { };
	
	for index, value in ipairs( check ) do
		
		table.insert( INTERFACE.gps_lines, { x = value.x, y = value.y, id = index } );
		
	end
	
	return check;
	
end

function removePointMap( )
	
	for index, value in ipairs( INTERFACE.gps_lines ) do
		
		local x, y = getElementPosition( localPlayer );
		
		if ( getDistanceBetweenPoints2D( x, y, value.x, value.y ) < 20 ) then
			
			table.remove( INTERFACE.gps_lines, index );
			
			for k, v in ipairs( INTERFACE.gps_lines ) do 
				
				if ( v.id < value.id ) then
					
					table.remove( INTERFACE.gps_lines, k );
					
				end
				
			end
			
			if ( table.maxn( INTERFACE.gps_lines ) == 0 ) then
				
				if ( blip_gps ) then
					
					destroyElement( blip_gps );
					blip_gps = nil;
					
				end
				
			end
			
		end
		
	end
	
end

local marked_location = {}
local marker_timer = {}

function drawMarkedLocation()
	if not marked_location[localPlayer] then return end
	for index, variavel in pairs(marked_location[localPlayer]) do
		local x, y, z = variavel.x, variavel.y, variavel.z
		local distance = getDistanceBetweenPoints3D(x, y, z, getElementPosition(localPlayer))
		
		if distance < 1000 then
			local screen_x, screen_y = getScreenFromWorldPosition(x, y, z)
			if screen_x and screen_y then
				dxDrawImage(screen_x - 12, screen_y - 5, 21, 25, "assets/minimap/blip_location-byfn.png", 0, 0, 0, variavel.color)
				dxDrawText(string.format("%.0fm", distance), screen_x - 50, screen_y + 25, screen_x + 50, screen_y + 50, tocolor(211, 211, 211), 1.0, "default-bold", "center", "top", false, false, false, true)
			end
		end
	end
end

function markLocation(x, y, z, player)
	if not marked_location[localPlayer] then 
		marked_location[localPlayer] = {}
	end
	if #marked_location[localPlayer] > 1 then
		table.remove(marked_location[localPlayer], 1)
	end
	table.insert( marked_location[localPlayer], {x = x, y = y, z = z, color = (getElementData(player, 'groupOwner') and tocolor(108, 40, 217, 200) or tocolor(255, 40, 60, 200))})
	
	if marker_timer[#marked_location[localPlayer]] and isTimer(marker_timer[#marked_location[localPlayer]]) then
		killTimer(marker_timer[#marked_location[localPlayer]])
	end
	
	marker_timer[#marked_location[localPlayer]] = setTimer(function()
		table.remove(marked_location[localPlayer], 1)
	end, 60000, 1)
end

function markLocationInFrontOfPlayer(distance, player)
	local px, py, pz = getElementPosition(player)
	local cameraX, cameraY, cameraZ, lookAtX, lookAtY, lookAtZ = getCameraMatrix()
	
	local startX, startY, startZ = getPedWeaponMuzzlePosition(player)
	local targetX, targetY, targetZ
	
	if getPedControlState(player, "aim_weapon") then
		targetX, targetY, targetZ = getPedTargetEnd(player)
	else
		local lookVectorX, lookVectorY, lookVectorZ = lookAtX - cameraX, lookAtY - cameraY, lookAtZ - cameraZ
		local length = math.sqrt(lookVectorX * lookVectorX + lookVectorY * lookVectorY + lookVectorZ * lookVectorZ)
		
		if length ~= 0 then
			lookVectorX = lookVectorX / length
			lookVectorY = lookVectorY / length
			lookVectorZ = lookVectorZ / length
		else
			lookVectorX, lookVectorY, lookVectorZ = 0, 0, 0
		end
		
		targetX = cameraX + lookVectorX * distance
		targetY = cameraY + lookVectorY * distance
		targetZ = cameraZ + lookVectorZ * distance
	end
	
	local hit, hitX, hitY, hitZ, hitElement = processLineOfSight(startX, startY, startZ, targetX, targetY, targetZ, true, false, false, true, false, false, false, false, player)
	
	if hit then
		targetX, targetY, targetZ = hitX, hitY, hitZ
	end
	
	markLocation(targetX, targetY, targetZ, player)
end

addEventHandler("onClientRender", root, drawMarkedLocation)

function calculatePathCoords(x, y)
	local player_x, player_y = getElementPosition(localPlayer)
	player_x, player_y = player_x + off_pos[1], player_y + off_pos[2]
	
	local map_size = 3072
	
	local line_x, line_y, line_z = getElementPosition(localPlayer)
	local blip_x = player_x + (((x - INTERFACE.GPS.x) - (INTERFACE.GPS.w / 2)) * 2 * zoom)
	local blip_y = player_y - (((y - INTERFACE.GPS.y) - (INTERFACE.GPS.h / 2)) * 2 * zoom)
	local coords = calculatePathByCoords(line_x, line_y, line_z, blip_x, blip_y, 0)
	
	markLocation(blip_x, blip_y, 10)
	
	return blip_x, blip_y, coords
end

function setLocationGPS(element, x, y)
	local position = { getElementPosition(localPlayer) }
	local line = { getElementPosition(element) }
	markLocation(position[1], position[2], position[3] + 10)
	
	local node_x = line[1] + (x - line[1])
	local node_y = line[2] - (y - line[2])
	
	local coords = calculatePathByCoords(position[1], position[2], position[3], node_x, node_y, 0)
	
	if (line[1] and line[2]) then
		if (#INTERFACE.gps_lines == 0) then
			INTERFACE.gps_lines = {}
			
			for index, value in ipairs(coords) do
				table.insert(INTERFACE.gps_lines, { x = value.x, y = value.y, id = index })
			end
		end
	end
end

function hasTableToLocation()
	if (#INTERFACE.gps_lines ~= 0) then
		INTERFACE.gps_lines = {}
	end
end

addEventHandler("onClientKey", root, function(button, state)
	if getElementData(localPlayer, "battleRoyaleRunning") then
		if (button == 'Q' or button == 'q') and state then
			local time = getElementData(localPlayer, 'myDuo')
			if time then
				if getElementData(time, "battleRoyaleRunning") then
					triggerServerEvent('Data:Marker', localPlayer, time, localPlayer)
					markLocationInFrontOfPlayer(150, localPlayer)
				end
			else
				markLocationInFrontOfPlayer(150, localPlayer)
			end
		end
	end
end)

addEvent('Data:LoadMarker', true)
addEventHandler('Data:LoadMarker', root, function(distance, player)
	markLocationInFrontOfPlayer(distance, player)
end)