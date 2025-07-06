local display = false

-- Character data (mock data for demonstration)
local characters = {
    {
        firstname = "John",
        lastname = "Doe",
        dateofbirth = "1990-01-01",
        gender = "Male",
        cash = 5000,
        bank = 50000,
        job = "Unemployed",
        slot = 1
    },
    {
        firstname = "Jane",
        lastname = "Smith",
        dateofbirth = "1992-05-15",
        gender = "Female",
        cash = 7500,
        bank = 75000,
        job = "Police",
        slot = 2
    }
}

-- Function to toggle the NUI display
function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
        characters = characters
    })
end

-- Command to show character selection
RegisterCommand('characters', function()
    SetDisplay(true)
end)

-- Event handler for when resource starts
AddEventHandler('onClientResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    SetDisplay(true)
end)

-- NUI Callback for selecting a character
RegisterNUICallback('selectCharacter', function(data, cb)
    SetDisplay(false)
    TriggerEvent('multicharacter:characterSelected', data.slot)
    cb('ok')
end)

-- NUI Callback for closing the UI
RegisterNUICallback('close', function(data, cb)
    SetDisplay(false)
    cb('ok')
end)

-- NUI Callback for creating a new character
RegisterNUICallback('createCharacter', function(data, cb)
    SetDisplay(false)
    -- Here you would typically trigger your character creation event/process
    cb('ok')
end)
