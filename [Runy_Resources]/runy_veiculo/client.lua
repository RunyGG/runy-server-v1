function replaceModel()
txd = engineLoadTXD('car.txd',568)
engineImportTXD(txd,568)
dff = engineLoadDFF('car.dff',568)
engineReplaceModel(dff,568)
setVehicleModelWheelSize(568, "all_wheels", 0.78)
end
addEventHandler ( 'onClientResourceStart', getResourceRootElement(getThisResource()), replaceModel)
--addCommandHandler ( 'reloadcar', replaceModel )

-- Sitemiz : https://sparrow-mta.blogspot.com/

-- Facebook : https://facebook.com/sparrowgta/
-- İnstagram : https://instagram.com/sparrowmta/
-- YouTube : https://www.youtube.com/@TurkishSparroW/

-- Discord : https://discord.gg/DzgEcvy