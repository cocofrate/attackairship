----------------------config-------------------------
local BOMB_RADIUS = 70 -- Set bombing radius here
local BOMB_INTERVAL = 30 -- Time between each falling bomb (in ms)
local BOMB_COUNT = 20 -- Number of bombs dropped when the button is pressed
local AIRSHIP_HASH = 0x7F701CD2 -- Hash of the airship model
local WEAPON_HASH = GetHashKey("WEAPON_AIRSTRIKE_ROCKET") -- Hash of the weapon used
-----------------------------------------------------

Citizen.CreateThread(function()
    RequestWeaponAsset(WEAPON_HASH)
    while not HasWeaponAssetLoaded(WEAPON_HASH) do
        Citizen.Wait(0)
    end
    
    while true do
        Citizen.Wait(500)
        local playerPed = PlayerPedId()
        if IsPedInModel(playerPed, AIRSHIP_HASH) then
            AddTextEntry("BOMB", "FLNC Airship:\nAppuyez sur ~INPUT_VEH_DROP_PROJECTILE~ pour bombarder.\n")
            DisplayHelpTextThisFrame("BOMB", false)
            break
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local playerPed = PlayerPedId()
        if IsPedInModel(playerPed, AIRSHIP_HASH) then
            local playerCoords = GetEntityCoords(playerPed)
            Bombardment(WEAPON_HASH, playerCoords)
        end
    end
end)

function Bombardment(weapon, coords)
    if IsControlPressed(0, 105) then
        for bombIndex = 1, BOMB_COUNT do
            local randomX = math.random(-BOMB_RADIUS, BOMB_RADIUS)
            local randomY = math.random(-BOMB_RADIUS, BOMB_RADIUS)
            local bombStartPos = vector3(coords.x + randomX, coords.y + randomY, coords.z - 10)
            local bombEndPos = vector3(coords.x + randomX, coords.y + randomY, coords.z - 500)
            
            -- Visual explosion effect
            AddExplosion(bombEndPos.x, bombEndPos.y, bombEndPos.z, 29, 1.0, true, false, 1.0)
            
            -- Fire the bomb
            ShootSingleBulletBetweenCoords(
                bombStartPos.x, bombStartPos.y, bombStartPos.z,
                bombEndPos.x, bombEndPos.y, bombEndPos.z,
                500, true, weapon, PlayerPedId(), true, false, 0
            )
            
            Citizen.Wait(BOMB_INTERVAL)
        end
    end
end
