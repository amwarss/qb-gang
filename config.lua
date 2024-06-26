Config = {}

Config.UseOxTarget = true -- قم بتعيين هذه القيمة إلى false لاستخدام qb-target

Config.bossmenu = {
    ["ballas"] = vector3(113.3059, -1970.89, 21.3276),
    ["vagos"] = vector3(344.67, -2022.14, 22.39),
    ["families"] = vector3(-136.91, -1609.84, 35.03),
}

Config.stash = {
    ["ballas"] = vector3(112.0, -1970.0, 21.0),
    ["vagos"] = vector3(343.0, -2021.0, 22.0),
    ["lostmc"] = vector3(1970.08, 4634.33, 41.23),
}

Config.clothingMenu = {
    ["lostmc"] = vector3(452.6, -992.8, 30.6),
    ["vagos"] = vector3(299.3, -598.4, 43.3)
}

Config.Stashes = {
    ["lostmc"] = {
        stashName = "lostmcstash",
        maxweight = 4000000,
        slots = 500,
    },
    ["gang2"] = {
        stashName = "gang2stash",
        maxweight = 3000000,
        slots = 400,
    },
}

Config.personalStash = {
    ["ballas"] = vector3(114.0, -1971.0, 21.0),
    ["vagos"] = vector3(345.0, -2023.0, 22.0),
    ["families"] = vector3(-135.0, -1610.0, 35.0),
    
}

Config.GangRanks = {
    ["ballas"] = true,
    ["vagos"] = true,
    ["families"] = true,
    ["lostmc"] = true,
}
