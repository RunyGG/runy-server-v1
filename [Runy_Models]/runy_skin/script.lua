txd = engineLoadTXD( 'random.txd' )
engineImportTXD( txd, 1 )
dff = engineLoadDFF('random.dff', 1)
engineReplaceModel( dff, 1 )