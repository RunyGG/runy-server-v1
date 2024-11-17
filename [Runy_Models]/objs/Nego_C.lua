models = {
    {id = 1955, txd = 'models/DROP', dff = 'models/DROP'},

    --{id = 645, txd = 'models/645', dff = 'models/645'},
    --{id = 669, txd = 'models/669', dff = 'models/669'},
}

addEventHandler('onClientResourceStart',resourceRoot,function () 
    for i,v in pairs(models) do
        if v.txd then
            txd = engineLoadTXD ( v.txd..".txd" )
            engineImportTXD ( txd, v.id )
        end
        if v.col then
            col = engineLoadCOL ( v.col..".col" )
            engineReplaceCOL ( col, v.id )
        end
        if v.dff then
            dff = engineLoadDFF ( v.dff..".dff" )
            engineReplaceModel ( dff, v.id )
        end
        engineSetModelLODDistance(v.id, 600)
    end
end)