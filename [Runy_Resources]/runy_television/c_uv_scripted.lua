--
-- c_uv_scripted.lua
--


local myShader
local startTickCount

addEventHandler( "onClientResourceStart", resourceRoot,
	function()

		-- Version check
		if getVersion ().sortable < "1.1.0" then
			outputChatBox( "Resource is not compatible with this client." )
			return
		end

		-- Create shader
		myShader, tec = dxCreateShader ( "uv_scripted.fx" )

		-- Create texture and add to shader
		local myTexture = dxCreateTexture ( "images/led.png" ); -- aqui você coloca o nome da sua textura que irá sobrepor a do jogo
		dxSetShaderValue ( myShader, "CUSTOMTEX0", myTexture );

		local myTexture = {	}

		if not myShader then
			outputDebugString('erro cod: myshader', 0, 255, 205, 129)
		else
			--outputChatBox( "Using technique " .. tec )

			-- Apply to world texture
			engineApplyShaderToWorldTexture ( myShader, "led" ) -- essa linha você coloca o nome da sua textura que será substituida no jogo para se mover

			-- Create object with model 4729 (billboard)
			--local x,y,z = getElementPosition( getLocalPlayer() )
			--createObject ( 4729, x-15, y, z+3 )

			-- Begin updates for UV animation
			startTickCount = getTickCount()
			addEventHandler( "onClientRender", root, updateUVs )
		end
	end
)


------------------------------------------------------
-- Update
------------------------------------------------------
function updateUVs()
	-- Valide shader to save bazillions of warnings
	if not isElement( myShader ) then return end

	-- Calc how many seconds have passed since uv anim started
	local secondsElapsed = ( getTickCount() - startTickCount ) / 1000

	-- Calc section (0-6) and time (0-1) within the section
	local timeLooped = ( secondsElapsed / 2 ) % 6
	local section = math.floor ( timeLooped )
	local time = timeLooped % 1

	-- Figure out what uv anims to do
	local bScrollRight = true -- Always scroll to the right

	local u,v = 0, 0
	local angle = 0
	local scale = 1

	-- Do uv anims
	if bScrollRight then
		u = time
	end

	-- Apply uv anims
	dxSetShaderValue ( myShader, "gUVPosition", u,v );
	dxSetShaderValue ( myShader, "gUVRotAngle", angle );
	dxSetShaderValue ( myShader, "gUVScale", scale, scale );
end
