local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local runService = game:GetService("RunService")
local lighting = game:GetService("Lighting")
local tweenService = game:GetService("TweenService")

-- Criar GUI principal
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")
screenGui.Name = "PainelDaNicolle"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Variáveis de controle
local settings = {
    computerESP = false,
    freezerESP = false,
    innocentESP = false,
    beastESP = false,
    exitESP = false,
    speed = false,
    fly = false,
    superJump = false,
    infiniteStamina = false,
    fullbright = false,
    thirdPerson = false,
    invisible = false,
    hitboxExpander = false,
    beastAlert = false,
    speedValue = 50
}

-- Variáveis para funções
local flyConnection = nil
local alertConnection = nil
local originalSize = {}

-- CRIAR ÍCONE MINIMALISTA MÓVEL 🥰
local icon = Instance.new("TextButton")
icon.Size = UDim2.new(0, 65, 0, 65)
icon.Position = UDim2.new(0, 20, 0, 20)
icon.BackgroundColor3 = Color3.fromRGB(30, 15, 35)
icon.BackgroundTransparency = 0.2
icon.BorderSizePixel = 3
icon.BorderColor3 = Color3.fromRGB(255, 50, 150)
icon.Text = "🥰"
icon.TextColor3 = Color3.fromRGB(255, 255, 255)
icon.TextSize = 35
icon.Font = Enum.Font.GothamBold
icon.Draggable = true
icon.Active = true
icon.Parent = screenGui

-- Cantos arredondados no ícone
local iconCorner = Instance.new("UICorner")
iconCorner.CornerRadius = UDim.new(1, 0)
iconCorner.Parent = icon

-- Efeito de brilho no ícone
local iconGlow = Instance.new("ImageLabel")
iconGlow.Size = UDim2.new(1.3, 0, 1.3, 0)
iconGlow.Position = UDim2.new(-0.15, 0, -0.15, 0)
iconGlow.BackgroundTransparency = 1
iconGlow.Image = "rbxassetid://1316045217"
iconGlow.ImageColor3 = Color3.fromRGB(255, 105, 180)
iconGlow.ImageTransparency = 0.6
iconGlow.Parent = icon

-- CRIAR PAINEL PRINCIPAL MÓVEL
local panel = Instance.new("Frame")
panel.Size = UDim2.new(0, 420, 0, 620)
panel.Position = UDim2.new(0, 100, 0, 100)
panel.BackgroundColor3 = Color3.fromRGB(20, 10, 25)
panel.BackgroundTransparency = 0.05
panel.BorderSizePixel = 3
panel.BorderColor3 = Color3.fromRGB(255, 50, 150)
panel.Active = true
panel.Draggable = true
panel.Visible = false
panel.Parent = screenGui

-- Cantos arredondados do painel
local panelCorner = Instance.new("UICorner")
panelCorner.CornerRadius = UDim.new(0, 20)
panelCorner.Parent = panel

-- Efeito futurista (linhas de luz)
for i = 1, 3 do
    local line = Instance.new("Frame")
    line.Size = UDim2.new(0.9, 0, 0, 2)
    line.Position = UDim2.new(0.05, 0, 0, 50 + (i * 30))
    line.BackgroundColor3 = Color3.fromRGB(255, 50, 150)
    line.BackgroundTransparency = 0.7
    line.BorderSizePixel = 0
    line.Parent = panel
end

-- Título do painel
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 55)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.fromRGB(255, 50, 150)
title.BackgroundTransparency = 0.2
title.Text = "🥰 PAINEL DA NICOLLE 🥰"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextStrokeColor3 = Color3.fromRGB(255, 50, 150)
title.TextStrokeTransparency = 0.3
title.Parent = panel

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 20)
titleCorner.Parent = title

-- Botão fechar (X)
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 35, 0, 35)
closeButton.Position = UDim2.new(1, -45, 0, 10)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 50, 150)
closeButton.Text = "✕"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 20
closeButton.Font = Enum.Font.GothamBold
closeButton.Parent = panel

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(1, 0)
closeCorner.Parent = closeButton

-- CRIAR ABAS
local function createTab(name, xPos)
    local tab = Instance.new("TextButton")
    tab.Size = UDim2.new(0.23, 0, 0, 35)
    tab.Position = UDim2.new(xPos, 0, 0, 60)
    tab.BackgroundColor3 = Color3.fromRGB(40, 20, 50)
    tab.BackgroundTransparency = 0.3
    tab.BorderSizePixel = 2
    tab.BorderColor3 = Color3.fromRGB(255, 50, 150)
    tab.Text = name
    tab.TextColor3 = Color3.fromRGB(255, 200, 220)
    tab.Font = Enum.Font.GothamBold
    tab.TextSize = 12
    tab.Parent = panel

    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 10)
    tabCorner.Parent = tab

    return tab
end

-- Criar abas
local tabEsp = createTab("🎯 ESP", 0.03)
local tabMov = createTab("⚡ MOV", 0.27)
local tabEfeitos = createTab("✨ EFEITOS", 0.51)
local tabAlertas = createTab("⚠️ ALERTAS", 0.75)

-- Container para os botões de cada aba
local buttonContainer = Instance.new("Frame")
buttonContainer.Size = UDim2.new(0.94, 0, 0, 460)
buttonContainer.Position = UDim2.new(0.03, 0, 0, 100)
buttonContainer.BackgroundTransparency = 1
buttonContainer.Parent = panel

-- Função para criar botões
local function createButton(name, setting, yPos, emoji, container)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.95, 0, 0, 38)
    button.Position = UDim2.new(0.025, 0, 0, yPos)
    button.BackgroundColor3 = Color3.fromRGB(60, 30, 75)
    button.BackgroundTransparency = 0.4
    button.Text = "   " .. emoji .. " " .. name .. ":  Desativado"
    button.TextColor3 = Color3.fromRGB(255, 200, 220)
    button.Font = Enum.Font.Gotham
    button.TextSize = 13
    button.TextXAlignment = Enum.TextXAlignment.Left
    button.BorderSizePixel = 2
    button.BorderColor3 = Color3.fromRGB(255, 50, 150)
    button.Parent = container

    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 12)
    buttonCorner.Parent = button

    button.MouseButton1Click:Connect(function()
        settings[setting] = not settings[setting]
        button.Text = "   " .. emoji .. " " .. name .. ":  " .. (settings[setting] and "Ativado 💖" or "Desativado")
        button.TextColor3 = settings[setting] and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(255, 200, 220)

        -- Ativar funções especiais
        if setting == "hitboxExpander" then toggleHitbox()
        elseif setting == "thirdPerson" then toggleThirdPerson()
        elseif setting == "invisible" then toggleInvisible()
        elseif setting == "beastAlert" then toggleBeastAlert()
        elseif setting == "infiniteStamina" then toggleInfiniteStamina()
        end
    end)

    return yPos + 43
end

-- ABA ESP (🎯) - Botões com transparência e círculo no computador
local espY = 5
espY = createButton("COMPUTADORES (CÍRCULO)", "computerESP", espY, "💻", buttonContainer)
espY = createButton("FREEZER", "freezerESP", espY, "❄️", buttonContainer)
espY = createButton("INOCENTES", "innocentESP", espY, "😇", buttonContainer)
espY = createButton("A BESTA", "beastESP", espY, "👾", buttonContainer)
espY = createButton("SAÍDAS", "exitESP", espY, "🚪", buttonContainer)

-- ABA MOVIMENTAÇÃO (⚡)
local movY = 5
movY = createButton("SUPER VELOCIDADE", "speed", movY, "🚀", buttonContainer)
movY = createButton("VOAR", "fly", movY, "🕊️", buttonContainer)
movY = createButton("SUPER PULO", "superJump", movY, "🦘", buttonContainer)
movY = createButton("INFINITO STAMINA", "infiniteStamina", movY, "💪", buttonContainer)

-- ABA EFEITOS (✨)
local efeitosY = 5
efeitosY = createButton("FULL LIGHT", "fullbright", efeitosY, "🌞", buttonContainer)
efeitosY = createButton("TERCEIRA PESSOA", "thirdPerson", efeitosY, "🎥", buttonContainer)
efeitosY = createButton("INVISÍVEL", "invisible", efeitosY, "👻", buttonContainer)
efeitosY = createButton("HITBOX EXPANDER", "hitboxExpander", efeitosY, "📦", buttonContainer)

-- ABA ALERTAS (⚠️)
local alertasY = 5
alertasY = createButton("ALERTA DA BESTA", "beastAlert", alertasY, "🔔", buttonContainer)

-- Slider de velocidade (aparece em todas as abas)
local speedContainer = Instance.new("Frame")
speedContainer.Size = UDim2.new(0.94, 0, 0, 60)
speedContainer.Position = UDim2.new(0.03, 0, 1, -70)
speedContainer.BackgroundTransparency = 1
speedContainer.Parent = panel

local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(1, 0, 0, 20)
speedLabel.Position = UDim2.new(0, 0, 0, 0)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "⚡ VELOCIDADE: " .. settings.speedValue
speedLabel.TextColor3 = Color3.fromRGB(255, 200, 220)
speedLabel.Font = Enum.Font.GothamBold
speedLabel.TextSize = 12
speedLabel.Parent = speedContainer

local sliderFrame = Instance.new("Frame")
sliderFrame.Size = UDim2.new(1, 0, 0, 25)
sliderFrame.Position = UDim2.new(0, 0, 0, 25)
sliderFrame.BackgroundColor3 = Color3.fromRGB(60, 30, 75)
sliderFrame.BorderSizePixel = 2
sliderFrame.BorderColor3 = Color3.fromRGB(255, 50, 150)
sliderFrame.Parent = speedContainer

local sliderCorner = Instance.new("UICorner")
sliderCorner.CornerRadius = UDim.new(0, 12)
sliderCorner.Parent = sliderFrame

local sliderIndicator = Instance.new("Frame")
sliderIndicator.Size = UDim2.new(settings.speedValue / 200, 1, 0, 0)
sliderIndicator.BackgroundColor3 = Color3.fromRGB(255, 50, 150)
sliderIndicator.BorderSizePixel = 0
sliderIndicator.Parent = sliderFrame

local dragButton = Instance.new("TextButton")
dragButton.Size = UDim2.new(1, 0, 1, 0)
dragButton.BackgroundTransparency = 1
dragButton.Text = ""
dragButton.Parent = sliderFrame

dragButton.MouseButton1Down:Connect(function()
    local connection
    connection = mouse.Move:Connect(function()
        local x = math.clamp(mouse.X - sliderFrame.AbsolutePosition.X, 0, sliderFrame.AbsoluteSize.X)
        settings.speedValue = math.floor(x / sliderFrame.AbsoluteSize.X * 200)
        sliderIndicator.Size = UDim2.new(settings.speedValue / 200, 0, 1, 0)
        speedLabel.Text = "⚡ VELOCIDADE: " .. settings.speedValue
    end)
    mouse.Button1Up:Wait()
    connection:Disconnect()
end)

-- Função para mostrar apenas a aba selecionada
local function showTab(tabName)
    for _, child in ipairs(buttonContainer:GetChildren()) do
        if child:IsA("TextButton") then
            child.Visible = false
        end
    end

    if tabName == "ESP" then
        for _, child in ipairs(buttonContainer:GetChildren()) do
            if child:IsA("TextButton") and (child.Text:find("COMPUTADORES") or child.Text:find("FREEZER") or child.Text:find("INOCENTES") or child.Text:find("BESTA") or child.Text:find("SAÍDAS")) then
                child.Visible = true
            end
        end
    elseif tabName == "MOV" then
        for _, child in ipairs(buttonContainer:GetChildren()) do
            if child:IsA("TextButton") and (child.Text:find("VELOCIDADE") or child.Text:find("VOAR") or child.Text:find("PULO") or child.Text:find("STAMINA")) then
                child.Visible = true
            end
        end
    elseif tabName == "EFEITOS" then
        for _, child in ipairs(buttonContainer:GetChildren()) do
            if child:IsA("TextButton") and (child.Text:find("LIGHT") or child.Text:find("PESSOA") or child.Text:find("INVISÍVEL") or child.Text:find("HITBOX")) then
                child.Visible = true
            end
        end
    elseif tabName == "ALERTAS" then
        for _, child in ipairs(buttonContainer:GetChildren()) do
            if child:IsA("TextButton") and child.Text:find("ALERTA") then
                child.Visible = true
            end
        end
    end
end

-- Eventos das abas
tabEsp.MouseButton1Click:Connect(function() showTab("ESP") end)
tabMov.MouseButton1Click:Connect(function() showTab("MOV") end)
tabEfeitos.MouseButton1Click:Connect(function() showTab("EFEITOS") end)
tabAlertas.MouseButton1Click:Connect(function() showTab("ALERTAS") end)

-- Abrir/fechar painel
icon.MouseButton1Click:Connect(function()
    panel.Visible = not panel.Visible
end)

closeButton.MouseButton1Click:Connect(function()
    panel.Visible = false
end)

-- Mostrar aba ESP por padrão
showTab("ESP")

-- ========== FUNÇÕES ESPECIAIS ==========

-- Hitbox Expander
local function toggleHitbox()
    if settings.hitboxExpander and player.Character then
        for _, part in ipairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                originalSize[part] = part.Size
                part.Size = part.Size * 1.5
            end
        end
    elseif player.Character then
        for part, size in pairs(originalSize) do
            if part and part.Parent then part.Size = size end
        end
    end
end

-- Terceira Pessoa
local function toggleThirdPerson()
    if settings.thirdPerson then
        workspace.CurrentCamera.CameraType = Enum.CameraType.Fixed
        runService:BindToRenderStep("ThirdPerson", Enum.RenderPriority.Camera.Value, function()
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                workspace.CurrentCamera.CFrame = CFrame.new(player.Character.HumanoidRootPart.Position + Vector3.new(0, 5, 10), player.Character.HumanoidRootPart.Position)
            end
        end)
    else
        workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
        runService:UnbindFromRenderStep("ThirdPerson")
    end
end

-- Invisível
local function toggleInvisible()
    if settings.invisible and player.Character then
        for _, part in ipairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.Transparency = 1 end
        end
    elseif player.Character then
        for _, part in ipairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.Transparency = 0 end
        end
    end
end

-- Alerta da Besta
local function toggleBeastAlert()
    if alertConnection then alertConnection:Disconnect() end
    if settings.beastAlert then
        alertConnection = runService.RenderStepped:Connect(function()
            for _, plr in ipairs(game.Players:GetPlayers()) do
                if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                    local isBeast = false
                    if plr.Character:FindFirstChildOfClass("Tool") then
                        local tool = plr.Character:FindFirstChildOfClass("Tool")
                        if tool and tool.Name:lower():find("hammer") then isBeast = true end
                    end
                    if isBeast and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local dist = (plr.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                        if dist < 30 then
                            local alert = Instance.new("ScreenGui")
                            alert.Parent = player:FindFirstChild("PlayerGui")
                            local frame = Instance.new("Frame")
                            frame.Size = UDim2.new(1, 0, 1, 0)
                            frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                            frame.BackgroundTransparency = 0.7
                            frame.Parent = alert
                            game:GetService("Debris"):AddItem(alert, 0.3)
                        elseif dist < 60 then
                            local alert = Instance.new("ScreenGui")
                            alert.Parent = player:FindFirstChild("PlayerGui")
                            local frame = Instance.new("Frame")
                            frame.Size = UDim2.new(1, 0, 1, 0)
                            frame.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
                            frame.BackgroundTransparency = 0.8
                            frame.Parent = alert
                            game:GetService("Debris"):AddItem(alert, 0.2)
                        end
                    end
                end
            end
        end)
    end
end

-- Stamina Infinita
local function toggleInfiniteStamina()
    if settings.infiniteStamina and player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.Running:Connect(function(speed)
            if speed > 0 then player.Character.Humanoid.WalkSpeed = settings.speedValue end
        end)
    end
end

-- ========== ESP COM TRANSPARÊNCIA E CÍRCULO NO COMPUTADOR ==========

-- Função para criar ESP com transparência
local function createESP(obj, color, text, offset)
    if not obj:FindFirstChild("ESP") then
        local bill = Instance.new("BillboardGui")
        bill.Name = "ESP"
        bill.Parent = obj
        bill.Size = UDim2.new(0, 100, 0, 40)
        bill.StudsOffset = offset or Vector3.new(0, 2, 0)
        bill.AlwaysOnTop = true

        local frame = Instance.new("Frame")
        frame.Parent = bill
        frame.Size = UDim2.new(1, 0, 1, 0)
        frame.BackgroundColor3 = color
        frame.BackgroundTransparency = 0.5 -- Transparente para ver o boneco
        frame.BorderSizePixel = 2
        frame.BorderColor3 = Color3.fromRGB(255, 255, 255)

        local label = Instance.new("TextLabel")
        label.Parent = frame
        label.Size = UDim2.new(1, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.Text = text
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.TextScaled = true
        label.Font = Enum.Font.GothamBold
    end
end

-- Função para criar círculo ao redor do computador
local function createComputerCircle(computer)
    if not computer:FindFirstChild("ComputerCircle") then
        local circle = Instance.new("CircleHandleAdornment")
        circle.Name = "ComputerCircle"
        circle.Radius = 2.5
        circle.Color3 = Color3.fromRGB(255, 105, 180) -- Rosa neon
        circle.Thickness = 2
        circle.ZIndex = 10
        circle.AlwaysOnTop = true
        circle.Parent = computer
        circle.Adornee = computer
    end
end

-- ESP Computadores (com círculo)
local function computerESP()
    if settings.computerESP then
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj.Name:lower():find("computer") and obj:IsA("BasePart") then
                createESP(obj, Color3.fromRGB(0, 100, 255), "💻 COMPUTADOR", Vector3.new(0, 2, 0))
                createComputerCircle(obj)
            end
        end
    else
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:FindFirstChild("ESP") then obj.ESP:Destroy() end
            if obj:FindFirstChild("ComputerCircle") then obj.ComputerCircle:Destroy() end
        end
    end
end

-- ESP Freezer
local function freezerESP()
    if settings.freezerESP then
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj.Name:lower():find("freezer") and obj:IsA("BasePart") and not obj:FindFirstChild("ESP") then
                createESP(obj, Color3.fromRGB(0, 200, 255), "❄️ FREEZER", Vector3.new(0, 2, 0))
            end
        end
    else
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:FindFirstChild("ESP") and obj:FindFirstChild("ESP"):FindFirstChild("Frame") and obj.ESP.Frame.BackgroundColor3 == Color3.fromRGB(0, 200, 255) then
                obj.ESP:Destroy()
            end
        end
    end
end

-- ESP Inocentes (verde transparente)
local function innocentESP()
    if settings.innocentESP then
        for _, plr in ipairs(game.Players:GetPlayers()) do
            if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                local isBeast = false
                if plr.Character:FindFirstChildOfClass("Tool") then
                    local tool = plr.Character:FindFirstChildOfClass("Tool")
                    if tool and tool.Name:lower():find("hammer") then isBeast = true end
                end
                if not isBeast and not plr.Character.HumanoidRootPart:FindFirstChild("ESP
