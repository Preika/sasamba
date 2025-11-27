local UserInputService = game:GetService("UserInputService")
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local awayTeam = workspace.PlayerStats.Away:FindFirstChild(player.Name)
local homeTeam = workspace.PlayerStats.Home:FindFirstChild(player.Name)

local awayStartPosition = Vector3.new(-156.830841, 5.29914236, -3.53833961)
local awayEndPosition = Vector3.new(-156.830841, 5.29914236, 25.6178398)

local homeStartPosition = Vector3.new(156.87178, 5.04873896, 25.6178417)
local homeEndPosition = Vector3.new(156.87178, 5.04873896, -3.53833675)

local steps = 5
local isTeleporting = false
local currentGoal = nil

local function teleportTo(position)
    if character and character.PrimaryPart then
        character:SetPrimaryPartCFrame(CFrame.new(position))
    end
end

local function teleportGradually(startPos, endPos)
    isTeleporting = true
    currentGoal = endPos
    for i = 0, steps do
        if not isTeleporting then
            return 
        end
        local newPosition = startPos:Lerp(endPos, i / steps)
        if character and character.PrimaryPart then
            character:SetPrimaryPartCFrame(CFrame.new(newPosition))
        end
        wait(0.01)
    end

    if currentGoal == endPos then
        teleportGradually(endPos, startPos)
    end
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed then
        if input.KeyCode == Enum.KeyCode.C then
            teleportTo(workspace.ball.Position)
        elseif input.KeyCode == Enum.KeyCode.V then
            if awayTeam then
                teleportTo(workspace.HomeGoalDetector.Position)
            elseif homeTeam then
                teleportTo(workspace.AwayGoalDetector.Position)
            end
        elseif input.KeyCode == Enum.KeyCode.R then  -- Teleport to team goals
            if awayTeam then
                print("Player is on the Away team")
                teleportGradually(awayStartPosition, awayEndPosition)
            elseif homeTeam then
                print("Player is on the Home team")
                teleportGradually(homeStartPosition, homeEndPosition)
            else
                warn("Player is not on either team!")
            end
        elseif input.KeyCode == Enum.KeyCode.T then
            isTeleporting = false
        end
    end
end)
