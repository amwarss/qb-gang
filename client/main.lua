local QBCore = exports['qb-core']:GetCoreObject()
local Config = Config or {}

local function isGangAllowed(gang)
    local playerData = QBCore.Functions.GetPlayerData()
    return playerData.gang.name == gang and Config.GangRanks[gang] == true
end

local function addBossMenuZone(gang, coords)
    if Config.UseOxTarget then
        exports.ox_target:addSphereZone({
            coords = coords,
            radius = 1.5,
            options = {
                {
                    name = gang .. '_boss_menu',
                    label = 'Open Boss Menu',
                    onSelect = function()
                        TriggerEvent('qb-gangmenu:client:OpenMenu')
                    end,
                    canInteract = function(entity, distance, coords, name)
                        return distance < 1.5 and isGangAllowed(gang)
                    end
                }
            }
        })
    else
        exports['qb-target']:AddBoxZone(gang .. '_boss_menu', coords, 1.5, 1.5, {
            name = gang .. '_boss_menu',
            heading = 0,
            debugPoly = false,
            minZ = coords.z - 1,
            maxZ = coords.z + 1
        }, {
            options = {
                {
                    type = "client",
                    event = "qb-gangmenu:client:OpenMenu",
                    icon = "fas fa-box",
                    label = "Open Boss Menu",
                    canInteract = function(entity, distance, coords, name)
                        return distance < 1.5 and isGangAllowed(gang)
                    end
                }
            },
            distance = 1.5
        })
    end
end

local function addClothingMenuZone(gang, coords)
    if Config.UseOxTarget then
        exports.ox_target:addSphereZone({
            coords = coords,
            radius = 1.5,
            options = {
                {
                    name = gang .. '_clothing_menu',
                    label = 'Open Outfit Menu',
                    onSelect = function()
                        TriggerEvent('qb-clothing:client:openOutfitMenu')
                    end,
                    canInteract = function(entity, distance, coords, name)
                        return distance < 1.5 and isGangAllowed(gang)
                    end
                }
            }
        })
    else
        exports['qb-target']:AddBoxZone(gang .. '_clothing_menu', coords, 1.5, 1.5, {
            name = gang .. '_clothing_menu',
            heading = 0,
            debugPoly = false,
            minZ = coords.z - 1,
            maxZ = coords.z + 1
        }, {
            options = {
                {
                    type = "client",
                    event = "qb-clothing:client:openOutfitMenu",
                    icon = "fas fa-tshirt",
                    label = "Open Outfit Menu",
                    canInteract = function(entity, distance, coords, name)
                        return distance < 1.5 and isGangAllowed(gang)
                    end
                }
            },
            distance = 1.5
        })
    end
end

local function addStashZone(gang, coords)
    if Config.UseOxTarget then
        exports.ox_target:addSphereZone({
            coords = coords,
            radius = 1.5,
            options = {
                {
                    type = "client",
                    event = "d3-gang:client:openStash",
                    icon = "fas fa-box",
                    label = "Open Stash",
                    canInteract = function(entity, distance, coords, name)
                        local playerData = QBCore.Functions.GetPlayerData()
                        local PlayerGang = playerData.gang.name
                        return distance < 1.5 and Config.Stashes[PlayerGang] ~= nil
                    end                }
            }
        })
    else
        exports['qb-target']:AddBoxZone(gang .. '_stash', coords, 1.5, 1.5, {
            name = gang .. '_stash',
            heading = 0,
            debugPoly = false,
            minZ = coords.z - 1,
            maxZ = coords.z + 1
        }, {
            options = {
                {
                    type = "client",
                    event = "d3-gang:client:openStash",
                    icon = "fas fa-box",
                    label = "Open Stash",
                    canInteract = function(entity, distance, coords, name)
                        return distance < 1.5 and isGangAllowed(gang)
                    end
                }
            },
            distance = 1.5
        })
    end
end

local function addPersonalStashZone(gang, coords)
    if Config.UseOxTarget then
        exports.ox_target:addSphereZone({
            coords = coords,
            radius = 1.5,
            options = {
                {
                    name = gang .. '_personal_stash',
                    label = 'Open Personal Stash',
                    onSelect = function()
                        local playerData = QBCore.Functions.GetPlayerData()
                        local stashName = "personalstash_" .. playerData.citizenid
                        TriggerEvent("inventory:client:SetCurrentStash", stashName)
                        TriggerServerEvent("inventory:server:OpenInventory", "stash", stashName, {
                            maxweight = 50000,
                            slots = 10,
                        })
                    end,
                    canInteract = function(entity, distance, coords, name)
                        return distance < 1.5 and isGangAllowed(gang)
                    end
                }
            }
        })
    else
        exports['qb-target']:AddBoxZone(gang .. '_personal_stash', coords, 1.5, 1.5, {
            name = gang .. '_personal_stash',
            heading = 0,
            debugPoly = false,
            minZ = coords.z - 1,
            maxZ = coords.z + 1
        }, {
            options = {
                {
                    type = "client",
                    event = "d3-gang:client:openPersonalStash",
                    icon = "fas fa-box",
                    label = "Open Personal Stash",
                    canInteract = function(entity, distance, coords, name)
                        return distance < 1.5 and isGangAllowed(gang)
                    end
                }
            },
            distance = 1.5
        })
    end
end

RegisterNetEvent("d3-gang:client:openStash", function()
    local playerData = QBCore.Functions.GetPlayerData()
    local PlayerGang = playerData.gang.name

    if PlayerGang and Config.Stashes[PlayerGang] then
        local stashConfig = Config.Stashes[PlayerGang]
        local stashName = stashConfig.stashName or (PlayerGang .. "stash")
        local maxweight = stashConfig.maxweight or 4000000
        local slots = stashConfig.slots or 500


        TriggerServerEvent("inventory:server:OpenInventory", "stash", stashName, {
            maxweight = maxweight,
            slots = slots,
        })
        TriggerEvent("inventory:client:SetCurrentStash", stashName)
    else
        QBCore.Functions.Notify('You are not part of a gang or stash is not configured', 'error')
    end
end)



RegisterNetEvent("d3-gang:client:openPersonalStash", function()
    local playerData = QBCore.Functions.GetPlayerData()
    local stashName = "personalstash_" .. playerData.citizenid
    TriggerEvent("inventory:client:SetCurrentStash", stashName)
    TriggerServerEvent("inventory:server:OpenInventory", "stash", stashName, {
        maxweight = 50000,
        slots = 10,
    })
end)

Citizen.CreateThread(function()
    for gang, coords in pairs(Config.bossmenu) do
        addBossMenuZone(gang, coords)
    end

    for name, coords in pairs(Config.clothingMenu) do
        addClothingMenuZone(name, coords)
    end

    for gang, coords in pairs(Config.stash) do
        addStashZone(gang, coords)
    end
    
    for gang, coords in pairs(Config.personalStash) do
        addPersonalStashZone(gang, coords)
    end
end)
