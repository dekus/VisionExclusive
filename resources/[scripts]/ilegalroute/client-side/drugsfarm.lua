local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
mrqz = Tunnel.getInterface("drogas_farm")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")


-- FARM MACONHA
local PermMaconha, GrooveOn = 'grove.autorizzazione', false
local PosMaconha1 = {102.93,6340.72,31.38}
local PosMaconha2 = {114.16,6360.45,32.31}
local PosMaconha3 = {116.72,6361.84,32.3}

-- FARM K9
local PermK9, VagosOn = 'vagos.autorizzazione', false
local PosK9_1 = {-1108.74,4952.3,218.65}
local PosK9_2 = {-1107.38,4948.73,218.65}
local PosK9_3 = {-1107.62,4939.38,218.65}

-- FARM KROKO
local PermKROKO, BallasOn = 'ballas.autorizzazione', false
local PosKROKO1 = {1505.61,6392.06,20.79}
local PosKROKO2 = {1494.68,6395.5,20.79}
local PosKROKO3 = {1493.24,6390.24,21.26}


RegisterCommand('startfarm', function(source, args, rawCmd)
  if mrqz.TemPermissao('ballas.autorizzazione') then
    BallasOn = not BallasOn
  elseif mrqz.TemPermissao('grove.autorizzazione') then
    GrooveOn = not GrooveOn
  elseif mrqz.TemPermissao('vagos.autorizzazione') then
    VagosOn = not VagosOn
  end
end)

Citizen.CreateThread(function() 
while true do
  local timeDistance = 5000
  local ped = PlayerPedId()
  local PedCoord = GetEntityCoords(ped)
  if GrooveOn then
    timeDistance = 5
    DrawMarker(20, PosMaconha1[1], PosMaconha1[2], PosMaconha1[3], 0, 0, 0, 180.0, 0, 0, 0.25, 0.25, 0.25, 255,255,255,180, 1, 0, 0, 1)
    if Vdist2(PedCoord, PosMaconha1[1], PosMaconha1[2], PosMaconha1[3]) < 4.0 then
      if IsControlJustPressed(0, 38) and mrqz.TemPermissao(PermMaconha) then
        Animar()
        mrqz.iojnoIBAIUGFVBUIABSdkj(PermMaconha, 'folhademaconha')
      end
    end
    DrawMarker(20, PosMaconha2[1], PosMaconha2[2], PosMaconha2[3], 0, 0, 0, 180.0, 0, 0, 0.25, 0.25, 0.25, 255,255,255,180, 1, 0, 0, 1)
    if Vdist2(PedCoord, PosMaconha2[1], PosMaconha2[2], PosMaconha2[3]) < 1.5 then
      if IsControlJustPressed(0, 38) and mrqz.TemPermissao(PermMaconha) then
        Animar()
        mrqz.iojnoIBAIUGFVBUIABSdkj(PermMaconha, 'maconhamacerada', 1, 'folhademaconha')
      end
    end
    DrawMarker(20, PosMaconha3[1], PosMaconha3[2], PosMaconha3[3], 0, 0, 0, 180.0, 0, 0, 0.25, 0.25, 0.25, 255,255,255,180, 1, 0, 0, 1)
    if Vdist2(PedCoord, PosMaconha3[1], PosMaconha3[2], PosMaconha3[3]) < 1.5 then
      if IsControlJustPressed(0, 38) and mrqz.TemPermissao(PermMaconha) then
        Animar()
        mrqz.iojnoIBAIUGFVBUIABSdkj(PermMaconha, 'baseado', 3, 'maconhamacerada')
      end
    end
  end
  if VagosOn then
    timeDistance = 5
    DrawMarker(20, PosK9_1[1], PosK9_1[2], PosK9_1[3], 0, 0, 0, 180.0, 0, 0, 0.25, 0.25, 0.25, 255,255,255,180, 1, 0, 0, 1)
    if Vdist2(PedCoord, PosK9_1[1], PosK9_1[2], PosK9_1[3]) < 1.5 then
      if IsControlJustPressed(0, 38) and mrqz.TemPermissao(PermK9) then
        Animar()
        mrqz.iojnoIBAIUGFVBUIABSdkj(PermK9, 'folhademaconha')
      end
    end
    DrawMarker(20, PosK9_2[1], PosK9_2[2], PosK9_2[3], 0, 0, 0, 180.0, 0, 0, 0.25, 0.25, 0.25, 255,255,255,180, 1, 0, 0, 1)
    if Vdist2(PedCoord, PosK9_2[1], PosK9_2[2], PosK9_2[3]) < 1.5 then
      if IsControlJustPressed(0, 38) and mrqz.TemPermissao(PermK9) then
        Animar()
        mrqz.iojnoIBAIUGFVBUIABSdkj(PermK9, 'canabinol', 1, 'folhademaconha')
      end
    end
    DrawMarker(20, PosK9_3[1], PosK9_3[2], PosK9_3[3], 0, 0, 0, 180.0, 0, 0, 0.25, 0.25, 0.25, 255,255,255,180, 1, 0, 0, 1)
    if Vdist2(PedCoord, PosK9_3[1], PosK9_3[2], PosK9_3[3]) < 1.5 then
      if IsControlJustPressed(0, 38) and mrqz.TemPermissao(PermK9) then
        Animar()
        mrqz.iojnoIBAIUGFVBUIABSdkj(PermK9, 'k9', 3, 'canabinol')
      end
    end
  end
  if BallasOn then
    timeDistance = 5
    DrawMarker(20, PosKROKO1[1], PosKROKO1[2], PosKROKO1[3], 0, 0, 0, 180.0, 0, 0, 0.25, 0.25, 0.25, 255,255,255,180, 1, 0, 0, 1)
    if Vdist2(PedCoord, PosKROKO1[1], PosKROKO1[2], PosKROKO1[3]) < 1.5 then
      if IsControlJustPressed(0, 38) and mrqz.TemPermissao(PermKROKO) then
        Animar()
        mrqz.iojnoIBAIUGFVBUIABSdkj(PermKROKO, 'iodo')
      end
    end
    DrawMarker(20, PosKROKO2[1], PosKROKO2[2], PosKROKO2[3], 0, 0, 0, 180.0, 0, 0, 0.25, 0.25, 0.25, 255,255,255,180, 1, 0, 0, 1)
    if Vdist2(PedCoord, PosKROKO2[1], PosKROKO2[2], PosKROKO2[3]) < 1.5 then
      if IsControlJustPressed(0, 38) and mrqz.TemPermissao(PermKROKO) then
        Animar()
        mrqz.iojnoIBAIUGFVBUIABSdkj(PermKROKO, 'codeina', 1, 'iodo')
      end
    end
    DrawMarker(20, PosKROKO3[1], PosKROKO3[2], PosKROKO3[3], 0, 0, 0, 180.0, 0, 0, 0.25, 0.25, 0.25, 255,255,255,180, 1, 0, 0, 1)
    if Vdist2(PedCoord, PosKROKO3[1], PosKROKO3[2], PosKROKO3[3]) < 1.5 then
      if IsControlJustPressed(0, 38) and mrqz.TemPermissao(PermKROKO) then
        Animar()
        mrqz.iojnoIBAIUGFVBUIABSdkj(PermKROKO, 'krokodil', 3, 'codeina')
      end
    end
  end
    Citizen.Wait(timeDistance)
  end
end)

function Animar()
  local ped = PlayerPedId()
  FreezeEntityPosition(ped, true)
  vRP._playAnim(false, {"amb@prop_human_parking_meter@female@idle_a", "idle_a_female"}, true)
  TriggerEvent('progress', 7500)
  Wait(7500)
  FreezeEntityPosition(ped, false)
  ClearPedTasks(ped)
end