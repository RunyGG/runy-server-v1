outputDebugString('RESOURCE '..getResourceName(getThisResource())..' ATIVADA COM SUCESSO', 4, 204, 82, 82)

local object = {}
local colshape = {}
local parent = {}
local itens = {}
local timer = {}
local destroyTimer = nil

local itens = {
  
  { id = "Munição", name = "41", quantity = 60, chance = 100, model = 2039, max=600 },
  
  { id = "m4", name = "32", quantity = 1, chance = 60, model = 50000, max=1 },
  { id = "g36c", name = "33", quantity = 1, chance = 40, model = 50002, max=1 },
  { id = "ak", name = "45", quantity = 1, chance = 60, model = 50003, max=1 },
  { id = "glock", name = "49", quantity = 1, chance = 60, model = 50006, max=1 },
  { id = "skorpion", name = "125", quantity = 1, chance = 50, model = 50016, max=1 },
  { id = "five", name = "36", quantity = 1, chance = 70, model = 50005, max=1},
  { id = "mp5", name = "46", quantity = 1, chance = 45, model = 50009, max=1},
  { id = "tec9", name = "35", quantity = 1, chance = 45, model = 50010, max=1},
  { id = "bandagem", name = "11", quantity = 1, chance = 70, model = 1241, max=5 },
  { id = "Colete", name = "12", quantity = 1, chance = 30, model = 1242, max=5 },
  { id = "faca", name = "19", quantity = 1, chance = 45, model = 335, max = 1 },
  { id = "save", name = "999", quantity = 1, chance = 0, model = 50024, max = 1 },
  { id = "kar98", name = "126", quantity = 1, chance = 0, model = 50025, max = 1 },
}

addEventHandler('onPlayerWasted', root, function()
  createDeadLoop(source)
end)

function createDeadLoop(player)
  toggleControl(player, "previous_weapon", false)
  toggleControl(player, "next_weapon", false)
  if getElementData(player, 'myDuo') then
    local duo = getElementData(player, 'myDuo')
    if not getElementData(duo, 'dropped') and not getElementData(duo, 'deadPlayer') and not getElementData(duo, "spectatingPlayer") and getElementData(duo, "battleRoyaleRunning") then
      local x, y, z = getElementPosition(player)
      local dimension = getElementDimension(player)
      z = z - 0.9
      createDroppedItem({ id = "save", name = "999", quantity = 1, chance = 0, model = 50024, max = 1 }, x + (math.random(1, 3)), y, z, dimension, 1, duo)
    end
  end
  local x, y, z = getElementPosition(player)
  local dimension = getElementDimension(player)
  z = z - 0.9
  triggerEvent('ChangeBliped', player, player, 'detach')
  setTimer(function(player)
    triggerEvent('ChangeBliped', player, player, 'move', {x, y, z})
  end, 500, 1, player)
  local playerItens = exports['runy_inventario']:getItensPlayer(player)
  for i, v in ipairs(playerItens) do 
    local item = getItemData(v.itemID, v.qnt)
    if item.id ~= 'save' then
      if (item) then 
        createDroppedItem(item, x + (math.random(1, 3)), y, z, dimension, v.qnt)
      end
    end
  end
end

function getItemData(name, amount)
  for i, v in ipairs(itens) do 
    if (tonumber(name) == tonumber(v.name)) then 
      v.quantity = tonumber(amount)
      return v 
    end
  end
end

local droppedItems = {}
function createDroppedItem(item, x, y, z, dimension, amount, duo)
  local object = createObject((item.model > 49999 and 1899 or item.model), (x+math.random(-1, 1)), y, z + 0.2)
  if item.model > 49999 then
    setElementData(object, 'objectID', item.model )
  end
  setElementDimension(object, dimension)
  setObjectScale(object, 1.0)
  setElementRotation(object, 0, 0, math.random(0, 360))
  setElementCollisionsEnabled(object, false)
  local colShape = createColSphere(x, y, z, 1.3)
  attachElements( colShape, object, 0,0,0,0,0,0 )
  setElementDimension(colShape, dimension)
  setElementData(colShape, "item", item)
  setElementData(colShape, "parent", object)
  droppedItems[colShape] = object
  if item.id == 'save' then
    if duo then
      setElementData(colShape, "save", duo)
    end
  end
  
  destroyTimer = setTimer(function()
    if isElement(object) then
      destroyElement(object)
      destroyElement(colShape)
      droppedItems[colShape] = nil
    end
  end, 300000, 1)
  
  return object, colShape
end


function collectDroppedItem(player, colShape)
  unbindKey(player, 'e', 'down', pressToCollect)
  local save = getElementData(colShape, "save")
  if save then
    if player ~= save then
      return
    end
  end
  local item = getElementData(colShape, "item")
  if not item then
    return
  end
  local playerItens = exports['runy_inventario']:getItensPlayer(player)
  local quantityToGive = item.quantity
  if (type(playerItens) == 'table') then
    for _, v in ipairs(playerItens) do
      if tostring(v.itemID) == item.name then
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
    --[[ triggerClientEvent(player, "Notify", player, "Você não pode pegar esse item agora.") ]]
    return
  end
  
  triggerClientEvent(player, "colletItemByFN2", resourceRoot, "assets/colletsound.mp3")
  --[[ triggerClientEvent(player, "Notify", player, "Você pegou um(a) " .. item.name) ]]
  
  local quantityRemaining = item.quantity - quantityToGive
  if quantityRemaining > 0 then
    item.quantity = quantityRemaining
    setElementData(colShape, "item", item)
  else
    destroyElement(getElementData(colShape, "parent"))
    destroyElement(colShape)
    droppedItems[colShape] = nil
    
    if isTimer(destroyTimer) then
      killTimer(destroyTimer)
    end
  end
end

function pressToCollect(player, key, state, colShape)
  if colShape then
    if key ~= 'e' or state ~= 'down' then
      return
    end
    if not isElementWithinColShape(player, colShape) then 
      return
    end
    collectDroppedItem(player, colShape)
  end
end

addEventHandler('onColShapeHit', resourceRoot, function(element, matchingDimension)
  if getElementType(element) == 'player' and matchingDimension then
    if droppedItems[source] then
      local item = getElementData(source, "item")
      bindKey(element, 'e', 'down', pressToCollect, source)
    end
  end
end)

addEventHandler('onColShapeLeave', resourceRoot, function(element, matchingDimension)
  if getElementType(element) == 'player' and matchingDimension then
    if droppedItems[source] then
      unbindKey(element, 'e', 'down', pressToCollect)
      local item = getElementData(source, "item")
    end
  end
end)

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