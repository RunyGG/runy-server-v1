local DEFAULT_DIMENSION = 0

local respawnTime = 600000 -- em milissegundos (10 minutos)

local respawnTimers = {}
col = {}
lootBox = {}
droppedItems = {}
local destroyTimer = nil

function getItemFromChance(items)
  if not items or (type(items) ~= 'table') then
    return false
  end
  
  local total, running = 0, 0
  
  for i = 1, #items do
    total = (total + items[i].chance)
  end
  
  local random = math.random() * total
  
  for i = 1, #items do
    running = (running + items[i].chance)
    
    if (running >= random) then
      return items[i]
    end
  end
  
  table.sort(items,
  function(a, b)
    return (a.chance > b.chance)
  end
)

return items[1]
end

function generateRandomItem(model)
  if model == 1580 then
    items = {
      { id = "Munição", name = "41", quantity = 100, chance = 100, model = 2039, max=600 },
    }
  elseif model == 1579 then
    items = {
      { id = "m4", name = "32", quantity = 1, chance = 40, model = 50000, max=1 },
      { id = "g36c", name = "33", quantity = 1, chance = 65, model = 50002, max=1 },
      { id = "ak", name = "45", quantity = 1, chance = 55, model = 50003, max=1 },
    }
  elseif model == 1577 then
    items = {
      { id = "Bandagem", name = "11", quantity = 1, chance = 50, model = 1241, max=5 },
      { id = "Colete", name = "12", quantity = 1, chance = 50, model = 1242, max=5 },
    }
  elseif model == 1576 then
    items = {
      --[[ { id = "glock", name = "49", quantity = 1, chance = 60, model = 50006, max=1 }, ]]
      --[[ { id = "skorpion", name = "125", quantity = 1, chance = 50, model = 50016, max=1}, ]]
      { id = "five", name = "36", quantity = 1, chance = 80, model = 50005, max=1},
      { id = "mp5", name = "46", quantity = 1, chance = 30, model = 50009, max=1},
      { id = "tec9", name = "35", quantity = 1, chance = 20, model = 50010, max=1},
    }
  end
  local itemData = getItemFromChance(items)
  
  return { id = itemData.id, name = itemData.name, quantity = itemData.quantity, model = itemData.model, max = itemData.max }
end

timer = {}
function createDroppedItem(item, x, y, z, dimension)
  if (not item.model) then
    item.model = itemModels[item.name]
  end
  if (not item.max) then
    item.max = itemsMaximum[item.name]
  end
  if item.model < 40000 then
    object = createObject(item.model, x, y, z + 0.2)
    setElementDimension(object, dimension)
    setObjectScale(object, 1.0)
    setElementCollisionsEnabled(object, false)
    --[[ setTimer(function()
      if isElement(object) then
        local rx, ry, rz = getElementRotation(object)
        if rx and ry and rz then
          setElementRotation(object, rx, ry, rz + 2)
        end
      end
    end, 50, 0) ]]
  else
    object = createObject(372, x, y, z + 0.2)
    setElementDimension(object, dimension)
    setElementData(object, 'objectID', item.model)
    setObjectScale(object, 1.1)
    setElementCollisionsEnabled(object, false)
    --[[ setTimer(function()
      if isElement(object) then
        local rx, ry, rz = getElementRotation(object)
        if rx and ry and rz then
          setElementRotation(object, rx, ry, rz + 2)
        end
      end
    end, 50, 0) ]]
  end
  local colShape = createColSphere(x, y, z, 1.5)
  setElementDimension(colShape, dimension)
  setElementData(colShape, "item", item)
  setElementData(colShape, "parent", object)
  droppedItems[colShape] = object
  
  for _, player in ipairs(getElementsWithinColShape(colShape, "player")) do
    bindKey(player, 'e', 'down', pressToCollect, colShape)
  end
  
  addEventHandler("onColShapeHit", colShape, function(hitElement, matchingDimension)
    if hitElement and getElementType(hitElement) == "player" then
      if isTimer(destroyTimer) then
        killTimer(destroyTimer)
      end
    end
  end)
  
  return object, colShape
end

bullets = {
  ['32'] = true,
  ['33'] = true,
  ['34'] = true,
  ['35'] = true,
  ['36'] = true,
  ['37'] = true,
  ['45'] = true,
  ['46'] = true,
  ['49'] = true,
  ['125'] = true,
}


function openLootBox(player, id, model, x, y, z)
  if isPedInVehicle(player) then
    --triggerClientEvent(player, "Notify", player, "Você não pode abrir o loot enquanto estiver em um veículo.")
    return
  end
  
  if (isTimer(timer[player])) then 
    return 
  end 
  
  triggerClientEvent(player, "progressBar", player, 2000)
  triggerClientEvent(root, "fn:animLoot > server", root, player)
  --[[ setPedAnimation(player, "BOMBER", "BOM_Plant", -1, false, false, false, false) ]]
  
  timer[player] = setTimer(function()
    local item = generateRandomItem(model)
    
    local dimension = getElementDimension(player)
    createDroppedItem(item, x, y, z, dimension)
    
    if bullets[tostring(item.name)] then
      local ammoItem = { id = "Munição", name = "41", quantity = 30, model = 2039, max = 600 }
      createDroppedItem(ammoItem, x + 1, y + 1, z, dimension)
    end
    triggerClientEvent(player, 'announcement', player, false)
    setPedAnimation(player)
    --triggerClientEvent(player, "Notify", player, "Você pegou um(a) " .. item.id .. " (Pegue do chão)")
    givePlayerMoney(player, 1)
    local playerName = getPlayerName(player)
    local itemType = ""
    if model == 1580 then
      itemType = "caixa de munições"
    elseif model == 1579 then
      itemType = "caixa de fuzil's"
    elseif model == 1577 then
      itemType = "caixa de cura"
    elseif model == 1576 then
      itemType = "caixa de smg's"
    end
    local message = playerName .. " abriu uma **" .. itemType .. "** e pegou um(a) **" .. item.id .. "** Quantidade: **" .. item.quantity .. "**"
    triggerEvent("RunyLogsDiscord2", root, root, message, 1)
    triggerClientEvent(root, "removeMarkerForItem", resourceRoot, id)
    
    for i, v in ipairs(getElementsByType('player')) do 
      
      if (getElementDimension(v) == getElementDimension(player)) then 
        
        triggerClientEvent(v, 'onClientRemoveObjectID', v, id)
        
      end
      
    end
    
  end, 2000, 1)
end

addEvent('cancelLootBox', true)
addEventHandler('cancelLootBox', root, function (player)
  if isTimer(timer[player]) then
    killTimer(timer[player])
    triggerClientEvent(player, "progressBar", player, 0)
    setPedAnimation(player)
  end
end)

function collectDroppedItem(player, colShape)
  unbindKey(player, 'e', 'down', pressToCollect)
  
  local item = getElementData(colShape, "item")
  if not item then
    return
  end
  
  local playerItens = exports['runy_inventario']:getItensPlayer(player)
  local quantityToGive = item.quantity
  
  if (type(playerItens) == 'table') then
    for _, v in ipairs(playerItens) do
      if tostring(v.itemID) == tostring(item.name) then
        if v.qnt >= item.max then
          return
        elseif (v.qnt + item.quantity) > item.max then
          quantityToGive = item.max - v.qnt
        end
      end
    end
  end
  
  local isGivedItem = exports["runy_inventario"]:giveItem(player, item.name, quantityToGive)
  if not isGivedItem then 
    --triggerClientEvent(player, "Notify", player, "Você não pode pegar esse item agora.")
    return
  end
  
  triggerClientEvent(player, "colletItemByFN", resourceRoot, "assets/colletsound.mp3")
  --triggerClientEvent(player, "Notify", player, "Você pegou um(a) " .. item.name)
  
  local quantityRemaining = item.quantity - quantityToGive
  if quantityRemaining > 0 then
    item.quantity = quantityRemaining
    setElementData(colShape, "item", item)
  else
    if isElement(colShape) then
      destroyElement(getElementData(colShape, "parent"))
      destroyElement(colShape)
      droppedItems[colShape] = nil
      
    end
    
    if isTimer(destroyTimer) then
      killTimer(destroyTimer)
    end
  end
end

function pressToCollect(player, key, state, colShape)
  if key ~= 'e' or state ~= 'down' then
    return
  end
  
  if not isElement(colShape) or getElementType(colShape) ~= "colshape" then
    return
  end
  
  if not isElementWithinColShape(player, colShape) then 
    return
  end
  
  collectDroppedItem(player, colShape)
end

addEventHandler('onColShapeHit', resourceRoot, function(element, matchingDimension)
  if getElementType(element) == 'player' and matchingDimension then
    if droppedItems[source] then
      bindKey(element, 'e', 'down', pressToCollect, source)
    end
  end
end)

addEventHandler('onColShapeLeave', resourceRoot, function(element, matchingDimension)
  if getElementType(element) == 'player' and matchingDimension then
    if droppedItems[source] then
      unbindKey(element, 'e', 'down', pressToCollect)
    end
  end
end)

function colShapeHit(player, dimension)
  if not player or not isElement(player) or player:getType() ~= 'player' or player:getAccount():isGuest() or not dimension then
    return
  end
  
  local id = getElementData(source, 'ID')
  
  if lootBox[getElementDimension(player)] and lootBox[getElementDimension(player)][id] then
    triggerClientEvent(player, 'announcement', player, true, lootBox[getElementDimension(player)][id])
  end
end

local models = { 1580, 1579, 1577, 1576 }
addEvent("onCreateLoot", true)
addEventHandler("onCreateLoot", root, function(dimension)
  
  local selectedSpawns = {}
  local totalSpawns = #lootSpawns
  local usedIndexes = {}
  
  for i = 1, 800 do
    local randomIndex
    repeat
      randomIndex = math.random(1, totalSpawns)
    until not usedIndexes[randomIndex]
    usedIndexes[randomIndex] = true
    table.insert(selectedSpawns, lootSpawns[randomIndex])
    selectedSpawns[#selectedSpawns].model = models[math.random(#models)]
    
  end
  
  for i, v in ipairs(getElementsByType('player')) do 
    
    if (getElementDimension(v) == tonumber(dimension)) then 
      
      triggerClientEvent(v, 'onClientCreateLootBox', v, selectedSpawns)
      
    end
    
  end 
  
end)

--[[ addCommandHandler('loot', function(player)
triggerEvent('onCreateLoot', root, getElementDimension(player))
end)
]]
function abrirBox(player, id, model, x, y, z)
  
  openLootBox(player, id, model, x, y, z)
  
end
addEvent("onPlayerTryToOpenBox", true)
addEventHandler("onPlayerTryToOpenBox", root, abrirBox)

function destroyLoot(dim)
  for _, colshape in pairs(getElementsByType('colshape', resourceRoot)) do
    if getElementDimension(colshape) == dim then
      destroyElement(getElementData(colshape, "parent"))
      if isElement(droppedItems[colshape]) then
        destroyElement(droppedItems[colshape])
        droppedItems[colshape] = nil
      end
      destroyElement(colshape)
    end
  end
end