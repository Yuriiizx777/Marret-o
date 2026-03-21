local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local runService = game:GetService("RunService")

-- Criar GUI principal
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")
screenGui.Name = "PainelDaNicolle"
screenGui.ResetOnSpawn = false

-- Variáveis de controle
local settings = {
    computerESP = false,
    innocentESP = false,
    beastESP = false,
    hitboxExpander = false
}

-- Variáveis para funções
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
panel.Size = UDim2.new(0, 340, 0, 380)
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
for i = 1, 2 do
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

-- Container para os botões
local buttonContainer = Instance.new("Frame")
buttonContainer.Size = UDim2.new(0.94, 0, 0, 250)
buttonContainer.Position = UDim2.new(0.03, 0, 0, 100)
buttonContainer.BackgroundTransparency = 1
buttonContainer.Parent = panel

-- Função para criar botões
local function createButton(name, setting, yPos, emoji)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.95, 0, 0, 45)
    button.Position = UDim2.new(0.025, 0, 0, yPos)
    button.BackgroundColor3 = Color3.fromRGB(60, 30, 75)
    button.BackgroundTransparency = 0.4
    button.Text = "   " .. emoji .. " " .. name .. ":  Desativado"
    button.TextColor3 = Color3.fromRGB(255, 200, 220)
    button.Font = Enum.Font.Gotham
    button.TextSize = 14
    button.TextXAlignment = Enum.TextXAlignment.Left
    button.BorderSizePixel = 2
    button.BorderColor3 = Color3.fromRGB(255, 50, 150)
    button.Parent = buttonContainer

    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 12)
    buttonCorner.Parent = button

    button.MouseButton1Click:Connect(function()
        settings[setting] = not settings[setting]
        button.Text = "   " .. emoji .. " " .. name .. ":  " .. (settings[setting] and "Ativado 💖" or "Desativado")
        button.TextColor3 = settings[setting] and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(255, 200, 220)
        
        if setting == "hitboxExpander" then
            toggleHitbox()
        end
    end)

    return yPos + 55
end

-- Criar botões
local yPos = 10
yPos = createButton("💻 COMPUTADOR (CÍRCULO)", "computerESP", yPos, "💻")
yPos = createButton("😇 INOCENTES", "innocentESP", yPos, "😇")
yPos = createButton("👾 A BESTA", "beastESP", yPos, "👾")
yPos = yPos + 15
yPos = createButton("📦 HITBOX EXPANDER", "hitboxExpander", yPos, "📦")

-- ========== FUNÇÃO HITBOX EXPANDER ==========
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
            if part and part.Parent then
                part.Size = size
            end
        end
    end
end

-- ========== ESP COMPUTADOR (COM CÍRCULO) ==========
local function computerESP()
    if settings.computerESP then
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj.Name:lower():find("computer") and obj:IsA("BasePart") then
                -- Marcador Billboard
                if not obj:FindFirstChild("ComputerESP") then
                    local bill = Instance.new("BillboardGui")
                    bill.Name = "ComputerESP"
                    bill.Parent = obj
                    bill.Size = UDim2.new(0, 100, 0, 40)
                    bill.StudsOffset = Vector3.new(0, 2, 0)
                    bill.AlwaysOnTop = true
                    
                    local frame = Instance.new("Frame")
                    frame.Parent = bill
                    frame.Size = UDim2.new(1, 0, 1, 0)
                    frame.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
                    frame.BackgroundTransparency = 0.5
                    frame.BorderSizePixel = 2
                    frame.BorderColor3 = Color3.fromRGB(255, 255, 255)
                    
                    local text = Instance.new("TextLabel")
                    text.Parent = frame
                    text.Size = UDim2.new(1, 0, 1, 0)
                    text.BackgroundTransparency = 1
                    text.Text = "💻 COMPUTADOR"
                    text.TextColor3 = Color3.fromRGB(255, 255, 255)
                    text.TextScaled = true
                    text.Font = Enum.Font.GothamBold
                end
                
                -- Círculo ao redor do computador
                if not obj:FindFirstChild("ComputerCircle") then
                    local circle = Instance.new("CircleHandleAdornment")
                    circle.Name = "ComputerCircle"
                    circle.Radius = 2.5
                    circle.Color3 = Color3.fromRGB(255, 105, 180)
                    circle.Thickness = 3
                    circle.ZIndex = 10
                    circle.AlwaysOnTop = true
                    circle.Parent = obj
                    circle.Adornee = obj
                end
            end
        end
    else
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:FindFirstChild("ComputerESP") then obj.ComputerESP:Destroy() end
            if obj:FindFirstChild("ComputerCircle") then obj.ComputerCircle:Destroy() end
        end
    end
end

-- ========== ESP INOCENTES (VERDE TRANSPARENTE) ==========
local function innocentESP()
    if settings.innocentESP then
        for _, plr in ipairs(game.Players:GetPlayers()) do
            if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                -- Verifica se é besta (tem martelo)
                local isBeast = false
                if plr.Character:FindFirstChildOfClass("Tool") then
                    local tool = plr.Character:FindFirstChildOfClass("Tool")
                    if tool and tool.Name:lower():find("hammer") then
                        isBeast = true
                    end
                end
                
                if not isBeast and not plr.Character.HumanoidRootPart:FindFirstChild("InnocentESP") then
                    local bill = Instance.new("BillboardGui")
                    bill.Name = "InnocentESP"
                    bill.Parent = plr.Character.HumanoidRootPart
                    bill.Size = UDim2.new(0, 100, 0, 40)
                    bill.StudsOffset = Vector3.new(0, 3, 0)
                    bill.AlwaysOnTop = true
                    
                    local frame = Instance.new("Frame")
                    frame.Parent = bill
                    frame.Size = UDim2.new(1, 0, 1, 0)
                    frame.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
                    frame.BackgroundTransparency = 0.4
                    frame.BorderSizePixel = 2
                    frame.BorderColor3 = Color3.fromRGB(255, 255, 255)
                    
                    local text = Instance.new("TextLabel")
                    text.Parent = frame
                    text.Size = UDim2.new(1, 0, 1, 0)
                    text.BackgroundTransparency = 1
                    text.Text = "😇 INOCENTE"
                    text.TextColor3 = Color3.fromRGB(255, 255, 255)
                    text.TextScaled = true
                    text.Font = Enum.Font.GothamBold
                end
            end
        end
    else
        for _, plr in ipairs(game.Players:GetPlayers()) do
            if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                if plr.Character.HumanoidRootPart:FindFirstChild("InnocentESP") then
                    plr.Character.HumanoidRootPart.InnocentESP:Destroy()
                end
            end
        end
    end
end

-- ========== ESP BESTA (VERMELHO TRANSPARENTE COM VIDA) ==========
local function beastESP()
    if settings.beastESP then
        for _, plr in ipairs(game.Players:GetPlayers()) do
            if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                local isBeast = false
                if plr.Character:FindFirstChildOfClass("Tool") then
                    local tool = plr.Character:FindFirstChildOfClass("Tool")
                    if tool and tool.Name:lower():find("hammer") then
                        isBeast = true
                    end
                end
                
                if isBeast then
                    local root = plr.Character.HumanoidRootPart
                    if not root:FindFirstChild("BeastESP") then
                        local bill = Instance.new("BillboardGui")
                        bill.Name = "BeastESP"
                        bill.Parent = root
                        bill.Size = UDim2.new(0, 120, 0, 50)
                        bill.StudsOffset = Vector3.new(0, 3, 0)
                        bill.AlwaysOnTop = true
                        
                        local frame = Instance.new("Frame")
                        frame.Parent = bill
                        frame.Size = UDim2.new(1, 0, 1, 0)
                        frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                        frame.BackgroundTransparency = 0.4
                        frame.BorderSizePixel = 2
                        frame.BorderColor3 = Color3.fromRGB(255, 255, 255)
                        
                        local text = Instance.new("TextLabel")
                        text.Parent = frame
                        text.Size = UDim2.new(1, 0, 0.6, 0)
                        text.Text = "👾 BESTA"
                        text.TextColor3 = Color3.fromRGB(255, 255, 255)
                        text.TextScaled = true
                        text.Font = Enum.Font.GothamBold
                        
                        local health = Instance.new("TextLabel")
                        health.Parent = frame
                        health.Size = UDim2.new(1, 0, 0.4, 0)
                        health.Position = UDim2.new(0, 0, 0.6, 0)
                        health.Text = "HP: " .. math.floor(plr.Character.Humanoid.Health)
                        health.TextColor3 = Color3.fromRGB(255, 255, 255)
                        health.TextScaled = true
                        
                        -- Atualizar vida em tempo real
                        plr.Character.Humanoid.HealthChanged:Connect(function()
                            if health and health.Parent then
                                health.Text = "HP: " .. math.floor(plr.Character.Humanoid.Health)
                            end
                        end)
                    end
                end
            end
        end
    else
        for _, plr in ipairs(game.Players:GetPlayers()) do
            if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                if plr.Character.HumanoidRootPart:FindFirstChild("BeastESP") then
                    plr.Character.HumanoidRootPart.BeastESP:Destroy()
                end
            end
        end
    end
end

-- Abrir/fechar painel
icon.MouseButton1Click:Connect(function()
    panel.Visible = not panel.Visible
end)

closeButton.MouseButton1Click:Connect(function()
    panel.Visible = false
end)

-- Loop principal
runService.RenderStepped:Connect(function()
    computerESP()
    innocentESP()
    beastESP()
end)

-- Rodapé
local footer = Instance.new("TextLabel")
footer.Size = UDim2.new(1, 0, 0, 35)
footer.Position = UDim2.new(0, 0, 1, -35)
footer.BackgroundColor3 = Color3.fromRGB(75, 0, 130)
footer.BackgroundTransparency = 0.3
footer.Text = "🥰 PAINEL DA NICOLLE - ESP COMPLETO 🥰"
footer.TextColor3 = Color3.fromRGB(255, 182, 193)
footer.Font = Enum.Font.Gotham
footer.TextSize = 11
footer.TextWrapped = true
footer.Parent = panel

local footerCorner = Instance.new("UICorner")
footerCorner.CornerRadius = UDim.new(0, 15)
footerCorner.Parent = footer

print("✅ PAINEL DA NICOLLE CARREGADO! Clique no ícone 🥰 para abrir")
