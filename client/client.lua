local currentChannel = nil
local isRadioOpen    = false
local radioProp      = nil

--
-- Threads
--

Citizen.CreateThread(function()
    if Config.EnableRadioCommand and Config.RadioCommand then
        TriggerEvent('chat:addSuggestion', '/' .. Config.RadioCommand, 'Open up your radio.', {})

        RegisterCommand(Config.RadioCommand, function()
            openRadio()
        end)
    end

    SendNUIMessage({
        type  = 'channelCount',
        count = Config.NumberOfChannels,
    })

    while true do
        Citizen.Wait(0)

        if isRadioOpen then
            DisableControlAction(0, 257, true)
            DisableControlAction(0, 347, true)
            DisableControlAction(0, 24, true)
            DisableControlAction(0, 25, true)
            DisableControlAction(0, 14, true)
            DisableControlAction(0, 15, true)
            DisableControlAction(0, 16, true)
            DisableControlAction(0, 17, true)

            if IsDisabledControlJustReleased(0, 15) then
                SendNUIMessage({
                    type = 'scrollUp',
                })
            end

            if IsDisabledControlJustReleased(0, 14) then
                SendNUIMessage({
                    type = 'scrollDown',
                })
            end

            if IsControlJustReleased(0, 176) then
                SendNUIMessage({
                    type = 'leftClick',
                })
            end

            if IsControlJustReleased(0, 177) then
                SendNUIMessage({
                    type = 'rightClick',
                })
            end
        end
    end
end)

--
-- Functions
--

function joinChannel(channel)
    if channel == 0 then
        if currentChannel then
            exports.tokovoip_script:removePlayerFromRadio(currentChannel)
            currentChannel = nil
            sendCurrentChannel()
        end

        showNotification('Radio turned off.')

        closeRadio()

        return
    end
    
    if not canJoinChannel(channel) then
        showNotification('You can not join this channel.')
        return
    end

    if currentChannel then
        exports.tokovoip_script:removePlayerFromRadio(currentChannel)
        currentChannel = nil
    end

    exports.tokovoip_script:addPlayerToRadio(channel)
    currentChannel = channel

    showNotification('Connected to ' .. channel .. '.00 MHz.')

    sendCurrentChannel()
    closeRadio()
end

function openRadio()
    sendCurrentChannel()

    SendNUIMessage({
        type    = 'display',
        display = true,
    })

    isRadioOpen = true

    playRadioAnimation()
end

function closeRadio()
    SendNUIMessage({
        type    = 'display',
        display = false,
    })

    isRadioOpen = false

    stopRadioAnimation()
end

function sendCurrentChannel()
    local correctedChannel = currentChannel

    if correctedChannel == nil then
        correctedChannel = 0
    end

    SendNUIMessage({
        type    = 'currentChannel',
        channel = correctedChannel
    })
end

function canJoinChannel(channel)
    -- Replace this with your own logic. For example
    -- you could restrict channels 1 - 10 to only
    -- police officers, etc.

    return true
end

function showNotification(message)
    -- This can easily be replaced with
    -- mythic_notify or any other
    -- notifications script.

    SetNotificationTextEntry('STRING')
    AddTextComponentString(message)
    DrawNotification(true, false)
end

function playRadioAnimation()
    local playerPed         = PlayerPedId()
    local playerCoordinates = GetEntityCoords(playerPed)
    local propHash          = GetHashKey('prop_cs_hand_radio')

    RequestAnimDict('cellphone@')
    RequestModel(propHash)

    while not HasAnimDictLoaded('cellphone@') or not HasModelLoaded(propHash) do
        Citizen.Wait(100)
    end

    TaskPlayAnim(playerPed, 'cellphone@', 'cellphone_text_read_base', 2.0, 2.0, -1, 51, 0, false, false, false)

    radioProp = CreateObject(propHash, playerCoordinates.x, playerCoordinates.y, playerCoordinates.z + 0.2, true, true, true)

    AttachEntityToEntity(radioProp, playerPed, GetPedBoneIndex(playerPed, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)

    RemoveAnimDict('cellphone@')
    SetModelAsNoLongerNeeded(propHash)
end

function stopRadioAnimation()
    ClearPedTasks(PlayerPedId())
    DeleteEntity(radioProp)

    radioProp = nil
end

--
-- NUI Callbacks
--

RegisterNUICallback('closeRadio', function(data, cb)
    cb({})

    closeRadio()
end)

RegisterNUICallback('selectChannel', function(data, cb)
    cb({})

    joinChannel(data.channel)
end)

--
-- Events
--

RegisterNetEvent('encore_radio:openRadio')
AddEventHandler('encore_radio:openRadio', function()
    openRadio()
end)

RegisterNetEvent('encore_radio:closeRadio')
AddEventHandler('encore_radio:closeRadio', function()
    closeRadio()
end)

RegisterNetEvent('encore_radio:turnOffRadio')
AddEventHandler('encore_radio:turnOffRadio', function()
    closeRadio()

    if currentChannel then
        exports.tokovoip_script:removePlayerFromRadio(currentChannel)
        currentChannel = nil
        sendCurrentChannel()
    end
end)