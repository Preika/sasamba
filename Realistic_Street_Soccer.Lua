local UserInputService = game:GetService("UserInputService")
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

local function teleportTo(position)
    if character and character.PrimaryPart then
        character:SetPrimaryPartCFrame(CFrame.new(position))
    end
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed then
        if input.KeyCode == Enum.KeyCode.C then
            local awayTeam = workspace.PlayerStats.Away:FindFirstChild(player.Name)
            local homeTeam = workspace.PlayerStats.Home:FindFirstChild(player.Name)

            if awayTeam then
                teleportTo(workspace.ball.Position)
                wait(0.2)
                teleportTo(workspace.HomeGoalDetector.Position)
            elseif homeTeam then
                teleportTo(workspace.ball.Position)
                wait(0.2)
                teleportTo(workspace.AwayGoalDetector.Position)
            end
        end
    end
end)
