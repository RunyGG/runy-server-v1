local teleportArea1 = createColCuboid(-1516.13184, 481.64102, -0.76562, 300, 100, 2.5)

local teleportPositions1 = {
    {-1418.57898, 500.30463, 11.19531},
    {-1309.68201, 506.91409, 11.19531},
    {-1307.84680, 495.69540, 11.19531},
    {-1333.02161, 491.78183, 11.19531},
    {-1346.45386, 496.56799, 11.19531},
    {-1426.24011, 498.69907, 11.19531},
    {-1391.05969, 492.69629, 3.03906},
    {-1415.63794, 512.16937, 3.03906},
    {-1430.20923, 494.25668, 3.03906},
    {-1425.45349, 501.74921, 18.22944},
    {-1373.51440, 504.27698, 18.23438},
    {-1323.53711, 505.61636, 18.23438},
    {-1271.83118, 500.21252, 18.22944},
    {-1311.51208, 495.10147, 18.23438}
}

local teleportArea2 = createColCuboid(-1475.96301, 439.44809, 7.18750, 259.3, 42.5, 20)

local teleportPositions2 = {
    {-1418.57898, 500.30463, 11.19531},
    {-1309.68201, 506.91409, 11.19531},
    {-1307.84680, 495.69540, 11.19531},
    {-1333.02161, 491.78183, 11.19531},
    {-1346.45386, 496.56799, 11.19531},
    {-1426.24011, 498.69907, 11.19531},
    {-1391.05969, 492.69629, 3.03906},
    {-1415.63794, 512.16937, 3.03906},
    {-1430.20923, 494.25668, 3.03906},
    {-1425.45349, 501.74921, 18.22944},
    {-1373.51440, 504.27698, 18.23438},
    {-1323.53711, 505.61636, 18.23438},
    {-1271.83118, 500.21252, 18.22944},
    {-1311.51208, 495.10147, 18.23438}
}


-- Função que teletransporta o jogador (geral para qualquer área)
function teleportPlayer(hitElement, teleportPositions)
    if getElementType(hitElement) == "player" then
        local teleportPosition = math.random(1, #teleportPositions)
        local fnviado = teleportPositions[teleportPosition]
        setElementPosition(hitElement, Vector3(unpack(fnviado)))
    end
end

-- Adicionando evento de detecção de entrada na primeira área
addEventHandler("onColShapeHit", teleportArea1, function(hitElement)
    teleportPlayer(hitElement, teleportPositions1)
end)

-- Adicionando evento de detecção de entrada na segunda área
addEventHandler("onColShapeHit", teleportArea2, function(hitElement)
    teleportPlayer(hitElement, teleportPositions2)
end)

-- Mensagem para confirmar que o script foi carregado
outputDebugString("Teleport System carregado com sucesso.")