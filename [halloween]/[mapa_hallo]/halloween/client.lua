pumpkin = 1265
tree1 = 780
tree2 = 738
Stump = 1339

addEventHandler('onClientResourceStart', resourceRoot,
function()
local txd = engineLoadTXD('models/pumpkin.txd',true)
engineImportTXD(txd, pumpkin)
local dff = engineLoadDFF('models/pumpkin.dff', 0)
engineReplaceModel(dff, pumpkin)

local txd = engineLoadTXD('models/tree1.txd',true)
engineImportTXD(txd, tree1)
local dff = engineLoadDFF('models/tree1.dff', 0)
engineReplaceModel(dff, tree1)

local txd = engineLoadTXD('models/tree2.txd',true)
engineImportTXD(txd, tree2)
local dff = engineLoadDFF('models/tree2.dff', 0)
engineReplaceModel(dff, tree2)

local txd = engineLoadTXD('models/Stump.txd',true)
engineImportTXD(txd, Stump)
local dff = engineLoadDFF('models/Stump.dff', 0)
engineReplaceModel(dff, Stump)
end)

-- Sitemiz : https://sparrow-mta.blogspot.com/

-- Facebook : https://facebook.com/sparrowgta/
-- İnstagram : https://instagram.com/sparrowmta/
-- YouTube : https://youtube.com/c/SparroWMTA/

-- Discord : https://discord.gg/DzgEcvy
