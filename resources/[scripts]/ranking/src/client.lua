local Tunnel = module("vrp","lib/Tunnel")
vServer = Tunnel.getInterface("rankingServer")

RegisterCommand("rankfazioni", function()
  local tableFacs = vServer.getRanks()
  SetNuiFocus(true, true)
  SendNUIMessage({ show = true, facs = tableFacs})
end)

RegisterNuiCallback("removeFocus", function(_, cb)
  SetNuiFocus(false, false)
  cb({success = true})
end)