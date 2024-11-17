config = {
    ["Mensagem Start"] = false,
    ["Itens"] = {
        --[ID] = {NAME, CATEGORY, HEIGHT, {element, quantity}, _}
        --[ID] = {NAME, CATEGORY, HEIGHT, ID WEAPON GAME, ID AMMO} [WEAPON]
        --[ID] = {NAME, CATEGORY, HEIGHT, {ID WEAPON GAME}, _} [WEAPON]
        [11] = {'Bandagem', 4, 0.0},
        [12] = {'Colete', 4, 0.0},
        [19] = {'faca', 4, 2, 4},
        [31] = {'m240', 4, 3, 34, 41},
        [32] = {'m4', 4, 0.0, 31, 41},
        [33] = {'g36c', 4, 0.0, 30, 41},
        [34] = {'imbel', 4, 0.0, 29, 41},
        [35] = {'tec9', 4, 4, 25, 41},
        [36] = {'five', 4, 0.0, 23, 41},
        [37] = {'magnum', 4, 0.5, 24, 41},  
        [41] = {'Munição 9mm', 4, 0.0, {23, 24, 29, 30, 31}},
        [43] = {'Sniper', 4, 3, 34, 41},
        [45] = {'ak', 4, 1, 30, 41},
        [46] = {'mp5', 4, 3, 29, 41},
        [47] = {'escopeta', 4, 4, 25, 41},
        [49] = {'glock', 4, 0.5, 24, 41},
        [50] = {'thompson', 4, 0.5, 24, 41},
        [125] = {'skorpion', 4, 0.0, 32, 41},
        [126] = {'kar98', 4, 0.01, 33, 41},
        [127] = {'suply', 4, 0.01, 17, 127},
        [999] = {'save', 4, 0.01},
    },
    ["Itens weapon"] = {
        [19] = true,
        [31] = true,
        [32] = true,
        [33] = true,
        [34] = true,
        [35] = true,
        [36] = true,
        [37] = true,
        [43] = true,
        [44] = true,
        [45] = true,
        [46] = true,
        [47] = true,
        [48] = true,
        [49] = true,
        [50] = true,
        [125] = true,
        [126] = true,
        [127] = true,
    },
    ["Itens food"] = {
    },
    ["Itens death"] = {
    },
    ['BlackList'] = {
    },
    ["Itens Special"] = {
    },
    ["Weight Template"] = 30,
}