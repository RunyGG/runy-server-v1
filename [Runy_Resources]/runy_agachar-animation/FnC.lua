local customBlockName = "animAgachar"
local IFP = engineLoadIFP( "assets/jsdajdsajdjsadjsajdsajdjsadjsajdasj.ifp", customBlockName )
if not IFP then
    print("Failed to load: 'assets/jsdajdsajdjsadjsajdsajdjsadjsajdasj.ifp'")
else
    print("Animação carregada com sucesso: 'assets/jsdajdsajdjsadjsajdsajdjsadjsajdasj.ifp'")
end
engineReplaceAnimation( localPlayer, "ped", "WEAPON_crouch", customBlockName, "WEAPON_crouch" )
engineReplaceAnimation( localPlayer, "ped", "GunCrouchFwd", customBlockName, "GunCrouchFwd" )