----------------------config-------------------------

rayon = 500 -- Set bombing radius here  

speedbomb = 30 -- Time between each falling bomb (in mlsc)

strikeCount = 20 -- Number of bombs dropped when the button is pressed

-----------------------------------------------------

Citizen.CreateThread(function()
  RequestWeaponAsset(GetHashKey("WEAPON_AIRSTRIKE_ROCKET")) 
  while not HasWeaponAssetLoaded(GetHashKey("WEAPON_AIRSTRIKE_ROCKET")) do
      Wait(0)
  end
  while true do
    Citizen.Wait(500)
    ped = PlayerPedId()
    hashAirship = 0x7F701CD2
    if IsPedInModel(ped, hashAirship) then
      AddTextEntry("BOMB", "Dirigeable du FLNC :\nAppuie sur ~INPUT_VEH_DROP_PROJECTILE~ pour bombarder.\n")
      DisplayHelpTextThisFrame("BOMB", false)
      break
    end
  end

end)

Citizen.CreateThread(function()
  hashAirship = 0x7F701CD2
  while true do
    if IsPedInModel(ped, hashAirship) then
      coords = GetEntityCoords(ped)
      bombardement("WEAPON_AIRSTRIKE_ROCKET")
    end
    Citizen.Wait(1)
  end
end)

function bombardement(arme)
  if IsControlPressed(0, 105) then
    o = 0
    while o < strikeCount do
      randomX = math.random(-rayon, rayon)
      randomY = math.random(-rayon, rayon)
      ShootSingleBulletBetweenCoords(coords.x, coords.y, coords.z-10, coords.x+randomX, coords.y+randomY, coords.z-500, 500, true,GetHashKey(arme), ped, true, false, 0)
      o = o + 1
      Citizen.Wait(speedbomb)
    end
  end
end