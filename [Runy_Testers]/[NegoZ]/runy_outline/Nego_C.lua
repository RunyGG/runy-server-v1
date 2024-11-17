screenX, screenY = guiGetScreenSize()
local cor = {109 /255, 40 /255, 217 /255, 1} -- SEMPRE DEIXAR O /255
local forca = 0.1
local effectMaxDistance = 8
local Aurora = true

local nx, ny = guiGetScreenSize ()
local efeitoON = nil
local Render = nil
local NegoShader = nil
local TipoEnabled = false
local outlineEffect = {}
local Atualizacao = 110

function enableOutline(Tipo)
	if Tipo == true and Aurora then 
		Render = dxCreateRenderTarget(nx, ny, true)
		NegoShader = dxCreateShader("files/fx/edge.fx")
		if not Render or not NegoShader then 
			TipoEnabled = false
			return
		else
			dxSetShaderValue(NegoShader, "sTex0", Render)
			dxSetShaderValue(NegoShader, "sRes", nx, ny)
			TipoEnabled = true
		end
	else
		TipoEnabled = false
		disableOutline()
	end
	pwEffectEnabled = true
end

function disableOutline()
	if isElement(Render) then
		destroyElement(Render)
	end
	if isElement(NegoShader) then
		destroyElement(NegoShader)
	end
	
	Render = nil
	NegoShader = nil
end

function createElementOutlineEffect(element, Tipo)
	if Tipo == false then
		destroyElementOutlineEffect(element)
	else
		if getElementAlpha(element) < 255 then
			return
		end
		if not Render or not NegoShader then
			enableOutline(Tipo)
		end
		efeitoON = true
		if not outlineEffect[element] then
			if Tipo then 
				outlineEffect[element] = dxCreateShader("files/fx/wall_mrt.fx", 1, 0, true, "all")
			else
				outlineEffect[element] = dxCreateShader("files/fx/wall.fx", 1, 0, true, "all")
			end
			if not outlineEffect[element] then return false
			else
				if Render then
					dxSetShaderValue (outlineEffect[element], "secondRT", Render)
				end
				dxSetShaderValue(outlineEffect[element], "sColorizePed",cor)
				dxSetShaderValue(outlineEffect[element], "sSpecularPower",forca)
				engineApplyShaderToWorldTexture ( outlineEffect[element], "*" , element )
				engineRemoveShaderFromWorldTexture(outlineEffect[element],"muzzle_texture*", element)
				if not Tipo then
					if getElementAlpha(element) == 255 then setElementAlpha(element, 254) end
				end
				setTimer(function() destroyElementOutlineEffect(element) end, 35000, 1)
				return true
			end
		end
	end
end
addEvent("outlineobject", true)
addEventHandler("outlineobject", root, createElementOutlineEffect)

function destroyElementOutlineEffect(element)
	if outlineEffect[element] then
		destroyElement(outlineEffect[element])
		outlineEffect[element] = nil
		disableOutline()
	end
end

addEventHandler( "onClientPreRender", root,
function()
	if not pwEffectEnabled or not TipoEnabled or not efeitoON then return end
	dxSetRenderTarget( Render, true )
	dxSetRenderTarget()
end, true, "high" )

addEventHandler( "onClientHUDRender", root,
function()
	if not pwEffectEnabled or not TipoEnabled or not efeitoON or not NegoShader then return end
	dxDrawImage( 0, 0, nx, ny, NegoShader )
end)

addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()),
function()
	local Tipo = false
	if dxGetStatus().VideoCardNumRenderTargets > 1 then 
		Tipo = true 
	end
end)

function switchOutline(pwOn, Tipo)
	if pwOn then
		if Tipo == false then
			disableOutline()
		else
			enableOutline(Tipo)
		end
	else
		disableOutline()
	end
end
addEvent("switchOutline", true)
addEventHandler("switchOutline", resourceRoot, switchOutline)