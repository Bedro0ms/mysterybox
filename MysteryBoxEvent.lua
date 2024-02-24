-- MysteryBoxEvent.lua: Full integration with initial setup and new enhancements

local MysteryBoxEvent = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Debris = game:GetService("Debris")

-- Customizable box contents
MysteryBoxEvent.boxContents = {
    common = {
        {type = "speedBoost", duration = 10, amount = 10}, -- Increase speed
        {type = "healthBoost", amount = 50}, -- Heal the player
        -- Add more common rewards as needed
    },
    uncommon = {
        {type = "temporaryShield", duration = 15}, -- Temporary shield
        {type = "lowGravity", duration = 10}, -- Lower gravity
        -- Add more uncommon rewards as needed
    },
    rare = {
        {type = "flyAbility", duration = 20}, -- Enable flying
        {type = "invisible", duration = 15}, -- Make the player invisible
        -- Add more rare rewards as needed
    },
    veryRare = {
        {type = "rareItem", itemName = "Golden Sword"}, -- Give a rare item
        {type = "largeCurrency", amount = 1000}, -- Grant currency
        -- Add more very rare rewards as needed
    },
    unlucky = {
        {type = "funnyEffect", effectName = "BigHead", duration = 20}, -- Enlarge player's head
        {type = "slowness", duration = 20, amount = -10}, -- Reduce speed
        -- Add more unlucky outcomes as needed
    }
}

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
            box.Interactable = true
            -- Add event listener for player interaction if necessary
        end
    end
end

-- Function to handle player interaction with a Mystery Box
function MysteryBoxEvent.handleInteraction(player, box)
    local outcome = math.random(1, 100) -- Randomizing the outcome
    local selectedCategory = ""
    local selectedReward = nil

    -- Determine the reward category based on the outcome
    if outcome <= 50 then
        selectedCategory = "common"
    elseif outcome <= 75 then
        selectedCategory = "uncommon"
    elseif outcome <= 90 then
        selectedCategory = "rare"
    elseif outcome <= 97 then
        selectedCategory = "veryRare"
    else
        selectedCategory = "unlucky"
    end

    -- Selecting a random reward from the chosen category
    selectedReward = MysteryBoxEvent.boxContents[selectedCategory][math.random(1, #MysteryBoxEvent.boxContents[selectedCategory])]

    -- Apply the selected reward to the player based on its type
    -- This should be expanded with actual implementation for each reward type
    if selectedReward.type == "speedBoost" then
        player.Character.Humanoid.WalkSpeed += selectedReward.amount
        wait(selectedReward.duration)
        player.Character.Humanoid.WalkSpeed -= selectedReward.amount
    -- Implement additional conditions for other reward types here
    end

    Debris:AddItem(box, 1) -- Clean up the box after interaction
end

-- Main function to initiate the event
function MysteryBoxEvent.initiateEvent()
    print("Spawning Mystery Boxes on each plate...")
    MysteryBoxEvent.spawnBoxes()
    -- Additional logic to start the event can be added here
end

return MysteryBoxEvent
