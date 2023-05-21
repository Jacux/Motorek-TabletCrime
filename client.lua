ESX = exports["es_extended"]:getSharedObject()


RegisterCommand("crime", function(source, args)

    TriggerEvent("Motorek-Crime:tablet")
    

    
end)
RegisterNetEvent("Motorek-Crime:tablet")
AddEventHandler("Motorek-Crime:tablet", function()
    ESX.TriggerServerCallback('Motorek-TabletCrime2.0:playerinfo', function(info)
        if info['user'].org_grade == nil then CancelEvent() return end
        print(info['user'].org_grade)
        if info['user'].org_grade >= Config.tabletgrade then
            SetDisplay(not display)
        end

            end)
    TriggerEvent("Motorek-TabletCrime2.0:updateludki")
    for k,v in pairs(Config.Shop) do
   
                    SendNUIMessage({
                        type = "sklep",
                        number = k,
                        title = v.title,
                        item = v.item,
                        desc = v.description,
                        count = v.count,
                        price = v.price,
                        lvl1 = Config.maxusers[1],
                        lvl2 = Config.maxusers[2],
                        lvl3 = Config.maxusers[3],
                    })
                end

                
                ESX.TriggerServerCallback('Motorek-TabletCrime2.0:wezekipe', function(org)
                    
                    ESX.TriggerServerCallback('Motorek-TabletCrime2.0:wezceny', function(ceny)
            
                        SendNUIMessage({
                            type = "update",
                           btc = org.btc,
                           eth = org.eth,
                           doge = org.doge,
                           srodki = org.money,
                           wallet = org.wallet,
                           portfel = org.account,
                           cenabtc = ceny.btc,
                           cenaeth = ceny.eth,
                           cenadoge = ceny.doge,
                           level = org.level,
                           name = org.name,
                           upgrade = org.upgrade,
                           medyk = org.medic
                           
                        })
                    end)
            
                end)

end)

RegisterCommand("wezceny", function(source, args)
    ESX.TriggerServerCallback('Motorek-TabletCrime2.0:wezceny', function(ceny)
print("btc: "..ceny.btc)
print("eth: "..ceny.eth)
print("doge: "..ceny.doge)
end)
end)



function SetDisplay(bool)
    display = bool
    if display then
        startTabletAnimation()
    else
        stopTabletAnimation()
    end
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
    })
    focus()
end

Citizen.CreateThread(function()
while true do
Citizen.Wait(5000)
if display then
ESX.TriggerServerCallback('Motorek-TabletCrime2.0:wezekipe', function(org)
    ESX.TriggerServerCallback('Motorek-TabletCrime2.0:wezceny', function(ceny)

        SendNUIMessage({
            type = "update",
           exp = tonumber(org.exp),
           btc = org.btc,
           eth = org.eth,
           doge = org.doge,
           srodki = org.money,
           wallet = org.wallet,
           portfel = org.account,
           cenabtc = ceny.btc,
           cenaeth = ceny.eth,
           cenadoge = ceny.doge,
           level = org.level,
           name = org.name
        })
    end)
end)



    
end
end

end)


Citizen.CreateThread(function()

    RequestModel(GetHashKey(Config.ped))
    
    while not HasModelLoaded(GetHashKey(Config.ped)) do
        Wait(155)
    end
    while CreatePed == nil do
        Citizen.Wait(100)
    end
    local ped = CreatePed(4, GetHashKey(Config.ped), vector4(Config.pedd['x'], Config.pedd['y'], Config.pedd['z'], Config.pedd['h']), false, true) 

    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
end)


Citizen.CreateThread(function()

    RequestModel(GetHashKey(Config.medic['ped']))
    
    while not HasModelLoaded(GetHashKey(Config.medic['ped'])) do
        Wait(155)
    end
    while CreatePed == nil do
        Citizen.Wait(100)
    end
    local ped = CreatePed(4, GetHashKey(Config.medic['ped']), vector4(Config.medic['x'], Config.medic['y'], Config.medic['z'], Config.medic['h']), false, true) 

    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
end)



exports.qtarget:AddBoxZone("tablet", vector3(Config.pedd['x'], Config.pedd['y'], Config.pedd['z']), 2, 2, {  
    name="tablet",
    heading=Config.pedd['h'],
    debugPoly=false,
      minZ =  Config.pedd['z'] - 2,
      maxZ =  Config.pedd['z'] + 2,
    }, {
        options = {
            {
                
                icon = "fa-solid fa-gun",
                label = _U('create_org'),
                action = function()

                        ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'nazwaorg', {
                            title = _U('create_org'),
                        }, function(data, menu)
                        
                    
                        
                                if data.value == nil then
                                
                                else
                                menu.close()
                                print(data.value)
                                TriggerServerEvent('Motorek-TabletCrime2.0:zaloz', data.value)
                                end
                    
                        
                        end, function(data, menu)
                            menu.close()
                        end)
                    
                    
                end
                
            },
        },
        distance = 3.5
})

exports.qtarget:AddBoxZone("medyk", vector3(Config.medic['x'], Config.medic['y'], Config.medic['z']), 2, 2, {  
    name="medyk",
    heading=Config.medic['h'],
    debugPoly=false,
      minZ =  Config.medic['z'] - 2,
      maxZ =  Config.medic['z'] + 2,
    }, {
        options = {
            {
                
                icon = Config.medic['icon'],
                label = Config.medic['label'],
                action = function()
                    ESX.TriggerServerCallback('Motorek-TabletCrime2.0:playerinfo', function(info)
                        if info['org'].medic == 1 then
                       TriggerEvent(Config.events['revive'])
                        else
                           ESX.ShowNotification( _U('no_med')) 
                        end
                    end)
                end
                
            },
        },
        distance = 3.5
})

Citizen.CreateThread(function()

        exports.qtarget:AddBoxZone("Szafka Crime", vector3(Config.locker['x'], Config.locker['y'], Config.locker['z']), Config.locker['length'], Config.locker['width'], {
            name= "Szafka Crime",
            heading= Config.locker['heading'],
            debugPoly=false,
              minZ = Config.locker['z'] - 2,
              maxZ = Config.locker['z'] + 2
            }, {
                options = {
                    {

                        icon = Config.locker['icon'],
                        label = Config.locker['label'],
                        action = function()

                        TriggerServerEvent("Motorek-TabletCrime2.0:szafka")
                        end
                    },

                },
                distance = 3.5
        })
    
        exports.qtarget:AddBoxZone("ciuchy Crime", vector3(Config.cloakroom['x'], Config.cloakroom['y'], Config.cloakroom['z']), Config.cloakroom['length'], Config.cloakroom['width'], {
            name= "ciuchy Crime",
            heading= Config.cloakroom['heading'],
            debugPoly=false,
              minZ = Config.cloakroom['z'] - 2,
              maxZ = Config.cloakroom['z'] + 2
            }, {
                options = {
                    {

                        icon = Config.cloakroom['icon'],
                        label = Config.cloakroom['label'],
                        action = function()

                        TriggerEvent("Motorek-TabletCrime2.0:ciuchy")

                        end
                    },

                },
                distance = 3.5
        })
    if Config.globalbase then
        exports.qtarget:AddBoxZone("bazatp", vector3(Config.globalb['x'], Config.globalb['y'], Config.globalb['z']), Config.globalb['length'], Config.globalb['width'], {
            name= "bazatp",
            heading= Config.globalb['heading'],
            debugPoly=false,
              minZ = Config.globalb['z'] - 2,
              maxZ = Config.globalb['z'] + 2
            }, {
                options = {
                    {

                        icon = Config.globalb['icon'],
                        label = Config.globalb['label'],
                        action = function()
                            ESX.TriggerServerCallback('Motorek-TabletCrime2.0:playerinfo', function(info)
                                if info['user'].org ~= nil then 
                                    ESX.Game.Teleport(PlayerPedId(), Config.globalb['tp'])
                                    TriggerServerEvent("Motorek-TabletCrime2.0:bucket", info['user'].org:sub(4) )
                           
                                else 
                                    ESX.ShowNotification("Nie masz organizacji!")
                                end
                            end)
 
                        end

                    },

                },
                distance = 3.5
        })
        exports.qtarget:AddBoxZone("bazatp1", vector3(Config.globalb['exit'].x, Config.globalb['exit'].y, Config.globalb['exit'].z), Config.globalb['exit'].length, Config.globalb['exit'].width, {
            name= "bazatp1",
            heading= Config.globalb['exit'].heading,
            debugPoly=false,
              minZ = Config.globalb['exit'].z - 2,
              maxZ = Config.globalb['exit'].z + 2
            }, {
                options = {
                    {

                        icon = Config.globalb['exit'].icon,
                        label = Config.globalb['exit'].label,
                        action = function()

                            ESX.Game.Teleport(PlayerPedId(), Config.globalb['exit'].tp)
                            TriggerServerEvent("Motorek-TabletCrime2.0:bucket", 0 )
                        end
                    },

                },
                distance = 3.5
        })
        


       
    end

end)
Citizen.CreateThread(function()
    if Config.globalbase then
    while true do
    
    ESX.TriggerServerCallback('Motorek-TabletCrime2.0:playerinfo', function(info)
        if info['user'].org ~= nil then 

            createblip() 
        else
            
            RemoveBlip(blipp)
         end
    end) 
    Citizen.Wait(10000)
end
end
end)
function createblip()
    if blipp then 
        RemoveBlip(blipp)
    end
blipp = AddBlipForCoord(Config.globalb['x'], Config.globalb['y'], Config.globalb['z'])
SetBlipSprite(blipp, Config.globalb['blip'].sprite)
SetBlipDisplay(blipp, 4)
SetBlipScale(blipp, 1.0)
SetBlipColour(blipp, Config.globalb['blip'].color)
SetBlipAsShortRange(blipp, true)
BeginTextCommandSetBlipName("STRING")
AddTextComponentString(Config.globalb['blip'].title)
EndTextCommandSetBlipName(blipp)
end

RegisterNetEvent("Motorek-TabletCrime2.0:szafkacl")
AddEventHandler("Motorek-TabletCrime2.0:szafkacl", function(org)

    ESX.TriggerServerCallback('Motorek-TabletCrime2.0:playerinfo', function(info)
        if info['user'].org ~= org then return end 
        if info['user'].org_grade <= Config.locker['grade'] then return end 
    exports.ox_inventory:openInventory('stash', {id=org})
    end)
end)

RegisterNetEvent("Motorek-TabletCrime2.0:ciuchy")
AddEventHandler("Motorek-TabletCrime2.0:ciuchy", function(org)

    ESX.TriggerServerCallback('Motorek-TabletCrime2.0:playerinfo', function(info)

        OpenCloakroomMenu(org, info)

    end)
end)
RegisterNetEvent("Motorek-TabletCrime2.0:updateludki")
AddEventHandler("Motorek-TabletCrime2.0:updateludki", function()

    SendNUIMessage({
        type = "clear"
    })
liczba = 0
    ESX.TriggerServerCallback('Motorek:listamiasiaczkow', function(employees)	
        ESX.TriggerServerCallback('Motorek-TabletCrime2.0:wezekipe', function(org)

                
        for i=1, #employees, 1 do
            liczba = liczba + 1
            
            SendNUIMessage({
                type = "misiaczki",
                number = i,
                name = employees[i].name,
                grade = employees[i].grade,
                ident = employees[i].identifier,
                status = employees[i].status,
                id = employees[i].id,
                liczbaa = liczba,
                max = Config.maxusers[org.upgrade]
            })
        end
    end)
end)
end)

function OpenCloakroomMenu(org, player)
    ESX.UI.Menu.CloseAll()

    local elements = {}

        table.insert(elements, {
            label = "Ubranie Prywatne",
            value = "priv"
        })

        table.insert(elements, {
            label = "Ubrania Organizacji",
            value = "org"
        })
if  player['user'].org_grade >= Config.cloakroom['addgrade'] then
    table.insert(elements, {
        label = "Dodaj Strój",
        value = "dodaj",
        arbuz = "essa",
    })

end
    ESX.UI.Menu.Open("default", GetCurrentResourceName(), "ciuchy", {
        title = "Stroje Organizacji",
        align = "bottom-right",
        elements = elements,
    }, function(data, menu)
        if data.current.value == "priv" then
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                TriggerEvent('skinchanger:loadSkin', skin)
            end)

        elseif data.current.value == "org" then
            OpenCloakroomClothes(player['user'].org, player)
        elseif data.current.value == "dodaj" then
            TriggerEvent('skinchanger:getSkin', function(skin)
                ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'nazwafitu', {
                    title = 'Podaj nazwę stroju'
                }, function(data, menu)
                
            
                
                        if data.value == nil then
                        
                        else
                        menu.close()

                        ESX.TriggerServerCallback('Motorek-TabletCrime2.0:saveclothes', function(cb)
                            
                            end, data.value, json.encode(skin), player['user'].org)
                        end
            
                
                end, function(data, menu)
                    menu.close()
                end)
                
            end)
        end

    end, function(data, menu)
        menu.close()
    end)
end

function OpenCloakroomClothes(org, player)
    Citizen.CreateThread(function()
        print(org)
        print(player)
        print("#1")
        ESX.UI.Menu.CloseAll()
        
        local elements1 = {}
        print(player['user'].org)
        ESX.TriggerServerCallback('Motorek-TabletCrime2.0:getclothes', function(ciuchy)
        
                     for k, v in pairs(ciuchy) do 
                        table.insert(elements1, {
                            label = v.name,
                            value = "cl",
                            skin = v.data,
                            id = v.id
                        })
                     end
        end, player['user'].org)
        
        
        Citizen.Wait(100)
        
        ESX.UI.Menu.Open("default", GetCurrentResourceName(), "ciuchy", {
            title = "Szafka Organizacji",
            align = "bottom-right",
            elements = elements1,
        }, function(data, menu)
        
            if data.current.value == "cl" then
        
        skin = json.decode(data.current.skin)
        id = data.current.id
        local elements2 = {}
        
        table.insert(elements2, {
            label = "Ubierz strój",
            value = "n"
        })
        if player['user'].org_grade >= Config.cloakroom['addgrade'] then

            
            table.insert(elements2, {
                label = "Usuń Strój",
                value = "y"
            })
        end
                    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Wybierzstroj', {
                        title    = "Wybierz strój",
                        align    = 'bottom-right',
                        elements = elements2
                      }, function(data2, menu2)
            
                            if data2.current.value == "n" then
                                TriggerEvent('skinchanger:getSkin', function(skin1)
                                        TriggerEvent('skinchanger:loadClothes', skin1, skin)
                                end)
                            elseif data2.current.value == "y" then
                                ESX.TriggerServerCallback('Motorek-TabletCrime2.0:deleteclothes', function(cb)
                                    
                                end, id)
                                ESX.UI.Menu.CloseAll()
                            end
                        
                      end,
                      function(data2, menu2)
                          menu2.close()
                      end)
                    end 

        
        end, function(data, menu)
            menu.close()
        end)
        end)
end


Citizen.CreateThread(function()
  function  focus()
while display do
    Citizen.Wait(0)
    DisableControlAction(0, 1, display) -- LookLeftRight
    DisableControlAction(0, 2, display) -- LookUpDown
    DisableControlAction(0, 24, display) -- Attack
    DisableControlAction(0, 142, display) -- MeleeAttackAlternate
    DisableControlAction(0, 106, display) -- VehicleMouseControlOverride
end

end
end)

-- NUI
RegisterNUICallback("exit", function(data)
    SetDisplay(false)


end)

RegisterNUICallback("upgrade", function(data)

print(data.lvl)

ESX.TriggerServerCallback('Motorek-TabletCrime2.0:upgrade', function(cb)
ESX.ShowNotification(cb)
end, data.lvl)
end)
RegisterNUICallback("medyk", function(data)


    
    ESX.TriggerServerCallback('Motorek-TabletCrime2.0:medyk', function(cb)
        ESX.ShowNotification(cb)
    end)
    end)
RegisterNUICallback("przelej", function(data)
print(data.coin)

    local input = lib.inputDialog(Config.coins[data.coin], {'Ilość', 'Numer Portfela'})

    if not input then return end
    local count = tonumber(input[1])
    local wallet = input[2]
    ESX.TriggerServerCallback('Motorek-TabletCrime2.0:przelew', function(cb)
ESX.ShowNotification(cb)
    end, data.coin, count, wallet)

    
    end)
    RegisterNUICallback("sprzedaj", function(data)
        print("tu")
        
            local input = lib.inputDialog(Config.coins[data.coin], {'Ilość'})
        
            if not input then return end
            local count = tonumber(input[1])
            local wallet = input[2]
            ESX.TriggerServerCallback('Motorek-TabletCrime2.0:sprzedaj', function(cb)
                ESX.ShowNotification(cb)
            end, data.coin, count)
        
            
            end)

    RegisterNUICallback("buyc", function(data)
        print(data.coin)
        
            local input = lib.inputDialog(Config.coins[data.coin], {'Ilość'})
        
            if not input then return end
            local count = tonumber(input[1])

            ESX.TriggerServerCallback('Motorek-TabletCrime2.0:buyc', function(cb)
                ESX.ShowNotification(cb)
            end, data.coin, count, wallet)
        
            
            end)
RegisterNUICallback("save", function(data)
    print(data.grade)
    print(data.isn)
    
    ESX.TriggerServerCallback('Motorek-TabletCrime2.0:playerinfo', function(info)
    
        
            if not (info['user'].org_grade >= Config.invitegrade) then
            return
            end
        if data.grade == "z" then
            ESX.TriggerServerCallback('Motorek-TabletCrime2.0:zwolnij', function(cb)

            end, data.isn)
            return
        end
            if tonumber(data.grade) > info['user'].org_grade then
return
        end
        ESX.TriggerServerCallback('Motorek-TabletCrime2.0:saveplayergrade', function(cb)
        if cb then
print("nadano")
        end
    end, data.isn, data.grade, info['user'].org_grade)
end)
Citizen.CreateThread(function()
    Citizen.Wait(1000)
    refresh()
end)

end)
RegisterNUICallback("sklep", function(data)
item = data.item
count = tonumber(data.count)
price = tonumber(data.price)
ESX.TriggerServerCallback('Motorek-TabletCrime2.0:playerinfo', function(info)
if price <= tonumber(info['org'].eth) then
    ESX.TriggerServerCallback('Motorek-TabletCrime2.0:buy', function(cb)
if cb then
    
    ESX.ShowNotification("Pomyślnie zakupiono!")

end       
    end, item, price, count, info['user'].org)
else
    wynik = price - tonumber(info['org'].eth)
    ESX.ShowNotification("Brakuje ci: "..wynik.."eth")
end


end)

end)

RegisterNUICallback("invite", function(data)
    ESX.TriggerServerCallback('Motorek:listamiasiaczkow', function(employees)	
        ESX.TriggerServerCallback('Motorek-TabletCrime2.0:wezekipe', function(org)

                liczba = 0
        for i=1, #employees, 1 do
            liczba = liczba + 1
        end
        print(liczba)
        if liczba >= Config.maxusers[org.upgrade] then ESX.ShowNotification("Twoja organizacja posiada maksymalną liczbę osób!") return end
    end)
end)
    ESX.TriggerServerCallback('Motorek-TabletCrime2.0:playerinfo', function(info)
        print("#1")
        if info['user'].org_grade >= Config.invitegrade then
            print("#2")
        TriggerServerEvent("Motorek-TabletCrime2.0:invite", data.id, info['user'].org)
        end
    end)

end)

RegisterNetEvent("Motorek-TabletCrime2.0:invitecl")
AddEventHandler("Motorek-TabletCrime2.0:invitecl", function(org, id )
    ESX.UI.Menu.CloseAll()
    local elements2 = {}
        
    table.insert(elements2, {
        label = "Przyjmij zaproszenie",
        value = "y"
    })
    
    table.insert(elements2, {
        label = "Odrzuć zaproszenie",
        value = "n"
    })
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'zaproszenie', {
                title    = "Zaproszenie od: "..org,
                align    = 'bottom-right',
                elements = elements2
              }, function(data2, menu2)
    
                    if data2.current.value == "y" then
                        ESX.TriggerServerCallback("Motorek-TabletCrime2.0:recruit", function(cb)
                            if cb then
ESX.ShowNotification("Pomyślnie dołączono!")
                            end
                        end, id, org)
                        menu2.close()
                    elseif data2.current.value == "n" then
                        menu2.close()
                    end
                
              end,
              function(data2, menu2)
                  menu2.close()
              end)
end)

function refresh()
    TriggerEvent("Motorek-TabletCrime2.0:updateludki")
    for k,v in pairs(Config.Shop) do

                    SendNUIMessage({
                        type = "sklep",
                        number = k,
                        title = v.title,
                        item = v.item,
                        desc = v.description,
                        count = v.count,
                        price = v.price
                    })
                end
                ESX.TriggerServerCallback('Motorek-TabletCrime2.0:wezekipe', function(org)
                    ESX.TriggerServerCallback('Motorek-TabletCrime2.0:wezceny', function(ceny)
            
                        SendNUIMessage({
                            type = "update",
                           exp = tonumber(org.exp),
                           btc = org.btc,
                           eth = org.eth,
                           doge = org.doge,
                           srodki = org.money,
                           wallet = org.wallet,
                           portfel = org.account,
                           cenabtc = ceny.btc,
                           cenaeth = ceny.eth,
                           cenadoge = ceny.doge,
                           level = org.level,
                           name = org.name
                        })
                    end)
            
                end)
end

local tabletEntity = nil

local tabletModel = "prop_cs_tablet"

local tabletDict = "amb@world_human_seat_wall_tablet@female@base"

local tabletAnim = "base"

function startTabletAnimation()

	Citizen.CreateThread(function()

	  RequestAnimDict(tabletDict)

	  while not HasAnimDictLoaded(tabletDict) do

	    Citizen.Wait(0)

	  end

		attachObject()

		TaskPlayAnim(GetPlayerPed(-1), tabletDict, tabletAnim, 8.0, -8.0, -1, 50, 0, false, false, false)

	end)

end



function attachObject()

	if tabletEntity == nil then

		Citizen.Wait(380)

		RequestModel(tabletModel)

		while not HasModelLoaded(tabletModel) do

			Citizen.Wait(1)

		end

		tabletEntity = CreateObject(GetHashKey(tabletModel), 1.0, 1.0, 1.0, 1, 1, 0)

		AttachEntityToEntity(tabletEntity, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 57005), 0.12, 0.10, -0.13, 25.0, 170.0, 160.0, true, true, false, true, 1, true)

	end

end



function stopTabletAnimation()

	if tabletEntity ~= nil then

		StopAnimTask(GetPlayerPed(-1), tabletDict, tabletAnim ,8.0, -8.0, -1, 50, 0, false, false, false)

		DeleteEntity(tabletEntity)

		tabletEntity = nil

	end

end


--F7

RegisterKeyMapping('orgaction', 'Otwórz menu organizacji', 'keyboard', 'f7')

RegisterCommand("orgaction", function() 

    if string.match(ESX.GetPlayerData().org.name, 'org') ~= nil then
        if not exports['fc-apartaments']:isInProperty() then
        menucrime()
        else
            ESX.ShowFailNotification("Nie możesz tego zrobić w mieszkaniu!")
        end
   
    end


end)

menucrime = function()

    ESX.UI.Menu.CloseAll()

    local elements = {}

        table.insert(elements, {
            label = "Kajdanki",
            value = "k"
        })

        table.insert(elements, {
            label = "Napraw Pojazd",
            value = "n"
        })

    ESX.UI.Menu.Open("default", GetCurrentResourceName(), "ciuchy", {
        title = "Menu Organizacji",
        align = "center",
        elements = elements,
    }, function(data, menu)
        if data.current.value == "k" then
            TriggerEvent("esx_policejob:kajdanki") 

        elseif data.current.value == "n" then

            local playerPed = GetPlayerPed(-1)
            local coords = GetEntityCoords(playerPed)
        
            if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
        
                local vehicle = nil
        
                if IsPedInAnyVehicle(playerPed, false) then
                    vehicle = GetVehiclePedIsIn(playerPed, false)
                else
                    vehicle =
                        GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
                end
        
                if DoesEntityExist(vehicle) then
                    TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
                    TriggerEvent("mythic_progbar:client:progress", {
                        name = "nazwa",
                        duration = 10000,
                        label = "Trwa naprawa",
                        useWhileDead = false,
                        canCancel = true,
                        controlDisables = {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true
                        }
        
                    }, function(status)
                        SetVehicleEngineHealth(vehicle, 1000)
                        SetVehicleFixed(vehicle)
                        SetVehicleUndriveable(vehicle, false)
                        ClearPedTasksImmediately(playerPed)
                        ESX.ShowSuccessNotification("Pomyślnie naprawiono pojazd!")
                        if not status then
                            ESX.ShowFailsNotification("Przestałeś naprawiać pojazd!")
                            -- Do Something If Event Wasn't Cancelled
                        end
                    end)
        
                end
            end
        end

    end, function(data, menu)
        menu.close()
    end)

end