-- Generated using GM2MC ( GTA:SA Models To MTA:SA Converter ) by SoRa

addEventHandler('onClientResourceStart',resourceRoot,function () 
    txd = engineLoadTXD( 'car.txd' ) 
    engineImportTXD( txd, 592 ) 
    dff = engineLoadDFF('car.dff', 592) 
    engineReplaceModel( dff, 592 )

    local objectsTable = getElementsByType("object")
    for ix = 1, #objectsTable do
        local objectElement = objectsTable[ix]
        local objectModel = getElementModel(objectElement)
        engineSetModelLODDistance(objectModel, 300)
    end
    setVehiclesLODDistance(100)
    setPedsLODDistance(300)
    setFarClipDistance(1500)
end)