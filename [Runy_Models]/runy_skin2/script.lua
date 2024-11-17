txd = engineLoadTXD( 'random.txd' )
engineImportTXD( txd, 0 )
dff = engineLoadDFF('random.dff', 0)
engineReplaceModel( dff, 0 )