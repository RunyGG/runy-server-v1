function replaceParachute()
    local txd = engineLoadTXD("paracx.txd")
    engineImportTXD(txd, 3131)

    local dff = engineLoadDFF("parachute.dff", 3131)
    engineReplaceModel(dff, 3131)
end

addEventHandler("onClientResourceStart", resourceRoot, replaceParachute)