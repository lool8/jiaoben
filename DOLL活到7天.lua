-- 在 WindUI 加载之后，创建窗口之前添加这些函数

-- 文本显示功能（用于世界设置标签）
local function txtf(action, position, text)
    if action == "UpdateLine" then
        -- 简单的文本显示实现
        if position == "Left" then
            -- 可以在屏幕上显示文本或输出到控制台
            print("[INFO] " .. (text or ""))
        end
    elseif action == "ClearText" then
        -- 清除文本显示
        print("[INFO] 文本已清除")
    end
end

-- 查找最近松树的函数（用于自动传送）
local function findClosestPine()
    local character = game.Players.LocalPlayer.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then
        return nil
    end
    
    local playerPos = character.HumanoidRootPart.Position
    local closestPine = nil
    local shortestDistance = math.huge
    
    -- 搜索工作区中的所有松树/木材
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Part") and (obj.Name:lower():find("pine") or obj.Name:lower():find("wood") or obj.Name:lower():find("log")) then
            local distance = (playerPos - obj.Position).Magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                closestPine = obj
            end
        end
    end
    
    return closestPine
end
-- 1. 加载 WindUI 核心库
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/lool8/-/refs/heads/main/DOLLUI.lua"))()

-- 2. 创建主窗口
local MainWindow = WindUI:CreateWindow({
    Title = "DOLL※༒", 
    Author = "༼DOLL༽ | ᐁQ群:1058549962ᐁ",
    Folder = "CharacterControl",
    Size = UDim2.fromOffset(400, 300),
    Theme = "Dark",  -- 使用预设的暗色主题
    SideBarWidth = 200,
    Acrylic = true,
    BlurRadius = 10,
    BackgroundImage = "rbxassetid://107548824953725",
    TitleBarGradient = {
        ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromHex("#4facfe")),
            ColorSequenceKeypoint.new(1, Color3.fromHex("#00f2fe"))
        }),
        Rotation = 135
    }
})

-- 4. 创建侧边栏标签页：视角设置
local Tab1 = MainWindow:Tab({
    Title = "视角设置",
    Icon = "camera"
})

-- 4.1 视角控制分组
local Tab1Section = Tab1:Section({
    Title = "视角参数"
})

-- 4.1.1 滑动条：视角距离
Tab1Section:Slider({
    Title = "视角距离",
    Value = {
        Min = 0,
        Max = 120,
        Default = 30
    },
    Callback = function(value)
        local camera = game.Workspace.CurrentCamera
        if camera then
            camera.FieldOfView = tonumber(value)  -- 调节视角FOV
        end
    end
})

-- 4.1.2 下拉菜单：视角模式
Tab1Section:Dropdown({
    Title = "视角模式",
    Values = {"第三人称", "第一人称", "自由视角"},  -- 可选选项
    Value = "自由视角",  -- 默认选项
    Callback = function(selected)
        local camera = game.Workspace.CurrentCamera
        local humanoid = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if not camera or not humanoid then return end
        
        -- 根据选择切换视角模式
        if selected == "第一人称" then
            camera.CameraType = Enum.CameraType.Attach
            humanoid.CameraOffset = Vector3.new(0, 1.5, 0)
        elseif selected == "第三人称" then
            camera.CameraType = Enum.CameraType.Custom
            humanoid.CameraOffset = Vector3.new(0, 0, 0)
        elseif selected == "自由视角" then
            camera.CameraType = Enum.CameraType.Free
        end
    end
})

local Tab2 = MainWindow:Tab({
    Title = "玩家",
    Icon = "bolt"  -- 标签页图标
})

local Tab2Section = Tab2:Section({
    Title = "主要的"
})

-- 防摔落
Tab2Section:Button({
    Title = "防摔落",
    Icon = "shield-virus",
    Color = Color3.fromHex("#000000"),
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/cytj777i/Fall-injury/main/防止摔落伤害"))()
        WindUI:Notify({ Title = "防摔落", Content = "✅ 已执行", Icon = "bolt" })
    end
})

-- 无敌少侠
Tab2Section:Button({
    Title = "无敌少侠",
    Icon = "user-astronaut",
    Color = Color3.fromHex("#000000"),
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Invinicible-Flight-R15-45414"))()
        WindUI:Notify({ Title = "无敌少侠", Content = "✅ 已执行", Icon = "bolt" })
    end
})

Tab2Section:Button({
    Title = "DOLL飞行",
    Icon = "refresh-cw",
    Color = Color3.fromHex("#000000"),  -- 按钮颜色
    Callback = function()
        local main = Instance.new("ScreenGui")
local speeds = 1 -- 新增：局部变量声明
local nowe = false -- 新增：局部变量声明
local tpwalking = false -- 新增：局部变量声明
local Frame = Instance.new("Frame")
local up = Instance.new("TextButton")
local down = Instance.new("TextButton")
local onof = Instance.new("TextButton")
local TextLabel = Instance.new("TextLabel")
local plus = Instance.new("TextButton")
local speed = Instance.new("TextLabel")
local mine = Instance.new("TextButton")
local closebutton = Instance.new("TextButton")
local mini = Instance.new("TextButton")
local mini2 = Instance.new("TextButton")

main.Name = "main"
main.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
main.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
main.ResetOnSpawn = false

Frame.Parent = main
Frame.BackgroundColor3 = Color3.fromRGB(163, 255, 137)
Frame.BorderColor3 = Color3.fromRGB(103, 221, 213)
Frame.Position = UDim2.new(0.100320168, 0, 0.379746825, 0)
Frame.Size = UDim2.new(0, 190, 0, 57)

up.Name = "up"
up.Parent = Frame
up.BackgroundColor3 = Color3.fromRGB(79, 255, 152)
up.Size = UDim2.new(0, 44, 0, 28)
up.Font = Enum.Font.SourceSans
up.Text = "上"
up.TextColor3 = Color3.fromRGB(0, 0, 0)
up.TextSize = 14.000

down.Name = "down"
down.Parent = Frame
down.BackgroundColor3 = Color3.fromRGB(215, 255, 121)
down.Position = UDim2.new(0, 0, 0.491228074, 0)
down.Size = UDim2.new(0, 44, 0, 28)
down.Font = Enum.Font.SourceSans
down.Text = "下"
down.TextColor3 = Color3.fromRGB(0, 0, 0)
down.TextSize = 14.000

onof.Name = "onof"
onof.Parent = Frame
onof.BackgroundColor3 = Color3.fromRGB(255, 249, 74)
onof.Position = UDim2.new(0.702823281, 0, 0.491228074, 0)
onof.Size = UDim2.new(0, 56, 0, 28)
onof.Font = Enum.Font.SourceSans
onof.Text = "飞行"
onof.TextColor3 = Color3.fromRGB(0, 0, 0)
onof.TextSize = 14.000

TextLabel.Parent = Frame
TextLabel.BackgroundColor3 = Color3.fromRGB(242, 60, 255)
TextLabel.Position = UDim2.new(0.469327301, 0, 0, 0)
TextLabel.Size = UDim2.new(0, 100, 0, 28)
TextLabel.Font = Enum.Font.SourceSans
TextLabel.Text = "DOLL飞行"
TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.TextScaled = true
TextLabel.TextSize = 14.000
TextLabel.TextWrapped = true

plus.Name = "plus"
plus.Parent = Frame
plus.BackgroundColor3 = Color3.fromRGB(133, 145, 255)
plus.Position = UDim2.new(0.231578946, 0, 0, 0)
plus.Size = UDim2.new(0, 45, 0, 28)
plus.Font = Enum.Font.SourceSans
plus.Text = "+"
plus.TextColor3 = Color3.fromRGB(0, 0, 0)
plus.TextScaled = true
plus.TextSize = 14.000
plus.TextWrapped = true

speed.Name = "speed"
speed.Parent = Frame
speed.BackgroundColor3 = Color3.fromRGB(255, 85, 0)
speed.Position = UDim2.new(0.468421042, 0, 0.491228074, 0)
speed.Size = UDim2.new(0, 44, 0, 28)
speed.Font = Enum.Font.SourceSans
speed.Text = "1"
speed.TextColor3 = Color3.fromRGB(0, 0, 0)
speed.TextScaled = true
speed.TextSize = 14.000
speed.TextWrapped = true

mine.Name = "mine"
mine.Parent = Frame
mine.BackgroundColor3 = Color3.fromRGB(123, 255, 247)
mine.Position = UDim2.new(0.231578946, 0, 0.491228074, 0)
mine.Size = UDim2.new(0, 45, 0, 29)
mine.Font = Enum.Font.SourceSans
mine.Text = "-"
mine.TextColor3 = Color3.fromRGB(0, 0, 0)
mine.TextScaled = true
mine.TextSize = 14.000
mine.TextWrapped = true

closebutton.Name = "Close"
closebutton.Parent = main.Frame
closebutton.BackgroundColor3 = Color3.fromRGB(225, 25, 0)
closebutton.Font = "SourceSans"
closebutton.Size = UDim2.new(0, 45, 0, 28)
closebutton.Text = "关闭"
closebutton.TextSize = 30
closebutton.Position =  UDim2.new(0, 0, -1, 27)

mini.Name = "minimize"
mini.Parent = main.Frame
mini.BackgroundColor3 = Color3.fromRGB(192, 150, 230)
mini.Font = "SourceSans"
mini.Size = UDim2.new(0, 45, 0, 28)
mini.Text = "隐藏"
mini.TextSize = 40
mini.Position = UDim2.new(0, 44, -1, 27)

mini2.Name = "minimize2"
mini2.Parent = main.Frame
mini2.BackgroundColor3 = Color3.fromRGB(192, 150, 230)
mini2.Font = "SourceSans"
mini2.Size = UDim2.new(0, 45, 0, 28)
mini2.Text = "+"
mini2.TextSize = 40
mini2.Position = UDim2.new(0, 44, -1, 57)
mini2.Visible = false

speeds = 1

local speaker = game:GetService("Players").LocalPlayer

local chr = game.Players.LocalPlayer.Character
local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")

nowe = false

game:GetService("StarterGui"):SetCore("SendNotification", { 
	Title = "DOLL脚本";
	Text = "欢迎使用DOLL飞行 谢谢🙏";
	Icon = "rbxthumb://type=Asset&id=5107182114&w=150&h=150"})
Duration = 5;

Frame.Active = true -- main = gui
Frame.Draggable = true

onof.MouseButton1Down:connect(function()

	if nowe == true then
		nowe = false

		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,true)
		speaker.Character.Humanoid:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
	else 
		nowe = true



		for i = 1, speeds do
			spawn(function()

				local hb = game:GetService("RunService").Heartbeat	


				tpwalking = true
				local chr = game.Players.LocalPlayer.Character
				local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
				while tpwalking and hb:Wait() and chr and hum and hum.Parent do
					if hum.MoveDirection.Magnitude > 0 then
						chr:TranslateBy(hum.MoveDirection)
					end
				end

			end)
		end
		game.Players.LocalPlayer.Character.Animate.Disabled = true
		local Char = game.Players.LocalPlayer.Character
		local Hum = Char:FindFirstChildOfClass("Humanoid") or Char:FindFirstChildOfClass("AnimationController")

		for i,v in next, 
		Hum:GetPlayingAnimationTracks() do
			v:AdjustSpeed(0)
		end
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,false)
		speaker.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Swimming)
	end




	if game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R6 then



		local plr = game.Players.LocalPlayer
		local torso = plr.Character.Torso
		local flying = true
		local deb = true
		local ctrl = {f = 0, b = 0, l = 0, r = 0}
		local lastctrl = {f = 0, b = 0, l = 0, r = 0}
		local maxspeed = 50
		local speed = 0


		local bg = Instance.new("BodyGyro", torso)
		bg.P = 9e4
		bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
		bg.cframe = torso.CFrame
		local bv = Instance.new("BodyVelocity", torso)
		bv.velocity = Vector3.new(0,0.1,0)
		bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
		if nowe == true then
			plr.Character.Humanoid.PlatformStand = true
		end
		while nowe == true or game:GetService("Players").LocalPlayer.Character.Humanoid.Health == 0 do
			game:GetService("RunService").RenderStepped:Wait()

			if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
				speed = speed+.5+(speed/maxspeed)
				if speed > maxspeed then
					speed = maxspeed
				end
			elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
				speed = speed-1
				if speed < 0 then
					speed = 0
				end
			end
			if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
				bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
				lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
			elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then
				bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
			else
				bv.velocity = Vector3.new(0,0,0)
			end
			--	game.Players.LocalPlayer.Character.Animate.Disabled = true
			bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0)
		end
		ctrl = {f = 0, b = 0, l = 0, r = 0}
		lastctrl = {f = 0, b = 0, l = 0, r = 0}
		speed = 0
		bg:Destroy()
		bv:Destroy()
		plr.Character.Humanoid.PlatformStand = false
		game.Players.LocalPlayer.Character.Animate.Disabled = false
		tpwalking = false




	else
		local plr = game.Players.LocalPlayer
		local UpperTorso = plr.Character.UpperTorso
		local flying = true
		local deb = true
		local ctrl = {f = 0, b = 0, l = 0, r = 0}
		local lastctrl = {f = 0, b = 0, l = 0, r = 0}
		local maxspeed = 50
		local speed = 0


		local bg = Instance.new("BodyGyro", UpperTorso)
		bg.P = 9e4
		bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
		bg.cframe = UpperTorso.CFrame
		local bv = Instance.new("BodyVelocity", UpperTorso)
		bv.velocity = Vector3.new(0,0.1,0)
		bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
		if nowe == true then
			plr.Character.Humanoid.PlatformStand = true
		end
		while nowe == true or game:GetService("Players").LocalPlayer.Character.Humanoid.Health == 0 do
			wait()

			if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
				speed = speed+.5+(speed/maxspeed)
				if speed > maxspeed then
					speed = maxspeed
				end
			elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
				speed = speed-1
				if speed < 0 then
					speed = 0
				end
			end
			if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
				bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
				lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
			elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then
				bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
			else
				bv.velocity = Vector3.new(0,0,0)
			end

			bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0)
		end
		ctrl = {f = 0, b = 0, l = 0, r = 0}
		lastctrl = {f = 0, b = 0, l = 0, r = 0}
		speed = 0
		bg:Destroy()
		bv:Destroy()
		plr.Character.Humanoid.PlatformStand = false
		game.Players.LocalPlayer.Character.Animate.Disabled = false
		tpwalking = false



	end





end)

local tis

up.MouseButton1Down:connect(function()
	tis = up.MouseEnter:connect(function()
		while tis do
			wait()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,1,0)
		end
	end)
end)

up.MouseLeave:connect(function()
	if tis then
		tis:Disconnect()
		tis = nil
	end
end)

local dis

down.MouseButton1Down:connect(function()
	dis = down.MouseEnter:connect(function()
		while dis do
			wait()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,-1,0)
		end
	end)
end)

down.MouseLeave:connect(function()
	if dis then
		dis:Disconnect()
		dis = nil
	end
end)


game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function(char)
	wait(0.7)
	game.Players.LocalPlayer.Character.Humanoid.PlatformStand = false
	game.Players.LocalPlayer.Character.Animate.Disabled = false

end)


plus.MouseButton1Down:connect(function()
	speeds = speeds + 1
	speed.Text = speeds
	if nowe == true then


		tpwalking = false
		for i = 1, speeds do
			spawn(function()

				local hb = game:GetService("RunService").Heartbeat	


				tpwalking = true
				local chr = game.Players.LocalPlayer.Character
				local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
				while tpwalking and hb:Wait() and chr and hum and hum.Parent do
					if hum.MoveDirection.Magnitude > 0 then
						chr:TranslateBy(hum.MoveDirection)
					end
				end

			end)
		end
	end
end)
mine.MouseButton1Down:connect(function()
	if speeds == 1 then
		speed.Text = 'cannot be less than 1'
		wait(1)
		speed.Text = speeds
	else
		speeds = speeds - 1
		speed.Text = speeds
		if nowe == true then
			tpwalking = false
			for i = 1, speeds do
				spawn(function()

					local hb = game:GetService("RunService").Heartbeat	


					tpwalking = true
					local chr = game.Players.LocalPlayer.Character
					local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
					while tpwalking and hb:Wait() and chr and hum and hum.Parent do
						if hum.MoveDirection.Magnitude > 0 then
							chr:TranslateBy(hum.MoveDirection)
						end
					end

				end)
			end
		end
	end
end)

closebutton.MouseButton1Click:Connect(function()
	main:Destroy()
end)

mini.MouseButton1Click:Connect(function()
	up.Visible = false
	down.Visible = false
	onof.Visible = false
	plus.Visible = false
	speed.Visible = false
	mine.Visible = false
	mini.Visible = false
	mini2.Visible = true
	main.Frame.BackgroundTransparency = 1
	closebutton.Position =  UDim2.new(0, 0, -1, 57)
end)

mini2.MouseButton1Click:Connect(function()
	up.Visible = true
	down.Visible = true
	onof.Visible = true
	plus.Visible = true
	speed.Visible = true
	mine.Visible = true
	mini.Visible = true
	mini2.Visible = false
	main.Frame.BackgroundTransparency = 0 
	closebutton.Position =  UDim2.new(0, 0, -1, 27)
end)
        WindUI:Notify({
            Title = "已打开飞行",
            Content = "欢迎使用DOLL",
            Icon = "bolt"
        })
    end
})

local Tab2ESP = Tab2Section:Toggle({
    Title = "玩家透视",
    Desc = "高亮显示所有玩家，便于观察",
    Default = false,
    Callback = function(isEnabled)
        _G.PlayerESPEnabled = isEnabled
        
        -- 发送通知提示
        WindUI:Notify({
            Title = "玩家透视",
            Content = isEnabled and "✅ 已开启" or "❌ 已关闭",
            Icon = "user-check",
            Duration = 3
        })
    end
})

-- 高亮功能的核心代码
local FillColor = Color3.fromRGB(175, 25, 255)
local DepthMode = "AlwaysOnTop"
local FillTransparency = 0.5
local OutlineColor = Color3.fromRGB(255, 255, 255)
local OutlineTransparency = 0

local CoreGui = game:FindService("CoreGui")
local Players = game:FindService("Players")
local lp = Players.LocalPlayer
local connections = {}

local Storage = Instance.new("Folder")
Storage.Parent = CoreGui
Storage.Name = "Highlight_Storage"

local function Highlight(plr)
    local Highlight = Instance.new("Highlight")
    Highlight.Name = plr.Name
    Highlight.FillColor = FillColor
    Highlight.DepthMode = DepthMode
    Highlight.FillTransparency = FillTransparency
    Highlight.OutlineColor = OutlineColor
    Highlight.OutlineTransparency = OutlineTransparency
    Highlight.Parent = Storage
    Highlight.Enabled = _G.PlayerESPEnabled -- 根据全局开关状态设置初始启用状态
    
    local plrchar = plr.Character
    if plrchar then
        Highlight.Adornee = plrchar
    end

    connections[plr] = plr.CharacterAdded:Connect(function(char)
        Highlight.Adornee = char
    end)
end

-- 监听开关状态变化，更新所有高亮的启用状态
game:GetService("RunService").Heartbeat:Connect(function()
    if Storage then
        for _, highlight in ipairs(Storage:GetChildren()) do
            highlight.Enabled = _G.PlayerESPEnabled
        end
    end
end)

Players.PlayerAdded:Connect(Highlight)
for i, v in next, Players:GetPlayers() do
    Highlight(v)
end

Players.PlayerRemoving:Connect(function(plr)
    local plrname = plr.Name
    if Storage[plrname] then
        Storage[plrname]:Destroy()
    end
    if connections[plr] then
        connections[plr]:Disconnect()
    end
end)

local Tab2GodmodeToggle = Tab2Section:Toggle({
    Title = "上帝模式",
    Desc = "开启后角色无敌且不掉血",
    Default = false,  -- 默认关闭
    Callback = function(isEnabled)
        local character = game.Players.LocalPlayer.Character
        if not character then return end
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.MaxHealth = isEnabled and math.huge or 100
            humanoid.Health = isEnabled and math.huge or 100
        end
        -- 发送通知提示
        WindUI:Notify({
            Title = "上帝模式",
            Content = isEnabled and "✅ 已开启" or "❌ 已关闭",
            Icon = "shield",
            Duration = 3
        })
    end
})

local Tab2InfJumpToggle = Tab2Section:Toggle({
    Title = "无限跳",
    Desc = "开启后按跳跃键可持续跳跃",
    Default = false,  -- 默认关闭
    Callback = function(isEnabled)
        -- 先断开旧连接，避免重复绑定导致多次跳跃
        if _G.JumpConnection then
            _G.JumpConnection:Disconnect()
        end
        
        -- 开启时绑定跳跃请求事件
        if isEnabled then
            _G.JumpConnection = game.UserInputService.JumpRequest:Connect(function()
                local humanoid = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end)
        end
        
        -- 发送状态通知
        WindUI:Notify({
            Title = "无限跳",
            Content = isEnabled and "✅ 已开启" or "❌ 已关闭",
            Icon = "feather",
            Duration = 3
        })
    end 
})


-- 3.1.2 滑动条：移动速度调节
local Tab2NightVisionSlider = Tab2Section:Slider({
    Title = "移动速度",
    Desc = "调节角色行走/奔跑速度",
    Step = 1,  -- 调节步长
    Value = {
        Min = 16,    -- 最小速度（默认）
        Max = 500,    -- 最大速度
        Default = 16 -- 初始速度
    },
    Callback = function(value)
        local character = game.Players.LocalPlayer.Character
        if not character then return end
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = tonumber(value)
        end
    end
})

Tab2Section:Slider({
    Title = "跳跃高度",
    Value = {
        Min = 1,
        Max = 200,
        Default = 50
    },
    Callback = function(value)
        local player = game.Players.LocalPlayer
        local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
        if not humanoid then return end
        
        -- 直接使用滑动条的值
        humanoid.JumpPower = value
    end
})

local Tab2NightVisionToggle = Tab2Section:Toggle({
    Title = "夜视",
    Desc = "顾名思义",
    Default = false,
    Callback = function(isEnabled)
        if isEnabled then
            game.Lighting.Ambient = Color3.new(1, 1, 1) -- 夜视开启：高亮环境光
        else
            game.Lighting.Ambient = Color3.new(0.3, 0.3, 0.3) -- 夜视关闭：恢复默认
        end
        
        -- 发送通知提示
        WindUI:Notify({
            Title = "夜视",
            Content = isEnabled and "✅ 已开启" or "❌ 已关闭",
            Icon = "moon",
            Duration = 3
        })
    end
})

local Tab2Slider = Tab2Section:Slider({
    Title = "范围",
    Desc = "调整其他玩家碰撞箱大小",
    Step = 1,
    Value = {
        Min = 1,      -- 最小值
        Max = 100,     -- 最大值
        Default = 1   -- 初始值
    },
    Callback = function(value)
        -- 断开旧的事件连接，避免重复执行
        if _G.HeadSizeConnection then
            _G.HeadSizeConnection:Disconnect()
        end

        _G.HeadSize = value
        _G.Disabled = true  -- 保持开启状态（可按需添加开关控制）

        -- 重新连接事件，执行修改逻辑
        _G.HeadSizeConnection = game:GetService('RunService').RenderStepped:Connect(function()
            if _G.Disabled then
                for _, v in ipairs(game:GetService('Players'):GetPlayers()) do
                    if v ~= game:GetService('Players').LocalPlayer then  -- 简化判断
                        pcall(function()
                            local root = v.Character:FindFirstChild("HumanoidRootPart")
                            if root then  -- 检查部件是否存在，避免错误
                                root.Size = Vector3.new(_G.HeadSize, _G.HeadSize, _G.HeadSize)
                                root.Transparency = 0.7
                                root.BrickColor = BrickColor.new("Really red")
                                root.Material = "Neon"
                                root.CanCollide = false
                            end
                        end)
                    end
                end
            end
        end)
    end
})

Tab2Section:Button({
    Title = "控制玩家",
    Icon = "click",
    Color = Color3.fromHex("#000000"),  -- 按钮颜色
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/dingding123hhh/tt/main/%E6%AD%BB%E4%BA%A1%E7%AC%94%E8%AE%B0%20(1).txt"))()
        WindUI:Notify({
            Title = "控制玩家",
            Content = "控制玩家已打开✅",
            Icon = "bolt"
        })
    end
})

-- 玩家提示 按钮
Tab2Section:Button({
    Title = "玩家提示",
    Icon = "info-circle",
    Color = Color3.fromHex("#000000"),
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/boyscp/scriscriptsc/main/bbn.lua"))()
        WindUI:Notify({
            Title = "玩家提示",
            Content = "✅ 已执行",
            Icon = "bolt"
        })
    end
})

-- 撸管r15 按钮
Tab2Section:Button({
    Title = "撸管r15",
    Icon = "click",
    Color = Color3.fromHex("#000000"),
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/YZoglOyJ/raw"))()
        WindUI:Notify({
            Title = "撸管r15",
            Content = "✅ 已执行",
            Icon = "bolt"
        })
    end
})

-- 撸管r6 按钮
Tab2Section:Button({
    Title = "撸管r6",
    Icon = "click",
    Color = Color3.fromHex("#000000"),
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/wa3v2Vgm/raw"))()
        WindUI:Notify({
            Title = "撸管r6",
            Content = "✅ 已执行",
            Icon = "bolt"
        })
    end
})

-- 初始化全局变量与基础功能
local ESPName = {
    "ScpESPFloder",
    "AnimalESPFloder",
}
for _,v in next,ESPName do
    local ESPFloder = Instance.new("Folder")
    ESPFloder.Parent = workspace
    ESPFloder.Name = v
end

-- 怪物透视创建函数
local function ESPMonster(Text, Adornee, Color)
    if not Adornee:FindFirstChild("ROLESPBillboardGui") then
        local ROLESPBillboardGui = Instance.new("BillboardGui")
        ROLESPBillboardGui.Parent = workspace.ScpESPFloder
        ROLESPBillboardGui.Adornee = Adornee
        ROLESPBillboardGui.Size = UDim2.new(0, 20, 0, 20)
        ROLESPBillboardGui.StudsOffset = Vector3.new(0, 3, 0)
        ROLESPBillboardGui.AlwaysOnTop = true
        local ROLESPTextLabel = Instance.new("TextLabel")
        ROLESPTextLabel.Parent = ROLESPBillboardGui
        ROLESPTextLabel.Size = UDim2.new(1, 0, 1, 0)
        ROLESPTextLabel.BackgroundTransparency = 1
        ROLESPTextLabel.Text = Text
        ROLESPTextLabel.TextColor3 = Color
        ROLESPTextLabel.TextStrokeTransparency = 0.5
        ROLESPTextLabel.TextScaled = true
    end
end

-- 动物透视创建函数
local function ESPAnimal(Text, Adornee, Color)
    if not Adornee:FindFirstChild("ROLESPBillboardGui") then
        local ROLESPBillboardGui = Instance.new("BillboardGui")
        ROLESPBillboardGui.Parent = workspace.AnimalESPFloder
        ROLESPBillboardGui.Adornee = Adornee
        ROLESPBillboardGui.Size = UDim2.new(0, 20, 0, 20)
        ROLESPBillboardGui.StudsOffset = Vector3.new(0, 3, 0)
        ROLESPBillboardGui.AlwaysOnTop = true
        local ROLESPTextLabel = Instance.new("TextLabel")
        ROLESPTextLabel.Parent = ROLESPBillboardGui
        ROLESPTextLabel.Size = UDim2.new(1, 0, 1, 0)
        ROLESPTextLabel.BackgroundTransparency = 1
        ROLESPTextLabel.Text = Text
        ROLESPTextLabel.TextColor3 = Color
        ROLESPTextLabel.TextStrokeTransparency = 0.5
        ROLESPTextLabel.TextScaled = true
    end
end

-- 核心变量初始化
local OAO = game.Players.LocalPlayer
local QWQ = game.ReplicatedStorage
local OvO = {
    instantlycutofftree = false,
    AutoCollectScraps = false,
    AutoCollectDirt = false,
    AutoCollectHarvt = false,
    KillAll = false,
    KillAura = false,
    AutoTpPine = false,
    AutoHeli = false,
    AutoCast = false
}

-- 防闲置踢人
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    game:GetService("VirtualUser"):Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    game:GetService("VirtualUser"):Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    game:GetService("VirtualUser"):CaptureController()
    game:GetService("VirtualUser"):ClickButton2(Vector2.new())
end)

local Tab3 = MainWindow:Tab({
    Title = "活到7天",
    Icon = "bolt"
})

-- 主要功能区域
local Tab3Section = Tab3:Section({
    Title = "核心功能",
    TextSize = 18,
    FontWeight = Enum.FontWeight.SemiBold
})

-- 透视相关变量
local animalConnection
local scpConnection

-- 动物透视（开关）
local Tab3Toggle = Tab3Section:Toggle({
    Title = "动物透视",
    Desc = "高亮显示所有动物，便于追踪",
    Default = false,
    Callback = function(isEnabled)
        WindUI:Notify({
            Title = "动物透视",
            Content = isEnabled and "✅ 已开启" or "❌ 已关闭",
            Icon = "bolt",
            Duration = 3
        })

        if isEnabled then
            if animalConnection then animalConnection:Disconnect() end
            -- 遍历已有动物添加透视
            if workspace:FindFirstChild("animals") then
                for _, v in next, workspace.animals:GetChildren() do
                    ESPAnimal(v.Name, v, Color3.new(1, 0, 0))
                end
                -- 监听新动物生成
                animalConnection = workspace.animals.ChildAdded:Connect(function(v)
                    ESPAnimal(v.Name, v, Color3.new(1, 0, 0))
                end)
            else
                WindUI:Notify({
                    Title = "错误",
                    Content = "未找到动物文件夹！",
                    Icon = "bolt",
                    Duration = 3
                })
            end
        else
            if animalConnection then animalConnection:Disconnect() end
            -- 清除透视
            if workspace:FindFirstChild("AnimalESPFloder") then
                workspace.AnimalESPFloder:ClearAllChildren()
            end
        end
    end
})

-- 怪物透视（开关）
local Tab3Toggle = Tab3Section:Toggle({
    Title = "怪物透视",
    Desc = "高亮显示所有怪物，提前预警",
    Default = false,
    Callback = function(isEnabled)
        WindUI:Notify({
            Title = "怪物透视",
            Content = isEnabled and "✅ 已开启" or "❌ 已关闭",
            Icon = "bolt",
            Duration = 3
        })

        if isEnabled then
            if scpConnection then scpConnection:Disconnect() end
            -- 遍历已有怪物添加透视
            if workspace:FindFirstChild("scps") then
                for _, v in next, workspace.scps:GetChildren() do
                    ESPMonster("怪物", v, Color3.new(0, 0, 1))
                end
                -- 监听新怪物生成
                scpConnection = workspace.scps.ChildAdded:Connect(function(v)
                    ESPMonster("怪物", v, Color3.new(0, 0, 1))
                end)
            else
                WindUI:Notify({
                    Title = "错误",
                    Content = "未找到怪物文件夹！",
                    Icon = "bolt",
                    Duration = 3
                })
            end
        else
            if scpConnection then scpConnection:Disconnect() end
            -- 清除透视
            if workspace:FindFirstChild("ScpESPFloder") then
                workspace.ScpESPFloder:ClearAllChildren()
            end
        end
    end
})

-- 秒砍树（开关）
local Tab3Toggle = Tab3Section:Toggle({
    Title = "秒砍树",
    Desc = "自动挥斧+收集木材，高效伐木",
    Default = false,
    Callback = function(isEnabled)
        WindUI:Notify({
            Title = "秒砍树",
            Content = isEnabled and "✅ 已开启" or "❌ 已关闭",
            Icon = "bolt",
            Duration = 3
        })

        OvO.instantlycutofftree = isEnabled
        if isEnabled then
            task.spawn(function()
                while OvO.instantlycutofftree do
                    task.wait()
                    pcall(function()
                        QWQ.remotes.swing_axe:FireServer()
                        if workspace:FindFirstChild("logs") then
                            for _,v in next,workspace.logs:GetChildren() do
                                if v.Name == "log" and v:FindFirstChild("main") and v.main:FindFirstChild("ProximityPrompt") then
                                    fireproximityprompt(v.main.ProximityPrompt)
                                end
                            end
                        end
                    end)
                end
            end)
        end
    end
})

-- 自动钓鱼（开关）
local Tab3Toggle = Tab3Section:Toggle({
    Title = "自动钓鱼",
    Desc = "自动抛竿+收鱼，无需手动操作",
    Default = false,
    Callback = function(isEnabled)
        WindUI:Notify({
            Title = "自动钓鱼",
            Content = isEnabled and "✅ 已开启" or "❌ 已关闭",
            Icon = "bolt",
            Duration = 3
        })

        OvO.AutoCast = isEnabled
        if isEnabled then
            task.spawn(function()
                while OvO.AutoCast do
                    task.wait()
                    pcall(function()
                        game:GetService("ReplicatedStorage").remotes.cast:FireServer()
                        task.wait(0.2)
                        for i = 1,8 do
                            game:GetService("ReplicatedStorage").remotes.hit_fish:FireServer()
                        end
                    end)
                end
            end)
        end
    end
})

-- 秒吃食物（按钮）
Tab3Section:Button({
    Title = "秒吃食物",
    Icon = "refresh-cw",
    Color = Color3.fromHex("#000000"),
    Callback = function()
        local success = false
        pcall(function()
            for _,v in pairs(OAO.Backpack:GetChildren()) do
                if v:FindFirstChild("eat") and OAO.Character and OAO.Character:FindFirstChild("hunger") and OAO.Character.hunger.Value < 30 then
                    v.Parent = OAO.Character
                    OAO.Character[v.Name].eat:FireServer()
                    success = true
                end
            end
        end)

        WindUI:Notify({
            Title = "秒吃食物",
            Content = success and "✅ 已快速补充饥饿值" or "❌ 无可用食物或饥饿值充足",
            Icon = "bolt"
        })
    end
})

-- 自动收集材料（开关）
local Tab3Toggle = Tab3Section:Toggle({
    Title = "自动收集材料",
    Desc = "自动传送收集所有材料碎片",
    Default = false,
    Callback = function(isEnabled)
        WindUI:Notify({
            Title = "自动收集材料",
            Content = isEnabled and "✅ 已开启" or "❌ 已关闭",
            Icon = "bolt",
            Duration = 3
        })

        OvO.AutoCollectScraps = isEnabled
        if isEnabled then
            task.spawn(function()
                while OvO.AutoCollectScraps do
                    task.wait()
                    pcall(function()
                        local character = OAO.Character
                        if not character or not character:FindFirstChild("HumanoidRootPart") then return end
                        local oldcf = character.HumanoidRootPart.CFrame

                        if workspace:FindFirstChild("scraps") then
                            for _, v in pairs(workspace.scraps:GetChildren()) do
                                local material = v:FindFirstChild("defaultMaterial10")
                                if material and OvO.AutoCollectScraps then
                                    local prompt = material:FindFirstChild("ProximityPrompt")
                                    if prompt and OvO.AutoCollectScraps then
                                        character.HumanoidRootPart.CFrame = material.CFrame + Vector3.new(0, 3, 0)
                                        task.wait(0.2)
                                        fireproximityprompt(prompt)
                                        task.wait(0.2)
                                        character.HumanoidRootPart.CFrame = oldcf
                                    end
                                end
                            end
                        end
                    end)
                end
            end)
        end
    end
})

-- 传送回出生点（按钮）
Tab3Section:Button({
    Title = "传送回出生点",
    Icon = "refresh-cw",
    Color = Color3.fromHex("#000000"),
    Callback = function()
        local character = OAO.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            character.HumanoidRootPart.CFrame = CFrame.new(57,42,416)
            WindUI:Notify({
                Title = "传送成功",
                Content = "已传送回出生点！",
                Icon = "bolt"
            })
        else
            WindUI:Notify({
                Title = "错误",
                Content = "角色未加载！",
                Icon = "bolt"
            })
        end
    end
})

-- 自动收集成熟品（开关）
local Tab3Toggle = Tab3Section:Toggle({
    Title = "自动收集成熟品",
    Desc = "自动收集所有成熟的农作物",
    Default = false,
    Callback = function(isEnabled)
        WindUI:Notify({
            Title = "自动收集成熟品",
            Content = isEnabled and "✅ 已开启" or "❌ 已关闭",
            Icon = "bolt",
            Duration = 3
        })

        OvO.AutoCollectHarvt = isEnabled
        local oldpos = OAO.Character and OAO.Character.HumanoidRootPart.CFrame or nil

        if isEnabled then
            task.spawn(function()
                while OvO.AutoCollectHarvt do
                    task.wait()
                    pcall(function()
                        local character = OAO.Character
                        if not character or not character:FindFirstChild("HumanoidRootPart") then return end
                        oldpos = oldpos or character.HumanoidRootPart.CFrame

                        if workspace:FindFirstChild("harvest") then
                            for _,v in next,workspace.harvest:GetChildren() do
                                if v:FindFirstChild("main") and v.main:FindFirstChild("ProximityPrompt") then
                                    character.HumanoidRootPart.CFrame = v.main.CFrame
                                    fireproximityprompt(v.main.ProximityPrompt)
                                end
                            end
                        end
                    end)
                end
            end)
        else
            -- 关闭时返回原位置
            if oldpos and OAO.Character and OAO.Character:FindFirstChild("HumanoidRootPart") then
                OAO.Character.HumanoidRootPart.CFrame = oldpos
            end
        end
    end
})

-- 自动收集生鹿肉（开关）
local Tab3Toggle = Tab3Section:Toggle({
    Title = "自动收集生鹿肉",
    Desc = "自动收集鹿类掉落的肉类材料",
    Default = false,
    Callback = function(isEnabled)
        WindUI:Notify({
            Title = "自动收集生鹿肉",
            Content = isEnabled and "✅ 已开启" or "❌ 已关闭",
            Icon = "bolt",
            Duration = 3
        })

        OvO.AutoCollectHarvt = isEnabled
        local oldpos = OAO.Character and OAO.Character.HumanoidRootPart.CFrame or nil

        if isEnabled then
            task.spawn(function()
                while OvO.AutoCollectHarvt do
                    task.wait()
                    pcall(function()
                        local character = OAO.Character
                        if not character or not character:FindFirstChild("HumanoidRootPart") then return end
                        oldpos = oldpos or character.HumanoidRootPart.CFrame

                        if workspace:FindFirstChild("interact") then
                            for _,v in next,workspace.interact:GetChildren() do
                                if v.Name == "deer" and v:FindFirstChild("lungs,heart,intestines") then
                                    local prompt = v["lungs,heart,intestines"]:FindFirstChild("ProximityPrompt")
                                    if prompt then
                                        character.HumanoidRootPart.CFrame = v["lungs,heart,intestines"].CFrame
                                        fireproximityprompt(prompt)
                                    end
                                end
                            end
                        end
                    end)
                end
            end)
        else
            -- 关闭时返回原位置
            if oldpos and OAO.Character and OAO.Character:FindFirstChild("HumanoidRootPart") then
                OAO.Character.HumanoidRootPart.CFrame = oldpos
            end
        end
    end
})

-- 自动收集包菜（开关）
local Tab3Toggle = Tab3Section:Toggle({
    Title = "自动收集包菜",
    Desc = "自动收集包菜农场的包菜",
    Default = false,
    Callback = function(isEnabled)
        WindUI:Notify({
            Title = "自动收集包菜",
            Content = isEnabled and "✅ 已开启" or "❌ 已关闭",
            Icon = "bolt",
            Duration = 3
        })

        OvO.AutoCollectDirt = isEnabled
        local oldpos = OAO.Character and OAO.Character.HumanoidRootPart.CFrame or nil

        if isEnabled then
            task.spawn(function()
                while OvO.AutoCollectDirt do
                    task.wait()
                    pcall(function()
                        local character = OAO.Character
                        if not character or not character:FindFirstChild("HumanoidRootPart") then return end
                        oldpos = oldpos or character.HumanoidRootPart.CFrame

                        local cabbageFarm = workspace:FindFirstChild("builds") and workspace.builds:FindFirstChild("Cabbage Farm")
                        if cabbageFarm and cabbageFarm:FindFirstChild("dirt") then
                            local prompt = cabbageFarm.dirt:FindFirstChild("ProximityPrompt")
                            if prompt then
                                character.HumanoidRootPart.CFrame = cabbageFarm.dirt.CFrame
                                fireproximityprompt(prompt)
                            end
                        else
                            WindUI:Notify({
                                Title = "错误",
                                Content = "未找到包菜农场！",
                                Icon = "bolt",
                                Duration = 3
                            })
                            OvO.AutoCollectDirt = false
                        end
                    end)
                end
            end)
        else
            -- 关闭时返回原位置
            if oldpos and OAO.Character and OAO.Character:FindFirstChild("HumanoidRootPart") then
                OAO.Character.HumanoidRootPart.CFrame = oldpos
            end
        end
    end
})

local Tab4 = MainWindow:Tab({
    Title = "战斗功能",
    Icon = "crosshair"
})

local Tab4Section = Tab4:Section({
    Title = "战斗模块",
    TextSize = 18,
    FontWeight = Enum.FontWeight.SemiBold
})

-- 枪械光环
local Tab4Toggle = Tab4Section:Toggle({
    Title = "枪械光环",
    Desc = "自动攻击所有SCP和动物",
    Default = false,
    Callback = function(isEnabled)
        OvO.KillAll = isEnabled
        pcall(function()
            spawn(function()
                while OvO.KillAll do wait()
                    for _,v in next, workspace.scps:GetChildren() do
                        if v:FindFirstChild("HumanoidRootPart") then
                            local args = {
                                [1] = CFrame.new(v.HumanoidRootPart.Position) * CFrame.Angles(0, 0, 0),
                                [2] = CFrame.new(v.HumanoidRootPart.Position) * CFrame.Angles(0, 0, 0),
                            }
                            game:GetService("ReplicatedStorage").remotes.shoot:FireServer(unpack(args))
                            game:GetService("ReplicatedStorage").remotes.reload:FireServer()
                        end
                    end
                    for _,v in next, workspace.animals:GetChildren() do
                        if v:FindFirstChild("HumanoidRootPart") then
                            local args = {
                                [1] = CFrame.new(v.HumanoidRootPart.Position) * CFrame.Angles(0, 0, 0),
                                [2] = CFrame.new(v.HumanoidRootPart.Position) * CFrame.Angles(0, 0, 0),
                            }
                            game:GetService("ReplicatedStorage").remotes.shoot:FireServer(unpack(args))
                            game:GetService("ReplicatedStorage").remotes.reload:FireServer()
                        end
                    end
                end
            end)
        end)
        
        WindUI:Notify({
            Title = "枪械光环",
            Content = isEnabled and "✅ 已开启" or "❌ 已关闭",
            Icon = "crosshair",
            Duration = 3
        })
    end 
})

-- 子弹追踪(锁头)
local Tab4Toggle = Tab4Section:Toggle({
    Title = "子弹追踪(锁头)",
    Desc = "自动瞄准头部攻击",
    Default = false,
    Callback = function(isEnabled)
        OvO.KillAura = isEnabled
        pcall(function()
            spawn(function()
                while OvO.KillAura do wait()
                    local character = game.Players.LocalPlayer.Character
                    if character and character:FindFirstChild("HumanoidRootPart") then
                        for _, scp in ipairs(workspace.scps:GetChildren()) do
                            local HitPart = scp:FindFirstChild("HumanoidRootPart") or scp:FindFirstChild("Head")
                            if HitPart and scp:FindFirstChildWhichIsA("Humanoid") and scp.Humanoid.Health > 0 then
                                game.ReplicatedStorage.remotes.shoot:FireServer(HitPart.CFrame + Vector3.new(0, 0.5, 0), HitPart.CFrame)
                            end
                        end
                        for _, animal in ipairs(workspace.animals:GetChildren()) do
                            local HitPart = animal:FindFirstChild("HumanoidRootPart") or animal:FindFirstChild("Head")
                            if HitPart and animal:FindFirstChildWhichIsA("Humanoid") and animal.Humanoid.Health > 0 then
                                game.ReplicatedStorage.remotes.shoot:FireServer(HitPart.CFrame + Vector3.new(0, 0.5, 0), HitPart.CFrame)
                            end
                        end
                    end
                end
            end)
        end)
        
        WindUI:Notify({
            Title = "子弹追踪",
            Content = isEnabled and "✅ 已开启" or "❌ 已关闭",
            Icon = "target",
            Duration = 3
        })
    end 
})

-- 自动拾取飞机残骸
local Tab4Toggle = Tab4Section:Toggle({
    Title = "自动拾取飞机残骸",
    Desc = "自动收集直升机残骸",
    Default = false,
    Callback = function(isEnabled)
        OvO.AutoHeli = isEnabled
        pcall(function()
            spawn(function()
                while OvO.AutoHeli do wait()
                    for _,v in next, workspace.interact:GetChildren() do
                        if v.Name == "heli" and v:FindFirstChild("Body") then
                            local prompt = v.Body:FindFirstChild("ProximityPrompt")
                            if prompt then
                                fireproximityprompt(prompt)
                            end
                        end
                    end
                end
            end)
        end)
        
        WindUI:Notify({
            Title = "自动拾取",
            Content = isEnabled and "✅ 已开启" or "❌ 已关闭",
            Icon = "helicopter",
            Duration = 3
        })
    end 
})

-- 创建第二个标签页用于世界设置
local Tab5 = MainWindow:Tab({
    Title = "世界设置",
    Icon = "globe"
})

local Tab5Section = Tab5:Section({
    Title = "环境控制",
    TextSize = 18,
    FontWeight = Enum.FontWeight.SemiBold
})

-- 无限模式
local Tab5Toggle = Tab5Section:Toggle({
    Title = "开启无限模式",
    Desc = "启用无限资源模式",
    Default = false,
    Callback = function(isEnabled)
        if workspace:FindFirstChild("infinite") then
            workspace.infinite.Value = isEnabled
        end
        
        WindUI:Notify({
            Title = "无限模式",
            Content = isEnabled and "✅ 已开启" or "❌ 已关闭",
            Icon = "infinity",
            Duration = 3
        })
    end 
})

-- 雨天控制
local Tab5Toggle = Tab5Section:Toggle({
    Title = "开启雨天",
    Desc = "控制天气效果",
    Default = false,
    Callback = function(isEnabled)
        if workspace:FindFirstChild("raining") then
            workspace.raining.Value = isEnabled
        end
        
        WindUI:Notify({
            Title = "雨天控制",
            Content = isEnabled and "✅ 已开启" or "❌ 已关闭",
            Icon = "cloud-rain",
            Duration = 3
        })
    end 
})

-- 信息显示
local Tab5Toggle = Tab5Section:Toggle({
    Title = "显示游戏信息",
    Desc = "显示天数和时间",
    Default = false,
    Callback = function(isEnabled)
        if isEnabled then
            if workspace:FindFirstChild("current_day") and workspace:FindFirstChild("waited") then
                txtf("UpdateLine", "Left", "当前天数: "..workspace.current_day.Value)
                txtf("UpdateLine", "Left", "当前时间: "..workspace.waited.Value)
            end
        else
            txtf("ClearText")
        end
        
        WindUI:Notify({
            Title = "信息显示",
            Content = isEnabled and "✅ 已开启" or "❌ 已关闭",
            Icon = "info",
            Duration = 3
        })
    end 
})

-- 自动传送木头（需要findClosestPine函数）
local function findClosestPine()
    local character = game.Players.LocalPlayer.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then
        return nil
    end
    
    local playerPos = character.HumanoidRootPart.Position
    local closestPine = nil
    local shortestDistance = math.huge
    
    for _, pine in ipairs(workspace:GetDescendants()) do
        if pine.Name:lower():find("pine") or pine.Name:lower():find("wood") then
            if pine:FindFirstChild("PrimaryPart") then
                local distance = (playerPos - pine.PrimaryPart.Position).Magnitude
                if distance < shortestDistance then
                    shortestDistance = distance
                    closestPine = pine
                end
            end
        end
    end
    
    return closestPine
end

local Tab5Toggle = Tab5Section:Toggle({
    Title = "自动传送最近的木头",
    Desc = "自动传送到最近的木材",
    Default = false,
    Callback = function(isEnabled)
        OvO.AutoTpPine = isEnabled
        pcall(function()
            spawn(function()
                while OvO.AutoTpPine do wait()
                    local character = game.Players.LocalPlayer.Character
                    if character and character:FindFirstChild("HumanoidRootPart") then
                        local closestPine = findClosestPine()
                        if closestPine and closestPine.PrimaryPart then
                            local targetPosition = closestPine.PrimaryPart.Position
                            character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(targetPosition.X, targetPosition.Y - 30, targetPosition.Z))
                            character.HumanoidRootPart.Anchored = OvO.AutoTpPine
                        end
                    end
                end
            end)
        end)
        
        WindUI:Notify({
            Title = "自动传送",
            Content = isEnabled and "✅ 已开启" or "❌ 已关闭",
            Icon = "tree-pine",
            Duration = 3
        })
    end 
})

MainWindow:SetToggleKey(Enum.KeyCode.LeftControl)