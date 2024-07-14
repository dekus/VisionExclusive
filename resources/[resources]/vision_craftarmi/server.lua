local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

vision = {}
Tunnel.bindInterface(GetCurrentResourceName(), vision)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARRAY
-----------------------------------------------------------------------------------------------------------------------------------------
local valores = {
    {
        itemReq = "armacaodearma",
        qtdReq = 60,
        item = "wbody|WEAPON_PISTOL_MK2",
        qtd = 1,
        perm = "armas.autorizzazione",
        dinheiroReq = 35000
    }, --- FIVE
    --[[{
        itemReq = "armacaodemp5",
        qtdReq = 1,
        item = "wbody|WEAPON_SMG_MK2",
        qtd = 1,
        perm = "armas.autorizzazione",
        dinheiroReq = 110000
    }, --- MP5
    {
        itemReq = "armacaodescar",
        qtdReq = 1,
        item = "wbody|WEAPON_HEAVYRIFLE",
        qtd = 1,
        perm = "armas.autorizzazione",
        dinheiroReq = 375000
    }, --- AK
    {
        itemReq = "armacaodeg3",
        qtdReq = 1,
        item = "wbody|WEAPON_SPECIALCARBINE_MK2",
        qtd = 1,
        perm = "armas.autorizzazione",
        dinheiroReq = 375000
    }, --- G3
    {
        itemReq = "armacaodeglock18",
        qtdReq = 1,
        item = "wbody|WEAPON_APPISTOL",
        qtd = 1,
        perm = "armas.autorizzazione",
        dinheiroReq = 75000
    } --- GLOCK 18--]]
}

local delayArmas = {}

-----------------------------------------------------------------------------------------------------------------------------------------
-- COMPRARE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("vision:ArmasTransformar")
AddEventHandler("vision:ArmasTransformar",function(item)
  local source = source
  local user_id = vRP.getUserId(source)
  if user_id then
    for k, v in pairs(valores) do
      if item == v.item then
        if vRP.hasPermission(user_id, v.perm) or vRP.hasPermission(user_id, "admin.autorizzazione") then
          if vRP.getInventoryWeight(user_id) + vRP.getItemWeight(v.item) * v.qtd <= vRP.getInventoryMaxWeight(user_id) then
            if vRP.getInventoryItemAmount(user_id, v.itemReq) >= v.qtdReq then
              if not v.dinheiroReq then
                if vRP.tryGetInventoryItem(user_id, v.itemReq, v.qtdReq) then
                  TriggerClientEvent("vision:ArmasFecharNui", source)
                  TriggerClientEvent("cancelando", source, true)
                  TriggerClientEvent("vision:TravarPed", source, true)
                  TriggerClientEvent("progress", source, 5000)
                  TriggerClientEvent("armas:anin", source, true)
                  SetTimeout(5000, function()
                    TriggerClientEvent("cancelando", source, false)
                    TriggerClientEvent("vision:TravarPed", source, false)
                    vRP.giveInventoryItem(user_id, v.item, v.qtd)
                    TriggerClientEvent("Notify",source,"successo","Convertito: \n<b>" .. v.qtdReq .. "x " .. vRP.itemNameList(v.itemReq) .. "</b> >> <b>" .. v.qtd .. "x " .. vRP.itemNameList(v.item) .. "</b>")  
                  end)
                else
                  TriggerClientEvent("Notify", source, "negato", "Creazione non riuscita. ")
                end
              else
                if vRP.tryFullPayment(user_id, v.dinheiroReq) then
                  if vRP.tryGetInventoryItem(user_id, v.itemReq, v.qtdReq) then
                    TriggerClientEvent("vision:ArmasFecharNui", source)
                    TriggerClientEvent("cancelando", source, true)
                    TriggerClientEvent("vision:TravarPed", source, true)
                    TriggerClientEvent("progress", source, 5000)
                    TriggerClientEvent("armas:anin", source, true)
                    SetTimeout(5000, function()
                      TriggerClientEvent("cancelando", source, false)
                      TriggerClientEvent("vision:TravarPed", source, false)
                      vRP.giveInventoryItem(user_id, v.item, v.qtd)
                      TriggerClientEvent("Notify",source,"successo","Convertito: \n<b>" .. v.qtdReq .. "x " .. vRP.itemNameList(v.itemReq) .. "</b> >> <b>" .. v.qtd .. "x " .. vRP.itemNameList(v.item) .. "</b>")
                      local count = math.random(12000,20000)
                      if vRP.hasPermission(user_id, 'bloods.autorizzazione') then 
                        TriggerEvent('vision:saldofac:Add', 'bloods', count )
                      elseif vRP.hasPermission(user_id, 'crips.autorizzazione') then
                        TriggerEvent('vision:saldofac:Add', 'crips', count )
                      end
                    end)
                  else
                      TriggerClientEvent("Notify", source, "negato", "Fallimento della creazione. ")
                  end
                else
                  TriggerClientEvent("Notify", source, "negato", "Non hai abbastanza soldi. Te ne occorono: "..v.dinheiroReq)
                end
              end
            else
                TriggerClientEvent("Notify",source,"negato",'Non hai i componenti necessari per questo. Te ne occorrono: <b>' ..v.qtdReq .."<b> di " ..vRP.itemNameList(v.itemReq))
            end
          else
              TriggerClientEvent("Notify", source, "negato", "Spazio insufficiente.")
          end
        else
          TriggerClientEvent("Notify", source, "negato", "Non puoi farlo.")
        end
      end
    end
  end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- Check permessi per aprire il menu
-----------------------------------------------------------------------------------------------------------------------------------------
function vision.checkPermission()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "armas.autorizzazione") then
        return true
    else
        TriggerClientEvent("Notify", source, "avviso", "Non sei autorizzato a farlo.")
        return false
    end
end
