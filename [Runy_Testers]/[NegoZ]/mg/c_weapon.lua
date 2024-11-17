-- {Arma, idObjeto},
armas = {  
  {"m4", 50000},
  {"imbel", 50001},
  {"g36c", 50002},
  {"ak", 50003},
  {"m240", 50004},
  {"five", 50005},
  {"glock", 50006},
  {"magnum", 50007},
  {"thompson", 50008},
  {"mp5", 50009},
  {"skorpion", 50010},
  {"vector", 50011},
  {"bazooka", 50012},
  {"escopeta", 50013},
  {"revolver", 50014},
  {"p90", 50015},
  {"machine1", 50016},
  {"kar98", 50025},
}

if not customSound then
  customSound = true
end

function soundCustom(both)
    customSound = both
    setWorldSoundEnabled ( 5, both )
end

depth = 0
weapsIDs = {347, 348, 352, 353, 372, 355, 356, 357, 349, 359, 346, 341, 371, 335}
for i,v in pairs(weapsIDs)do
  txd = engineLoadTXD("models/None.txd",v)
  engineImportTXD(txd,v)
  dff = engineLoadDFF("models/None.dff",v)
  engineReplaceModel(dff,v)
  if not customSound then end
  setWorldSoundEnabled ( 5, false )
end

function PlaySound2(ID, ammo, ammoInClip, hitX, hitY, hitZ, hitElement, startX, startY, startZ)
  if not customSound then return end
  if not startX then
    startX, startY, startZ = getElementPosition(source)
  end
  local dim = getElementDimension(source)
  wpn1 = getElementData(source,"cweapon")
  x,y,z = getPedWeaponMuzzlePosition(source)
  if (not hitElement) then
    local dist = getDistanceBetweenPoints3D(startX, startY, startZ, hitX, hitY, hitZ)
    if dist < 80 and dist > 1 then
      if math.random(1,5) <= 3 then
        local rd = math.random(1,6)
        local sfx = playSound3D("Sounds/bullet/bullet"..rd..".wav", hitX, hitY, hitZ, false)
        setSoundVolume( sfx, 0.8 )
        setElementDimension(sfx, dim)
        setSoundMaxDistance(sfx, 10)
        
      end
    end
  end
  for _,weap in pairs(armas)do
    soundName = weap[1]:gsub(' ','')
    if wpn1 == weap[1] then
      if getElementData(source, 'attached_'..wpn1) and removeHex(getElementData(source, 'attached_'..wpn1)) == 'silenciador' then
        if fileExists("Sounds/Secundary/"..soundName..".mp3") then 
          sound = playSound3D("Sounds/Secundary/"..soundName..".mp3",x,y,z, false)
        else
          sound = playSound3D("Sounds/Secundary/ak.mp3",x,y,z, false)
        end
        setElementDimension(sound, dim)
        setSoundVolume( sound, 0.35 )
        setSoundMaxDistance(sound, 30)
      else
        
        if source ~= localPlayer then
          local px, py, pz = getElementPosition(source)
          local vx, vy, vz = getElementPosition(localPlayer)
          local dist = getDistanceBetweenPoints3D(vx, vy, vz, px, py, pz)
          if dist > 100 then
            if fileExists("Sounds/far/"..soundName..".wav") then
              sound = playSound3D("Sounds/far/"..soundName..".wav", px, py, pz, false)
              setSoundVolume( sound, 0.8 )
              setElementDimension(sound, dim)
              setSoundMaxDistance(sound, 350)
            end
          end
        end
        if fileExists("Sounds/Primary/"..soundName..".wav") then
          sound = playSound3D("Sounds/Primary/"..soundName..".wav",x,y,z, false)
          setSoundVolume( sound, 0.6 )
          setElementDimension(sound, dim)
          setSoundMaxDistance(sound, 60)
        end
      end
    end
    --if isElement(sound) then
    --  setSoundMaxDistance(sound, 100)
    --end
  end
end
addEventHandler("onClientPlayerWeaponFire",root,PlaySound2)
addEventHandler("onClientPedWeaponFire", root, PlaySound2)

GatilhoW = {
  [28] = false,
  [17] = false,
  [0] = false,
  [2] = false,
  [8] = false,
  [10] = false,
  [9] = false,
  [6] = false,
  [5] = false,
  [3] = false,
  [4] = false,
  [46] = false,
  [43] = false,
  
}

function PlaySound(som, player)
  if isTimer(Firetime[player]) then return end
  if som == "gatilho" then
    local x, y, z = getElementPosition(player)
    local sound = playSound3D("Sounds/"..som..".mp3", x, y, z)
    local dim = getElementDimension(player)
    local int = getElementInterior(player)
    setElementDimension(sound, dim)
    setElementInterior(sound, int)
    attachElements(sound, player)
    Firetime[player] = setTimer(function() end, 800,1)
  end
end
addEvent("playSound", true)
addEventHandler("playSound", root, PlaySound)