--// C. Munis
--[[ txd = engineLoadTXD("[c_munis]/c_munis.txd", 1580 )
engineImportTXD(txd, 1580)
dff = engineLoadDFF("[c_munis]/c_munis.dff", 1580 )
engineReplaceModel(dff, 1580) ]]--
--// Lancer
txd = engineLoadTXD("[lancer]/euros.txd", 587 )
engineImportTXD(txd, 587)
dff = engineLoadDFF("[lancer]/euros.dff", 587 )
engineReplaceModel(dff, 587)
