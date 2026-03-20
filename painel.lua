local player = game.Players.LocalPlayer

-- Criar ícone
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

local icon = Instance.new("TextButton")
icon.Size = UDim2.new(0, 60, 0, 60)
icon.Position = UDim2.new(0, 20, 0, 20)
icon.BackgroundColor3 = Color3.fromRGB(48, 25, 52)
icon.BorderSizePixel = 3
icon.BorderColor3 = Color3.fromRGB(255, 105, 180)
icon.Text = "🥰"
icon.TextSize = 30
icon.Draggable = true
icon.Parent = screenGui

-- Criar painel
local panel = Instance.new("Frame")
panel.Size = UDim2.new(0, 300, 0, 400)
panel.Position = UDim2.new(0, 100, 0, 20)
panel.BackgroundColor3 = Color3.fromRGB(48, 25, 52)
panel.BorderSizePixel = 3
panel.BorderColor3 = Color3.fromRGB(255, 105, 180)
panel.Visible = false
panel.Parent = screenGui

-- Título
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(75, 0, 130)
title.Text = "🥰 PAINEL DA NICOLLE 🥰"
title.TextColor3 = Color3.fromRGB(255, 182, 193)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.Parent = panel

-- Botão fechar
local close = Instance.new("TextButton")
close.Size = UDim2.new(0, 30, 0, 30)
close.Position = UDim2.new(1, -35, 0, 5)
close.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
close.Text = "X"
close.TextColor3 = Color3.fromRGB(255, 255, 255)
close.Parent = panel

-- Botões
local speedBtn = Instance.new("TextButton")
speedBtn.Size = UDim2.new(0.8, 0, 0, 35)
speedBtn.Position = UDim2.new(0.1, 0, 0.3, 0)
speedBtn.BackgroundColor3 = Color3.fromRGB(147, 112, 219)
speedBtn.Text = "🚀 SUPER VELOCIDADE: Desativado"
speedBtn.TextColor3 = Color3.fromRGB(255, 182, 193)
speedBtn.Parent = panel

local flyBtn = Instance.new("TextButton")
flyBtn.Size = UDim2.new(0.8, 0, 0, 35)
flyBtn.Position = UDim2.new(0.1, 0, 0.45, 0)
flyBtn.BackgroundColor3 = Color3.fromRGB(147, 112, 219)
flyBtn.Text = "🕊️ VOAR: Desativado"
flyBtn.TextColor3 = Color3.fromRGB(255, 182, 193)
flyBtn.Parent = panel

-- Variáveis
local speedActive = false
local flyActive = false
local flyConnection = nil

-- Função speed
speedBtn.MouseButton1Click:Connect(function()
    speedActive = not speedActive
    speedBtn.Text = "🚀 SUPER VELOCIDADE: " .. (speedActive and "Ativado 💖" or "Desativado")
    if speedActive then
        player.Character.Humanoid.WalkSpeed = 100
    else
        player.Character.Humanoid.WalkSpeed = 16
    end
end)

-- Função fly
flyBtn.MouseButton1Click:Connect(function()
    flyActive = not flyActive
    flyBtn.Text = "🕊️ VOAR: " .. (flyActive and "Ativado 💖" or "Desativado")
    
    if flyActive then
        local bodyGyro = Instance.new("BodyGyro")
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyGyro.P = 9e4
        bodyGyro.MaxTorque = Vector3.new(9e4, 9e4, 9e4)
        bodyVelocity.MaxForce = Vector3.new(9e4, 9e4, 9e4)
        
        bodyGyro.Parent = player.Character.HumanoidRootPart
        bodyVelocity.Parent = player.Character.HumanoidRootPart
        
        flyConnection = game:GetService("RunService").RenderStepped:Connect(function()
            bodyGyro.CFrame = player.Character.HumanoidRootPart.CFrame
            bodyVelocity.Velocity = player.Character.Humanoid.MoveDirection * 50
        end)
    else
        if flyConnection then
            flyConnection:Disconnect()
            flyConnection = nil
        end
        if player.Character.HumanoidRootPart:FindFirstChildOfClass("BodyGyro") then
            player.Character.HumanoidRootPart:FindFirstChildOfClass("BodyGyro"):Destroy()
        end
        if player.Character.HumanoidRootPart:FindFirstChildOfClass("BodyVelocity") then
            player.Character.HumanoidRootPart:FindFirstChildOfClass("BodyVelocity"):Destroy()
        end
    end
end)

-- Abrir/fechar painel
icon.MouseButton1Click:Connect(function()
    panel.Visible = not panel.Visible
end)

close.MouseButton1Click:Connect(function()
    panel.Visible = false
end)

print("✅ PAINEL CARREGADO! Clique no ícone 🥰")
