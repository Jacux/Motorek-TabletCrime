btccena = nil
ethcena = nil
dogecena = nil

ESX = exports["es_extended"]:getSharedObject()
-- Petle

Citizen.CreateThread(function()

    while true do
        btccena = math.random(Config.minbtcprice, Config.maxbtcprice)
        ethcena = math.random(Config.minethprice, Config.maxethprice)
        dogecena = math.random(Config.mindogeprice, Config.maxdogeprice)
        Citizen.Wait(Config.cryptoupdatemin * 60000)
    end
end)

Citizen.CreateThread(function()

 

        local orgs = MySQL.Sync.fetchAll("SELECT * FROM `addon_organizations`",
                                         {}) or false

        for k, v in pairs(orgs) do

            local stash = {
                id = v.org,
                label = v.name,
                slots = Config.locker['slots'],
                weight = Config.locker['weight']
            }
            exports.ox_inventory:RegisterStash(stash.id, stash.label,
                                               stash.slots, stash.weight)
        end

end)

RegisterNetEvent("Motorek-Crime:RegisterSzafka", function(id, nazwa)

    local stash = {
        id = id,
        label = nazwa,
        slots = Config.locker['slots'],
        weight = Config.locker['weight']
    }
    exports.ox_inventory:RegisterStash(stash.id, stash.label,
                                       stash.slots, stash.weight)
end)

-- Callbacki
ESX.RegisterServerCallback('Motorek-TabletCrime2.0:wezceny',
                           function(source, cb)
    ceny = {btc = btccena, eth = ethcena, doge = dogecena}

    cb(ceny)

end)

ESX.RegisterServerCallback('Motorek-TabletCrime2.0:saveplayergrade',
                           function(source, cb, isn, grade, sgrade)

                            isnINFO = getFromISN(isn)
    
local xTarget = ESX.GetPlayerFromIdentifier(isnINFO.identifier)

if xTarget then

    if tonumber(xTarget.org.grade) >= tonumber(sgrade) then return end
    print(grade)
    xTarget.setOrg(xTarget.org.name, grade)
    if grade == 4 or grade == "4" then
        TriggerClientEvent('esx:showNotification', source,
                           '~r~Może być tylko 1 szef!')
        return
    end
else

    if tonumber(isnINFO.org_grade) >= tonumber(sgrade) then return end
    print(grade)
    if grade == 4 or grade == "4" then
        TriggerClientEvent('esx:showNotification', source,
                           '~r~Może być tylko 1 szef!')
        return
    end

    MySQL.Async.execute(
        "UPDATE `users` SET `org_grade` = @badge WHERE `id` = @identifier",
        {["@identifier"] = isn, ["@badge"] = grade})
    print("nadano")
    cb(true)
end
end)

ESX.RegisterServerCallback('Motorek-TabletCrime2.0:zwolnij',
                           function(source, cb, isn)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    isnINFO = getFromISN(isn)
    
    local xTarget = ESX.GetPlayerFromIdentifier(isnINFO.identifier)


                     --user = xplayer
                     -- user1 = xtarget

if xTarget then 
    if tonumber(xTarget.org.grade) >= tonumber(xPlayer.org.grade) then return end
xTarget.setOrg('unemployed', 0)

else
    local user1 = MySQL.Sync.fetchAll(
                      "SELECT * FROM `users` WHERE `id` = @identifier",
                      {["@identifier"] = isn})[1] or false

    if tonumber(user1.org_grade) >= tonumber(xPlayer.org.grade) then return end
    MySQL.Async.execute(
        "UPDATE `users` SET `org_grade` = @badge WHERE `id` = @identifier",
        {["@identifier"] = isn, ["@badge"] = 0})
    MySQL.Async.execute(
        "UPDATE `users` SET `org` = @badge WHERE `id` = @identifier",
        {["@identifier"] = isn, ["@badge"] = 'unemployed'})

end
    cb(true)
end)

ESX.RegisterServerCallback('Motorek-TabletCrime2.0:saveclothes',
                           function(source, cb, nazwa, skin, org)

    MySQL.Async.execute(
        "INSERT INTO organizations_clothes (name, owner, data) VALUES (@name, @owner, @data)",
        {['@name'] = nazwa, ['@owner'] = org, ['@data'] = skin})

end)
ESX.RegisterServerCallback('Motorek-TabletCrime2.0:buy',
                           function(source, cb, item, price, count, org)
    print(string.match(item, "weapon"))
    print("niue nil")
    local orgg = MySQL.Sync.fetchAll(
                     "SELECT * FROM `addon_organizations` WHERE `org` = @identifier",
                     {["@identifier"] = org})[1] or false
    if orgg.eth >= price then

        MySQL.Async.execute(
            "UPDATE `addon_organizations` SET `eth` = @badge WHERE `org` = @identifier",
            {["@identifier"] = org, ["@badge"] = orgg.eth - price})

        local inventory = exports.ox_inventory:GetInventory(org, false)

        if string.match(item, "weapon") then
            print("1")
            for i = 1, count do
                exports.ox_inventory:AddItem(inventory.dbId, item, 1,
                                             {registered = false}, 1, false)
            end
        else
            print("2")
            for i = 1, count do
                exports.ox_inventory:AddItem(inventory.dbId, item, 1)
            end
        end
        cb(true)
    end

end)

ESX.RegisterServerCallback('Motorek-TabletCrime2.0:deleteclothes',
                           function(source, cb, id)

    MySQL.Async.execute("DELETE FROM `organizations_clothes` WHERE `id` = @id",
                        {["@id"] = id})

end)

ESX.RegisterServerCallback('Motorek:listamiasiaczkow', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    MySQL.Async.fetchAll(
        'SELECT identifier FROM users',
        {}, function(results)
local ziomki = {}

    local xPlayers = ESX.GetPlayers()

    for i=1, #xPlayers, 1 do
        local xPlayer2 = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer2.org.name == xPlayer.org.name  then

            table.insert(ziomki, xPlayer2.identifier);
            
        end
    end


for a, b in pairs(results) do

    for k, v in pairs(ziomki) do

if b.identifier==v then b.identifier = nil end


    end
    if b.identifier ~= nil then

    table.insert(ziomki, b.identifier);
    end
end
local employees1 = {}
MySQL.Async.fetchAll(
    'SELECT * FROM users',
    {}, function(ziomki23)

        for c,d in pairs(ziomki) do
              

                for i = 1, #ziomki23, 1 do
                    if d == ziomki23[i].identifier then
                    local xTarget = ESX.GetPlayerFromIdentifier(ziomki23[i].identifier)

                    if xTarget then
                        status = "active"
                        print(xTarget.org.grade)
                        table.insert(employees1, {
                            name = ziomki23[i].firstname .. ' ' ..
                                ziomki23[i].lastname,
                            identifier = ziomki23[i].identifier,
                            grade = Config.grades[tonumber(xTarget.org.grade)],
                            status = status,
                            id = ziomki23[i].id
                        })
                    else
                        status = "offline"
                        table.insert(employees1, {
                            name = ziomki23[i].firstname .. ' ' ..
                                ziomki23[i].lastname,
                            identifier = ziomki23[i].identifier,
                            grade = Config.grades[ziomki23[i].org_grade],
                            status = status,
                            id = ziomki23[i].id
                        })
                    end

                    
                end
     
                end

            end
            print(json.encode(employees1))
            cb(employees1)
                
            end)

        end)

end)

ESX.RegisterServerCallback('Motorek-TabletCrime2.0:getclothes',
                           function(source, cb, org)
    print(org)
    local clothes = MySQL.Sync.fetchAll(
                        "SELECT * FROM `organizations_clothes` WHERE `owner` = @identifier",
                        {["@identifier"] = org}) or false

    cb(clothes)
end)

ESX.RegisterServerCallback('Motorek-TabletCrime2.0:wezekipe',
                           function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)


    local org = MySQL.Sync.fetchAll(
                    "SELECT * FROM `addon_organizations` WHERE `org` = @identifier",
                    {["@identifier"] = xPlayer.org.name})[1] or false

    cb(org)

end)

ESX.RegisterServerCallback('Motorek-TabletCrime2.0:buyc',
                           function(source, cb, coin, count)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)


    local org = MySQL.Sync.fetchAll(
                    "SELECT * FROM `addon_organizations` WHERE `org` = @identifier",
                    {["@identifier"] = xPlayer.org.name})[1] or false
    if count <= 0 then return end
    if coin == "btc" then
        cena = count * btccena
        if cena <= xPlayer.getAccount('bank').money then

            xPlayer.removeAccountMoney("bank", cena)
            MySQL.Async.execute(
                "UPDATE `addon_organizations` SET `btc` = @badge WHERE `org` = @identifier",
                {["@identifier"] = org.org, ["@badge"] = org.btc + count})
            cb("Pomyślnie zakupiono!")
        end
    end
    if coin == "eth" then
        cena = count * ethcena
        if cena <= xPlayer.getAccount('bank').money then

            xPlayer.removeAccountMoney("bank", cena)
            MySQL.Async.execute(
                "UPDATE `addon_organizations` SET `eth` = @badge WHERE `org` = @identifier",
                {["@identifier"] = org.org, ["@badge"] = org.eth + count})
            cb("Pomyślnie zakupiono!")
        end
    end
    if coin == "doge" then
        cena = count * dogecena
        if cena <= xPlayer.getAccount('bank').money then

            xPlayer.removeAccountMoney("bank", cena)
            MySQL.Async.execute(
                "UPDATE `addon_organizations` SET `doge` = @badge WHERE `org` = @identifier",
                {["@identifier"] = org.org, ["@badge"] = org.doge + count})
            cb("Pomyślnie zakupiono!")
        end
    end
end)
ESX.RegisterServerCallback('Motorek-TabletCrime2.0:sprzedaj',
                           function(source, cb, coin, count)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)


    local org = MySQL.Sync.fetchAll(
                    "SELECT * FROM `addon_organizations` WHERE `org` = @identifier",
                    {["@identifier"] = xPlayer.org.name})[1] or false
    if count <= 0 then return end
    if coin == "btc" then
        cena = count * btccena
        if count <= org.btc then
            MySQL.Async.execute(
                "UPDATE `addon_organizations` SET `btc` = @badge WHERE `org` = @identifier",
                {["@identifier"] = org.org, ["@badge"] = org.btc - count})

            xPlayer.addAccountMoney("bank", cena)
            cb("Pomyślnie sprzedano!")
        end
    end
    if count <= 0 then return end
    if coin == "eth" then
        cena = count * ethcena
        if count <= org.eth then
            MySQL.Async.execute(
                "UPDATE `addon_organizations` SET `eth` = @badge WHERE `org` = @identifier",
                {["@identifier"] = org.org, ["@badge"] = org.eth - count})

            xPlayer.addAccountMoney("bank", cena)
            cb("Pomyślnie sprzedano!")
        end
    end
    if count <= 0 then return end
    if coin == "doge" then
        cena = count * dogecena
        if count <= org.doge then
            MySQL.Async.execute(
                "UPDATE `addon_organizations` SET `doge` = @badge WHERE `org` = @identifier",
                {["@identifier"] = org.org, ["@badge"] = org.doge - count})

            xPlayer.addAccountMoney("bank", cena)
            cb("Pomyślnie sprzedano!")
        end
    end
end)
ESX.RegisterServerCallback('Motorek-TabletCrime2.0:playerinfo',
                           function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer == nil then return end

    local org = MySQL.Sync.fetchAll(
                    "SELECT * FROM `addon_organizations` WHERE `org` = @identifier",
                    {["@identifier"] =  xPlayer.org.name})[1] or false
    info = {['user'] = {org =  xPlayer.org.name,
org_grade = tonumber(xPlayer.org.grade)} , ['org'] = org}
    cb(info)

end)

ESX.RegisterServerCallback('Motorek-TabletCrime2.0:medyk', function(source, cb)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)


    local org = MySQL.Sync.fetchAll(
                    "SELECT * FROM `addon_organizations` WHERE `org` = @identifier",
                    {["@identifier"] = xPlayer.org.name})[1] or false
    if org.btc < 2 then return end

    MySQL.Async.execute(
        "UPDATE `addon_organizations` SET `medic` = @badge WHERE `org` = @identifier",
        {["@identifier"] = org.org, ["@badge"] = 1})
    cb("Pomyślnie zakupiono!")
end)

-- Eventy
RegisterNetEvent("Motorek-TabletCrime2.0:bucket")
AddEventHandler("Motorek-TabletCrime2.0:bucket", function(bckt)
    local _source = source

    SetPlayerRoutingBucket(_source, tonumber(bckt))
    print(GetPlayerRoutingBucket(_source))
end)
RegisterNetEvent("Motorek-TabletCrime2.0:invite")
AddEventHandler("Motorek-TabletCrime2.0:invite", function(id, org)
    local _source = source
    if tonumber(source) == tonumber(id) then return end
    ajdi = id

    TriggerClientEvent("Motorek-TabletCrime2.0:invitecl", id, org, ajdi)
end)
ESX.RegisterServerCallback('Motorek-TabletCrime2.0:upgrade',
                           function(source, cb, lvl)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)


    local org = MySQL.Sync.fetchAll(
                    "SELECT * FROM `addon_organizations` WHERE `org` = @identifier",
                    {["@identifier"] = xPlayer.org.name})[1] or false
    print(org.btc)
    print(lvl)
    if org.btc < 5 then
        cb("Nie masz wystarczająco środków")
        return
    end
    if org.upgrade ~= lvl - 1 then
        cb("Najpierw odblokuj poprzednie poziomy!")
        return
    end

    if org.btc >= 5 and org.upgrade == lvl - 1 then

        MySQL.Async.execute(
            "UPDATE `addon_organizations` SET `upgrade` = @badge WHERE `org` = @identifier",
            {["@identifier"] = org.org, ["@badge"] = tonumber(lvl)})
        MySQL.Async.execute(
            "UPDATE `addon_organizations` SET `btc` = @badge WHERE `org` = @identifier",
            {["@identifier"] = org.org, ["@badge"] = org.btc - 5})
        cb("Pomyślnie zakupiono ulepszenie!")
    end
end)

ESX.RegisterServerCallback('Motorek-TabletCrime2.0:recruit',
                           function(source, cb, id, org)
    if id == nil then
        print(id)
        return
    end
    if tonumber(source) ~= tonumber(id) then
        print(source)
        print(id)
        return
    end
    if org == nil then
        print("org")
        return
    end
    local xPlayer = ESX.GetPlayerFromId(id)
    xPlayer.setOrg(org, 0)
   
end)
RegisterNetEvent('Motorek-TabletCrime2.0:zaloz')
AddEventHandler('Motorek-TabletCrime2.0:zaloz', function(nazwa)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local ilemam = xPlayer.getInventoryItem(Config.item).count

    if ilemam >= Config.ilosc then


        local numer =
            MySQL.Sync.fetchAll("SELECT * FROM `last_org`  ", {})[1] or false

        numer = tonumber(numer.last)
        print(xPlayer.org.name )
        if xPlayer.org.name == 'unemployed' or xPlayer.org.name == nil then

            xPlayer.removeInventoryItem(Config.item, Config.ilosc)
            TriggerClientEvent('esx:showNotification', _source,
                               '~g~Pomyślnie założono organizację: ~w~' ..
                                   nazwa)

            MySQL.Async.execute("UPDATE `last_org` SET `last` = @badge",
                                {["@badge"] = numer + 1})

            local orggg = 'org' .. numer
            MySQL.Async.execute(
                "INSERT INTO addon_organizations (org, name, owner, account, wallet) VALUES (@org,@name, @owner, @konto, @wallet)",
                {
                    ['@org'] = orggg,
                    ['@name'] = nazwa,
                    ['@owner'] = xPlayer.identifier,
                    ['@konto'] = GenerateBank(),
                    ['@wallet'] = GenerateWallet()
                })
            print(orggg)
            xPlayer.setOrg(orggg, 4)
TriggerEvent("Motorek-Crime:RegisterSzafka", orgggg, nazwa)

        else
            TriggerClientEvent('esx:showNotification', _source,
                               '~r~Masz już organizację')
        end
    else
        TriggerClientEvent('esx:showNotification', _source,
                           '~r~Nie posiadasz przedmiotów')
    end
end)

RegisterNetEvent('Motorek-TabletCrime2.0:szafka')
AddEventHandler('Motorek-TabletCrime2.0:szafka', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    print(xPlayer.org.grade)
    print(Config.locker['grade'])
    print(xPlayer.org.name ~= nil)
    if xPlayer.org.name ~= 'unemployed' and tonumber(xPlayer.org.grade) >= Config.locker['grade'] then
        print("#1")
        TriggerClientEvent("Motorek-TabletCrime2.0:szafkacl", _source, xPlayer.org.name)
    end
end)

ESX.RegisterServerCallback('Motorek-TabletCrime2.0:przelew',
                           function(source, cb, coin, count, wallet)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)


    local org = MySQL.Sync.fetchAll(
                    "SELECT * FROM `addon_organizations` WHERE `org` = @identifier",
                    {["@identifier"] = xPlayer.org.name})[1] or false
    local target = MySQL.Sync.fetchAll(
                       "SELECT * FROM `addon_organizations` WHERE `wallet` = @identifier",
                       {["@identifier"] = wallet})[1] or false
    if not target then
        cb("Nie ma takiego portfela!")
        return
    end

    if coin == "eth" then

        if org.eth >= count then

            MySQL.Async.execute(
                "UPDATE `addon_organizations` SET `eth` = @badge WHERE `org` = @identifier",
                {["@identifier"] = org.org, ["@badge"] = org.eth - count})
            MySQL.Async.execute(
                "UPDATE `addon_organizations` SET `eth` = @badge WHERE `wallet` = @identifier",
                {["@identifier"] = wallet, ["@badge"] = target.eth + count})
            cb("Pomyślnie wysłano!")
        end
        if coin == "btc" then

            if org.btc >= count then

                MySQL.Async.execute(
                    "UPDATE `addon_organizations` SET `eth` = @badge WHERE `org` = @identifier",
                    {["@identifier"] = org.org, ["@badge"] = org.btc - count})
                MySQL.Async.execute(
                    "UPDATE `addon_organizations` SET `eth` = @badge WHERE `wallet` = @identifier",
                    {["@identifier"] = wallet, ["@badge"] = target.btc + count})
                cb("Pomyślnie wysłano!")
            end
        end
        if coin == "doge" then

            if org.doge >= count then

                MySQL.Async.execute(
                    "UPDATE `addon_organizations` SET `eth` = @badge WHERE `org` = @identifier",
                    {["@identifier"] = org.org, ["@badge"] = org.doge - count})
                MySQL.Async.execute(
                    "UPDATE `addon_organizations` SET `eth` = @badge WHERE `wallet` = @identifier",
                    {["@identifier"] = wallet, ["@badge"] = target.doge + count})
                cb("Pomyślnie wysłano!")
            end
        end
    end

end)
-- Konto
function GenerateBank()
    repeat
        gen = GenerateAccountNumber()

        local num = CheckAccountNumber(gen)

    until num == nil
    return gen
end

function GenerateAccountNumber()
    local numBase0 = math.random(100, 999)
    local numBase1 = math.random(0, 9999)
    local num = string.format("%03d%04d", numBase0, numBase1)
    return num
end

function CheckAccountNumber(numer)
    local result = MySQL.Sync.fetchAll(
                       "SELECT * FROM addon_organizations WHERE addon_organizations.account = @konto",
                       {['@konto'] = numer})
    if result[1] ~= nil then return "zajete" end
    return nil
end
-- Wallet
function GenerateWallet()
    repeat
        gen = GenerateWalletNumber()

        local num = CheckWalletNumber(gen)

    until num == nil
    return gen
end

function getFromISN(isn)
    local user = MySQL.Sync.fetchAll(
                     "SELECT * FROM `users` WHERE `id` = @identifier",
                     {["@identifier"] = isn})[1] or false

                     return user

end
function GenerateWalletNumber()
    wallet = "0x"

    repeat
        local gen = math.random(1, 9)

        wallet = wallet .. gen
    until string.len(wallet) == 10

    return wallet

end
function CheckWalletNumber(wallet)
    local result = MySQL.Sync.fetchAll(
                       "SELECT * FROM addon_organizations WHERE addon_organizations.wallet = @wallet",
                       {['@wallet'] = wallet})
    if result[1] ~= nil then return "zajete" end
    return nil
end

------------------------------------------------------------------------------------------------------------------------
--[[

░█████╗░██████╗░██╗░░░██╗██████╗░████████╗░█████╗░
██╔══██╗██╔══██╗╚██╗░██╔╝██╔══██╗╚══██╔══╝██╔══██╗
██║░░╚═╝██████╔╝░╚████╔╝░██████╔╝░░░██║░░░██║░░██║
██║░░██╗██╔══██╗░░╚██╔╝░░██╔═══╝░░░░██║░░░██║░░██║
╚█████╔╝██║░░██║░░░██║░░░██║░░░░░░░░██║░░░╚█████╔╝
░╚════╝░╚═╝░░╚═╝░░░╚═╝░░░╚═╝░░░░░░░░╚═╝░░░░╚════╝░

]] --
