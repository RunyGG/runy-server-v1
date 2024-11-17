config = {

    markerColor = {69, 144, 225, 90}; -- // Cor do marker
    notify = function(player, text, type)
        return exports['fr_dxmessages']:addBox(player, text, type)
    end;
    itensX = {
        
        ['bxadrezb'] = {'cabelo', 7, 1, 'assets/images/icons/cabelo/bxadrez.png'};
        ['cgrafiteb'] = {'cabelo', 9, 3, 'assets/images/icons/cabelo/cgrafite.png'};
        ['cxadrezb'] = {'cabelo', 9, 2, 'assets/images/icons/cabelo/cxadrez.png'};
        ['cpadrao'] = {'cabelo', 9, 1, 'assets/images/icons/cabelo/cpadrao.png'};
        ['ctoxicoc'] = {'cabelo', 9, 4, 'assets/images/icons/cabelo/ctoxico.png'};
        ['tgrafite'] = {'cabelo', 10, 2, 'assets/images/icons/cabelo/tgrafite.png'};
        ['txadrez'] = {'cabelo', 10, 1, 'assets/images/icons/cabelo/txadrez.png'};

        ['nbeta'] = {'corpo', 2, 8, 'assets/images/icons/corpo/nbeta.png'};
        ['nbooster'] = {'corpo', 2, 9, 'assets/images/icons/corpo/nbooster.png'};
        ['ngrafite'] = {'corpo', 2, 3, 'assets/images/icons/corpo/ngrafite.png'};
        ['npadrao'] = {'corpo', 2, 2, 'assets/images/icons/corpo/npadrao.png'};
        ['ntoxico'] = {'corpo', 2, 4, 'assets/images/icons/corpo/ntoxico.png'};
        ['nxadrez'] = {'corpo', 2, 1, 'assets/images/icons/corpo/nxadrez.png'};
        ['sgrafites'] = {'corpo', 6, 1, 'assets/images/icons/corpo/sgrafite.png'};

        ['jsakura'] = {'corpo', 6, 5, 'assets/images/icons/corpo/jsakura.png'};
        ['jsakurab'] = {'corpo', 6, 6, 'assets/images/icons/corpo/jsakurab.png'};

        ['diamantes1'] = {'corpo', 2, 10, 'assets/images/icons/corpo/diamantes1.png'};
        ['mestres1'] = {'corpo', 2, 11, 'assets/images/icons/corpo/mestres1.png'};
        ['lendas1'] = {'corpo', 2, 12, 'assets/images/icons/corpo/lendas1.png'};
        ['globals1'] = {'corpo', 2, 13, 'assets/images/icons/corpo/globals1.png'};

        ['bxadrez'] = {'bandana', 3, 1, 'assets/images/icons/bandana/bxadrez.png'};
        ['gtoxico'] = {'bandana', 2, 1, 'assets/images/icons/bandana/gtoxico.png'};
        ['mgrafiteb'] = {'bandana', 4, 5, 'assets/images/icons/bandana/mgrafite.png'};
        ['mtoxico'] = {'bandana', 4, 6, 'assets/images/icons/bandana/mtoxico.png'};
        ['mxadrez'] = {'bandana', 4, 1, 'assets/images/icons/bandana/mxadrez.png'};
        ['msakura'] = {'bandana', 4, 7, 'assets/images/icons/bandana/msakura.png'};
        ['msakurab'] = {'bandana', 4, 8, 'assets/images/icons/bandana/msakurab.png'};

        ['jxadrez'] = {'oculos', 1, 1, 'assets/images/icons/oculos/jxadrez.png'};
        ['jtoxico'] = {'oculos', 1, 2, 'assets/images/icons/oculos/jtoxico.png'};
        ['jgrafite'] = {'oculos', 1, 3, 'assets/images/icons/oculos/jgrafite.png'};

        ['sakuramask1'] = {'oculos', 50027, false, 'assets/images/icons/oculos/sakuramask1.png'};
        ['sakuramask2'] = {'oculos', 50027, false, 'assets/images/icons/oculos/sakuramask2.png'};

        ['ctoxico'] = {'perna', 4, 1, 'assets/images/icons/short/stoxico.png'};
        ['cgrafite'] = {'perna', 4, 2, 'assets/images/icons/short/cgrafite.png'};
        ['cxadrez'] = {'perna', 4, 3, 'assets/images/icons/short/cxadrez.png'};
        ['csakura'] = {'perna', 4, 4, 'assets/images/icons/short/csakura.png'};
        ['csakurab'] = {'perna', 4, 5, 'assets/images/icons/short/csakurab.png'};

        ['mgrafite'] = {'short', 2, 3, 'assets/images/icons/short/mgrafite.png'};
        ['sgrafitep'] = {'short', 1, 1, 'assets/images/icons/short/sgrafite.png'};
        ['stoxicos'] = {'short', 1, 2, 'assets/images/icons/short/stoxico.png'};

        ['htoxico'] = {'tenis', 1, 1, 'assets/images/icons/tenis/htoxico.png'};
        ['sxadrez'] = {'tenis', 2, 1, 'assets/images/icons/tenis/sxadrez.png'};
        ['sgrafite'] = {'tenis', 2, 2, 'assets/images/icons/tenis/sgrafite.png'};
        ['stoxico'] = {'tenis', 2, 3, 'assets/images/icons/tenis/stoxico.png'};
        ['ssakura'] = {'tenis', 2, 7, 'assets/images/icons/tenis/ssakura.png'};
        ['ssakurab'] = {'tenis', 2, 8, 'assets/images/icons/tenis/ssakurab.png'};

    };

    spawnPlayer = {1659.2639 - 2, -1678.3678, 21.4306, 180};
    cameras = {

        ['corpo'] = {1657.6885595703, -1684.1064453125, 21.875, 1657.6396484375, -1683.1075439453, 21.922220230103, 0, 70};
        ['cabelo'] = {1657.6885595703, -1684.1064453125, 21.875, 1657.6396484375, -1683.1075439453, 21.922220230103, 0, 10};
        ['camisa'] = {1657.6885595703, -1684.1064453125, 21.975, 1657.6396484375, -1683.1075439453, 21.922220230103, 0, 10};
        ['perna'] = {1657.6885595703, -1684.1064453125, 22.125, 1657.6396484375, -1683.1075439453, 21.922220230103, 0, 12};
        ['tenis'] = {1657.6885595703, -1684.1064453125, 22.215, 1657.6396484375, -1683.1075439453, 21.922220230103, 0, 10};

    };

    categorys = {

        'cabelo';
        'corpo';
        'perna';
        'short';
        'tenis';
        'bandana';
        'barba';
        'mochila';
        'oculos';

    };
}

function getItemDiretory(item)
 return config.itensX[item][4]
end