config = {  
    notify = function(player, text, type)
        return triggerClientEvent(player, "Notify", player, text)
    end;

    planeModel = 1681; 
    planeScale = 4.5;  

    routes = {
        {
            startPosition = {2891.593, -1666.1063, 220.5465+350, 0, 0, 90}, -- x, y, z, rx, ry, rz
            finishPosition = {-841.1356, -1623.6833, 220.5465+350}, -- x, y, z
            flightTime = 60, -- Tempo de voo em segundos
        },
         {
            startPosition = {2065.23022, -2580.45093, 220.5465+350, 0, 0, 55},
            finishPosition = {387.35382, -1243.52539, 220.5465+350},
            flightTime = 45,
        },
        {
            startPosition = {-42.29278, -1371.87488, 220.54650+350, 0, 0, 251.6},
            finishPosition = {2755.85327, -2337.22119, 220.5465+350},
            flightTime = 45,
        },
        {
            startPosition = {2181.38599, -898.03937, 220.5465+350, 0, 0, 180},
            finishPosition = {2138.56177, -2815.56616, 220.5465+350},
            flightTime = 40,
        },
       --[[] 
        {
            startPosition = {3000, 3000, 300, 0, 0, 90},
            finishPosition = {-3000, -3000, 300},
            flightTime = 50,
        } ]]
    };

    localName = {
        {2218.6569824219, -1165.5849609375, 25.7265625, name = 'HOTEL LARANJA'},
        {1232.96399, -1400.23328, 13.09867, name = 'PRINCIPAL'},
        {2484.12183, -1667.03662, 13.34375, name = 'CJ'},
        {1921.38196, -1426.40198, 10.35938, name = 'PISTA DE SKATE'},
        {2210.8386230469, -1342.2854003906, 23.984375, name = 'IGREJA'},
        {2314.8903808594, -1432.1363525391, 24, name = 'LAGOA'},
        {2482.2622070312, -1477.1436767578, 33.506393432617, name = 'LAVA JATO'},
        {2302.71484375, -1524.2288818359, 26.873748779297, name = 'QUADRA'},
        {2737.4829101562, -1760.6585693359, 44.140251159668, name = 'ESTADIO'},
        {2179.3327636719, -2088.5395507812, 13.546875, name = 'LIXÃO'},
        {1129.9077148438, -1492.5523681641, 22.769031524658, name = 'SHOPPING' },
        {1478.2194824219, -1662.5501708984, 14.553216934204, name = 'PRAÇA' },
        {485.01498413086, -1503.4226074219, 20.393480300903, name = 'JOALHERIA' },
        {316.02639770508, -1512.4637451172, 76.5390625, name = 'HOSPITAL' },
        {748.65863037109, -1256.3786621094, 13.56121635437, name = 'TENIS' },
        {883.42272949219, -1093.5067138672, 24.303991317749, name = 'CEMITERIO' },
        {1164.1437988281, -2035.3736572266, 69.0078125, name = 'OBSERVATÓRIO' },
        {1866.293, -2481.607, 13.555, name = 'AEROPORTO'},
        {2456.185, -2448.75, 13.453, name = 'DOCAS'},
        {2332.291, -1798.241, 13.547, name = 'CONDOMINIO AZUL'},
        {1760.266, -1899.326, 13.563, name = 'ESTAÇÃO'},
        {1888.907, -1887.692, 13.489, name = 'ZIP ZIP'},
        {1730.438, -2113.447, 13.383, name = 'BAIRRO 1'},
        {2037.706, -1675.038, 13.383, name = 'BAIRRO 2'},
        {1883.302, -2061.655, 13.547, name = 'CONDOMINIO VERMELHO'},
        {2102.045, -1807.282, 13.555, name = 'PIZZA'},
        {1872.432, -1683.731, 58.196, name = 'BOATE'},
        {1659.096, -1676.591, 21.432, name = 'ESTACIONAMENTO BRANCO '},
        {1730.899, -1425.967, 15.758, name = 'BOMBEIRO'},
        {1780.688, -1556.774, 22.942, name = 'CASSINO'},
        {2316.123, -1963.745, 13.429, name = 'MINI BAIRRO'},
        {2714.561, -2033.012, 13.369, name = 'BAIRRO 3'},
        {1414.026, -1296.108, 33.516, name = 'AMMUNATION'},
        {1207.742, -1281.953, 13.383, name = 'HOSPITAL 2'},
        {1208.923, -1134.111, 23.943, name = 'CALÇADA DA FAMA'},
        {1174.168, -1039.4, 31.791, name = 'BAIRRO 4'},
        {1197.26, -901.355, 48.062, name = 'BURGER SHOT'},
        {1022.607, -1051.676, 31.608, name = 'CHINA'},
        {1000.501, -1323.798, 13.391, name = 'DONUTS'},
        {872.626, -1234.368, 15.435, name = 'ARMAZEM'},
        {1052.253, -910.537, 42.765, name = 'SEX SHOP'},
        {712.312, -1357.589, 27.484, name = 'EMISSORA'},
        {729.887, -1515.111, -0.55, name = 'LAGOA'},
        {724.352, -1670.62, 10.524, name = 'BAIRRO DE BARRO'},
        {921.103, -1488.999, 13.37, name = 'BAIRRO 5'},
        {870.235, -1689.213, 13.555, name = 'PISCINA'},
        {371.6, -1763.528, 12.716, name = 'PIER'},
        {276.732, -1233.42, 74.493, name = 'MANSÃO'},
        {1477.149, -1810.515, 33.43, name = 'PREFEITURA'},
        {1970.021, -1196.673, 25.68, name = 'LAGOINHA'},
        {2508.233, -1055.907, 69.353, name = 'FAVELINHA'},
        {2164.275, -1020.371, 62.541, name = 'FAVELA CJ'},
        {1979.572, -1093.716, 25.251, name = 'BAIRRO GREN'},
        {2454.767, -1350.18, 23.836, name = 'VILA DO CHAVES'},
        {2578.318, -1351.052, 35.861, name = 'CENTRO'},
        {1180.463, -1719.924, 13.564, name = 'AUTO ESCOLA'},
        {2735.926, -1360.603, 42.903, name = 'PRINCIPAL 2'},
        {562.518, -1021.22, 76.274, name = 'LOTE'},

    },

    waitingPosition = {208.708, 2508.262, 16.504}, -- x, y, z
    customRoomPosition = {208.708, 2508.262, 16.504},

    key = 'E';

    -- minimunMembers = 5;
    -- maxMembers = 50; -- Maximo de membros para iniciar a partida
    -- startTime = 12.3; -- Tempo em minutos para a partida começar (após o primeiro jogador entrar)
    -- matchTime = 60; -- Tempo para a dimensão ficar disponível novamente 
    -- countdownTime = 30; -- Defina o tempo de contagem regressiva aqui

    minimunMembers = 5;
    maxMembers = 50; -- Maximo de membros para iniciar a partida
    startTime = 8.9; -- Tempo em minutos para a partida começar (após o primeiro jogador entrar)
    matchTime = 60; -- Tempo para a dimensão ficar disponível novamente 
    countdownTime = 30; -- Defina o tempo de contagem regressiva aqui
};