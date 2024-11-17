local dimensaoMinima = 5000
local dimensaoMaxima = 7000
local atrasoAposVitoria = 1000
local ultimaVitoria = {}
local verificandoDimensao = {}

function verificarDimensao(dimensao)
    if not verificandoDimensao[dimensao] then return end

    for _, player in ipairs(getElementsByType("player")) do
        local dimensaoAtual = getElementDimension(player)

        if dimensaoAtual == dimensao then
            local nomeDoPlayer = getPlayerName(player)
            local tempoPassado = getTickCount() - (ultimaVitoria[dimensao] or 0)

            if tempoPassado >= atrasoAposVitoria then
                local mensagem = "RUNY - Fim de game na dimensão " .. dimensao .. ", winner: " .. nomeDoPlayer
                triggerEvent("RunyLogsDiscord1", player, player, mensagem, 1)
                ultimaVitoria[dimensao] = getTickCount()
                verificandoDimensao[dimensao] = false
                return
            end
        end
    end
end

function iniciarVerificacaoDimensao(dimensao)
    setTimer(function ()
        if dimensao < dimensaoMinima or dimensao > dimensaoMaxima then return end
        verificandoDimensao[dimensao] = true
        verificarDimensao(dimensao)
    end, 5000, 1)
end
addEvent("iniciarVerificacaoDimensao", true)
addEventHandler("iniciarVerificacaoDimensao", root, iniciarVerificacaoDimensao)