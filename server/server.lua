ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('ali:buy')
AddEventHandler('ali:buy', function(http)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local price = Config.Items[http].price
    local userMoney = xPlayer.getMoney()
    if userMoney >= price then 
        if Config.ESXInventory then -- weaponlu şekilde ayarlanacak
            local item = Config.Items[http].item
            if Config.WeightSystem then
                if xPlayer.canCarryItem(item, 1) then
                    xPlayer.removeMoney(price)
                    xPlayer.addWeapon(item, 1)
                else
                  xPlayer.showNotification('Üstün dolu')
                  return
                end
            else
                xPlayer.removeMoney(price)
                xPlayer.addWeapon(item, 1)
            end
        else -- itemli verilecek yer
            local item = Config.Items[http].item
            if Config.WeightSystem then
                if xPlayer.canCarryItem(item, 1) then
                    xPlayer.removeMoney(price)
                    xPlayer.addInventoryItem(item, 1)
                else
                    xPlayer.showNotification('Üstün dolu')
                    return
                end
            else
                xPlayer.removeMoney(price)
                xPlayer.addInventoryItem(item, 1)
            end
        end
    else
        xPlayer.showNotification('Bunu satın alabilmek için yeterli paran yok')
    end
end)