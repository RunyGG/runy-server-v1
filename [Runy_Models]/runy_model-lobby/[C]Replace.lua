function onClientResourceStartReplaceModels()
    local modelsToReplace = {
        { -- substituir objetos
            colFiles = {"lobby.col"},
            txdFile = "Textures.txd",
            dffFiles = {
            "lobby.dff", 
            -- "Model_predio.dff",
        }, 
            modelIDs = {2894},
            alphaTransparency = true,
            filteringEnabled = true,
            lodDistance = 5000, -- Distância de LOD para objetos
            modifyCollision = true, -- Opção para modificar colisão
        },  -- Adicione mais entradas conforme necessário
    }

    for _, modelData in ipairs(modelsToReplace) do
        local modelTxd = modelData.txdFile
        local modelIDs = modelData.modelIDs
        local dffFiles = modelData.dffFiles
        local colFiles = modelData.colFiles
        local lodDistance = modelData.lodDistance
        local modifyCollision = modelData.modifyCollision

        for i, modelID in ipairs(modelIDs) do
            local modelDff = dffFiles[i]
            local modelCol = colFiles[i]

            if modifyCollision and modelCol then
                local colData = engineLoadCOL(modelCol)
                if colData then
                    engineReplaceCOL(colData, modelID)
                end
            end

            if modelTxd then
                local filteringEnabled = modelData.filteringEnabled
                local txdData = engineLoadTXD(modelTxd, filteringEnabled)
                if txdData then
                    engineImportTXD(txdData, modelID)
                end
            end

            if modelDff then
                local dffData = engineLoadDFF(modelDff)
                if dffData then
                    local alphaTransparency = modelData.alphaTransparency
                    engineReplaceModel(dffData, modelID, alphaTransparency)
                    engineSetModelLODDistance(modelID, lodDistance) -- Define a distância de LOD
                end
            end
        end
    end
end
addEventHandler("onClientResourceStart", resourceRoot, onClientResourceStartReplaceModels)
