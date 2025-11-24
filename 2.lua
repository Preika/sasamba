local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Robojini/Tuturial_UI_Library/main/UI_Template_1"))()
local Window = Library.CreateLib("AndroNIX", "RJTheme1")
local Tab = Window:NewTab("Cheats")
local Section = Tab:NewSection("Movement")
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local HumanoidRootPart = character:WaitForChild("HumanoidRootPart")
local lastpos
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local player = game.Players.LocalPlayer
local invis_on = false
local invis_transparency = 0.75
local seatTeleportPosition = Vector3.new(-25.95, 400, 3537.55)
local voidLevelYThreshold = -50
local currentSeatPosition = nil
local seatReturnHeartbeatConnection = nil

Section:NewButton("TP to spawn", "tp to spawn", function()
x = workspace.Andreyka794.HumanoidRootPart.CFrame
workspace.Andreyka794.HumanoidRootPart.CFrame = workspace.Lobby:GetChildren()[643].CFrame
end)
Section:NewButton("TP back", "tp back", function()
workspace.Andreyka794.HumanoidRootPart.CFrame = x
end)
Section:NewToggle("Tp to spawn", "tp to spawn and back", function(state)
    if state then
        x = workspace.Andreyka794.HumanoidRootPart.CFrame
workspace.Andreyka794.HumanoidRootPart.CFrame = workspace.Lobby:GetChildren()[643].CFrame
    else
        workspace.Andreyka794.HumanoidRootPart.CFrame = x
    end
end)
Section:NewSlider("WalkSpeed", "ur speed", 500, 16, function(s) -- 500 (Макс. значение) | 16 (Мин. значение)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)
Section:NewSlider("Hitboxes", "super mlg novements", 10, 1, function(a)
    _G.HeadSize = a
    _G.Disabled = true
    if _G.RenderSteppedConnection then
        _G.RenderSteppedConnection:Disconnect()
    end

    _G.RenderSteppedConnection = game:GetService('RunService').RenderStepped:Connect(function()
        if _G.Disabled then
            for _, v in next, game:GetService('Players'):GetPlayers() do
                if v.Name ~= game:GetService('Players').LocalPlayer.Name then
                    pcall(function()
                        if v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                            v.Character.HumanoidRootPart.Size = Vector3.new(_G.HeadSize, _G.HeadSize, _G.HeadSize)
                            v.Character.HumanoidRootPart.Transparency = 0.7
                            v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really red")
                            v.Character.HumanoidRootPart.Material = Enum.Material.Neon
                            v.Character.HumanoidRootPart.CanCollide = false
                        end
                    end)
                end
            end
        end
    end)
end)

Section:NewTextBox("Hitboxes", "hitboxes too", function(a)
        _G.HeadSize = a
    _G.Disabled = true
    if _G.RenderSteppedConnection then
        _G.RenderSteppedConnection:Disconnect()
    end

    _G.RenderSteppedConnection = game:GetService('RunService').RenderStepped:Connect(function()
        if _G.Disabled then
            for _, v in next, game:GetService('Players'):GetPlayers() do
                if v.Name ~= game:GetService('Players').LocalPlayer.Name then
                    pcall(function()
                        if v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                            v.Character.HumanoidRootPart.Size = Vector3.new(_G.HeadSize, _G.HeadSize, _G.HeadSize)
                            v.Character.HumanoidRootPart.Transparency = 0.7
                            v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really red")
                            v.Character.HumanoidRootPart.Material = Enum.Material.Neon
                            v.Character.HumanoidRootPart.CanCollide = false
                        end
                    end)
                end
            end
        end
    end)
end)

Section:NewDropdown("DropdownText", "DropdownInf", {"Option 1", "Option 2", "Option 3"}, function(currentOption)
    print(currentOption)
end)

-- Функция установки прозрачности персонажа
local function setCharacterTransparency(transparency)
    local character = player.Character
    if character then
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                part.Transparency = transparency
            end
        end
    end
end


local function stopSeatReturnHeartbeat()
    if seatReturnHeartbeatConnection then
        seatReturnHeartbeatConnection:Disconnect()
        seatReturnHeartbeatConnection = nil
    end
end


local function startSeatReturnHeartbeat()
    if seatReturnHeartbeatConnection then
        seatReturnHeartbeatConnection:Disconnect()
        seatReturnHeartbeatConnection = nil
    end
    seatReturnHeartbeatConnection = RunService.Heartbeat:Connect(function()
        -- Дополнительная логика может быть добавлена здесь
    end)
end


local function toggleInvisibility()
    invis_on = not invis_on
    
    if invis_on then
        -- Включение невидимости
        setCharacterTransparency(invis_transparency)
        
        local character = player.Character
        if character then
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart then
                local savedpos = humanoidRootPart.CFrame
                
                -- Телепортация на позицию сиденья
                task.wait(0.05)
                pcall(function() character:MoveTo(seatTeleportPosition) end)
                task.wait(0.05)
                
                -- Проверка на падение в бездну
                if not character:FindFirstChild("HumanoidRootPart") or character.HumanoidRootPart.Position.Y < voidLevelYThreshold then
                    pcall(function() character:MoveTo(savedpos) end)
                    invis_on = false
                    setCharacterTransparency(0)
                    return
                end
                
                -- Создание невидимого сиденья
                local Seat = Instance.new('Seat')
                Seat.Parent = workspace
                Seat.Anchored = false
                Seat.CanCollide = false
                Seat.Name = 'invischair'
                Seat.Transparency = 1
                Seat.Position = seatTeleportPosition
                
                -- Приваривание сиденья к торсу
                local Weld = Instance.new("Weld")
                Weld.Part0 = Seat
                local torso = character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso")
                if torso then
                    Weld.Part1 = torso
                    Weld.Parent = Seat
                    task.wait()
                    pcall(function() Seat.CFrame = savedpos end)
                    currentSeatPosition = Seat.Position
                    startSeatReturnHeartbeat()
                else
                    Seat:Destroy()
                    currentSeatPosition = nil
                    stopSeatReturnHeartbeat()
                end
            end
        end
    else
        
        setCharacterTransparency(0)
        
        
        task.spawn(function()
            local inv = workspace:FindFirstChild('invischair')
            if inv then
                pcall(function() inv:Destroy() end)
            end
        end)
        
        stopSeatReturnHeartbeat()
        currentSeatPosition = nil
    end
end


local function cleanup()
    invis_on = false
    setCharacterTransparency(0)
    stopSeatReturnHeartbeat()
    
    local inv = workspace:FindFirstChild('invischair')
    if inv then
        pcall(function() inv:Destroy() end)
    end
end


game:GetService("Players").PlayerRemoving:Connect(cleanup)
Section:NewToggle("Invisivle", "just invisible", function(state)
    if state then
        toggleInvisibility()
    else
        toggleInvisibility()
    end
end)
Section:NewKeybind("Invisible keybind", "praga", Enum.KeyCode.F, function()
    toggleInvisibility()
end)
Section:NewButton("ESP", "котакбас", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/AgungHari/Universal-ESP-For-Roblox/main/ver1.lua"))()
end)