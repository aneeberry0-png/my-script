-- Định nghĩa biến plr đầu tiên nè (っ˘ω˘ς)
local plr = game:GetService("Players").LocalPlayer
local replicated = game:GetService("ReplicatedStorage")

_G.RaceClickAutov3 = true
_G.RaceClickAutov4 = true
Boud = true

-- Hàm bấm phím kỹ năng nhó (〃´∀｀)
local function Useskills(arg1, key)
    game:GetService("VirtualInputManager"):SendKeyEvent(true, key, false, game)
    task.wait(0.1) -- Dùng task.wait cho xịn nhó ann
    game:GetService("VirtualInputManager"):SendKeyEvent(false, key, false, game)
end

-- Auto Race V3
task.spawn(function()
    while task.wait(0.5) do -- Chỉnh lại xíu cho đỡ lag nhó
        if _G.RaceClickAutov3 then
            pcall(function()
                -- CommE thường dùng cho các lệnh kích hoạt Race nhó
                replicated.Remotes.CommE:FireServer("ActivateAbility")
            end)
            task.wait(30) -- Đợi hồi chiêu nhó (๑˃ᴗ˂)ﻭ
        end
    end
end)

-- Auto Race V4
task.spawn(function()
    while task.wait(0.2) do
        if _G.RaceClickAutov4 then
            pcall(function()
                local char = plr.Character
                -- Check xem có RaceEnergy và đủ 1 (100%) để bật V4 hông mò
                if char and char:FindFirstChild("RaceEnergy") then
                    if char.RaceEnergy.Value >= 1 then 
                        Useskills("nil", "Y")
                    end
                end
            end)
        end
    end
end)

-- Auto Buso (Haki)
task.spawn(function()
    while task.wait(1) do
        if Boud then
            pcall(function()
                -- Nếu chưa có HasBuso thì mới bật nhó (っ˘ω˘ς)
                if plr.Character and not plr.Character:FindFirstChild("HasBuso") then
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
