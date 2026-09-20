-- Super Ring V2 | anhbadaden143 (Executor-safe build)
if not getgenv then warn("Need executor") return end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")
local HttpService = game:GetService("HttpService")
local WS = game:GetService("Workspace")
local LP = Players.LocalPlayer
local PG = LP:WaitForChild("PlayerGui")

-- cleanup old instances
local old = PG:FindFirstChild("SuperRingGUI") if old then old:Destroy() end
old = PG:FindFirstChild("ReopenBtn") if old then old:Destroy() end

-- Sounds
local clickSfx = Instance.new("Sound")
clickSfx.SoundId = "rbxassetid://12221967"
clickSfx.Volume = 0.5
clickSfx.Parent = SoundService
local function sfx() clickSfx:Play() end

do
    local s = Instance.new("Sound")
    s.SoundId = "rbxassetid://2865227271"
    s.Volume = 0.7
    s.Parent = SoundService
    s:Play()
    s.Ended:Connect(function() s:Destroy() end)
end

-- ================= CONFIG =================
local cfg = { radius = 50, height = 100, rotationSpeed = 10, attractionStrength = 1000 }

local function save()
    if writefile then pcall(writefile, "SuperRingConfig.txt", HttpService:JSONEncode(cfg)) end
end
if isfile and readfile and isfile("SuperRingConfig.txt") then
    pcall(function()
        local d = HttpService:JSONDecode(readfile("SuperRingConfig.txt"))
        for k, v in pairs(d) do
            if cfg[k] ~= nil then cfg[k] = v end
        end
    end)
end

-- ================= SIM RADIUS (once) =================
pcall(function()
    LP.ReplicationFocus = WS
end)
if sethiddenproperty then
    pcall(sethiddenproperty, LP, "SimulationRadius", math.huge)
end

-- ================= GUI =================
local gui = Instance.new("ScreenGui")
gui.Name = "SuperRingGUI"
gui.ResetOnSpawn = false
gui.DisplayOrder = 999
gui.Parent = PG

local box = Instance.new("Frame")
box.Size = UDim2.new(0, 260, 0, 290)
box.Position = UDim2.new(0.5, -130, 0.5, -145)
box.BackgroundTransparency = 1
box.Active = true
box.Parent = gui

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 220, 0, 290)
main.BackgroundColor3 = Color3.fromRGB(28, 28, 32)
main.BorderSizePixel = 0
main.Active = true
main.Parent = box

do
    local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, 12) c.Parent = main
    local st = Instance.new("UIStroke") st.Color = Color3.fromRGB(0, 170, 220) st.Thickness = 1.5 st.Parent = main
end

local tb = Instance.new("Frame")
tb.Size = UDim2.new(1, 0, 0, 32)
tb.BackgroundColor3 = Color3.fromRGB(0, 150, 200)
tb.BorderSizePixel = 0
tb.Parent = main
do
    local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, 12) c.Parent = tb
end

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -70, 1, 0)
title.Position = UDim2.new(0, 34, 0, 0)
title.Text = "Super Ring V2"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = tb

local hideBtn = Instance.new("TextButton")
hideBtn.Size = UDim2.new(0, 24, 0, 24)
hideBtn.Position = UDim2.new(0, 6, 0, 4)
hideBtn.Text = "H"
hideBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
hideBtn.TextColor3 = Color3.new(1, 1, 1)
hideBtn.Font = Enum.Font.GothamBold
hideBtn.TextSize = 12
hideBtn.Parent = tb
do
    local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, 12) c.Parent = hideBtn
end

local minBtn = Instance.new("TextButton")
minBtn.Size = UDim2.new(0, 24, 0, 24)
minBtn.Position = UDim2.new(1, -30, 0, 4)
minBtn.Text = "-"
minBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
minBtn.TextColor3 = Color3.new(0, 0, 0)
minBtn.Font = Enum.Font.GothamBold
minBtn.TextSize = 16
minBtn.Parent = tb
do
    local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, 12) c.Parent = minBtn
end

local made = Instance.new("TextLabel")
made.Size = UDim2.new(1, -10, 0, 16)
made.Position = UDim2.new(0, 5, 0, 34)
made.Text = "Made by anhbadaden143"
made.TextColor3 = Color3.fromRGB(255, 200, 0)
made.BackgroundTransparency = 1
made.Font = Enum.Font.Gotham
made.TextSize = 11
made.Parent = main

local ringBtn = Instance.new("TextButton")
ringBtn.Size = UDim2.new(0.9, 0, 0, 32)
ringBtn.Position = UDim2.new(0.05, 0, 0, 56)
ringBtn.Text = "Ring: OFF"
ringBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
ringBtn.TextColor3 = Color3.new(1, 1, 1)
ringBtn.Font = Enum.Font.GothamBold
ringBtn.TextSize = 14
ringBtn.Parent = main
do
    local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, 8) c.Parent = ringBtn
end

-- Lag fix panel
local lagF = Instance.new("Frame")
lagF.Size = UDim2.new(0, 40, 0, 40)
lagF.Position = UDim2.new(0, 220, 0, 0)
lagF.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
lagF.BorderSizePixel = 0
lagF.Parent = box
do
    local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, 8) c.Parent = lagF
    local st = Instance.new("UIStroke") st.Color = Color3.fromRGB(0, 170, 220) st.Thickness = 1.5 st.Parent = lagF
end

local lagBtn = Instance.new("TextButton")
lagBtn.Size = UDim2.new(1, 0, 1, 0)
lagBtn.Text = "LAG"
lagBtn.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
lagBtn.TextColor3 = Color3.new(1, 1, 1)
lagBtn.Font = Enum.Font.GothamBold
lagBtn.TextSize = 11
lagBtn.Parent = lagF
do
    local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, 8) c.Parent = lagBtn
end

-- ================= CONTROL ROWS =================
local function makeCtrl(posY, col, lbl, key)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(0.9, 0, 0, 38)
    row.Position = UDim2.new(0.05, 0, 0, posY)
    row.BackgroundTransparency = 1
    row.Parent = main

    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(0, 20, 0, 38)
    l.Text = lbl
    l.TextColor3 = col
    l.BackgroundTransparency = 1
    l.Font = Enum.Font.GothamBold
    l.TextSize = 14
    l.Parent = row

    local dec = Instance.new("TextButton")
    dec.Size = UDim2.new(0, 24, 0, 28)
    dec.Position = UDim2.new(0, 22, 0, 5)
    dec.Text = "-"
    dec.BackgroundColor3 = col
    dec.TextColor3 = Color3.new(0, 0, 0)
    dec.Font = Enum.Font.GothamBold
    dec.TextSize = 14
    dec.Parent = row
    do local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, 6) c.Parent = dec end

    local disp = Instance.new("TextLabel")
    disp.Size = UDim2.new(0, 50, 0, 28)
    disp.Position = UDim2.new(0, 50, 0, 5)
    disp.Text = tostring(cfg[key])
    disp.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
    disp.TextColor3 = Color3.new(1, 1, 1)
    disp.Font = Enum.Font.GothamBold
    disp.TextSize = 12
    disp.Parent = row
    do local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, 6) c.Parent = disp end

    local inc = Instance.new("TextButton")
    inc.Size = UDim2.new(0, 24, 0, 28)
    inc.Position = UDim2.new(0, 104, 0, 5)
    inc.Text = "+"
    inc.BackgroundColor3 = col
    inc.TextColor3 = Color3.new(0, 0, 0)
    inc.Font = Enum.Font.GothamBold
    inc.TextSize = 14
    inc.Parent = row
    do local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, 6) c.Parent = inc end

    local tbox = Instance.new("TextBox")
    tbox.Size = UDim2.new(0, 55, 0, 28)
    tbox.Position = UDim2.new(0, 132, 0, 5)
    tbox.PlaceholderText = "Enter"
    tbox.Text = ""
    tbox.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    tbox.TextColor3 = Color3.new(1, 1, 1)
    tbox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
    tbox.Font = Enum.Font.Gotham
    tbox.TextSize = 11
    tbox.ClearTextOnFocus = false
    tbox.Parent = row
    do local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, 6) c.Parent = tbox end

    local function setV(v)
        v = math.clamp(math.floor(v + 0.5), 0, 10000)
        cfg[key] = v
        disp.Text = tostring(v)
        save()
    end

    dec.MouseButton1Click:Connect(function()
        setV(cfg[key] - 10)
        sfx()
    end)
    inc.MouseButton1Click:Connect(function()
        setV(cfg[key] + 10)
        sfx()
    end)
    tbox.FocusLost:Connect(function(ent)
        if ent then
            local v = tonumber(tbox.Text)
            if v then setV(v) sfx() end
        end
        tbox.Text = ""
    end)
end

makeCtrl(100, Color3.fromRGB(200, 200, 60), "R", "radius")
makeCtrl(140, Color3.fromRGB(200, 80, 200), "H", "height")
makeCtrl(180, Color3.fromRGB(80, 200, 200), "S", "rotationSpeed")
makeCtrl(220, Color3.fromRGB(200, 80, 80), "A", "attractionStrength")

-- ================= DRAG (fixed: no connection leak) =================
do
    local dragging = false
    local dragStart, startPos

    box.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = box.Position
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch) then
            local d = input.Position - dragStart
            box.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + d.X,
                startPos.Y.Scale, startPos.Y.Offset + d.Y
            )
        end
    end)

    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

-- ================= MINIMIZE / HIDE =================
local minimized = false

local function setMin(state)
    minimized = state
    lagF.Visible = not minimized
    made.Visible = not minimized
    ringBtn.Visible = not minimized
    for _, c in ipairs(main:GetChildren()) do
        if c:IsA("Frame") and c ~= tb then c.Visible = not minimized end
    end
    if minimized then
        box.Size = UDim2.new(0, 260, 0, 32)
        main.Size = UDim2.new(0, 220, 0, 32)
        minBtn.Text = "+"
    else
        box.Size = UDim2.new(0, 260, 0, 290)
        main.Size = UDim2.new(0, 220, 0, 290)
        minBtn.Text = "-"
    end
end

minBtn.MouseButton1Click:Connect(function()
    setMin(not minimized)
    sfx()
end)

local function mkReopen()
    if PG:FindFirstChild("ReopenBtn") then return end
    local r = Instance.new("TextButton")
    r.Name = "ReopenBtn"
    r.Size = UDim2.new(0, 40, 0, 40)
    r.Position = UDim2.new(0, 10, 0.5, -20)
    r.Text = "SR"
    r.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
    r.TextColor3 = Color3.new(1, 1, 1)
    r.Font = Enum.Font.GothamBold
    r.TextSize = 14
    r.Parent = PG
    do local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, 20) c.Parent = r end
    r.MouseButton1Click:Connect(function()
        box.Visible = true
        r:Destroy()
        sfx()
    end)
end

hideBtn.MouseButton1Click:Connect(function()
    box.Visible = false
    mkReopen()
    sfx()
end)

UIS.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.X then
        box.Visible = not box.Visible
        local r = PG:FindFirstChild("ReopenBtn")
        if box.Visible then
            if r then r:Destroy() end
        else
            mkReopen()
        end
    end
end)

-- ================= RING CORE (optimized) =================
local ringOn = false
local partsSet = {}
local partsArr = {}
local nParts = 0
local zeroPhys = PhysicalProperties.new(0, 0, 0, 0, 0)

local function addP(p)
    local cls = p.ClassName
    if cls ~= "Part" and cls ~= "MeshPart" and cls ~= "UnionOperation"
    and cls ~= "WedgePart" and cls ~= "CornerWedgePart" and cls ~= "TrussPart" then
        return
    end
    if partsSet[p] then return end
    if p.Anchored then return end
    if not p.Parent then return end

    -- exclude characters, tools, accessories
    local m = p
    while m and m ~= WS do
        local mc = m.ClassName
        if mc == "Model" and m:FindFirstChildOfClass("Humanoid") then return end
        if mc == "Tool" or mc == "Accessory" then return end
        m = m.Parent
    end
    if p.Name == "HumanoidRootPart" or p.Name == "Head" then return end

    partsSet[p] = true
    nParts += 1
    partsArr[nParts] = p
    p.CustomPhysicalProperties = zeroPhys
    p.CanCollide = false
    if p.SetNetworkOwner then pcall(function() p:SetNetworkOwner(LP) end) end
end

local function rmP(p)
    if partsSet[p] then
        partsSet[p] = nil
        nParts -= 1
    end
end

for _, p in ipairs(WS:GetDescendants()) do
    pcall(addP, p)
end
WS.DescendantAdded:Connect(function(p) pcall(addP, p) end)
WS.DescendantRemoving:Connect(rmP)

local function rebuild()
    local i = 0
    for p in pairs(partsSet) do
        i += 1
        partsArr[i] = p
    end
    nParts = i
end

-- hot loop
RunService.Heartbeat:Connect(function(dt)
    if not ringOn or nParts == 0 then return end
    local ch = LP.Character
    if not ch then return end
    local hrp = ch:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local cp = hrp.Position
    local cx, cy, cz = cp.X, cp.Y, cp.Z
    local spin = math.rad(cfg.rotationSpeed) * (dt * 60)
    local t = os.clock()
    local str = cfg.attractionStrength * 0.3
    local hAmp = cfg.height * 0.3
    local r = cfg.radius
    local rSq = (r + 40) * (r + 40)
    local dirty = false

    for i = 1, nParts do
        local p = partsArr[i]
        if p and p.Parent and not p.Anchored then
            local pos = p.Position
            local dx, dz = pos.X - cx, pos.Z - cz
            local distSq = dx * dx + dz * dz
            if distSq < rSq then
                local dist = math.sqrt(distSq)
                local ang = math.atan2(dz, dx) + spin
                local rad = dist < r and dist or r
                local hOff = math.sin(t * 2 + i * 0.5) * hAmp

                local dirX = (cx + math.cos(ang) * rad) - pos.X
                local dirY = (cy + hOff) - pos.Y
                local dirZ = (cz + math.sin(ang) * rad) - pos.Z
                local mag = math.sqrt(dirX*dirX + dirY*dirY + dirZ*dirZ)
                if mag > 0.1 then
                    local s = str / mag
                    p.Velocity = Vector3.new(dirX * s, dirY * s + 20, dirZ * s)
                end
            end
        else
            if partsSet[p] then
                partsSet[p] = nil
                nParts -= 1
                dirty = true
            end
        end
    end
    if dirty then rebuild() end
end)

ringBtn.MouseButton1Click:Connect(function()
    ringOn = not ringOn
    ringBtn.Text = ringOn and "Ring: ON" or "Ring: OFF"
    ringBtn.BackgroundColor3 = ringOn and Color3.fromRGB(50, 205, 50) or Color3.fromRGB(220, 50, 50)
    sfx()
end)

-- ================= LAG FIX (batched, no freeze) =================
local lagOn = false
local cP, cE, cT = {}, {}, {}

local function applyLag(v)
    local cls = v.ClassName
    if cls == "Part" or cls == "MeshPart" or cls == "UnionOperation" or cls == "WedgePart" then
        table.insert(cP, {I = v, M = v.Material})
        v.Material = Enum.Material.SmoothPlastic
    elseif cls == "ParticleEmitter" or cls == "Smoke" or cls == "Fire" or cls == "Sparkles"
        or cls == "Beam" or cls == "Trail" or cls == "Highlight" or cls == "Explosion"
        or cls == "BloomEffect" or cls == "BlurEffect" or cls == "DepthOfFieldEffect"
        or cls == "SunRaysEffect" then
        table.insert(cE, {I = v, E = v.Enabled})
        v.Enabled = false
    elseif cls == "Decal" or cls == "Texture" then
        table.insert(cT, {I = v, T = v.Texture})
        v.Texture = ""
    elseif cls == "Sky" then
        v.SkyboxBk, v.SkyboxDn, v.SkyboxFt, v.SkyboxLf, v.SkyboxRt, v.SkyboxUp = "", "", "", "", "", ""
    end
end

lagBtn.MouseButton1Click:Connect(function()
    lagOn = not lagOn
    if lagOn then
        lagBtn.Text = "FIXED"
        lagF.BackgroundColor3 = Color3.fromRGB(20, 40, 25)
        lagBtn.BackgroundColor3 = Color3.fromRGB(20, 40, 25)
        -- batched so client never freezes
        task.spawn(function()
            local all = game:GetDescendants()
            for i = 1, #all, 300 do
                for j = i, math.min(i + 299, #all) do
                    pcall(applyLag, all[j])
                end
                task.wait()
            end
        end)
    else
        lagBtn.Text = "LAG"
        lagF.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
        lagBtn.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
        for _, e in ipairs(cP) do
            pcall(function() if e.I and e.I.Parent then e.I.Material = e.M end end)
        end
        for _, e in ipairs(cE) do
            pcall(function() if e.I and e.I.Parent then e.I.Enabled = e.E end end)
        end
        for _, e in ipairs(cT) do
            pcall(function() if e.I and e.I.Parent then e.I.Texture = e.T end end)
        end
        cP, cE, cT = {}, {}, {}
    end
    sfx()
end)

WS.DescendantAdded:Connect(function(v)
    if lagOn then pcall(applyLag, v) end
end)

print("[Super Ring V2] Loaded — Ring toggle, X to hide, - to minimize.")
