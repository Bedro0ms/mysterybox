-- MysteryBoxEvent.lua: Enhanced with cooldowns, visual indicators, and more rewards

local MysteryBoxEvent = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Debris = game:GetService("Debris")

-- Configurations
local mysteryBoxTemplate = ReplicatedStorage:FindFirstChild("MysteryBox")
local eventDuration = 30 -- Duration of the event in seconds
local playerCooldowns = {} -- Track cooldowns for each player

-- Function to check cooldown
local function canPlayerInteract(player)
    if not playerCooldowns[player.UserId] or time() - playerCooldowns[player.UserId] > eventDuration then
        return true
    else
        return false, playerCooldowns[player.UserId] + eventDuration - time() -- Remaining cooldown time
    end
end

-- Update the spawnBoxes function to include cooldown checks
function MysteryBoxEvent.spawnBoxes()
    for _, player in ipairs(Players:GetPlayers()) do
        local plate = --[[ Find the player's plate here ]]
        if plate and mysteryBoxTemplate then
            local box = mysteryBoxTemplate:Clone()
            box.Position = plate.Position + Vector3.new(0, 5, 0) -- Adjust Y value as needed
            box.Parent = plate
            box.Interactable = true

            -- Add an interaction event listener here, if necessary
            -- This part will depend on how you set up interactions in your game
        end
    end
end

-- Enhanced interaction function with cooldown checks and more outcomes
function MysteryBoxEvent.handleInteraction(player, box)
    local canInteract, cooldown = canPlayerInteract(player)
    if not canInteract then
        player:SendNotification({
            Title = "Cooldown",
            Text = "Please wait " .. math.floor(cooldown) .. " more seconds.",
            Duration = 5
        })
        return
    end

    playerCooldowns[player.UserId] = time() -- Update the player's last interaction time

    local outcome = math.random(1, 100)
    -- Expanding the outcomes with more varied rewards and effects
    if outcome <= 50 then
        -- Common rewards
        -- Example: Temporarily increase speed
        local originalSpeed = player.Character.Humanoid.WalkSpeed
        player.Character.Humanoid.WalkSpeed += 10
        wait(10) -- Speed boost duration
        player.Character.Humanoid.WalkSpeed = originalSpeed
    elseif outcome <= 75 then
        -- Uncommon rewards
        -- Example: Heal the player fully
        player.Character.Humanoid.Health = player.Character.Humanoid.MaxHealth
    elseif outcome <= 90 then
        -- Rare rewards
        -- Example: Give a temporary flying ability or other unique power
    elseif outcome <= 97 then
        -- Very rare rewards
        -- Example: Grant a significant amount of in-game currency or rare items
    else
        -- Unlucky outcomes
        -- Example: Harmless prank, like changing the character's head size
        player.Character.Head.Mesh.Scale = Vector3.new(2, 2, 2) -- Enlarge the head
        wait(10) -- Duration of the effect
        player.Character.Head.Mesh.Scale = Vector3.new(1, 1, 1) -- Reset the head size
    end

    Debris:AddItem(box, 1) -- Ensure the box is cleaned up after interaction
end

-- Function to initiate the event with a visual indicator
function MysteryBoxEvent.initiateEvent()
    -- Notify all players that the event has started
    for _, player in ipairs(Players:GetPlayers()) do
        player:SendNotification({
            Title = "Mystery Box Event",
            Text = "Mystery boxes have spawned! Find and open yours!",
            Duration = eventDuration
        })
    end

    MysteryBoxEvent.spawnBoxes() -- Spawn the mystery boxes
    wait(eventDuration) -- Wait for the event duration before ending
    -- Any cleanup or reset operations go here
end

return MysteryBoxEvent
