config = {
    skill = {
        [1] = {time = 2000, animX = 'sword_2', animX2 = 'sword_1', animtarget = 'neck2', effect = true},
        [2] = {time = 3000, animX = 'fight', animX2 = false, effect = false},
        [3] = {time = 3000, animX = 'fight', animX2 = false, effect = false},
    },
    status = { -- configuração quando o player cair / finalizado ou revivido
        vida_cair = 12, 

        tempo = { -- milissegundos
            [true] = 90000; -- com headshot
            [false] = 90000; -- sem headshot
        };

        anim = {'CRACK', 'crckdeth2'}, 

        controls = { -- controles que serão tirados do jogador enquanto ele está caido (https://wiki.multitheftauto.com/wiki/Control_names)
            'fire', 'aim_weapon', 'next_weapon', 'previous_weapon', 'forwards', 'backwards', 'left', 'right', 'zoom_in', 'zoom_out',
            'change_camera', 'jump', 'sprint', 'look_behind', 'crouch', 'action', 'walk', 'conversation_yes', 'conversation_no',
            'group_control_forwards', 'group_control_back', 'enter_exit', 'vehicle_fire', 'vehicle_secondary_fire', 'vehicle_left', 'vehicle_right',
            'steer_forward', 'steer_back', 'accelerate', 'brake_reverse', 'radio_next', 'radio_previous', 'radio_user_track_skip', 'horn', 'sub_mission',
            'handbrake', 'vehicle_look_left', 'vehicle_look_right', 'vehicle_look_behind', 'vehicle_mouse_look', 'special_control_left', 'special_control_right',
            'special_control_down', 'special_control_up' 
        }, 
    }, 

}

function message(player, text, type) 
    exports['nock_infobox']:addBox(player, text, type)
end

r, g, b, a = 101, 101, 101, 90