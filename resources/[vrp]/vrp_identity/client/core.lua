local Tunnel = module("vrp","lib/Tunnel")
local server = Tunnel.getInterface("identity")
local menuactive = false
 RegisterCommand('+identidade',function()
     menuactive = not menuactive
     if menuactive then
        local carteira,Banca,nome,idade,user_id,identidade,telefone,job,jobdois,staff,vip,coins = server.getIdentity()
        SendNUIMessage({ show = true, id = user_id, nome = nome, idade = idade, identidade = identidade, telefone = telefone, job = job, job2 = jobdois, vip = vip, staff = staff, carteira = carteira, Banca = Banca, color = Identity.Color })
     else
        SendNUIMessage({ hide = true })
     end
 end)
 RegisterKeyMapping('+identidade', '[MRQZ] identidade', 'keyboard', 'F11')