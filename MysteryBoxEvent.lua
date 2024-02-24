-- MysteryBoxEvent.lua: Handles the Mystery Box event logic
local MysteryBoxEvent = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- Assuming you have a MysteryBox model in ReplicatedStorage
local mysteryBoxTemplate = ReplicatedStorage:FindFirstChild("MysteryBox")

-- Function to spawn a Mystery Box on each player's plate
function MysteryBoxEvent.spawnBoxes()
    for _, player in ipairs(Players:GetPlayers()) do
        local plate = --[[ Find the player's plate here ]]
        if plate and mysteryBoxTemplate then
            local box = mysteryBoxTemplate:Clone()
            box.Position = plate.Position + Vector3.new(0, 5, 0) -- Adjust Y value as needed
            box.Parent = plate
            box.Interactable = true -- Ensure your box model can be interacted with
            -- Add an event listener here for player interaction, if necessary
        end
    end
end

-- Function to handle player interaction with a Mystery Box
function MysteryBoxEvent.handleInteraction(player, box)
    local outcome = math.random(1, 100) -- More granular random range for outcomes

    -- Define outcomes based on the random number
    if outcome <= 50 then
        -- Common rewards
        player.Character.Humanoid.WalkSpeed += 10 -- Example: Increase speed
    elseif outcome > 50 and outcome <= 75 then
        -- Uncommon rewards
        -- Add logic for a temporary shield or other effect
    elseif outcome > 75 and outcome <= 90 then
        -- Rare rewards
        -- Add logic for giving a unique tool or weapon
    elseif outcome > 90 and outcome <= 97 then
        -- Very rare rewards
        -- Add logic for significant in-game rewards
    else
        -- Unlucky outcome
        -- Add logic for a funny but harmless effect
    end

    box:Destroy() -- Remove the box after interaction
end

-- Main function to initiate the event
function MysteryBoxEvent.initiateEvent()
    print("Spawning Mystery Boxes on each plate...")
    MysteryBoxEvent.spawnBoxes()
    -- Connect to an event listener for box interaction, if not done within spawnBoxes
end

return MysteryBoxEvent
