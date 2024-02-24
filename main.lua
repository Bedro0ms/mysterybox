-- main.lua: Main event trigger script
local MysteryBoxEvent = require(game.ServerScriptService.MysteryBoxEvent) -- Adjust the path as needed
local eventInterval = 300 -- Time in seconds between each event

-- Function to start the Mystery Box event
local function startMysteryBoxEvent()
    print("Mystery Box event starting!")
    MysteryBoxEvent.initiateEvent()
end

-- Main loop to trigger the event at set intervals
while true do
    wait(eventInterval) -- Wait for the defined interval
    startMysteryBoxEvent() -- Start the Mystery Box event
end
