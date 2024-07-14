local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local cfg = module("vrp","cfg/groups")
vRP = Proxy.getInterface("vRP")
src = {}
Tunnel.bindInterface("loginConfigS", src)

function src.getCoords()
  if vRP.getUserId(source) then
    if vRP.hasGroup(vRP.getUserId(source),"ballas") then
      return {88.55,-1959.91,20.75}
    elseif vRP.hasGroup(vRP.getUserId(source),"groove") then
      return {-151.41,-1686.22,32.88}
    elseif vRP.hasGroup(vRP.getUserId(source),"vagos") then
      return {300.99,-2018.26,20.27}
    elseif vRP.hasGroup(vRP.getUserId(source),"crips") then
      return {1280.24,-1722.09,54.66}
    elseif vRP.hasGroup(vRP.getUserId(source),"bloods") then
      return {-1088.23,-1672.01,4.71}
    elseif vRP.hasGroup(vRP.getUserId(source),"bahamas") then
      return {-1393.24,-639.08,28.68}
    elseif vRP.hasGroup(vRP.getUserId(source),"lifeinvader") then
      return {-1047.64,-240.11,37.97}
    elseif vRP.hasGroup(vRP.getUserId(source),"yardie") then
      return {-1526.6,869.79,181.75}
    elseif vRP.hasGroup(vRP.getUserId(source),"siciliana") then
      return {-1462.46,-41.03,54.66}
    end
  end
end

