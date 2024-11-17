local refScreenWidth, refScreenHeight = 1366, 768
local sW, sH = guiGetScreenSize()
local screenWidth, screenHeight = guiGetScreenSize()
local scaleX, scaleY = screenWidth / refScreenWidth, screenHeight / refScreenHeight

local hudArma = false

local fonts = {
   font2 = dxCreateFont("files/font2.ttf", 12 * scaleX)
}

local weaponNames = {
    [29] = "MP5",
    [23] = "FIVE",
    [31] = "M4A1",
    [30] = "G36c",
    [46] = "PARACHUTE",
    [32] = "TEC-9",
    [4] = "FACA",
    [0] = "FIST",
}

local weaponImageSizes = {
    [29] = {width = 86, height = 29},
    [23] = {width = 43, height = 30},
    [31] = {width = 55, height = 19.74},
    [30] = {width = 55, height = 20.46},
    [4] = {width = 55, height = 11.99},
    [32] = {width = 45, height = 23.74},
    [46] = {width = 20, height = 26.15},
    [0] = {width = 20, height = 20},
}

local weaponImagePositions = {
    [29] = {x = 1289, y = 621},
    [23] = {x = 1268, y = 621},
    [31] = {x = 1246, y = 583},
    [30] = {x = 1245, y = 581},
    [32] = {x = 1252, y = 581},
    [46] = {x = 1263, y = 579},
    [4] = {x = 1249, y = 586},
    [0] = {x = 1265, y = 582},
}

local weaponImages = {}

for weaponID, weaponName in pairs(weaponNames) do
    local imagePath = "files/" .. weaponID .. ".png"
    weaponImages[weaponID] = dxCreateTexture(imagePath)
end

function drawWeaponAndAmmo()
    if not hudArma then return end
    local weapon = getPedWeapon(localPlayer)
    local ammoInClip = getPedAmmoInClip(localPlayer)
    local totalAmmo = getPedTotalAmmo(localPlayer)

    local weaponImageSize = weaponImageSizes[weapon]
    local weaponImageWidth, weaponImageHeight
    if weaponImageSize then
        weaponImageWidth, weaponImageHeight = weaponImageSize.width * scaleX, weaponImageSize.height * scaleY
    end

    local weaponImagePosition = weaponImagePositions[weapon]
    local weaponImageX, weaponImageY
    if weaponImagePosition then
        weaponImageX, weaponImageY = weaponImagePosition.x * scaleX, weaponImagePosition.y * scaleY
    end

    local textWeapon = localPlayer:getData('cweapon') or "Desconhecida"
    local textAmmo = ammoInClip .. "/#908F8E" .. (totalAmmo - ammoInClip)

    local ammoX, ammoY = (1235) * scaleX, (604.5) * scaleY

    dxDrawImage(sW * (1182/1366), sH * (603/768), sW * (126/1366), sH * (57/768), "files/fundo.png", 0, 0, 0, tocolor(255, 255, 255), false)
    dxDrawImage(sW * (1222/1366), sH * (608.5/768), sW * (9/1366), sH * (11.25/768), "files/muni_bg.png", 0, 0, 0, tocolor(255, 255, 255), false)

    dxDrawText(textAmmo, ammoX, ammoY, screenWidth, screenHeight, tocolor(255, 255, 255, 255), 1, fonts.font2, "left", "top", false, false, false, true, false)

    local weaponImage = textWeapon
    if weaponImage and weaponImageSize and weaponImagePosition then
        if fileExists( "files/"..weaponImage..".png" ) then
            dxDrawImage(sW * (1183/1366), sH * (603/768), sW * (126/1366), sH * (57/768), "files/"..weaponImage..".png", 0, 0, 0, tocolor(255, 255, 255), true)
        end
    else
        dxDrawImage(sW * (1183/1366), sH * (603/768), sW * (126/1366), sH * (57/768), "files/0.png", 0, 0, 0, tocolor(255, 255, 255), true)
    end
end

addEventHandler("onClientRender", root, drawWeaponAndAmmo)

function hideHudArma()
    hudArma = false
end
addEvent("hideHudArma", true)
addEventHandler("hideHudArma", root, hideHudArma)


function showHudArma()
    hudArma = true
end
addEvent("showHudArma", true)
addEventHandler("showHudArma", root, showHudArma)
