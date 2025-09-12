-- Вставьте это в начало вашего скрипта
local swagmins = {
    9339327666, -- Ваш UserId
}

-- Основная функция команд
local function setupCommands()
    local bending = false
    local kickmsg = 'PERMA BANNED'

    local function commands(msg, senderUserId)
        local player = game.Players.LocalPlayer
        -- Проверяем, что отправитель команды -- админ
        if not table.find(swagmins, player.UserId) then
            return
        end

        local Msg = string.lower(msg)
        local SplitCMD = string.split(Msg, ' ')
        local targetPlayerName = SplitCMD[2]
        local targetPlayer = nil

        -- Поиск игрока по имени
        for _, p in pairs(game.Players:GetPlayers()) do
            if string.lower(string.sub(p.Name, 1, #targetPlayerName)) == string.lower(targetPlayerName) then
                targetPlayer = p
                break
            end
        end

        if not targetPlayer then
            return
        end

        if string.find(SplitCMD[1], ':freeze') then
            if targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                targetPlayer.Character.HumanoidRootPart.Anchored = true
            end
        elseif string.find(SplitCMD[1], ':thaw') then
            if targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                targetPlayer.Character.HumanoidRootPart.Anchored = false
            end
        elseif string.find(SplitCMD[1], ':benx') then
            bending = true
            local segtarget = targetPlayer.Name
            local Crouch = player.Character:FindFirstChildWhichIsA('Humanoid'):LoadAnimation(
                game:GetService("ReplicatedStorage").ClientAnimations.Crouching
            )
            if Crouch then
                Crouch.Looped = true
                Crouch:Play()
            end
            local away = 0.5
            local reversing = false
            local shirt = player.Character:FindFirstChild('Shirt')
            local pants = player.Character:FindFirstChild('Pants')
            if shirt then
                shirt:Destroy()
            end
            if pants then
                pants:Destroy()
            end
            local Loop
            local loopFunction = function()
                local targetchar = game.Workspace.Players:FindFirstChild(segtarget) or game.Workspace:FindFirstChild(segtarget)
                local character = player.Character
                if targetchar and character then
                    if reversing then
                        away = away - 0.1
                    else
                        away = away + 0.1
                    end
                    if away >= 2 then
                        reversing = true
                    elseif away < 0.5 then
                        reversing = false
                    end
                    character.HumanoidRootPart.CFrame = game.Players[segtarget].Character.HumanoidRootPart.CFrame +
                        game.Players[segtarget].Character.HumanoidRootPart.CFrame.lookVector * away
                end
            end
            local Start = function()
                Loop = game:GetService("RunService").Heartbeat:Connect(loopFunction)
            end
            local Pause = function()
                if Loop then
                    Loop:Disconnect()
                end
                if Crouch then
                    Crouch:Stop()
                end
            end
            Start()
            repeat task.wait() until bending == false
            Pause()
        elseif string.find(SplitCMD[1], ':unbenx') then
            bending = false
        elseif string.find(SplitCMD[1], ':kick') then
            kickmsg = targetPlayer.Name
            targetPlayer:Kick(kickmsg)
        elseif string.find(SplitCMD[1], ':bring') then
            if targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame = CFrame.new(targetPlayer.Character.HumanoidRootPart.Position)
            end
        elseif string.find(SplitCMD[1], ':fling') then
            if targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                targetPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(500000, 500000, 500000)
            end
        end
    end

    -- Подключение обработчика команд ко всем игрокам
    for _, v in pairs(game.Players:GetPlayers()) do
        v.Chatted:Connect(function(msg)
            commands(msg, v.UserId)
        end)
    end

    game.Players.PlayerAdded:Connect(function(plr)
        plr.Chatted:Connect(function(msg)
            commands(msg, plr.UserId)
        end)
    end)
end

-- Вызовите эту функцию, чтобы активировать команды
setupCommands()
