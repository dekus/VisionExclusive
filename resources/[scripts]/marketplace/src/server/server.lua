local Tunnel = module("vrp", "lib/Tunnel");
local Proxy = module("vrp", "lib/Proxy");
vRP = Proxy.getInterface("vRP");

src = {};
Tunnel.bindInterface("marketplace-Server", src);

vRP.prepare('marketplace/selectTable','SELECT * FROM marketplace')
vRP.prepare('marketplace/announceItem','INSERT IGNORE INTO marketplace(name,spawn,quantity,price,announcer,image,item_id) VALUES(@name,@spawn,@quantity,@price,@announcer,@image,@item_id)')
vRP.prepare('marketplace/removeItem', 'DELETE FROM marketplace WHERE announcer = @announcer AND item_id = @item_id')
vRP.prepare('marketplace/selectSeller','SELECT * FROM vrp_user_moneys WHERE user_id = @user_id')
vRP.prepare('marketplace/updateSellerCash','UPDATE vrp_user_moneys SET bank = @bank WHERE user_id = @user_id')

local function paySeller(data)
  local nidentity = vRP.getUserIdentity(data.announcer)
  local nsource = vRP.getUserSource(data.announcer)
  local sellerBank = vRP.query('marketplace/selectSeller', { user_id = data.announcer })
  if not nsource then
    vRP.execute("marketplace/updateSellerCash", {user_id = data.announcer, bank = parseInt(sellerBank[1].bank + data.price) })
  else
    vRP.giveBankMoney(data.announcer,data.price)
    TriggerClientEvent("Notify", nsource, "importante", "Hai venduto <b>"..data.quantity.." "..data.name.."</b> per <b>€ "..vRP.format(data.price).."</b>!")
  end
end

function src.buy(data)
  local user_id = vRP.getUserId(source)
  if not vRP.itemNameList(data.spawn) then
    TriggerClientEvent("Notify", source, "negato", "Questo item non esiste, contatta lo staff!")
    print("ERRORE | SPAWN: '"..data.spawn.."' non esiste! Controlla la configurazione dell'item: "..data.name)
    return false
  end
  if not user_id and not data then return false end
  if parseInt(vRP.getInventoryWeight(user_id) + vRP.getItemWeight(data.spawn)) > vRP.getInventoryMaxWeight(user_id) then
    TriggerClientEvent("Notify", source, "negato", "Non possiedi <b>spazio</b> nella tua borsa!") 
    return false
  end
  if vRP.tryFullPayment(user_id, data.price) then
    TriggerClientEvent("Notify", source, "successo", "Hai pagato <b>€ "..vRP.format(data.price).." euro!</b>")
    vRP.giveInventoryItem(user_id, data.spawn, data.quantity)
    vRP.execute('marketplace/removeItem', {announcer = data.announcer, item_id = data.item_id})
    paySeller(data)
    return true
  else
    TriggerClientEvent("Notify", source, "negato", "Non possiedi <b>€ "..vRP.format(data.price).." euro!</b>")
    return false
  end
end

local Token = {
  ['letter'] = {'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'},
  ['number'] = {1,2,3,4,5,6,7,8,9,0},
  ['symbols'] = {"!","@","#","$","%","&","*","+","-","/",":","<","=",">","?","^"},
}

function genToken(length)
  local empty = 'k'
  for i = 1, length do
    local sort = math.random(1,3) 
      if sort == 1 then
          local randomNumber = math.random(1,#Token['number'])
          empty = empty .. Token['number'][randomNumber]
      elseif sort == 2 then
          local randomLetter = math.random(1,#Token['letter'])
          empty = empty .. Token['letter'][randomLetter]
      elseif sort == 3 then
        local randomSymbol = math.random(1,#Token['symbols'])
        empty = empty .. Token['symbols'][randomSymbol]
      end
  end
  return empty
end

function src.announce(data)
  local source = source
  local user_id = vRP.getUserId(source)
  if not vRP.itemNameList(data.spawn) then
    TriggerClientEvent("Notify", source, "negato", "Questo item non esiste, contatta lo staff!")
    print("ERROR | SPAWN: '"..data.spawn.."' non esiste controlla il config dell'item: "..data.name)
    return
  end
  if not user_id or not data then
    return
  end
  local randomInt = tostring(math.random(0,2147483647));
  local quantity = parseInt(vRP.prompt(source, "Digita la quantità "..data.name.." che desideri annunciare:",""));
  if quantity > vRP.getInventoryItemAmount(user_id, data.spawn) then
    TriggerClientEvent("Notify", source, "negato", "Non hai "..quantity.." "..data.name.." nel tuo zaino!")
    return
  elseif quantity < 1 then
    return
  end
  local price = parseInt(vRP.prompt(source, "Digita la quantità "..data.name.." che desideri annunciare:",""));
  if price >= 2147483647 then
    TriggerClientEvent("Notify", source, "negato", "Valore non valido!")
    return
  elseif price < 1 then
    return
  end
  if vRP.request(source, "Vuoi confermare l'invio di <b>"..quantity.." "..data.name.."</b> per <b>€ "..vRP.format(price).."</b> nel Marketplace?",15) then
    if vRP.tryGetInventoryItem(user_id, data.spawn, quantity) then
      vRP.execute('marketplace/announceItem', { announcer = user_id, quantity = quantity, spawn = data.spawn, name = data.name, price = price, image = data.image, item_id = genToken(20) })
    end
  end
end

function src.getAnnouncedItems()
  local query = vRP.query('marketplace/selectTable')
  return query
end

function src.getMochila()
  local source = source
  local user_id = vRP.getUserId(source)
  local data = vRP.getUserDataTable(user_id)
  local inventario = {}

  if data and data.inventory then
    for k, v in pairs(data.inventory) do
      if vRP.itemBodyList(k) and not isInBlacklist(k) then
        table.insert(inventario, { quantity = parseInt(v.amount), name = vRP.itemNameList(k), image = vRP.itemIndexList(k), spawn = k })
      end
    end
    return inventario
  end
end

function isInBlacklist(itemName)
  for _, blacklistedItem in ipairs(Config.Blacklist) do
    if blacklistedItem == itemName then
      return true
    end
  end
  return false
end
