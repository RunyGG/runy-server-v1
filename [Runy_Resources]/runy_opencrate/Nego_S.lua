addEvent("NZ > GiveItemCrate", true)
addEventHandler("NZ > GiveItemCrate", root, function (thePlayer, raridade, item, category, Quantidade)
    if clothes[item] then
        exports["runy_roupas-inventario"]:giveItem(thePlayer, item, category)
    elseif category == 'equipamentos' then
        exports["runy_equipamentos"]:giveItem(thePlayer, item, category)
    elseif category == 'arsenal' then
        exports["runy_arsenal"]:giveItem(thePlayer, item, category)
    end
end)

clothes = {
    
    ['bxadrez'] = true,
    ['txadrez'] = true,
    ['nxadrez'] = true,
    ['mxadrez'] = true,
    ['jxadrez'] = true,
    ['cxadrez'] = true,
    ['sxadrez'] = true,
    
    ['ctoxico'] = true,
    ['ntoxico'] = true,
    ['gtoxico'] = true,
    ['jtoxico'] = true,
    ['stoxico'] = true,
    ['htoxico'] = true,
    
    ['cgrafite'] = true,
    ['tgrafite'] = true,
    ['mgrafite'] = true,
    ['sgrafite'] = true,
    ['ngrafite'] = true,
    ['jgrafite'] = true,
    
}