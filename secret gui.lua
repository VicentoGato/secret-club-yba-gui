-- Secret Club GUI v1.2
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

getgenv().UnifiedEnabled = false
getgenv().UnifiedWhitelisted = getgenv().UnifiedWhitelisted or {}
getgenv().SecretClubActive = true

-- ===================== GUI =====================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SecretClubGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = PlayerGui

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 560, 0, 640)
mainFrame.Position = UDim2.new(0.5, -280, 0.5, -320)
mainFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 32)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.ClipsDescendants = true
mainFrame.Active = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 16)
local stroke = Instance.new("UIStroke", mainFrame)
stroke.Color = Color3.fromRGB(80, 80, 100)
stroke.Thickness = 2

-- Resize
local resizeBtn = Instance.new("ImageButton", mainFrame)
resizeBtn.Size = UDim2.new(0, 34, 0, 34)
resizeBtn.Position = UDim2.new(1, -38, 1, -38)
resizeBtn.BackgroundTransparency = 1
resizeBtn.Image = "rbxassetid://10676406507"
resizeBtn.ImageColor3 = Color3.fromRGB(160, 160, 180)
local resizing = false
local resizeStart, resizeSize
resizeBtn.InputBegan:Connect(function(inp)
    if not getgenv().SecretClubActive or inp.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
    resizing = true
    resizeStart = inp.Position
    resizeSize = mainFrame.Size
end)
UserInputService.InputEnded:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1 then resizing = false end
end)
UserInputService.InputChanged:Connect(function(inp)
    if resizing and inp.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = inp.Position - resizeStart
        mainFrame.Size = UDim2.new(0, math.max(480, resizeSize.X.Offset + delta.X), 0, math.max(520, resizeSize.Y.Offset + delta.Y))
    end
end)

-- Title + Close
local titleBar = Instance.new("Frame", mainFrame)
titleBar.Size = UDim2.new(1, 0, 0, 50)
titleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 16)

local titleLabel = Instance.new("TextLabel", titleBar)
titleLabel.Size = UDim2.new(1, -100, 1, 0)
titleLabel.Position = UDim2.new(0, 16, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Secret Club GUI v1.2"
titleLabel.TextColor3 = Color3.new(1,1,1)
titleLabel.Font = Enum.Font.GothamBlack
titleLabel.TextSize = 22
titleLabel.TextXAlignment = Enum.TextXAlignment.Left

local closeBtn = Instance.new("TextButton", titleBar)
closeBtn.Size = UDim2.new(0, 40, 0, 40)
closeBtn.Position = UDim2.new(1, -50, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.Font = Enum.Font.GothamBlack
closeBtn.TextSize = 24
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 12)
closeBtn.MouseButton1Click:Connect(function()
    getgenv().SecretClubActive = false
    getgenv().UnifiedEnabled = false
    screenGui:Destroy()
end)

-- Drag
local dragging = false
local dragStart, startPos
titleBar.InputBegan:Connect(function(inp)
    if not getgenv().SecretClubActive or inp.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
    dragging = true
    dragStart = inp.Position
    startPos = mainFrame.Position
end)
titleBar.InputEnded:Connect(function() dragging = false end)
UserInputService.InputChanged:Connect(function(inp)
    if dragging and inp.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = inp.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Tabs
local tabsFrame = Instance.new("Frame", mainFrame)
tabsFrame.Size = UDim2.new(1, -24, 0, 50)
tabsFrame.Position = UDim2.new(0, 12, 0, 62)
tabsFrame.BackgroundTransparency = 1

local tabFly = Instance.new("TextButton", tabsFrame)
tabFly.Size = UDim2.new(0, 150, 1, 0)
tabFly.BackgroundColor3 = Color3.fromRGB(85, 170, 255)
tabFly.Text = "Fly/Noclip"
tabFly.TextColor3 = Color3.new(1,1,1)
tabFly.Font = Enum.Font.GothamBold
tabFly.TextSize = 18
Instance.new("UICorner", tabFly).CornerRadius = UDim.new(0, 12)

local tabESP = Instance.new("TextButton", tabsFrame)
tabESP.Size = UDim2.new(0, 150, 1, 0)
tabESP.Position = UDim2.new(0, 160, 0, 0)
tabESP.BackgroundColor3 = Color3.fromRGB(60, 60, 75)
tabESP.Text = "ESP"
tabESP.TextColor3 = Color3.new(1,1,1)
tabESP.Font = Enum.Font.GothamBold
tabESP.TextSize = 18
Instance.new("UICorner", tabESP).CornerRadius = UDim.new(0, 12)

local tabAllah = Instance.new("TextButton", tabsFrame)
tabAllah.Size = UDim2.new(0, 150, 1, 0)
tabAllah.Position = UDim2.new(0, 320, 0, 0)
tabAllah.BackgroundColor3 = Color3.fromRGB(60, 60, 75)
tabAllah.Text = "Allah Mode"
tabAllah.TextColor3 = Color3.new(1,1,1)
tabAllah.Font = Enum.Font.GothamBold
tabAllah.TextSize = 18
Instance.new("UICorner", tabAllah).CornerRadius = UDim.new(0, 12)

-- Content
local contentFrame = Instance.new("Frame", mainFrame)
contentFrame.Size = UDim2.new(1, -24, 1, -124)
contentFrame.Position = UDim2.new(0, 12, 0, 118)
contentFrame.BackgroundTransparency = 1

local flyContent = Instance.new("Frame", contentFrame); flyContent.Size = UDim2.new(1, 0, 1, 0); flyContent.BackgroundTransparency = 1
local espContent = Instance.new("Frame", contentFrame); espContent.Size = UDim2.new(1, 0, 1, 0); espContent.BackgroundTransparency = 1; espContent.Visible = false
local allahContent = Instance.new("Frame", contentFrame); allahContent.Size = UDim2.new(1, 0, 1, 0); allahContent.BackgroundTransparency = 1; allahContent.Visible = false

local function openTab(tab)
    flyContent.Visible = tab == 1
    espContent.Visible = tab == 2
    allahContent.Visible = tab == 3
    tabFly.BackgroundColor3 = tab == 1 and Color3.fromRGB(85,170,255) or Color3.fromRGB(60,60,75)
    tabESP.BackgroundColor3 = tab == 2 and Color3.fromRGB(85,170,255) or Color3.fromRGB(60,60,75)
    tabAllah.BackgroundColor3 = tab == 3 and Color3.fromRGB(85,170,255) or Color3.fromRGB(60,60,75)
end
tabFly.MouseButton1Click:Connect(function() openTab(1) end)
tabESP.MouseButton1Click:Connect(function() openTab(2) end)
tabAllah.MouseButton1Click:Connect(function() openTab(3) end)

-- Button creator
local function createButton(parent, text, color)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(1, -20, 0, 50)
    btn.BackgroundColor3 = color
    btn.Text = text
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 20
    btn.AutoButtonColor = false
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 14)
    return btn
end

-- Fly Tab
local flyLayout = Instance.new("UIListLayout", flyContent)
flyLayout.Padding = UDim.new(0, 14)
flyLayout.FillDirection = Enum.FillDirection.Vertical
flyLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local flyKeyBtn = createButton(flyContent, "Fly Key: F (Click to change)", Color3.fromRGB(85,170,255))
local noclipBtn = createButton(flyContent, "Noclip: OFF", Color3.fromRGB(255,140,80))

local speedFrame = Instance.new("Frame", flyContent)
speedFrame.Size = UDim2.new(1, -20, 0, 50)
speedFrame.BackgroundColor3 = Color3.fromRGB(55,55,70)
Instance.new("UICorner", speedFrame).CornerRadius = UDim.new(0,14)

local speedLabel = Instance.new("TextLabel", speedFrame)
speedLabel.Size = UDim2.new(0.5,0,1,0)
speedLabel.Position = UDim2.new(0,16,0,0)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "Speed: 50"
speedLabel.TextColor3 = Color3.new(1,1,1)
speedLabel.Font = Enum.Font.GothamBold
speedLabel.TextSize = 20
speedLabel.TextXAlignment = Enum.TextXAlignment.Left

local minusBtn = Instance.new("TextButton", speedFrame)
minusBtn.Size = UDim2.new(0,70,0,40)
minusBtn.Position = UDim2.new(0.55,0,0.1,0)
minusBtn.BackgroundColor3 = Color3.fromRGB(220,80,80)
minusBtn.Text = "−"
minusBtn.TextSize = 30
Instance.new("UICorner", minusBtn).CornerRadius = UDim.new(0,12)

local plusBtn = Instance.new("TextButton", speedFrame)
plusBtn.Size = UDim2.new(0,70,0,40)
plusBtn.Position = UDim2.new(0.78,0,0.1,0)
plusBtn.BackgroundColor3 = Color3.fromRGB(80,220,100)
plusBtn.Text = "+"
plusBtn.TextSize = 28
Instance.new("UICorner", plusBtn).CornerRadius = UDim.new(0,12)

-- ESP Tab
local espLayout = Instance.new("UIListLayout", espContent)
espLayout.Padding = UDim.new(0, 14)
espLayout.FillDirection = Enum.FillDirection.Vertical
espLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local boxBtn = createButton(espContent, "Box ESP: OFF", Color3.fromRGB(85,170,255))
local nameBtn = createButton(espContent, "Name ESP: OFF", Color3.fromRGB(255,170,85))
local fontPlusBtn = createButton(espContent, "Font Size +", Color3.fromRGB(200,200,60))
local fontMinusBtn = createButton(espContent, "Font Size -", Color3.fromRGB(200,200,60))

local espBoxEnabled = false
local espNameEnabled = false
local espFontSize = 18

-- Allah Tab + Whitelist
local allahToggle = createButton(allahContent, "Allah Mode: OFF", Color3.fromRGB(120,60,140))

local searchBox = Instance.new("TextBox", allahContent)
searchBox.Size = UDim2.new(1,-20,0,46)
searchBox.Position = UDim2.new(0,10,0,70)
searchBox.PlaceholderText = "Search player..."
searchBox.BackgroundColor3 = Color3.fromRGB(50,50,65)
searchBox.TextColor3 = Color3.new(1,1,1)
searchBox.Font = Enum.Font.Gotham
searchBox.TextSize = 18
searchBox.ClearTextOnFocus = false
Instance.new("UICorner", searchBox).CornerRadius = UDim.new(0,14)

local playerScroll = Instance.new("ScrollingFrame", allahContent)
playerScroll.Size = UDim2.new(1,-20,1,-140)
playerScroll.Position = UDim2.new(0,10,0,126)
playerScroll.BackgroundColor3 = Color3.fromRGB(45,45,55)
playerScroll.ScrollBarThickness = 8
playerScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
Instance.new("UICorner", playerScroll).CornerRadius = UDim.new(0,14)

local playerLayout = Instance.new("UIListLayout", playerScroll)
playerLayout.Padding = UDim.new(0,10)

-- Whitelist (English)
local function updatePlayerList()
    if not getgenv().SecretClubActive then return end
    local oldScroll = playerScroll.CanvasPosition.Y
    for _, c in playerScroll:GetChildren() do if c:IsA("Frame") then c:Destroy() end end
    local search = string.lower(searchBox.Text or "")
    for _, plr in Players:GetPlayers() do
        if plr ~= LocalPlayer then
            local name = string.lower(plr.Name)
            local display = string.lower(plr.DisplayName)
            if search == "" or string.find(name, search) or string.find(display, search) then
                local inWL = table.find(getgenv().UnifiedWhitelisted, plr.Name)
                local entry = Instance.new("Frame", playerScroll)
                entry.Size = UDim2.new(1,0,0,64)
                entry.BackgroundColor3 = inWL and Color3.fromRGB(60,120,60) or Color3.fromRGB(65,65,85)
                Instance.new("UICorner", entry).CornerRadius = UDim.new(0,14)

                local thumb = Instance.new("ImageLabel", entry)
                thumb.Size = UDim2.new(0,52,0,52)
                thumb.Position = UDim2.new(0,6,0,6)
                thumb.BackgroundTransparency = 1
                thumb.Image = Players:GetUserThumbnailAsync(plr.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)
                Instance.new("UICorner", thumb).CornerRadius = UDim.new(1,0)

                local dname = Instance.new("TextLabel", entry)
                dname.Size = UDim2.new(0.5,0,0.5,0)
                dname.Position = UDim2.new(0,70,0,4)
                dname.BackgroundTransparency = 1
                dname.Text = plr.DisplayName
                dname.TextColor3 = Color3.new(1,1,1)
                dname.Font = Enum.Font.GothamBold
                dname.TextXAlignment = Enum.TextXAlignment.Left

                local uname = Instance.new("TextLabel", entry)
                uname.Size = UDim2.new(0.5,0,0.5,0)
                uname.Position = UDim2.new(0,70,0.5,0)
                uname.BackgroundTransparency = 1
                uname.Text = "@"..plr.Name
                uname.TextColor3 = Color3.fromRGB(200,200,200)
                uname.TextXAlignment = Enum.TextXAlignment.Left

                local wlBtn = Instance.new("TextButton", entry)
                wlBtn.Size = UDim2.new(0,110,0,44)
                wlBtn.Position = UDim2.new(1,-124,0,10)
                wlBtn.BackgroundColor3 = inWL and Color3.fromRGB(200,60,60) or Color3.fromRGB(60,180,60)
                wlBtn.Text = inWL and "Remove" or "Add"
                wlBtn.TextColor3 = Color3.new(1,1,1)
                wlBtn.Font = Enum.Font.GothamBold
                wlBtn.TextSize = 16
                Instance.new("UICorner", wlBtn).CornerRadius = UDim.new(0,12)
                wlBtn.MouseButton1Click:Connect(function()
                    if inWL then
                        for i,v in ipairs(getgenv().UnifiedWhitelisted) do if v == plr.Name then table.remove(getgenv().UnifiedWhitelisted, i) break end end
                    else
                        table.insert(getgenv().UnifiedWhitelisted, plr.Name)
                    end
                    updatePlayerList()
                end)
            end
        end
    end
    task.spawn(function() task.wait() playerScroll.CanvasPosition = Vector2.new(0, oldScroll) end)
end
Players.PlayerAdded:Connect(updatePlayerList)
Players.PlayerRemoving:Connect(function(p)
    for i,v in ipairs(getgenv().UnifiedWhitelisted) do if v == p.Name then table.remove(getgenv().UnifiedWhitelisted, i) end end
    updatePlayerList()
end)
searchBox:GetPropertyChangedSignal("Text"):Connect(function() task.defer(updatePlayerList) end)
updatePlayerList()

-- ===================== LOGIC =====================
local flying = false
local noclip = false
local flySpeed = 50
local flyKey = Enum.KeyCode.F
local waitingForKey = false
local bv, bg = nil, nil

flyKeyBtn.MouseButton1Click:Connect(function() if getgenv().SecretClubActive then waitingForKey = true flyKeyBtn.Text = "Press any key..." end end)
noclipBtn.MouseButton1Click:Connect(function() if getgenv().SecretClubActive then noclip = not noclip noclipBtn.Text = noclip and "Noclip: ON" or "Noclip: OFF" end end)
plusBtn.MouseButton1Click:Connect(function() if getgenv().SecretClubActive then flySpeed = math.min(flySpeed + 10, 600) speedLabel.Text = "Speed: " .. flySpeed end end)
minusBtn.MouseButton1Click:Connect(function() if getgenv().SecretClubActive then flySpeed = math.max(flySpeed - 10, 10) speedLabel.Text = "Speed: " .. flySpeed end end)
boxBtn.MouseButton1Click:Connect(function() if getgenv().SecretClubActive then espBoxEnabled = not espBoxEnabled boxBtn.Text = espBoxEnabled and "Box ESP: ON" or "Box ESP: OFF" end end)
nameBtn.MouseButton1Click:Connect(function() if getgenv().SecretClubActive then espNameEnabled = not espNameEnabled nameBtn.Text = espNameEnabled and "Name ESP: ON" or "Name ESP: OFF" end end)
fontPlusBtn.MouseButton1Click:Connect(function() if getgenv().SecretClubActive then espFontSize = math.min(espFontSize + 2, 40) end end)
fontMinusBtn.MouseButton1Click:Connect(function() if getgenv().SecretClubActive then espFontSize = math.max(espFontSize - 2, 10) end end)
allahToggle.MouseButton1Click:Connect(function()
    if not getgenv().SecretClubActive then return end
    getgenv().UnifiedEnabled = not getgenv().UnifiedEnabled
    allahToggle.Text = getgenv().UnifiedEnabled and "Allah Mode: ON" or "Allah Mode: OFF"
    allahToggle.BackgroundColor3 = getgenv().UnifiedEnabled and Color3.fromRGB(180,60,80) or Color3.fromRGB(120,60,140)
end)

UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if waitingForKey and input.UserInputType == Enum.UserInputType.Keyboard then
        flyKey = input.KeyCode
        flyKeyBtn.Text = "Fly Key: " .. input.KeyCode.Name
        waitingForKey = false
    elseif input.KeyCode == Enum.KeyCode.Delete then
        screenGui.Enabled = not screenGui.Enabled
    elseif input.KeyCode == flyKey and getgenv().SecretClubActive then
        flying = not flying
        local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local root = char:FindFirstChild("HumanoidRootPart")
        if root and flying then
            bv = Instance.new("BodyVelocity", root)
            bv.MaxForce = Vector3.new(1e5,1e5,1e5)
            bg = Instance.new("BodyGyro", root)
            bg.MaxTorque = Vector3.new(1e5,1e5,1e5)
        else
            if bv then bv:Destroy() end
            if bg then bg:Destroy() end
        end
    end
end)

-- Main loop (Fly + Noclip + ESP)
RunService.Heartbeat:Connect(function()
    if not getgenv().SecretClubActive then return end

    if flying and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local root = LocalPlayer.Character.HumanoidRootPart
        local cam = workspace.CurrentCamera
        local move = Vector3.new(0,0,0)
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then move += cam.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then move -= cam.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then move -= cam.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then move += cam.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move += Vector3.new(0,1,0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then move -= Vector3.new(0,1,0) end
        if move.Magnitude > 0 then bv.Velocity = move.Unit * flySpeed else bv.Velocity = Vector3.zero end
        bg.CFrame = cam.CFrame
    end

    if noclip and LocalPlayer.Character then
        for _, part in LocalPlayer.Character:GetDescendants() do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end

    for _, plr in Players:GetPlayers() do
        if plr ~= LocalPlayer and plr.Character then
            local char = plr.Character
            local root = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso")
            local head = char:FindFirstChild("Head")
            local hum = char:FindFirstChildOfClass("Humanoid")

            local box = char:FindFirstChild("SecretClubBox")
            if espBoxEnabled and root then
                if not box then
                    box = Instance.new("BoxHandleAdornment")
                    box.Name = "SecretClubBox"
                    box.Adornee = root
                    box.Size = Vector3.new(4,6,3)
                    box.Color3 = Color3.fromRGB(85,170,255)
                    box.Transparency = 0.6
                    box.AlwaysOnTop = true
                    box.ZIndex = 10
                    box.Parent = char
                end
            elseif box then box:Destroy() end

            local bill = char:FindFirstChild("SecretClubName")
            if espNameEnabled and head and hum then
                if not bill then
                    bill = Instance.new("BillboardGui")
                    bill.Name = "SecretClubName"
                    bill.Adornee = head
                    bill.Size = UDim2.new(0,200,0,50)
                    bill.StudsOffset = Vector3.new(0,3,0)
                    bill.AlwaysOnTop = true
                    bill.Parent = char
                    local lbl = Instance.new("TextLabel", bill)
                    lbl.Name = "Label"
                    lbl.Size = UDim2.new(1,0,1,0)
                    lbl.BackgroundTransparency = 1
                    lbl.TextColor3 = Color3.fromRGB(255,170,85)
                    lbl.Font = Enum.Font.SourceSansBold
                    lbl.TextStrokeTransparency = 0
                    lbl.TextSize = espFontSize
                end
                bill.Label.Text = plr.DisplayName.." [HP: "..math.floor(hum.Health).."]"
                bill.Label.TextSize = espFontSize
            elseif bill then bill:Destroy() end
        end
    end
end)

--  ALLAH MODE 
task.spawn(function()
    
    while true do
        if not getgenv().SecretClubActive or not getgenv().UnifiedEnabled then
            task.wait(0.5)
            continue
        end

        local Character = LocalPlayer.Character
        if not Character then
            LocalPlayer.CharacterAdded:Wait()
            Character = LocalPlayer.Character
        end

        if not Character:FindFirstChild("HumanoidRootPart") or not Character:FindFirstChild("RemoteEvent") then
            task.wait(0.5)
            continue
        end

        local myRoot = Character.HumanoidRootPart
        local Remote = Character.RemoteEvent

       
        for _, plr in Players:GetPlayers() do
            if plr == LocalPlayer then continue end
            if table.find(getgenv().UnifiedWhitelisted, plr.Name) then continue end
            if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                local target = plr.Character.HumanoidRootPart
                pcall(function()
                    target.CFrame = myRoot.CFrame * CFrame.new(0, 0, -2.5)
                end)
            end
        end

        
        pcall(function()
            Remote:FireServer("InputBegan", {Input = Enum.KeyCode.G})
            Remote:FireServer("InputBegan", {Input = Enum.KeyCode.T})
            Remote:FireServer("InputBegan", {Input = Enum.KeyCode.Y})
            Remote:FireServer("InputBegan", {Input = Enum.KeyCode.X})
        end)

        task.wait(0.05)  
    end
end)
