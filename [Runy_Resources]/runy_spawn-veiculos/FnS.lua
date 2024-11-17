local veiculosSpawnados = {}

local function spawnVeiculoAleatorio(tabela)
    local tipo = tabela[math.random(#tabela)]
    local veiculosTipo = veiculosDisponiveis[tipo]
    if veiculosTipo then
        local veiculoID = veiculosTipo[math.random(#veiculosTipo)]
        return veiculoID
    else
        outputDebugString("Tipo de veículo inválido: " .. tipo)
    end
end

local function shuffleTable(t)
    local tbl = {}
    for i = 1, #t do
        tbl[i] = t[i]
    end
    for i = #tbl, 2, -1 do
        local j = math.random(i)
        tbl[i], tbl[j] = tbl[j], tbl[i]
    end
    return tbl
end

local function spawnVeiculoNoTrigger(dimension)
    if veiculosSpawnados[dimension] then
        for _, veiculo in ipairs(veiculosSpawnados[dimension]) do
            destroyElement(veiculo)
        end
    end

    veiculosSpawnados[dimension] = {}

    local posicoesDeSpawnShuffled = shuffleTable(posicoesDeSpawn)
    local posicoesSelecionadas = {}
    
    for i = 1, 45 do
        table.insert(posicoesSelecionadas, posicoesDeSpawnShuffled[i])
    end

    for _, posicao in ipairs(posicoesSelecionadas) do
        local veiculoID = spawnVeiculoAleatorio({"motos", "carros"})
        local veiculo = createVehicle(veiculoID, posicao.x, posicao.y, posicao.z, 0, 0, 0)
        if veiculo then
            setElementDimension(veiculo, dimension)
            table.insert(veiculosSpawnados[dimension], veiculo)
        else
            print("Falha ao criar veículo")
        end
    end    
end

addEvent("spawnVeiculo", true)
addEventHandler("spawnVeiculo", root, function(dimension)
    spawnVeiculoNoTrigger(dimension)
end)