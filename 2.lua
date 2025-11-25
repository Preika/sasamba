local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Robojini/Tuturial_UI_Library/main/UI_Template_1"))()
local Window = Library.CreateLib("AndroNIX", "RJTheme1")

local Tab = Window:NewTab("Cheats")
local Section = Tab:NewSection("all")

local Tab2 = Window:NewTab("Movement")
local Section2 = Tab2:NewSection("Player")

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:FindFirstChildOfClass("Humanoid")
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
humanoid.UseJumpPower = true

Section2:NewButton("TP to spawn", "tp to spawn", function()
x = HumanoidRootPart.CFrame
HumanoidRootPart.CFrame = workspace.Lobby:GetChildren()[643].CFrame
end)
Section2:NewButton("TP back", "tp back", function()
HumanoidRootPart.CFrame = x
end)
Section2:NewToggle("Tp to spawn", "tp to spawn and back", function(state)
    if state then
        x = HumanoidRootPart.CFrame
        HumanoidRootPart.CFrame = workspace.Lobby:GetChildren()[643].CFrame
    else
        HumanoidRootPart.CFrame = x
    end
end)

Section2:NewSlider("WalkSpeed", "ur speed", 500, 16, function(WalkSpeed)
        humanoid.WalkSpeed = WalkSpeed
end)

Section2:NewSlider("JumpPower", "ur JumpPower", 500, 50, function(JumpPower)
        humanoid.JumpPower = JumpPower
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

local Players = game:GetService("Players")

-- TELEPORT TO PLAYERS

local Players = game:GetService("Players")
local dropdownOptions = {}

local function updateDropdown()
    local playerNames = {}
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= Players.LocalPlayer then
            table.insert(playerNames, player.Name)
        end
    end
    dropdownOptions = playerNames
end

local function teleportToPlayer(targetPlayerName)
    local player = Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

    local targetPlayer = Players:FindFirstChild(targetPlayerName)
    if targetPlayer and targetPlayer.Character then
        local targetHumanoidRootPart = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
        if targetHumanoidRootPart then
            humanoidRootPart.CFrame = targetHumanoidRootPart.CFrame
        end
    end
end

updateDropdown()

local dropdown = Section2:NewDropdown("teleport to players", "tp u to player", dropdownOptions, function(currentOption)
    teleportToPlayer(currentOption)
end)

Players.PlayerAdded:Connect(function(newPlayer)
    updateDropdown()
    dropdown:Refresh(dropdownOptions)
end)

Players.PlayerRemoving:Connect(function(removedPlayer)
    updateDropdown()
    dropdown:Refresh(dropdownOptions)
end)

-- LOOP TELEPORT TO PLAYER

local Players = game:GetService("Players")
local dropdownOptions = {}

local function updateDropdown()
    local playerNames = {}
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= Players.LocalPlayer then
            table.insert(playerNames, player.Name)
        end
    end
    dropdownOptions = playerNames
end

local function teleportToPlayer(targetPlayerName)
    tp_bool = true
    local player = Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

    local targetPlayer = Players:FindFirstChild(targetPlayerName)
    if targetPlayer and targetPlayer.Character then
        local targetHumanoidRootPart = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
        while tp_bool == true do
            humanoidRootPart.CFrame = targetHumanoidRootPart.CFrame
            RunService.RenderStepped:Wait()
        end
    end
end

updateDropdown()

local dropdown = Section2:NewDropdown("Loop teleport", "loop to player", dropdownOptions, function(currentOption)
    teleportToPlayer(currentOption)
end)

Players.PlayerAdded:Connect(function(newPlayer)
    updateDropdown()
    dropdown:Refresh(dropdownOptions)
end)

Players.PlayerRemoving:Connect(function(removedPlayer)
    updateDropdown()
    dropdown:Refresh(dropdownOptions)
end)

-- ANTI LOOP TELEPORT
Section2:NewButton("anti loop", "anti loop", function()
    tp_bool = false
end)


-- INVISIBLE

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
        
    end)
end


local function toggleInvisibility()
    invis_on = not invis_on
    
    if invis_on then
        
        setCharacterTransparency(invis_transparency)
        
        local character = player.Character
        if character then
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart then
                local savedpos = humanoidRootPart.CFrame
                
                
                task.wait(0.05)
                pcall(function() character:MoveTo(seatTeleportPosition) end)
                task.wait(0.05)
                
                
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

-- FLING

game:GetService("Players").PlayerRemoving:Connect(cleanup)
Section:NewToggle("Invisivle", "just invisible", function(state)
    if state then
        toggleInvisibility()
    else
        toggleInvisibility()
    end
end)
Section:NewKeybind("Invisible keybind", "just invisible", Enum.KeyCode.R, function()
    toggleInvisibility()
end)

Section:NewKeybind("Spinner", "fling and spin", Enum.KeyCode.F, function()
    local FLING_PART = "HumanoidRootPart"
    local player = game:GetService("Players").LocalPlayer
    local camera = game:GetService("Workspace").CurrentCamera

    local function flingCharacter()
        local character = player.Character
        if not character then return end
        local rootPart = character:FindFirstChild(FLING_PART)
        if not rootPart then return end
        local humanoid = character:FindFirstChildWhichIsA("Humanoid")
        if not humanoid then return end

        if rootPart:FindFirstChildWhichIsA("BodyAngularVelocity") then
            rootPart:FindFirstChildWhichIsA("BodyAngularVelocity"):Destroy()
            rootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
            camera.CameraSubject = humanoid
            humanoid.AutoRotate = true

            -- Удаляем удерживающую силу при отключении флинга
            if rootPart:FindFirstChild("BodyPosition") then
                rootPart:FindFirstChild("BodyPosition"):Destroy()
            end

            -- Восстанавливаем массу частей
            for _, child in pairs(character:GetDescendants()) do 
                if child:IsA("BasePart") then 
                    child.Massless = false 
                end 
            end
            return
        end

        -- Устанавливаем массу частей на Massless
        for _, child in pairs(character:GetDescendants()) do 
            if child:IsA("BasePart") then 
                child.Massless = true 
            end 
        end
        
        -- Создаем BodyAngularVelocity для вращения
        local bv = Instance.new("BodyAngularVelocity")
        bv.AngularVelocity = Vector3.new(0, 9e4, 0)
        bv.MaxTorque = Vector3.new(9e4, 9e4, 9e4)
        bv.P = 9e4
        bv.Parent = rootPart

        -- Создаем BodyPosition для удержания персонажа в воздухе
        local bp = Instance.new("BodyPosition")
        bp.Position = rootPart.Position
        bp.MaxForce = Vector3.new(4000, 4000, 4000) -- Сила удержания
        bp.Parent = rootPart

        humanoid.AutoRotate = false
        camera.CameraSubject = rootPart

        if rootPart:FindFirstChildWhichIsA("BodyGyro") then
            rootPart:FindFirstChildWhichIsA("BodyGyro"):Destroy()
        end
    end

    flingCharacter()
end)

Section:NewButton("ESP v1", "cannot be off", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/AgungHari/Universal-ESP-For-Roblox/main/ver1.lua"))()
end)


--INFINITY JUMP

_G.infinjump = false

local Player = game:GetService("Players").LocalPlayer
local UserInputService = game:GetService("UserInputService")
local Humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")

local function onJumpRequest()
    if _G.infinjump then
        if Humanoid then
            Humanoid:ChangeState("Jumping")
        end
    end
end

UserInputService.JumpRequest:Connect(onJumpRequest)

Section:NewToggle("Infinity Jump", "Toggle infinite jump", function(state)
    _G.infinjump = state
    if state then
        onJumpRequest()
    else
        onJumpRequest()
    end
end)
