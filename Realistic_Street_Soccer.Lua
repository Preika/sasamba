local UserInputService = game:GetService("UserInputService")
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Функция телепортации
local function teleportTo(position)
    if character and character.PrimaryPart then
        character:SetPrimaryPartCFrame(CFrame.new(position))
    else
        warn("PrimaryPart не найден у персонажа!")
    end
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed then
        if input.KeyCode == Enum.KeyCode.C then
            -- Проверяем, в какой команде находится игрок
            local awayTeam = workspace.PlayerStats.Away:FindFirstChild(player.Name)
            local homeTeam = workspace.PlayerStats.Home:FindFirstChild(player.Name)

            if awayTeam then
                print("Игрок в команде: Away")  -- Лог для диагностики
                teleportTo(workspace.ball.Position)
                wait(0.1)
                teleportTo(workspace.HomeGoalDetector.Position)
            elseif homeTeam then
                print("Игрок в команде: Home")  -- Лог для диагностики
                teleportTo(workspace.ball.Position)
                wait(0.1)
                teleportTo(workspace.AwayGoalDetector.Position)
            else
                warn("Игрок не в ни одной из команд!")
            end
        end
    end
end)
