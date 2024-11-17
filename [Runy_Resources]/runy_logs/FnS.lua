local discordWebhookURLs = {
    "https://discord.com/api/webhooks/1301970058611921007/xBTKZ4rByAUwvcewEiph6wS0d2u7e3AJzewIHz3SEsLE81PeqgqdCj3HsPw8yjVZADrD", -- Match Winner
    "https://discord.com/api/webhooks/1301609879198240809/ZRbjj8Eq7tprePejYxwdxMBmmQW1qQeKOv8-YpaJCwKgzgm5V5nPEyHIBYW9pCiLQ4rd", -- Loots
    "https://discord.com/api/webhooks/1301970499961622601/GN9KtBhx17IOFvnCQ4uotJlaOnNWF2DRuDfBV-niAsoUJLzrokQyHacdEmnYT6xWho1_", -- Logins
    "https://discord.com/api/webhooks/1301970625304465430/YMOuErnXklz-99REP2fG5LvFZ4VM3aHgmPKYCywnHRUOzIyg1tmbAUF1UqdRp9GsmJ76", -- Kills
    "https://discord.com/api/webhooks/1301970808398413878/cn_BAXsLZsoI3BYgd0l-J4C7AaCMuFREi-3okG9TX2V2lOnbH9BAm6SvlXkNSV-lA2mJ", -- Mattchs
    "https://discord.com/api/webhooks/1263711030530281514/PzRI1z7Y1NYdteODb5F8dySwtERDzdm5YZO3RjMrGNxA0T7showE2CYcGl_jYgopElnw", -- suspeitos
    "https://discordapp.com/api/webhooks/1274141290971533384/E8xq8nOeyk0XXUtYW3_IQSgU5U_0CNHeaoNEqmjTkUX_svugh_950pTdXgzlkEYb6OZL", -- caixas setadas
    "https://discordapp.com/api/webhooks/1274161340583379035/FNrRP0KemoUp_WNXZELz2zkxzER-Qy2Z4npYBJapADsTJdV6nMlxx3x96TVNvh0Ck9PE" -- Caixas abertas
}

function sendToDiscord(post, url)
    local dados = {
        embeds = {
            {
                --title = "Logs Runy GG",
                color = 3092790,
                description = post,
            },
        }
    }
    dados = toJSON(dados)
    dados = dados:sub(2, -2)
    local opt = {
        connectionAttempts = 5,
        connectTimeout = 7000,
        headers = {
            ["Content-Type"] = "application/json"
        },
        postData = dados
    }
    fetchRemote(url, opt, function()end)
end

function RunyLogsDiscord1(ply, post) sendToDiscord(post, discordWebhookURLs[1]) end
function RunyLogsDiscord2(ply, post) sendToDiscord(post, discordWebhookURLs[2]) end
function RunyLogsDiscord3(ply, post) sendToDiscord(post, discordWebhookURLs[3]) end
function RunyLogsDiscord4(ply, post) sendToDiscord(post, discordWebhookURLs[4]) end
function RunyLogsDiscord5(ply, post) sendToDiscord(post, discordWebhookURLs[5]) end
function RunyLogsDiscord6(ply, post) sendToDiscord(post, discordWebhookURLs[6]) end
function RunyLogsDiscord7(ply, post) sendToDiscord(post, discordWebhookURLs[7]) end
function RunyLogsDiscord8(ply, post) sendToDiscord(post, discordWebhookURLs[8]) end

addEvent("RunyLogsDiscord1", true)
addEventHandler("RunyLogsDiscord1", root, RunyLogsDiscord1)
addEvent("RunyLogsDiscord2", true)
addEventHandler("RunyLogsDiscord2", root, RunyLogsDiscord2)
addEvent("RunyLogsDiscord3", true)
addEventHandler("RunyLogsDiscord3", root, RunyLogsDiscord3)
addEvent("RunyLogsDiscord4", true)
addEventHandler("RunyLogsDiscord4", root, RunyLogsDiscord4)
addEvent("RunyLogsDiscord5", true)
addEventHandler("RunyLogsDiscord5", root, RunyLogsDiscord5)
addEvent("RunyLogsDiscord6", true)
addEventHandler("RunyLogsDiscord6", root, RunyLogsDiscord6)
addEvent("RunyLogsDiscord7", true)
addEventHandler("RunyLogsDiscord7", root, RunyLogsDiscord7)
addEvent("RunyLogsDiscord8", true)
addEventHandler("RunyLogsDiscord8", root, RunyLogsDiscord8)