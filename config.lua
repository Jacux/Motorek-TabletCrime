Config = {}


Config.minbtcprice = 57000
Config.maxbtcprice = 69000
Config.minethprice = 8000
Config.maxethprice = 15000
Config.mindogeprice = 8000
Config.maxdogeprice = 15000
Config.cryptoupdatemin = 30
Config.ped = "s_m_m_movprem_01"
Config.ilosc = 1
Config.item = "tabletorg"
Config.globalbase = true
Config.invitegrade = 3
Config.tabletgrade = 3
Config.maxusers = {
[0] = 5,
[1] = 8, -- lvl1
[2] = 16, -- lvl2
[3] = 24 -- lvl3
}

Config.events = {
    ['revive'] = "hypex_ambulancejob:hypexrevive"
}

Config.coins = {
    ['eth'] = "Ethereum",
    ['btc'] = "Bitcoin",
    ['doge'] = "Dogecoin",
}

Config.globalb = {
    ['x'] = 927.84,
    ['y'] = -1560.14,
    ['z'] = 30.75,
    ['length'] = 1.5,
    ['width'] = 1.5,
    ['icon'] = "fas fa-box",
    ['label'] = "Siedziba Organizacji",
    ['heading'] = 0,
    ['tp'] = vector3(999.21, -2390.85, 30.14),
    ['exit'] = {
        x = 997.51,   
        y = -2390.7,
        z = 30.18,
        heading = 355,
        icon = "fas fa-box",
        label = "Wyjście",
        length = 1.5,
        width = 1.5,
        tp = vector3(925.38, - 1560.14, 30.74)
    },
    ['blip'] = {
        sprite = 590,
        color = 42,
        title = "Siedziba Organizacji"
    }



}

Config.pedd = {
    ['x'] = -1993.95,
    ['y'] = 639.7,
    ['z'] = 121.54,
    ['h'] = 72, -- heading
}
Config.medic = {
    ['ped'] = "s_m_m_doctor_01",
    ['x'] = 156.33,
    ['y'] = 3129.01,
    ['z'] = 42.8,
    ['h'] = 304.85, -- heading
    ['icon'] = "",
    ['label'] = "Skorzystaj z pomocy medyka"
}

Config.locker = {
    ['x'] = 1021.59,
    ['y'] = -2405.81,
    ['z'] = 30.14,
    ['length'] = 1,
    ['width'] = 7,
    ['grade'] = 2,
    ['icon'] = "fas fa-box",
    ['label'] = "Szafka Organizacji",
    ['slots'] = 1000,
    ['heading'] = 270,
    ['weight'] = 1000000
}
Config.cloakroom = {
    ['x'] = 1010.78,
    ['y'] = -2389.04,
    ['z'] = 30.14,
    ['length'] = 0.5,
    ['width'] = 2,
    ['addgrade'] = 3,
    ['heading'] = 180,
    ['icon'] = "fas fa-box",
    ['label'] = "Stroje organizacji" 
}
Config.grades = {
[0] = "Rekrut",
[1] = "Członek",
[2] = "Kapitan",
[3] = "Zastępca",
[4] = "Szef"
}

Config.Shop = {
{
    title = "Zestaw Amunicji",
    item = "ammo-pistol",
    description = "1000 naboi do pistoletu",
    count = 1000,
    price = 1 -- eth

},
{
    title = "Pakiet Vintage",
    item = "weapon_vintagepistol",
    description = "10 pistoletów vintage",
    count = 10,
    price = 10-- eth

},
{
    title = "Pakiet SNS mk2",
    item = "weapon_snspistol_mk2",
    description = "10 pistoletów SNS mk2",
    count = 10,
    price = 10-- eth

},

}