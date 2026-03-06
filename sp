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

local checkDistance = 400

local function getCurrentToolTip()
    local myName = string.lower(plr.Name)
    local myDisplayName = string.lower(plr.DisplayName)
    
    if getgenv().Configs then
        for _, data in pairs(getgenv().Configs) do
            if type(data) == "table" and data.Users then
                for _, user in pairs(data.Users) do
                    local configUser = string.lower(user)
                    if configUser == myName or configUser == myDisplayName then 
                        return data.ToolTip 
                    end
                end
            end
        end
    end
    return nil
end

local myToolTip = getCurrentToolTip()

local function isEnemyNearby()
    local character = plr.Character
    local root = character and character:FindFirstChild("HumanoidRootPart")
    if not root then return false end
    
    local enemies = workspace:FindFirstChild("Enemies") or workspace:FindFirstChild("NPCs") or workspace
    for _, v in pairs(enemies:GetChildren()) do
        local eRoot = v:FindFirstChild("HumanoidRootPart")
        local eHum = v:FindFirstChild("Humanoid")
        if eRoot and eHum and eHum.Health > 0 and v ~= character then
            if (root.Position - eRoot.Position).Magnitude <= checkDistance then
                return true
            end
        end
    end
    return false
end

local function equipToolByRole()
    if not myToolTip then return end
    local character = plr.Character
    local backpack = plr:FindFirstChild("Backpack")
    if character and backpack then
        local hum = character:FindFirstChild("Humanoid")
        local currentlyEquipped = character:FindFirstChildOfClass("Tool")
        if currentlyEquipped and currentlyEquipped.ToolTip == myToolTip then return end
        if hum then
            for _, item in pairs(backpack:GetChildren()) do
                if item:IsA("Tool") and item.ToolTip == myToolTip then
                    hum:EquipTool(item)
                    break
                end
            end
        end
    end
end

task.spawn(function()
    while true do
        if isEnemyNearby() then
            equipToolByRole()
            task.wait(0.5)
        else
            task.wait(2) 
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
