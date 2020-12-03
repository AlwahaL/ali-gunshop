ESX = nil
local PlayerData = {}
local playerJob = "none"
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) esx = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nill do
        Citizen.Wait(0)
    end
    playerJob = ESX.GetPlayerData().job.name
end) 

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(response)
    playerJob = response.name
end)

CreateThread(function()
    while ESX == nil do 
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
    while true do
        local sleep = 5000
        local _source = source
        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)
        for i = 1, #Config.Coords, 1 do
            if Config.UseJob then
                if playerJob == Config.Job then
                    local konum = Config.Coords[i]
                    local userDst = GetDistanceBetweenCoords(pedCoords, konum.x, konum.y, konum.z, true)

                    local bossKonum = Config.BossAction
                    local boosDst = GetDistanceBetweenCoords(pedCoords, bossKonum.x, bossKonum.y, bossKonum.z, true)
                    
                    if ESX.GetPlayerData().job.grade_name == 'boss' then
                        if boosDst <= 15 then
                            sleep = 2
                            if boosDst <= 5 then
                                DrawText3D(bossKonum.x, bossKonum.y, bossKonum.z, Config.BossText)
                                if boosDst <= 1 then
                                    if IsControlJustPressed(0, 38) then
                                        bossAction()
                                    end
                                end
                            end
                        end
                    end
                    if userDst <= 15 then
                        sleep = 2
                        if userDst <= 5 then
                            DrawText3D(konum.x, konum.y, konum.z, Config.Text)
                            if userDst <= 1 then
                                if IsControlJustPressed(0, 38) then
                                    gunShop()
                                end
                            end
                        end
                    end
                end
            else
                local konum = Config.Coords[i]
                local userDst = GetDistanceBetweenCoords(pedCoords, konum.x, konum.y, konum.z, true)
                if userDst <= 15 then
                    sleep = 2
                    if userDst <= 5 then
                        DrawText3D(konum.x, konum.y, konum.z, Config.Text)
                        if userDst <= 1 then
                            if IsControlJustPressed(0, 38) then
                                gunShop()
                            end
                        end
                    end
                end
            end
            Citizen.Wait(sleep)
        end
    end
end)
function gunShop()
    local elements = {}
    for i = 1, #Config.Items, 1 do 
    table.insert(elements, {label = Config.Items[i].Label..' : $ '..Config.Items[i].price, value = i})
    end
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'GunShop', {
            title = 'Ürünler',
            align = 'left-right',
            elements = elements
    }, function(data, menu)
        TriggerServerEvent('ali:buy', data.current.value)
        menu.close()
    end, function(data, menu)
        menu.close()
    end)
end

function bossAction()
    ESX.UI.Menu.CloseAll()
        TriggerEvent('esx_society:openBossMenu', Config.Job, function(data, menu)
            menu.close()

            CurrentAction     = 'menu_boss_actions'
            CurrentActionMsg  = 'Patron Menüsü'
            CurrentActionData = {}
        end, { wash = false })
end

function DrawText3D(x,y,z,text,size)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)

    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end
