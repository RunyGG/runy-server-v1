screenW, screenH = guiGetScreenSize()
sW, sH = (screenW/1366), (screenH/768)

--// Variáveis
local notificationDuration = 5000
local fadeDuration = 500
local maxNotifications = 5
local notifications = {}
local background = dxCreateTexture("files/fundo.png")
local background2 = dxCreateTexture("files/atencao.png")
local font = dxCreateFont("files/font.ttf", 12)

if not font or not background then
    outputDebugString("Erro: Não foi possível carregar a fonte ou o fundo da notificação.")
end

local isRendering = false

--// Posições iniciais
local initialX_fundo, initialY_fundo, initialW_fundo, initialH_fundo = 528, 101, 285, 42
local initialX_atencao, initialY_atencao, initialW_atencao, initialH_atencao = 622, 75, 97, 30
local initialX_texto, initialY_texto, initialW_texto, initialH_texto = 528, 93, 252, 15

--// Funções
function Texto(text, x1, y1, w1, h1, ...)
    return dxDrawText(text, sW * x1, sH * y1, sW * w1, sH * h1, ...)
end

function Image(x1, y1, w1, h1, ...)
    return dxDrawImage(sW * x1, sH * y1, sW * w1, sH * h1, ...)
end

function renderNotifications()
    if not isRendering then return end

    for i, notif in ipairs(notifications) do
        local currentTime = getTickCount()
        local elapsedTime = currentTime - notif.startTime
        local alpha = 255

        if elapsedTime < notificationDuration then
            if elapsedTime < fadeDuration then
                alpha = 255 * (elapsedTime / fadeDuration)
            elseif elapsedTime > notificationDuration - fadeDuration then
                alpha = 255 * ((notificationDuration - elapsedTime) / fadeDuration)
            end

            local y = initialY_fundo + (i - 1) * (notif.height + 42)
            local y2 = initialY_atencao + (i - 1) * (notif.height + 42)
            
            local textX = initialX_texto
            local textY = initialY_texto + (i - 1) * (notif.height + 42) + (notif.height / 2) + 12

            local textWidth = dxGetTextWidth(notif.message, 1, font)
            if textWidth > 252 then
                local extraCharacters = textWidth - 252
                local extraWidth = extraCharacters * 1.5
                notif.width = initialW_fundo + extraWidth
                notif.x = initialX_fundo - extraWidth / 2
                textX = notif.x
            end

            Image(notif.x, y, notif.width, initialH_fundo, background, 0, 0, 0, tocolor(255, 255, 0, 250))
            Image(initialX_atencao, y2, initialW_atencao, initialH_atencao, background2, 0, 0, 0, tocolor(255, 255, 255, alpha))
            Texto(notif.message, textX, textY, textX + notif.width, textY, tocolor(255, 255, 255, alpha), 1, font, "center", "center", false, false, false, true)
        else
            table.remove(notifications, i)
        end
    end
end

function showNotification(messageText)
    local notification = {
        message = messageText,
        startTime = getTickCount(),
        x = initialX_fundo,
        width = initialW_fundo,
        height = initialH_fundo
    }

    table.insert(notifications, notification)

    if #notifications > maxNotifications then
        table.remove(notifications, 1)
    end

    if not isRendering then
        addEventHandler("onClientRender", root, renderNotifications)
        isRendering = true
    end
end

addEvent("Notify", true)
addEventHandler("Notify", root, showNotification)

function receiveNotification(messageText)
    showNotification(messageText)
end

addEvent("clientReceiveNotification", true)
addEventHandler("clientReceiveNotification", root, receiveNotification)