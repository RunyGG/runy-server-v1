local blip_gps;

addEvent( "gps > insert_vehicle", true );
addEventHandler( "gps > insert_vehicle", root, 
	function( player, worldX, worldY, worldZ ) 

		local x, y, z = getElementPosition( player );

		if ( isElement( blip_gps ) ) then

			destroyElement( blip_gps );
			blip_gps = nil;

		end

		blip_gps = createBlip( worldX, worldY, 0, 1 );

		triggerClientEvent( player, "gps > insert_blip", player, x, y, z, worldX, worldY, worldZ );

	end
);

addEvent( "gps > remove_blip", true );
addEventHandler( "gps > remove_blip", root,
	function( player )

		if ( not isElement( player ) ) then

			return;

		end

		if ( isElement( blip_gps ) ) then

			destroyElement( blip_gps );
			blip_gps = nil;

		end

	end
);

function createNotification( player, text, type )

	if ( text ) then

		triggerClientEvent( player, "create > notification", player, text, tonumber( type ) );

	end

end

addEvent('Data:Marker', true)
addEventHandler('Data:Marker', root, function(player, cliente)
    triggerClientEvent(player, 'Data:LoadMarker', player, 150, cliente)
end)