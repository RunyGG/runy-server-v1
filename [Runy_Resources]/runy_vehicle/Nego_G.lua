Config = {
    ["Anti-Cheat"] = {
        ["name"] = "KING's Anti-Cheat",
        ["webhook"] = "https://discord.com/api/webhooks/1270932378503745618/209ZSbvIbqQn1ewlWfWcD3HFICX1_rt-jWHTGsm70ik_d_Md5GI1kPhV8WiZ_bxJRtSU",
        ["Fire-Hack"] = {
            ["Fire-acls-allowed"] = {
                "Console",
                "Admin",
                "Staff"
            },
            ["Fire-data-allowed"] = {
                "cweapon"
            },
            ["Fire-weapons-allowed"] = {
                "m4",
                "imbel",
                "g36c",
                "ak",
                "m240",
                "five",
                "glock",
                "magnum",
                "thompson",
                "mp5",
                "uzi",
                "vector",
                "bazooka",
                "escopeta",
                "revolver",
                "taser",
                "p90",
                "machine1",
                "machine2",
                "caseira",
            },
            ["Fire-ids"] = {
                23,
                24,
                25,
                26,
                27,
                29,
                30,
                31,
                32,
                33,
                34,
                35,
                36,
                37,
                38
            },
        },
        ["Explosion"] = {
            ["explosion-ids"] = {
                0,
                1,
                2,
                3,
                8,
                10,
                11,
                12
            },
            ["explosion-acls-allowed"] = {
                "Console",
                "Admin",
                "Staff"
            },
            ["Explosion-data-allowed"] = {
                "cweapon",
            }
        },
        ["Speed"] = {
            ["max-speed"] = 1,
            
            ["speed-acls-allowed"] = {
                "Console",
                "Admin",
                "Staff"
            },
            
            ["speed-data-allowed"] = {
                "Usando",
            }
        },
        ["Fly"] = {
            ["Fly-acls-allowed"] = {
                "Console",
                "Admin",
                "Staff"
            },
            ["Fly-data-allowed"] = {
                "StaffNaSituação",
            }
        },
        ["Projectile"] = {
            ["Projectile-acls-allowed"] = {
                "Console",
                "Admin",
                "Staff"
            },
        },
        ["JetPack"] = {
            ["jetpack-acls-allowed"] = {
                "Console",
                "Admin",
                "Staff"
            },
            
            ["JetPack-data-allowed"] = {
                "StaffNaSituação",
            }
        },
    }
}

notifyS = function (thePlayer, msg, type)
    triggerClientEvent (thePlayer, "addBox", thePlayer, msg, type)
end

notifyC = function (msg, type)
    triggerEvent ("addBox", localPlayer, msg, type)
end


formatNumber = function(number)   
    local formatted = number   
    while true do       
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1.%2')     
        if ( k==0 ) then       
            break   
        end   
    end   
    return formatted 
end 

function removeHex (s)
    if type (s) == "string" then
        while (s ~= s:gsub ("#%x%x%x%x%x%x", "")) do
            s = s:gsub ("#%x%x%x%x%x%x", "")
        end
    end
    return s or false
end


ElementsChange = { -- Lista de elementos permitidos (que a alteração é permitida no anti-cheat)
    "coloque aqui seus elements",
    "coloque aqui seus elements",
    "coloque aqui seus elements"
}

checkElementChange = true -- Anti element data change

luaexec1 = true -- Anti lua exec (lua executores, debug hook, loadstring, etc)


versaominima = "1.6.0-9.22596.0" -- Versão mínima do MTA SA para jogar no servidor

