_G.RaceClickAutov3 = true
_G.RaceClickAutov4 = true
Boud = true

local replicated = game:GetService("ReplicatedStorage")

local function Useskills(arg1, key)
    game:GetService("VirtualInputManager"):SendKeyEvent(true, key, false, game)
    wait(0.1)
    game:GetService("VirtualInputManager"):SendKeyEvent(false, key, false, game)
end

-- Auto Race V3
task.spawn(function()
    while task.wait(0.2) do
        if _G.RaceClickAutov3 then
            pcall(function()
                replicated.Remotes.CommE:FireServer("ActivateAbility")
            end)
            task.wait(30)
        end
    end
end)

-- Auto Race V4
task.spawn(function()
    while task.wait(0.2) do
        if _G.RaceClickAutov4 then
            pcall(function()
                local char = plr.Character
                if char and char:FindFirstChild("RaceEnergy") then
                    if char.RaceEnergy.Value >= 1 then 
                        Useskills("nil", "Y")
                    end
                end
            end)
        end
    end
end)

-- Auto Buso
task.spawn(function()
    while task.wait(1) do
        if Boud then
            pcall(function()
                if not plr.Character:FindFirstChild("HasBuso") then
                    replicated.Remotes.CommF_:InvokeServer("Buso")
                end
            end)
        end
    end
end)


-- Noclip Logic
local noclipEnabled = true 
game:GetService("RunService").Stepped:Connect(function()
    if noclipEnabled then
        local char = plr.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") and part.CanCollide then
                    part.CanCollide = false
                end
            end
        end
    end
end)
