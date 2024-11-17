--// C. Munis
txd = engineLoadTXD("[c_munis]/c_munis.txd", 1580 )
engineImportTXD(txd, 1580)
dff = engineLoadDFF("[c_munis]/c_munis.dff", 1580 )
engineReplaceModel(dff, 1580)
engineSetModelLODDistance(1580, 500)

--// C. Armas
txd = engineLoadTXD("[c_armas]/c_armas.txd", 1579 )
engineImportTXD(txd, 1579)
dff = engineLoadDFF("[c_armas]/c_armas.dff", 1579 )
engineReplaceModel(dff, 1579)
engineSetModelLODDistance(1579, 500)

--// C. Utils
txd = engineLoadTXD("[c_utils]/c_utils.txd", 1577 )
engineImportTXD(txd, 1577)
dff = engineLoadDFF("[c_utils]/c_utils.dff", 1577 )
engineReplaceModel(dff, 1577)
engineSetModelLODDistance(1577, 500)

--// C.Smgs
txd = engineLoadTXD("[c_smgs]/c_smgs.txd", 1576 )
engineImportTXD(txd, 1576)
dff = engineLoadDFF("[c_smgs]/c_smgs.dff", 1576 )
engineReplaceModel(dff, 1576)
engineSetModelLODDistance(1576, 500)

--// Colete
txd = engineLoadTXD("[colete]/1.txd", 1242 )
engineImportTXD(txd, 1242)
dff = engineLoadDFF("[colete]/1.dff", 1242 )
engineReplaceModel(dff, 1242)
engineSetModelLODDistance(1242, 500)

--// Muni Model
txd = engineLoadTXD("[muni_model]/2.txd", 2039 )
engineImportTXD(txd, 2039)
dff = engineLoadDFF("[muni_model]/2.dff", 2039 )
engineReplaceModel(dff, 2039)
engineSetModelLODDistance(2039, 500)