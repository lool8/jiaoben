-- 在代码开头添加这些变量定义
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

-- 全局变量定义
_G.PlayerESPEnabled = false
_G.HeadSize = 1
_G.Disabled = true
_G.HeadSizeConnection = nil
_G.JumpConnection = nil

-- 自动功能相关变量
getgenv().auto = false
getgenv().autoTeleport = false
getgenv().autoSpeed = 5

-- 飞行功能相关变量
local speeds = 1
local nowe = false
local tpwalking = false

-- 战斗功能相关变量
local rpgAttackActive = false
local blockFDMG = false

-- 死亡位置记录变量
local deathPosition = nil
local deathOrientation = nil

-- 需要补充的函数定义
local function GetBall()
    for a, b in next, workspace.Balls:GetChildren() do
        if b:IsA("BasePart") and b:GetAttribute("realBall") then
            return b
        end
    end
    return nil
end

local function IsTarget(a)
    return a:GetAttribute("target") == LP.Name
end

local function Parry()
    task.spawn(function() 
        game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, nil, 0) 
    end)
end

-- 死亡位置跟踪函数
local function setupDeathTracking()
    local player = game.Players.LocalPlayer
    
    player.CharacterAdded:Connect(function(character)
        local humanoid = character:WaitForChild("Humanoid")
        
        humanoid.Died:Connect(function()
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                deathPosition = rootPart.Position
                deathOrientation = rootPart.CFrame - rootPart.Position
            end
        end)
    end)
    
    -- 处理现有角色
    if player.Character then
        local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.Died:Connect(function()
                local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
                if rootPart then
                    deathPosition = rootPart.Position
                    deathOrientation = rootPart.CFrame - rootPart.Position
                end
            end)
        end
    end
end

-- 初始化函数
local function Initialize()
    setupDeathTracking()
    
    -- 清理旧连接
    if _G.HeadSizeConnection then
        _G.HeadSizeConnection:Disconnect()
    end
    if _G.JumpConnection then
        _G.JumpConnection:Disconnect()
    end
    
    print("DOLL脚本初始化完成")
end

-- 调用初始化
Initialize()
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

local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Plr = game:GetService("Players")
local LP = Plr.LocalPlayer

-- 初始化WindUI
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Syndromehsh/Lua/baff0bc41893a32f8e997d840241ad4b3d26ab4d/AlienX/AlienX%20Wind%203.0%20UI.txt"))()

local MainWindow = WindUI:CreateWindow({
    Title = 'AlienX<font color="#00FF00">2.0</font>/ 战争大亨|XI团队出品必是精品',
    Icon = "rbxassetid://4483362748",
    IconThemed = true,
    Author = "AlienX",
    Folder = "CloudHub",
    Size = UDim2.fromOffset(580, 440),
    Transparent = true,
    Theme = "Dark",
    User = {
        Enabled = true,
        Callback = function() print("clicked") end,
        Anonymous = false
    },
    SideBarWidth = 200,
    ScrollBarEnabled = true,
})

MainWindow:EditOpenButton({
    Title = "打开脚本",
    Icon = "monitor",
    CornerRadius = UDim.new(0,16),
    StrokeThickness = 4,
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromHex("FF0000")),
        ColorSequenceKeypoint.new(0.16, Color3.fromHex("FF7F00")),
        ColorSequenceKeypoint.new(0.33, Color3.fromHex("FFFF00")),
        ColorSequenceKeypoint.new(0.5, Color3.fromHex("00FF00")),
        ColorSequenceKeypoint.new(0.66, Color3.fromHex("0000FF")),
        ColorSequenceKeypoint.new(0.83, Color3.fromHex("4B0082")),
        ColorSequenceKeypoint.new(1, Color3.fromHex("9400D3"))
    }),
    Draggable = true,
})

-- 创建标签页
local Tab1 = MainWindow:Tab({
    Title = "视觉功能",
    Icon = "bolt"
})

local Tab1Section = Tab1:Section({
    Title = "视觉设置",
    TextSize = 18,
    FontWeight = Enum.FontWeight.SemiBold
})

-- 视觉球体功能
Tab1Section:Button({
    Title = "创建视觉球体",
    Icon = "refresh-cw",
    Color = Color3.fromHex("#000000"), 
    Callback = function()
        local Part = Instance.new("Part", workspace)
        Part.Material = Enum.Material.ForceField
        Part.Anchored = true
        Part.CanCollide = false
        Part.CastShadow = false
        Part.Shape = Enum.PartType.Ball
        Part.Color = Color3.fromRGB(132, 0, 255)
        Part.Transparency = 0.5
        
        WindUI:Notify({
            Title = "视觉球体",
            Content = "已创建视觉球体",
            Icon = "bolt"
        })
    end
})

-- 彩虹标题功能
Tab1Section:Button({
    Title = "添加彩虹标题",
    Icon = "user",
    Callback = function()
        local function addRainbowTitleToLocalPlayer(player, titleText)
            local function addTitleToCharacter(character)
                local head = character:FindFirstChild("Head") or character:WaitForChild("Head")
                local old = head:FindFirstChild("PlayerTitle")
                if old then old:Destroy() end
                local billboardGui = Instance.new("BillboardGui")
                billboardGui.Name = "PlayerTitle"
                billboardGui.Adornee = head
                billboardGui.Size = UDim2.new(4, 0, 1, 0)
                billboardGui.StudsOffset = Vector3.new(0, 2, 0)
                billboardGui.AlwaysOnTop = true
                billboardGui.MaxDistance = 1000
                local textLabel = Instance.new("TextLabel")
                textLabel.Size = UDim2.new(1, 0, 1, 0)
                textLabel.BackgroundTransparency = 1
                textLabel.Text = titleText
                textLabel.TextScaled = true
                textLabel.Font = Enum.Font.GothamBold
                textLabel.TextWrapped = true
                textLabel.Parent = billboardGui
                local stroke = Instance.new("UIStroke")
                stroke.Thickness = 1
                stroke.Color = Color3.new(1, 1, 1)
                stroke.Parent = textLabel
                local gradient = Instance.new("UIGradient")
                gradient.Rotation = 90
                gradient.Parent = textLabel
                local connection
                connection = game:GetService("RunService").RenderStepped:Connect(function()
                    local time = tick() * 0.5
                    gradient.Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0, Color3.fromHSV(time % 1, 1, 1)),
                        ColorSequenceKeypoint.new(0.2, Color3.fromHSV((time + 0.2) % 1, 1, 1)),
                        ColorSequenceKeypoint.new(0.4, Color3.fromHSV((time + 0.4) % 1, 1, 1)),
                        ColorSequenceKeypoint.new(0.6, Color3.fromHSV((time + 0.6) % 1, 1, 1)),
                        ColorSequenceKeypoint.new(0.8, Color3.fromHSV((time + 0.8) % 1, 1, 1)),
                        ColorSequenceKeypoint.new(1, Color3.fromHSV(time % 1, 1, 1))
                    })
                end)
                billboardGui.AncestryChanged:Connect(function()
                    if not billboardGui:IsDescendantOf(game) then
                        if connection then connection:Disconnect() end
                    end
                end)
                billboardGui.Parent = head
            end
            local character = player.Character or player.CharacterAdded:Wait()
            addTitleToCharacter(character)
            player.CharacterAdded:Connect(addTitleToCharacter)
        end
        addRainbowTitleToLocalPlayer(LP, "AlienX VIP")
        
        WindUI:Notify({
            Title = "彩虹标题",
            Content = "已添加彩虹标题",
            Icon = "user"
        })
    end
})

-- 创建文本显示功能
Tab1Section:Toggle({
    Title = "显示信息面板",
    Desc = "显示距离和速度信息",
    Default = false,
    Callback = function(isEnabled)
        if isEnabled then
            local BaseGui = Instance.new("ScreenGui", game.CoreGui)
            BaseGui.Name = "BaseGui"

            local TL = Instance.new("TextLabel", BaseGui)
            TL.Name = "TL"
            TL.Parent = BaseGui
            TL.BackgroundColor3 = Color3.new(1, 1, 1)
            TL.BackgroundTransparency = 1
            TL.BorderColor3 = Color3.new(0, 0, 0)
            TL.Position = UDim2.new(0.95, -300, 0.85, 0)
            TL.Size = UDim2.new(0, 300, 0, 50)
            TL.FontFace = Font.new("rbxassetid://12187370000", Enum.FontWeight.Bold)
            TL.Text = ""
            TL.TextColor3 = Color3.new(1, 1, 1)
            TL.TextScaled = true
            TL.TextSize = 14
            TL.TextWrapped = true
            TL.Visible = true
            TL.RichText = true

            local function rainbowColor(hue)
                return Color3.fromHSV(hue, 1, 1)
            end

            local function updateRainbowText(distance, ballSpeed, spamRadius, minDistance)
                local hue = (tick() * 0.1) % 1
                local color1 = rainbowColor(hue)
                local color2 = rainbowColor((hue + 0.3) % 1)
                local color3 = rainbowColor((hue + 0.6) % 1)
                local color4 = rainbowColor((hue + 0.9) % 1)

                TL.Text = string.format(
                "<font color='#%s'>distance: %s</font>\n"..
                "<font color='#%s'>ballSpeed: %s</font>\n"..
                "<font color='#%s'>spamRadius: %s</font>\n"..
                "<font color='#%s'>minDistance: %s</font>",
                color1:ToHex(), tostring(distance),
                color2:ToHex(), tostring(ballSpeed),
                color3:ToHex(), tostring(spamRadius),
                color4:ToHex(), tostring(minDistance)
                )
            end
            
            -- 模拟更新数据
            game:GetService("RunService").RenderStepped:Connect(function()
                updateRainbowText(100, 50, 25, 10)
            end)
        else
            if game.CoreGui:FindFirstChild("BaseGui") then
                game.CoreGui.BaseGui:Destroy()
            end
        end
        
        WindUI:Notify({
            Title = "信息面板",
            Content = isEnabled and "✅ 已开启" or "❌ 已关闭",
            Icon = "monitor",
            Duration = 3
        })
    end 
})

local Tab2 = MainWindow:Tab({
    Title = "传送功能",
    Icon = "map-pin"
})

local Tab2Section = Tab2:Section({
    Title = "传送设置",
    TextSize = 18,
    FontWeight = Enum.FontWeight.SemiBold
})

-- 基地传送位置
local Positions = {
    ["Alpha"] = CFrame.new(-1197, 65, -4790),
    ["Bravo"] = CFrame.new(-220, 65, -4919),
    ["Charlie"] = CFrame.new(797, 65, -4740),
    ["Delta"] = CFrame.new(2044, 65, -3984),
    ["Echo"] = CFrame.new(2742, 65, -3031),
    ["Foxtrot"] = CFrame.new(3045, 65, -1788),
    ["Golf"] = CFrame.new(3376, 65, -562),
    ["Hotel"] = CFrame.new(3290, 65, 587),
    ["Juliet"] = CFrame.new(2955, 65, 1804),
    ["Kilo"] = CFrame.new(2569, 65, 2926),
    ["Lima"] = CFrame.new(989, 65, 3419),
    ["Omega"] = CFrame.new(-319, 65, 3932),
    ["Romeo"] = CFrame.new(-1479, 65, 3722),
    ["Sierra"] = CFrame.new(-2528, 65, 2549),
    ["Tango"] = CFrame.new(-3018, 65, 1503),
    ["Victor"] = CFrame.new(-3587, 65, 634),
    ["Yankee"] = CFrame.new(-3957, 65, -287),
    ["Zulu"] = CFrame.new(-4049, 65, -1334)
}

Tab2Section:Button({
    Title = "当前玩家基地",
    Icon = "home",
    Callback = function()
        WindUI:Notify({
            Title = "当前基地",
            Content = "当前玩家基地: " .. LP.Team.Name,
            Icon = "home"
        })
    end
})

Tab2Section:Dropdown({
    Title = "传送基地",
    Values = {"Alpha", "Bravo", "Charlie", "Delta", "Echo", "Foxtrot", "Golf", "Hotel", "Juliet", "Kilo", "Lima", "Omega", "Romeo", "Sierra", "Tango", "Victor", "Yankee", "Zulu"},
    Value = "Alpha",
    Callback = function(selected)
        if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
            LP.Character:FindFirstChild("HumanoidRootPart").CFrame = Positions[selected]
            WindUI:Notify({
                Title = "传送成功",
                Content = "已传送到 " .. selected .. " 基地",
                Icon = "map-pin"
            })
        end
    end
})

local Tab3 = MainWindow:Tab({
    Title = "自动功能",
    Icon = "settings"
})

local Tab3Section = Tab3:Section({
    Title = "自动设置",
    TextSize = 18,
    FontWeight = Enum.FontWeight.SemiBold
})

-- 自动功能变量
getgenv().auto = false
getgenv().autoTeleport = false

Tab3Section:Toggle({
    Title = "自动箱子",
    Desc = "自动收集箱子",
    Default = false,
    Callback = function(isEnabled)
        getgenv().auto = isEnabled
        
        if isEnabled then
            -- 自动箱子功能代码
            local ps = game:GetService("Players")
            local ws = game:GetService("Workspace")
            local rs = game:GetService("ReplicatedStorage")
            local lp = ps.LocalPlayer
            
            spawn(function()
                while getgenv().auto do
                    task.wait(0.1)
                    -- 自动箱子逻辑
                end
            end)
        end
        
        WindUI:Notify({
            Title = "自动箱子",
            Content = isEnabled and "✅ 已开启" or "❌ 已关闭",
            Icon = "package",
            Duration = 3
        })
    end 
})

Tab3Section:Toggle({
    Title = "自动升级",
    Desc = "自动升级基地",
    Default = false,
    Callback = function(isEnabled)
        getgenv().autoTeleport = isEnabled
        
        if isEnabled then
            spawn(function()
                while getgenv().autoTeleport do
                    task.wait(0.2)
                    -- 自动升级逻辑
                end
            end)
        end
        
        WindUI:Notify({
            Title = "自动升级",
            Content = isEnabled and "✅ 已开启" or "❌ 已关闭",
            Icon = "trending-up",
            Duration = 3
        })
    end 
})

Tab3Section:Slider({
    Title = "自动速度",
    Desc = "调整自动功能速度",
    Step = 1,  
    Value = {
        Min = 1,    
        Max = 10,    
        Default = 5 
    },
    Callback = function(value)
        getgenv().autoSpeed = value
        WindUI:Notify({
            Title = "速度设置",
            Content = "自动速度已设置为: " .. value,
            Icon = "gauge"
        })
    end
})

local Tab4 = MainWindow:Tab({
    Title = "战斗功能",
    Icon = "sword"
})

local Tab4Section = Tab4:Section({
    Title = "战斗设置",
    TextSize = 18,
    FontWeight = Enum.FontWeight.SemiBold
})

-- 自动格挡功能
Tab4Section:Toggle({
    Title = "自动格挡",
    Desc = "自动格挡攻击",
    Default = false,
    Callback = function(isEnabled)
        if isEnabled then
            spawn(function()
                while isEnabled do
                    local function Parry()
                        task.spawn(function() 
                            game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, nil, 0) 
                        end)
                    end
                    
                    -- 检测是否需要格挡
                    local ball = GetBall()
                    if ball and IsTarget(ball) then
                        Parry()
                    end
                    task.wait(0.1)
                end
            end)
        end
        
        WindUI:Notify({
            Title = "自动格挡",
            Content = isEnabled and "✅ 已开启" or "❌ 已关闭",
            Icon = "shield",
            Duration = 3
        })
    end 
})

-- 获取球体函数
local function GetBall()
    for a, b in next, workspace.Balls:GetChildren() do
        if b:IsA("BasePart") and b:GetAttribute("realBall") then
            return b
        end
    end
end

-- 目标检测函数
local function IsTarget(a)
    return a:GetAttribute("target") == LP.Name
end

-- RPG功能
Tab4Section:Button({
    Title = "获取RPG",
    Icon = "rocket",
    Callback = function()
        local Players = game:GetService("Players")
        local localPlayer = Players.LocalPlayer
        local TycoonsFolder = workspace.Tycoon.Tycoons
        
        local function findNearestTeleportPosition()
            local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
            local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
            local playerPosition = humanoidRootPart.Position
            local closestDistance = math.huge
            local closestCFrame = nil
            
            for _, tycoonModel in ipairs(TycoonsFolder:GetChildren()) do
                if tycoonModel:IsA("Model") then
                    local purchasedObjects = tycoonModel:FindFirstChild("PurchasedObjects")
                    if purchasedObjects then
                        local rpgGiver = purchasedObjects:FindFirstChild("RPG Giver")
                        if rpgGiver then
                            local prompt = rpgGiver:FindFirstChild("Prompt")
                            if prompt and prompt:IsA("BasePart") then
                                local distance = (playerPosition - prompt.Position).Magnitude
                                if distance < closestDistance then
                                    closestDistance = distance
                                    closestCFrame = prompt.CFrame
                                end
                            end
                        end
                    end
                end
            end
            
            return closestCFrame
        end
        
        local targetCFrame = findNearestTeleportPosition()
        if targetCFrame and localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
            localPlayer.Character.HumanoidRootPart.CFrame = targetCFrame
            WindUI:Notify({
                Title = "RPG获取",
                Content = "正在获取RPG...",
                Icon = "rocket"
            })
        else
            WindUI:Notify({
                Title = "ERROR",
                Content = "未能找到附近的RPG",
                Duration = 4,
            })
        end
    end
})

-- RPG轰炸功能
local rpgAttackActive = false
Tab4Section:Toggle({
    Title = "RPG轰炸",
    Desc = "自动RPG轰炸",
    Default = false,
    Callback = function(isEnabled)
        rpgAttackActive = isEnabled
        
        if isEnabled then
            spawn(function()
                while rpgAttackActive do
                    local Players = game:GetService("Players")
                    local LocalPlayer = Players.LocalPlayer
                    
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        local attackPosition = LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 1000, 0)
                        local weapon = LocalPlayer.Character:FindFirstChild("RPG")
                        
                        if weapon then
                            -- RPG攻击逻辑
                        end
                    end
                    task.wait(0.5)
                end
            end)
        end
        
        WindUI:Notify({
            Title = "RPG轰炸",
            Content = isEnabled and "✅ 已开启" or "❌ 已关闭",
            Icon = "bomb",
            Duration = 3
        })
    end 
})

local Tab5 = MainWindow:Tab({
    Title = "辅助功能",
    Icon = "help-circle"
})

local Tab5Section = Tab5:Section({
    Title = "辅助设置",
    TextSize = 18,
    FontWeight = Enum.FontWeight.SemiBold
})

-- 无坠落伤害
local blockFDMG = false
Tab5Section:Toggle({
    Title = "无坠落伤害",
    Desc = "防止坠落伤害",
    Default = false,
    Callback = function(isEnabled)
        blockFDMG = isEnabled
        
        if isEnabled then
            local oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
                if blockFDMG and getnamecallmethod() == "FireServer" and tostring(self) == "FDMG" then
                    return nil
                end
                return oldNamecall(self, ...)
            end)
        end
        
        WindUI:Notify({
            Title = "无坠落伤害",
            Content = isEnabled and "✅ 已开启" or "❌ 已关闭",
            Icon = "shield",
            Duration = 3
        })
    end 
})

-- 删除所有门
Tab5Section:Button({
    Title = "删除所有门",
    Icon = "door-open",
    Callback = function()
        for k,v in pairs(workspace.Tycoon.Tycoons:GetChildren()) do
            for x,y in pairs(v.PurchasedObjects:GetChildren()) do
                if(y.Name:find("Door") or y.Name:find("Gate")) then 
                    y:destroy()
                end
            end
        end
        WindUI:Notify({
            Title = "删除门",
            Content = "已删除所有门",
            Icon = "door-open"
        })
    end
})

-- 无CD状态
Tab5Section:Toggle({
    Title = "无CD状态",
    Desc = "消除技能冷却",
    Default = false,
    Callback = function(isEnabled)
        if isEnabled then
            local ContextActions = game:GetService("Workspace")[game.Players.LocalPlayer.Name].ContextActions
            local ContextMain = require(ContextActions.ContextMain)
            
            ContextMain:New({
                RobPlayerLength = 0.1,
                FixWallLength = 0.1,
                CrackSafeLength = 0.1,
                RobSafeLength = 0.1,
                RobRegisterLength = 0.1,
                PickCellLength = 0.1,
                SkinAnimalLength = 0.1
            }, 200, {
                "Get out of my shop! Outlaws are not welcome here!",
                "Hey, scoundrel! Get out before I call the sheriff!",
                "You're an outlaw! We don't serve your type here!"
            }, {
                "This here's a bandit camp! Get out!",
                "Get lost, cowboy!",
                "Are you an outlaw? Didn't think so! Scram!"
            })
        end
        
        WindUI:Notify({
            Title = "无CD状态",
            Content = isEnabled and "✅ 已开启" or "❌ 已关闭",
            Icon = "zap",
            Duration = 3
        })
    end 
})

-- 原地重生功能
local deathPosition = nil
local deathOrientation = nil

Tab5Section:Button({
    Title = "原地重生",
    Icon = "refresh-cw",
    Callback = function()
        if not deathPosition then
            WindUI:Notify({
                Title = "错误",
                Content = "没有记录死亡位置",
                Icon = "alert-circle"
            })
            return
        end
        
        local player = game.Players.LocalPlayer
        local character = player.Character
        
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.Health > 0 then
                WindUI:Notify({
                    Title = "提示",
                    Content = "角色还活着，无需重生",
                    Icon = "alert-circle"
                })
                return
            end
        end
        
        player:LoadCharacter()
        local connection
        connection = player.CharacterAdded:Connect(function(newCharacter)
            local newRootPart = newCharacter:WaitForChild("HumanoidRootPart", 5)
            if newRootPart then
                wait(0.5)
                newRootPart.CFrame = CFrame.new(deathPosition) * deathOrientation
                deathPosition = nil
                deathOrientation = nil
                if connection then connection:Disconnect() end
            end
        end)
        
        WindUI:Notify({
            Title = "重生",
            Content = "正在原地重生...",
            Icon = "refresh-cw"
        })
    end
})

-- 死亡位置记录
local function setupDeathTracking()
    local player = game.Players.LocalPlayer
    
    player.CharacterAdded:Connect(function(character)
        local humanoid = character:WaitForChild("Humanoid")
        
        humanoid.Died:Connect(function()
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                deathPosition = rootPart.Position
                deathOrientation = rootPart.CFrame - rootPart.Position
            end
        end)
    end)
end

setupDeathTracking()

MainWindow:SetToggleKey(Enum.KeyCode.LeftControl)