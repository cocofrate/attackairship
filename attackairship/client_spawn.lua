
----------------------config-------------------------
blipCoords = vector3(1691.47, 3277.09, 41.06) -- Coordinate of marker where you can spawn the airship
airshipSpawn = vector3(1432.811, 3177.402, 40.41412) -- Coordinate of airship spawn
motoSpawn = vector3(1690.48, 3275.14, 41.02) 
-----------------------------------------------------

Citizen.CreateThread(function()
    model = 0x7F701CD2
    moto = -1453280962
    RequestModel(model)
    while not HasModelLoaded(model) do Citizen.Wait(0) end
    RequestModel(moto)
    while not HasModelLoaded(moto) do Citizen.Wait(0) end
    blip = AddBlipForCoord(blipCoords.x, blipCoords.y, blipCoords.z)
    SetBlipAsShortRange(blip, true)
    SetBlipSprite(blip, 638)
    while true do
        local ped = PlayerPedId()
        Citizen.Wait(1)
        local coords = GetEntityCoords(ped)
        local marker = DrawMarker(0, blipCoords.x, blipCoords.y, blipCoords.z,0.0, 0.0, 0.0, 0.0, 0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 50, false, true, 2, nil, nil, false)
        
        local distance = GetDistanceBetweenCoords(coords.x, coords.y, coords.z,1691.47, 3277.09, 41.06,true)
        if distance < 1 then
            AddTextEntry("zepellin","Appuyez sur ~INPUT_CONTEXT~ pour faire apparaitre le dirigeable de combat")
            DisplayHelpTextThisFrame("zepellin", false)
            if IsControlJustPressed(0, 51) then
                dirigeable = CreateVehicle(model, airshipSpawn.x, airshipSpawn.y,airshipSpawn.z, 104.15, true, false)
                newMoto = CreateVehicle(moto, motoSpawn.x,motoSpawn.y,motoSpawn.z, 117.57, true, false)
                Citizen.Wait(10000)
            end
        end
    end
end)