-- ============================================================
-- MAIN GUI WITH KEY SYSTEM + FEATURES (FULLY FIXED)
-- ============================================================

-- Wait until we are in a real game with a LocalPlayer
repeat task.wait() until game:GetService("Players").LocalPlayer
local player = game:GetService("Players").LocalPlayer

if not player then
    warn("Not in a valid game environment. Script stopped.")
    return
end

-- Create main ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "MainGUI"
gui.Parent = player:WaitForChild("PlayerGui")

-- Background overlay
local overlay = Instance.new("Frame")
overlay.Size = UDim2.new(1, 0, 1, 0)
overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
overlay.BackgroundTransparency = 0.5
overlay.Parent = gui

-- Main frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 400, 0, 280)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -140)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = overlay

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame

local shadow = Instance.new("ImageLabel")
shadow.Size = UDim2.new(1, 20, 1, 20)
shadow.Position = UDim2.new(0, -10, 0, -10)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://1316045217"
shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
shadow.ImageTransparency = 0.6
shadow.Parent = mainFrame

-- Title bar
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame
local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = titleBar

local titleText = Instance.new("TextLabel")
titleText.Size = UDim2.new(1, 0, 1, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "OP Script (BETA)"
titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleText.Font = Enum.Font.GothamBold
titleText.TextSize = 18
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.Position = UDim2.new(0, 15, 0, 0)
titleText.Parent = titleBar

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -40, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 18
closeBtn.BorderSizePixel = 0
closeBtn.Parent = titleBar
local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closeBtn

-- Dragging
local dragging = false
local dragStart, startPos
titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)
titleBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)
game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Content
local content = Instance.new("Frame")
content.Size = UDim2.new(1, -20, 1, -60)
content.Position = UDim2.new(0, 10, 0, 50)
content.BackgroundTransparency = 1
content.Parent = mainFrame

local keyLabel = Instance.new("TextLabel")
keyLabel.Size = UDim2.new(1, 0, 0, 25)
keyLabel.Position = UDim2.new(0, 0, 0, 0)
keyLabel.BackgroundTransparency = 1
keyLabel.Text = "Enter access key:"
keyLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
keyLabel.Font = Enum.Font.Gotham
keyLabel.TextSize = 14
keyLabel.TextXAlignment = Enum.TextXAlignment.Left
keyLabel.Parent = content

local keyBox = Instance.new("TextBox")
keyBox.Size = UDim2.new(1, 0, 0, 35)
keyBox.Position = UDim2.new(0, 0, 0, 30)
keyBox.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
keyBox.Text = ""
keyBox.PlaceholderText = "Enter key..."
keyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
keyBox.Font = Enum.Font.Gotham
keyBox.TextSize = 14
keyBox.ClearTextOnFocus = false
keyBox.Parent = content
local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 8)
inputCorner.Parent = keyBox

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, 0, 0, 25)
statusLabel.Position = UDim2.new(0, 0, 0, 75)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Waiting for key..."
statusLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 13
statusLabel.Parent = content

local submitBtn = Instance.new("TextButton")
submitBtn.Size = UDim2.new(1, 0, 0, 40)
submitBtn.Position = UDim2.new(0, 0, 0, 110)
submitBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
submitBtn.Text = "Unlock"
submitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
submitBtn.Font = Enum.Font.GothamBold
submitBtn.TextSize = 16
submitBtn.BorderSizePixel = 0
submitBtn.Parent = content
local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 10)
btnCorner.Parent = submitBtn

submitBtn.MouseEnter:Connect(function()
    submitBtn.BackgroundColor3 = Color3.fromRGB(0, 140, 220)
end)
submitBtn.MouseLeave:Connect(function()
    submitBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
end)

local CORRECT_KEY = "test123"

-- ==================== FEATURES (defined first) ====================
local function loadFeatures()
    statusLabel.Text = "✅ Key accepted! Loading features..."
    statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)

    keyBox.Visible = false
    submitBtn.Visible = false
    keyLabel.Visible = false
    statusLabel.Position = UDim2.new(0, 0, 0, 40)

    -- ========== 1. AUTO-PICKUP ==========
    do
        local rs = game:GetService("RunService")
        local plr = game:GetService("Players").LocalPlayer
        local lastCheck = 0
        local checkInterval = 0.15
        local dropCache = {}
        local function autoPickup()
            if not plr.Character then return end
            local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            local now = tick()
            if now - lastCheck < checkInterval then return end
            lastCheck = now
            for _, obj in ipairs(workspace:GetChildren()) do
                if obj.Name == "_drop" and obj:FindFirstChild("TouchInterest") then
                    firetouchinterest(hrp, obj, 0)
                    firetouchinterest(hrp, obj, 1)
                    dropCache[obj] = true
                end
            end
        end
        rs.Heartbeat:Connect(autoPickup)
        plr.CharacterRemoving:Connect(function() dropCache = {} end)
        print("Auto-pickup loaded")
    end

    -- ========== 2. FAST FIRE & MELEE ==========
    loadstring([[
    if game.GameId == 6035872082 then
        local Storage = game:GetService("ReplicatedStorage")
        local Items = require(Storage.Modules.ItemLibrary).Items
        local gunExceptions = { Sniper = false, Crossbow = false, Bow = false, RPG = false }
        for name, data in pairs(Items) do
            if typeof(data) == "table" and not gunExceptions[name] then
                if data.ShootSpread then data.ShootSpread = 0 end
                if data.ShootAccuracy then data.ShootAccuracy = 0 end
                if data.ShootRecoil then data.ShootRecoil = 0 end
                if data.ShootCooldown then data.ShootCooldown = 0.001 end
                if data.ShootBurstCooldown then data.ShootBurstCooldown = 0.001 end
            end
        end
        for name, data in pairs(Items) do
            if typeof(data) == "table" then
                if data.AttackCooldown then data.AttackCooldown = 0.001 end
                if data.SwingCooldown then data.SwingCooldown = 0.001 end
                if data.MeleeCooldown then data.MeleeCooldown = 0.001 end
                if data.Cooldown then data.Cooldown = 0.001 end
                if data.RecoveryTime then data.RecoveryTime = 0.001 end
                if data.ResetTime then data.ResetTime = 0.001 end
            end
        end
        print("Fast fire/melee loaded for Rivals")
    end
    ]])()

    -- ========== 3. DESYNC + WALLBANG ==========
    pcall(function()
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local LocalPlayer = Players.LocalPlayer
        if not LocalPlayer then return end

        local PlayerScripts = LocalPlayer.PlayerScripts
        local GunModule = require(PlayerScripts.Modules.ItemTypes.Gun)
        local UtilityModule = require(ReplicatedStorage.Modules.Utility)
        if not GunModule or not UtilityModule then return end

        local CONFIG = {
            TARGET_UPDATE_RATE = 0.08, DESYNC_DEPTH = -10, SHOOT_DESYNC_DELAY = 0.1,
            HEAD_OFFSET_Y = 0.2, JITTER_XZ = 0.8, JITTER_Y = 0.6,
            PACKET_DELAY = 0.15, DESYNC_RESTORE_PRIORITY = 101
        }

        local characterParts = setmetatable({}, {
            __index = function(_, partName)
                local char = LocalPlayer.Character
                if not char then return nil end
                if partName == "HumanoidRootPart" then return char:FindFirstChild("HumanoidRootPart")
                elseif partName == "Head" then return char:FindFirstChild("Head") end
                return nil
            end
        })

        local globalEnv = getgenv()
        if globalEnv.DesyncWallbang then globalEnv.DesyncWallbang:Shutdown() end

        globalEnv.DesyncWallbang = {}
        local instance = globalEnv.DesyncWallbang

        function instance:FindClosestEnemy()
            local myChar = LocalPlayer.Character
            if not myChar then return nil end
            local myRoot = myChar:FindFirstChild("HumanoidRootPart")
            if not myRoot then return nil end
            local closest, closestDist = nil, math.huge
            for _, player in next, Players:GetPlayers() do
                if player == LocalPlayer then continue end
                local char = player.Character
                if not char then continue end
                local root = char:FindFirstChild("HumanoidRootPart")
                local head = char:FindFirstChild("Head")
                local hum = char:FindFirstChildWhichIsA("Humanoid")
                if not (root and head and hum and hum.Health > 0) then continue end
                local dist = (myRoot.Position - root.Position).Magnitude
                if dist < closestDist then closestDist = dist; closest = player end
            end
            return closest
        end

        function instance:StartDesync(target)
            if self.desyncConnection then self.desyncConnection:Disconnect() end
            self.desyncActive = true
            self.currentDesyncTarget = target
            self.desyncConnection = RunService.Heartbeat:Connect(function()
                if not self.desyncActive then return end
                local myRoot = characterParts.HumanoidRootPart
                if not myRoot then return end
                local targetRoot = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
                if not targetRoot then self:StopDesync(); return end
                local originalCF = myRoot.CFrame
                local originalVel = myRoot.Velocity
                local originalRotVel = myRoot.RotVelocity
                myRoot.CFrame = targetRoot.CFrame * CFrame.new(0, CONFIG.DESYNC_DEPTH, 0)
                RunService:BindToRenderStep("DesyncRestore", CONFIG.DESYNC_RESTORE_PRIORITY, function()
                    myRoot.CFrame = originalCF
                    myRoot.Velocity = originalVel
                    myRoot.RotVelocity = originalRotVel
                    RunService:UnbindFromRenderStep("DesyncRestore")
                end)
            end)
        end

        function instance:StopDesync()
            self.desyncActive = false
            self.currentDesyncTarget = nil
            if self.desyncConnection then
                self.desyncConnection:Disconnect()
                self.desyncConnection = nil
            end
        end

        function instance:Shutdown()
            self.active = false
            if self.targetUpdateConnection then self.targetUpdateConnection:Disconnect() end
            if self.desyncConnection then self.desyncConnection:Disconnect() end
            if self.delayTask then task.cancel(self.delayTask) end
            if self.originalShootFunction then GunModule.StartShooting = self.originalShootFunction end
        end

        function instance:Setup()
            self.active = true
            self.currentTarget = nil
            self.desyncActive = false
            self.targetUpdateConnection = nil
            self.desyncConnection = nil
            self.delayTask = nil
            self.originalShootFunction = nil
            self.lastTargetFindTime = 0

            self.targetUpdateConnection = RunService.Heartbeat:Connect(function()
                if not self.active then return end
                local now = tick()
                if now - self.lastTargetFindTime < CONFIG.TARGET_UPDATE_RATE then return end
                self.lastTargetFindTime = now
                self.currentTarget = self:FindClosestEnemy()
            end)

            local originalShoot = GunModule.StartShooting
            self.originalShootFunction = originalShoot
            GunModule.StartShooting = function(gunObject, ...)
                local results = { originalShoot(gunObject, ...) }
                if not gunObject.ClientFighter or not gunObject.ClientFighter.IsLocalPlayer then
                    return unpack(results)
                end
                local packetData = results[3]
                if not packetData or typeof(packetData) ~= "table" then
                    return unpack(results)
                end
                results[4] = true
                local target = self.currentTarget
                if not target or not target.Character then return unpack(results) end
                if not self.desyncActive or self.currentDesyncTarget ~= target then
                    self:StartDesync(target)
                    task.wait(CONFIG.SHOOT_DESYNC_DELAY)
                end
                if self.delayTask then task.cancel(self.delayTask) end
                local targetHead = target.Character:FindFirstChild("Head")
                if not targetHead then return unpack(results) end
                local headPos = targetHead.Position
                local headCF = targetHead.CFrame
                local aimPoint = headPos - Vector3.new(0, CONFIG.HEAD_OFFSET_Y, 0)
                local aimDir = CFrame.lookAt(aimPoint, headPos)
                local jitterOffset = Vector3.new(
                    math.random(-CONFIG.JITTER_XZ, CONFIG.JITTER_XZ),
                    math.random(-CONFIG.JITTER_Y, CONFIG.JITTER_Y),
                    math.random(-CONFIG.JITTER_XZ, CONFIG.JITTER_XZ)
                )
                local randomCF = headCF:ToObjectSpace(CFrame.new(headPos + jitterOffset))
                packetData[utf8.char(0)] = UtilityModule:EncodeCFrame(CFrame.new(aimPoint, headPos) * CFrame.Angles(aimDir:ToOrientation()))
                packetData[utf8.char(1)] = UtilityModule:EncodeCFrame(CFrame.new(headPos) * CFrame.Angles(aimDir:ToOrientation()))
                packetData[utf8.char(2)] = targetHead
                packetData[utf8.char(3)] = UtilityModule:EncodeCFrame(randomCF)
                self.delayTask = task.delay(CONFIG.PACKET_DELAY, function() self:StopDesync() end)
                return unpack(results)
            end
        end

        instance:Setup()
        print("Desync/wallbang loaded")
    end)

    statusLabel.Text = "✅ All features loaded successfully!"
    print("All scripts loaded.")
    task.wait(3)
    gui:Destroy()
end

-- ==================== Helper to unlock ====================
local function tryUnlock()
    if keyBox.Text == CORRECT_KEY then
        loadFeatures()
    else
        statusLabel.Text = "❌ Invalid key! Try again."
        statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        keyBox.Text = ""
        local originalPos = mainFrame.Position
        for i = 1, 4 do
            mainFrame.Position = UDim2.new(originalPos.X.Scale, originalPos.X.Offset + (i%2==0 and -5 or 5), originalPos.Y.Scale, originalPos.Y.Offset)
            task.wait(0.02)
        end
        mainFrame.Position = originalPos
    end
end

-- Connect events
submitBtn.MouseButton1Click:Connect(tryUnlock)
keyBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then tryUnlock() end
end)
closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

gui.ResetOnSpawn = false
