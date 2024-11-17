function dxCreateScreenSource()
    txd = engineLoadTXD( 'fn/vending.txd' ) 
    engineImportTXD( txd, 1776 )
    dff = engineLoadDFF('fn/vending.dff', 1776) 
    engineReplaceModel( dff, 1776 )
    col = engineLoadCOL( "fn/vending.col" )
    engineReplaceCOL( col, 1776 ) 
end
addEventHandler('onClientResourceStart',getResourceRootElement(getThisResource()),dxCreateScreenSource)