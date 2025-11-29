-- 1. 加载 WindUI 核心库
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/lool8/-/refs/heads/main/DOLLUI.lua"))()

-- 2. 创建主窗口
local MainWindow = WindUI:CreateWindow({
    Title = "DOLL※༒/力量传奇", 
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

-- 主标签页：力量传奇［主要功能］
local Tab3 = MainWindow:Tab({
    Title = "力量传奇［主要功能］",
    Icon = "bolt"
})

-- 实用功能区域
local Tab3Section = Tab3:Section({
    Title = "实用功能",
    TextSize = 18,
    FontWeight = Enum.FontWeight.SemiBold
})

-- 自动比赛开关（ Toggle ）
local Tab3Toggle = Tab3Section:Toggle({
    Title = "自动比赛开关",
    Desc = "自动参与比赛",
    Default = false,
    Callback = function(isEnabled)
        WindUI:Notify({
            Title = "自动比赛",
            Content = isEnabled and "✅ 已开启" or "❌ 已关闭",
            Icon = "bolt",
            Duration = 3
        })

        if isEnabled then
            task.spawn(function()
                while isEnabled do
                    task.wait(2)
                    game:GetService("ReplicatedStorage").rEvents.brawlEvent:FireServer("joinBrawl")
                end
            end)
        end
    end
})

-- 自动举哑铃（ Toggle ）
local Tab3Toggle = Tab3Section:Toggle({
    Title = "自动举哑铃",
    Desc = "自动装备哑铃并锻炼",
    Default = false,
    Callback = function(isEnabled)
        WindUI:Notify({
            Title = "自动举哑铃",
            Content = isEnabled and "✅ 已开启" or "❌ 已关闭",
            Icon = "bolt",
            Duration = 3
        })

        local part = nil
        if isEnabled then
            -- 创建临时部件
            part = Instance.new('Part', workspace)
            part.Size = Vector3.new(500, 20, 530.1)
            part.Position = Vector3.new(0, 100000, 133.15)
            part.CanCollide = true
            part.Anchored = true

            task.spawn(function()
                while isEnabled do
                    task.wait()
                    local character = game.Players.LocalPlayer.Character
                    if character then
                        local rootPart = character:FindFirstChild("HumanoidRootPart")
                        if rootPart then
                            rootPart.CFrame = part.CFrame + Vector3.new(0, 50, 0)
                        end

                        -- 装备哑铃工具
                        for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                            if v:IsA("Tool") and v.Name == "Weight" then
                                v.Parent = character
                            end
                        end

                        game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
                    end
                end
            end)
        else
            -- 关闭时清理部件
            if part then
                part:Destroy()
            end
        end
    end
})

-- 自动俯卧撑（ Toggle ）
local Tab3Toggle = Tab3Section:Toggle({
    Title = "自动俯卧撑",
    Desc = "自动装备俯卧撑工具并锻炼",
    Default = false,
    Callback = function(isEnabled)
        WindUI:Notify({
            Title = "自动俯卧撑",
            Content = isEnabled and "✅ 已开启" or "❌ 已关闭",
            Icon = "bolt",
            Duration = 3
        })

        local part = nil
        if isEnabled then
            part = Instance.new('Part', workspace)
            part.Size = Vector3.new(500, 20, 530.1)
            part.Position = Vector3.new(0, 100000, 133.15)
            part.CanCollide = true
            part.Anchored = true

            task.spawn(function()
                while isEnabled do
                    task.wait()
                    local character = game.Players.LocalPlayer.Character
                    if character then
                        local rootPart = character:FindFirstChild("HumanoidRootPart")
                        if rootPart then
                            rootPart.CFrame = part.CFrame + Vector3.new(0, 50, 0)
                        end

                        -- 装备俯卧撑工具
                        for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                            if v:IsA("Tool") and v.Name == "Pushups" then
                                v.Parent = character
                            end
                        end

                        game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
                    end
                end
            end)
        else
            if part then
                part:Destroy()
            end
        end
    end
})

-- 自动仰卧起坐（ Toggle ）
local Tab3Toggle = Tab3Section:Toggle({
    Title = "自动仰卧起坐",
    Desc = "自动装备仰卧起坐工具并锻炼",
    Default = false,
    Callback = function(isEnabled)
        WindUI:Notify({
            Title = "自动仰卧起坐",
            Content = isEnabled and "✅ 已开启" or "❌ 已关闭",
            Icon = "bolt",
            Duration = 3
        })

        local part = nil
        if isEnabled then
            part = Instance.new('Part', workspace)
            part.Size = Vector3.new(500, 20, 530.1)
            part.Position = Vector3.new(0, 100000, 133.15)
            part.CanCollide = true
            part.Anchored = true

            task.spawn(function()
                while isEnabled do
                    task.wait()
                    local character = game.Players.LocalPlayer.Character
                    if character then
                        local rootPart = character:FindFirstChild("HumanoidRootPart")
                        if rootPart then
                            rootPart.CFrame = part.CFrame + Vector3.new(0, 50, 0)
                        end

                        -- 装备仰卧起坐工具
                        for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                            if v:IsA("Tool") and v.Name == "Situps" then
                                v.Parent = character
                            end
                        end

                        game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
                    end
                end
            end)
        else
            if part then
                part:Destroy()
            end
        end
    end
})

-- 自动倒立身体（ Toggle ）
local Tab3Toggle = Tab3Section:Toggle({
    Title = "自动倒立身体",
    Desc = "自动装备倒立工具并锻炼",
    Default = false,
    Callback = function(isEnabled)
        WindUI:Notify({
            Title = "自动倒立身体",
            Content = isEnabled and "✅ 已开启" or "❌ 已关闭",
            Icon = "bolt",
            Duration = 3
        })

        local part = nil
        if isEnabled then
            part = Instance.new('Part', workspace)
            part.Size = Vector3.new(500, 20, 530.1)
            part.Position = Vector3.new(0, 100000, 133.15)
            part.CanCollide = true
            part.Anchored = true

            task.spawn(function()
                while isEnabled do
                    task.wait()
                    local character = game.Players.LocalPlayer.Character
                    if character then
                        local rootPart = character:FindFirstChild("HumanoidRootPart")
                        if rootPart then
                            rootPart.CFrame = part.CFrame + Vector3.new(0, 50, 0)
                        end

                        -- 装备倒立工具
                        for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                            if v:IsA("Tool") and v.Name == "Handstands" then
                                v.Parent = character
                            end
                        end

                        game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
                    end
                end
            end)
        else
            if part then
                part:Destroy()
            end
        end
    end
})

-- 自动锻炼（ Toggle ）
local Tab3Toggle = Tab3Section:Toggle({
    Title = "自动锻炼",
    Desc = "自动装备所有锻炼工具并循环锻炼",
    Default = false,
    Callback = function(isEnabled)
        WindUI:Notify({
            Title = "自动锻炼",
            Content = isEnabled and "✅ 已开启" or "❌ 已关闭",
            Icon = "bolt",
            Duration = 3
        })

        local part = nil
        if isEnabled then
            part = Instance.new('Part', workspace)
            part.Size = Vector3.new(500, 20, 530.1)
            part.Position = Vector3.new(0, 100000, 133.15)
            part.CanCollide = true
            part.Anchored = true

            task.spawn(function()
                while isEnabled do
                    task.wait()
                    local character = game.Players.LocalPlayer.Character
                    if character then
                        local rootPart = character:FindFirstChild("HumanoidRootPart")
                        if rootPart then
                            rootPart.CFrame = part.CFrame + Vector3.new(0, 50, 0)
                        end

                        -- 装备所有锻炼工具并锻炼
                        for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                            if v:IsA("Tool") and (v.Name == "Handstands" or v.Name == "Situps" or v.Name == "Pushups" or v.Name == "Weight") then
                                local numberValue = v:FindFirstChildOfClass("NumberValue")
                                if numberValue then
                                    numberValue.Value = 0
                                end
                                character:WaitForChild("Humanoid"):EquipTool(v)
                                game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
                            end
                        end
                    end
                end
            end)
        else
            if part then
                part:Destroy()
            end
        end
    end
})

-- 自动重生（ Toggle ）
local Tab3Toggle = Tab3Section:Toggle({
    Title = "自动重生",
    Desc = "持续发送重生请求",
    Default = false,
    Callback = function(isEnabled)
        WindUI:Notify({
            Title = "自动重生",
            Content = isEnabled and "✅ 已开启" or "❌ 已关闭",
            Icon = "bolt",
            Duration = 3
        })

        if isEnabled then
            task.spawn(function()
                while isEnabled do
                    task.wait()
                    game:GetService("ReplicatedStorage").rEvents.rebirthRemote:InvokeServer("rebirthRequest")
                end
            end)
        end
    end
})

-- 收集宝石（ Button ）
Tab3Section:Button({
    Title = "收集宝石",
    Icon = "refresh-cw",
    Color = Color3.fromHex("#000000"),
    Callback = function()
        local jk = {}
        local chestRewards = game:GetService("ReplicatedStorage"):FindFirstChild("chestRewards")
        if not chestRewards then
            WindUI:Notify({
                Title = "错误",
                Content = "未找到宝石奖励文件夹！",
                Icon = "bolt"
            })
            return
        end

        for _, v in pairs(chestRewards:GetDescendants()) do
            if v.Name ~= "Light Karma Chest" and v.Name ~= "Evil Karma Chest" then
                table.insert(jk, v.Name)
            end
        end

        task.spawn(function()
            for i = 1, #jk do
                task.wait(2)
                game:GetService("ReplicatedStorage").rEvents.checkChestRemote:InvokeServer(jk[i])
            end
            WindUI:Notify({
                Title = "收集完成",
                Content = "所有宝石已收集完毕！",
                Icon = "bolt"
            })
        end)

        WindUI:Notify({
            Title = "收集宝石",
            Content = "开始自动收集宝石，共" .. #jk .. "个！",
            Icon = "bolt"
        })
    end
})

-- 传送到幸运抽奖区域（ Button ）
Tab3Section:Button({
    Title = "传送到幸运抽奖区域",
    Icon = "refresh-cw",
    Color = Color3.fromHex("#000000"),
    Callback = function()
        local character = game.Players.LocalPlayer.Character
        if character then
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                rootPart.CFrame = CFrame.new(-2606, -2, 5753)
                WindUI:Notify({
                    Title = "传送完成",
                    Content = "已成功传送到幸运抽奖区域！",
                    Icon = "bolt"
                })
            else
                WindUI:Notify({
                    Title = "错误",
                    Content = "未找到角色根部件！",
                    Icon = "bolt"
                })
            end
        else
            WindUI:Notify({
                Title = "错误",
                Content = "角色未加载！",
                Icon = "bolt"
            })
        end
    end
})

-- 主标签页1：力量传奇［传送］
local Tab4 = MainWindow:Tab({
    Title = "力量传奇［传送］",
    Icon = "bolt"
})

-- 传送功能区域
local Tab4Section = Tab4:Section({
    Title = "健身房传送",
    TextSize = 18,
    FontWeight = Enum.FontWeight.SemiBold
})

-- 传送到肌肉之王健身房（按钮）
Tab4Section:Button({
    Title = "传送到肌肉之王健身房",
    Icon = "refresh-cw",
    Color = Color3.fromHex("#000000"),
    Callback = function()
        local character = game.Players.LocalPlayer.Character
        if character then
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                rootPart.CFrame = CFrame.new(-8554, 22, -5642)
                WindUI:Notify({
                    Title = "传送完成",
                    Content = "已传送到肌肉之王健身房！",
                    Icon = "bolt"
                })
            else
                WindUI:Notify({
                    Title = "错误",
                    Content = "未找到角色根部件！",
                    Icon = "bolt"
                })
            end
        else
            WindUI:Notify({
                Title = "错误",
                Content = "角色未加载！",
                Icon = "bolt"
            })
        end
    end
})

-- 传送到传说健身房（按钮）
Tab4Section:Button({
    Title = "传送到传说健身房",
    Icon = "refresh-cw",
    Color = Color3.fromHex("#000000"),
    Callback = function()
        local character = game.Players.LocalPlayer.Character
        if character then
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                rootPart.CFrame = CFrame.new(4676, 997, -3915)
                WindUI:Notify({
                    Title = "传送完成",
                    Content = "已传送到传说健身房！",
                    Icon = "bolt"
                })
            else
                WindUI:Notify({
                    Title = "错误",
                    Content = "未找到角色根部件！",
                    Icon = "bolt"
                })
            end
        else
            WindUI:Notify({
                Title = "错误",
                Content = "角色未加载！",
                Icon = "bolt"
            })
        end
    end
})

-- 传送到永恒健身房（按钮）
Tab4Section:Button({
    Title = "传送到永恒健身房",
    Icon = "refresh-cw",
    Color = Color3.fromHex("#000000"),
    Callback = function()
        local character = game.Players.LocalPlayer.Character
        if character then
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                rootPart.CFrame = CFrame.new(-6686, 13, -1284)
                WindUI:Notify({
                    Title = "传送完成",
                    Content = "已传送到永恒健身房！",
                    Icon = "bolt"
                })
            else
                WindUI:Notify({
                    Title = "错误",
                    Content = "未找到角色根部件！",
                    Icon = "bolt"
                })
            end
        else
            WindUI:Notify({
                Title = "错误",
                Content = "角色未加载！",
                Icon = "bolt"
            })
        end
    end
})

-- 传送到神话健身房（按钮）
Tab4Section:Button({
    Title = "传送到神话健身房",
    Icon = "refresh-cw",
    Color = Color3.fromHex("#000000"),
    Callback = function()
        local character = game.Players.LocalPlayer.Character
        if character then
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                rootPart.CFrame = CFrame.new(2177, 13, 1070)
                WindUI:Notify({
                    Title = "传送完成",
                    Content = "已传送到神话健身房！",
                    Icon = "bolt"
                })
            else
                WindUI:Notify({
                    Title = "错误",
                    Content = "未找到角色根部件！",
                    Icon = "bolt"
                })
            end
        else
            WindUI:Notify({
                Title = "错误",
                Content = "角色未加载！",
                Icon = "bolt"
            })
        end
    end
})

-- 传送到冰霜健身房（按钮）
Tab4Section:Button({
    Title = "传送到冰霜健身房",
    Icon = "refresh-cw",
    Color = Color3.fromHex("#000000"),
    Callback = function()
        local character = game.Players.LocalPlayer.Character
        if character then
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                rootPart.CFrame = CFrame.new(-2543, 13, -410)
                WindUI:Notify({
                    Title = "传送完成",
                    Content = "已传送到冰霜健身房！",
                    Icon = "bolt"
                })
            else
                WindUI:Notify({
                    Title = "错误",
                    Content = "未找到角色根部件！",
                    Icon = "bolt"
                })
            end
        else
            WindUI:Notify({
                Title = "错误",
                Content = "角色未加载！",
                Icon = "bolt"
            })
        end
    end
})

-- 传送到丛林健身房（按钮）
Tab4Section:Button({
    Title = "传送到丛林健身房",
    Icon = "refresh-cw",
    Color = Color3.fromHex("#000000"),
    Callback = function()
        local character = game.Players.LocalPlayer.Character
        if character then
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                rootPart.CFrame = CFrame.new(-8760.79, 46.58, 2394.51)
                WindUI:Notify({
                    Title = "传送完成",
                    Content = "已传送到丛林健身房！",
                    Icon = "bolt"
                })
            else
                WindUI:Notify({
                    Title = "错误",
                    Content = "未找到角色根部件！",
                    Icon = "bolt"
                })
            end
        else
            WindUI:Notify({
                Title = "错误",
                Content = "角色未加载！",
                Icon = "bolt"
            })
        end
    end
})

-- 温馨提示区域
local Tab4Section = Tab4:Section({
    Title = "温馨提示",
    TextSize = 16,
    FontWeight = Enum.FontWeight.Regular
})

-- 自动打石头0（开关）
local Tab4Toggle = Tab4Section:Toggle({
    Title = "自动打石头0",
    Desc = "建议把体型调成2",
    Default = false,
    Callback = function(isEnabled)
        WindUI:Notify({
            Title = "自动打石头0",
            Content = isEnabled and "✅ 已开启" or "❌ 已关闭",
            Icon = "bolt",
            Duration = 3
        })

        getgenv().rock = isEnabled
        if isEnabled then
            task.spawn(function()
                while getgenv().rock do
                    task.wait()
                    local character = game.Players.LocalPlayer.Character
                    if not character then continue end

                    -- 装备Punch工具
                    for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                        if v:IsA("Tool") and v.Name == "Punch" then
                            character:WaitForChild("Humanoid"):EquipTool(v)
                        end
                    end

                    -- 激活工具
                    for _, h in pairs(character:GetChildren()) do
                        if h:IsA("Tool") and h.Name == "Punch" then
                            h:Activate()
                        end
                    end

                    -- 传送到指定位置
                    local rootPart = character:FindFirstChild("HumanoidRootPart")
                    if rootPart then
                        rootPart.CFrame = CFrame.new(7.60643005, 4.02632904, 2104.54004, -0.23040159, -8.53662385e-08, -0.973095655, -4.68743764e-08, 1, -7.66279342e-08, 0.973095655, 2.79580536e-08, -0.23040159)
                    end
                end
            end)
        else
            -- 关闭时卸下工具
            local character = game.Players.LocalPlayer.Character
            if character then
                character:WaitForChild("Humanoid"):UnequipTools()
            end
        end
    end
})

-- 自动打石头10（开关）
local Tab4Toggle = Tab4Section:Toggle({
    Title = "自动打石头10",
    Desc = "需耐久度≥10，建议体型调为2",
    Default = false,
    Callback = function(isEnabled)
        local localPlayer = game.Players.LocalPlayer
        if isEnabled and localPlayer.Durability.Value < 10 then
            WindUI:Notify({
                Title = "错误",
                Content = "耐久度不足10，无法开启！",
                Icon = "bolt",
                Duration = 3
            })
            return
        end

        WindUI:Notify({
            Title = "自动打石头10",
            Content = isEnabled and "✅ 已开启" or "❌ 已关闭",
            Icon = "bolt",
            Duration = 3
        })

        getgenv().rock = isEnabled
        if isEnabled then
            task.spawn(function()
                while getgenv().rock do
                    task.wait()
                    local character = localPlayer.Character
                    if not character then continue end

                    -- 装备Punch工具
                    for _, v in pairs(localPlayer.Backpack:GetChildren()) do
                        if v:IsA("Tool") and v.Name == "Punch" then
                            character:WaitForChild("Humanoid"):EquipTool(v)
                        end
                    end

                    -- 激活工具
                    for _, h in pairs(character:GetChildren()) do
                        if h:IsA("Tool") and h.Name == "Punch" then
                            h:Activate()
                        end
                    end

                    -- 传送到指定位置
                    local rootPart = character:FindFirstChild("HumanoidRootPart")
                    if rootPart then
                        rootPart.CFrame = CFrame.new(-157.680908, 3.72453046, 434.871185, 0.923298299, -1.81774684e-09, -0.384083599, 3.45247031e-09, 1, 3.56670582e-09, 0.384083599, -4.61917082e-09, 0.923298299)
                    end
                end
            end)
        else
            -- 关闭时卸下工具
            local character = localPlayer.Character
            if character then
                character:WaitForChild("Humanoid"):UnequipTools()
            end
        end
    end
})

-- 主标签页2：力量传奇-自动石头
local Tab5 = MainWindow:Tab({
    Title = "力量传奇-自动石头",
    Icon = "bolt"
})

-- 自动打石头功能区域
local Tab5Section = Tab5:Section({
    Title = "自动打石头（需耐久≥100）",
    TextSize = 18,
    FontWeight = Enum.FontWeight.SemiBold
})

-- 自动打石头100（开关）
local Tab5Toggle = Tab5Section:Toggle({
    Title = "自动打石头100",
    Desc = "需耐久度≥100",
    Default = false,
    Callback = function(isEnabled)
        local localPlayer = game.Players.LocalPlayer
        if isEnabled and localPlayer.Durability.Value < 100 then
            WindUI:Notify({
                Title = "错误",
                Content = "耐久度不足100，无法开启！",
                Icon = "bolt",
                Duration = 3
            })
            return
        end

        WindUI:Notify({
            Title = "自动打石头100",
            Content = isEnabled and "✅ 已开启" or "❌ 已关闭",
            Icon = "bolt",
            Duration = 3
        })

        getgenv().rock = isEnabled
        if isEnabled then
            task.spawn(function()
                while getgenv().rock do
                    task.wait()
                    local character = localPlayer.Character
                    if not character then continue end

                    -- 装备Punch工具
                    for _, v in pairs(localPlayer.Backpack:GetChildren()) do
                        if v:IsA("Tool") and v.Name == "Punch" then
                            character:WaitForChild("Humanoid"):EquipTool(v)
                        end
                    end

                    -- 激活工具
                    for _, h in pairs(character:GetChildren()) do
                        if h:IsA("Tool") and h.Name == "Punch" then
                            h:Activate()
                        end
                    end

                    -- 传送到指定位置
                    local rootPart = character:FindFirstChild("HumanoidRootPart")
                    if rootPart then
                        rootPart.CFrame = CFrame.new(162.233673, 3.66615629, -164.686783, -0.921312928, -1.80826774e-07, -0.38882193, -9.13036544e-08, 1, -2.48719346e-07, 0.38882193, -1.93647494e-07, -0.921312928)
                    end
                end
            end)
        else
            -- 关闭时卸下工具
            local character = localPlayer.Character
            if character then
                character:WaitForChild("Humanoid"):UnequipTools()
            end
        end
    end
})

-- 自动打石头5000（开关）
local Tab5Toggle = Tab5Section:Toggle({
    Title = "自动打石头5000",
    Desc = "需耐久度≥100",
    Default = false,
    Callback = function(isEnabled)
        local localPlayer = game.Players.LocalPlayer
        if isEnabled and localPlayer.Durability.Value < 100 then
            WindUI:Notify({
                Title = "错误",
                Content = "耐久度不足100，无法开启！",
                Icon = "bolt",
                Duration = 3
            })
            return
        end

        WindUI:Notify({
            Title = "自动打石头5000",
            Content = isEnabled and "✅ 已开启" or "❌ 已关闭",
            Icon = "bolt",
            Duration = 3
        })

        getgenv().rock = isEnabled
        if isEnabled then
            task.spawn(function()
                while getgenv().rock do
                    task.wait()
                    local character = localPlayer.Character
                    if not character then continue end

                    -- 装备Punch工具
                    for _, v in pairs(localPlayer.Backpack:GetChildren()) do
                        if v:IsA("Tool") and v.Name == "Punch" then
                            character:WaitForChild("Humanoid"):EquipTool(v)
                        end
                    end

                    -- 激活工具
                    for _, h in pairs(character:GetChildren()) do
                        if h:IsA("Tool") and h.Name == "Punch" then
                            h:Activate()
                        end
                    end

                    -- 传送到指定位置
                    local rootPart = character:FindFirstChild("HumanoidRootPart")
                    if rootPart then
                        rootPart.CFrame = CFrame.new(283.42, 3.71, -590.84, -0.921312928, -1.80826774e-07, -0.38882193, -9.13036544e-08, 1, -2.48719346e-07, 0.38882193, -1.93647494e-07, -0.921312928)
                    end
                end
            end)
        else
            -- 关闭时卸下工具
            local character = localPlayer.Character
            if character then
                character:WaitForChild("Humanoid"):UnequipTools()
            end
        end
    end
})

-- 自动打石头150000（开关）
local Tab5Toggle = Tab5Section:Toggle({
    Title = "自动打石头150000",
    Desc = "需耐久度≥100",
    Default = false,
    Callback = function(isEnabled)
        local localPlayer = game.Players.LocalPlayer
        if isEnabled and localPlayer.Durability.Value < 100 then
            WindUI:Notify({
                Title = "错误",
                Content = "耐久度不足100，无法开启！",
                Icon = "bolt",
                Duration = 3
            })
            return
        end

        WindUI:Notify({
            Title = "自动打石头150000",
            Content = isEnabled and "✅ 已开启" or "❌ 已关闭",
            Icon = "bolt",
            Duration = 3
        })

        getgenv().rock = isEnabled
        if isEnabled then
            task.spawn(function()
                while getgenv().rock do
                    task.wait()
                    local character = localPlayer.Character
                    if not character then continue end

                    -- 装备Punch工具
                    for _, v in pairs(localPlayer.Backpack:GetChildren()) do
                        if v:IsA("Tool") and v.Name == "Punch" then
                            character:WaitForChild("Humanoid"):EquipTool(v)
                        end
                    end

                    -- 激活工具
                    for _, h in pairs(character:GetChildren()) do
                        if h:IsA("Tool") and h.Name == "Punch" then
                            h:Activate()
                        end
                    end

                    -- 传送到指定位置
                    local rootPart = character:FindFirstChild("HumanoidRootPart")
                    if rootPart then
                        rootPart.CFrame = CFrame.new(-2585.99, 17.38, -249.59)
                    end
                end
            end)
        else
            -- 关闭时卸下工具
            local character = localPlayer.Character
            if character then
                character:WaitForChild("Humanoid"):UnequipTools()
            end
        end
    end
})

-- 自动打石头400000（开关）
local Tab5Toggle = Tab5Section:Toggle({
    Title = "自动打石头400000",
    Desc = "需耐久度≥100",
    Default = false,
    Callback = function(isEnabled)
        local localPlayer = game.Players.LocalPlayer
        if isEnabled and localPlayer.Durability.Value < 100 then
            WindUI:Notify({
                Title = "错误",
                Content = "耐久度不足100，无法开启！",
                Icon = "bolt",
                Duration = 3
            })
            return
        end

        WindUI:Notify({
            Title = "自动打石头400000",
            Content = isEnabled and "✅ 已开启" or "❌ 已关闭",
            Icon = "bolt",
            Duration = 3
        })

        getgenv().rock = isEnabled
        if isEnabled then
            task.spawn(function()
                while getgenv().rock do
                    task.wait()
                    local character = localPlayer.Character
                    if not character then continue end

                    -- 装备Punch工具
                    for _, v in pairs(localPlayer.Backpack:GetChildren()) do
                        if v:IsA("Tool") and v.Name == "Punch" then
                            character:WaitForChild("Humanoid"):EquipTool(v)
                        end
                    end

                    -- 激活工具
                    for _, h in pairs(character:GetChildren()) do
                        if h:IsA("Tool") and h.Name == "Punch" then
                            h:Activate()
                        end
                    end

                    -- 传送到指定位置
                    local rootPart = character:FindFirstChild("HumanoidRootPart")
                    if rootPart then
                        rootPart.CFrame = CFrame.new(2220.94, 12.67, 1252.67)
                    end
                end
            end)
        else
            -- 关闭时卸下工具
            local character = localPlayer.Character
            if character then
                character:WaitForChild("Humanoid"):UnequipTools()
            end
        end
    end
})

-- 自动打石头100万（开关，去重）
local Tab5Toggle = Tab5Section:Toggle({
    Title = "自动打石头100万",
    Desc = "需耐久度≥100",
    Default = false,
    Callback = function(isEnabled)
        local localPlayer = game.Players.LocalPlayer
        if isEnabled and localPlayer.Durability.Value < 100 then
            WindUI:Notify({
                Title = "错误",
                Content = "耐久度不足100，无法开启！",
                Icon = "bolt",
                Duration = 3
            })
            return
        end

        WindUI:Notify({
            Title = "自动打石头100万",
            Content = isEnabled and "✅ 已开启" or "❌ 已关闭",
            Icon = "bolt",
            Duration = 3
        })

        getgenv().rock = isEnabled
        if isEnabled then
            task.spawn(function()
                while getgenv().rock do
                    task.wait()
                    local character = localPlayer.Character
                    local backpack = localPlayer.Backpack
                    if not character then continue end

                    -- 装备Punch工具
                    for _, tool in ipairs(backpack:GetChildren()) do
                        if tool:IsA("Tool") and tool.Name == "Punch" then
                            local humanoid = character:FindFirstChildOfClass("Humanoid")
                            if humanoid then
                                humanoid:EquipTool(tool)
                            end
                        end
                    end

                    -- 激活工具
                    for _, tool in ipairs(character:GetChildren()) do
                        if tool:IsA("Tool") and tool.Name == "Punch" then
                            tool:Activate()
                        end
                    end

                    -- 传送到指定位置
                    local rootPart = character:FindFirstChild("HumanoidRootPart")
                    if rootPart then
                        rootPart.CFrame = CFrame.new(4178.57, 1012.66, -4062.21)
                    end
                end
            end)
        else
            -- 关闭时卸下工具
            local character = localPlayer.Character
            if character then
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid:UnequipTools()
                end
            end
        end
    end
})

-- 自动打石头500万（开关）
local Tab5Toggle = Tab5Section:Toggle({
    Title = "自动打石头500万",
    Desc = "需耐久度≥100",
    Default = false,
    Callback = function(isEnabled)
        local localPlayer = game.Players.LocalPlayer
        if isEnabled and localPlayer.Durability.Value < 100 then
            WindUI:Notify({
                Title = "错误",
                Content = "耐久度不足100，无法开启！",
                Icon = "bolt",
                Duration = 3
            })
            return
        end

        WindUI:Notify({
            Title = "自动打石头500万",
            Content = isEnabled and "✅ 已开启" or "❌ 已关闭",
            Icon = "bolt",
            Duration = 3
        })

        getgenv().rock = isEnabled
        if isEnabled then
            task.spawn(function()
                while getgenv().rock do
                    task.wait()
                    local character = localPlayer.Character
                    if not character then continue end

                    -- 装备Punch工具
                    for _, tool in pairs(localPlayer.Backpack:GetChildren()) do
                        if tool:IsA("Tool") and tool.Name == "Punch" then
                            character:WaitForChild("Humanoid"):EquipTool(tool)
                        end
                    end

                    -- 激活工具
                    for _, tool in pairs(character:GetChildren()) do
                        if tool:IsA("Tool") and tool.Name == "Punch" then
                            tool:Activate()
                        end
                    end

                    -- 传送到指定位置
                    local rootPart = character:FindFirstChild("HumanoidRootPart")
                    if rootPart then
                        rootPart.CFrame = CFrame.new(-8919.20, 40.01, -6014.81)
                    end
                end
            end)
        else
            -- 关闭时卸下工具
            local character = localPlayer.Character
            if character then
                character:WaitForChild("Humanoid"):UnequipTools()
            end
        end
    end
})

-- 自动打石头1000万（开关）
local Tab5Toggle = Tab5Section:Toggle({
    Title = "自动打石头1000万",
    Desc = "需耐久度≥100",
    Default = false,
    Callback = function(isEnabled)
        local localPlayer = game.Players.LocalPlayer
        if isEnabled and localPlayer.Durability.Value < 100 then
            WindUI:Notify({
                Title = "错误",
                Content = "耐久度不足100，无法开启！",
                Icon = "bolt",
                Duration = 3
            })
            return
        end

        WindUI:Notify({
            Title = "自动打石头1000万",
            Content = isEnabled and "✅ 已开启" or "❌ 已关闭",
            Icon = "bolt",
            Duration = 3
        })

        getgenv().rock = isEnabled
        if isEnabled then
            task.spawn(function()
                while getgenv().rock do
                    task.wait()
                    local character = localPlayer.Character
                    local backpack = localPlayer.Backpack
                    if not character then continue end

                    -- 装备Punch工具
                    for _, tool in ipairs(backpack:GetChildren()) do
                        if tool:IsA("Tool") and tool.Name == "Punch" then
                            local humanoid = character:FindFirstChildOfClass("Humanoid")
                            if humanoid then
                                humanoid:EquipTool(tool)
                            end
                        end
                    end

                    -- 激活工具
                    for _, tool in ipairs(character:GetChildren()) do
                        if tool:IsA("Tool") and tool.Name == "Punch" then
                            tool:Activate()
                        end
                    end

                    -- 传送到指定位置
                    local rootPart = character:FindFirstChild("HumanoidRootPart")
                    if rootPart then
                        rootPart.CFrame = CFrame.new(-7689.18, 61.99, 2869.29)
                    end
                end
            end)
        else
            -- 关闭时卸下工具
            local character = localPlayer.Character
            if character then
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid:UnequipTools()
                end
            end
        end
    end
})

-- 主标签页：力量传奇［跑步机］
local Tab6 = MainWindow:Tab({
    Title = "力量传奇［跑步机］",
    Icon = "bolt"
})

-- 跑步机功能区域（含温馨提示）
local Tab6Section = Tab6:Section({
    Title = "跑步机功能",
    TextSize = 18,
    FontWeight = Enum.FontWeight.SemiBold,
    Desc = "建议把体型调成1再跑，提升运行稳定性"
})

-- 沙滩跑步机10（开关）
local Tab6Toggle = Tab6Section:Toggle({
    Title = "沙滩跑步机10",
    Desc = "敏捷值+10，体型建议调为1",
    Default = false,
    Callback = function(isEnabled)
        WindUI:Notify({
            Title = "沙滩跑步机10",
            Content = isEnabled and "✅ 已开启" or "❌ 已关闭",
            Icon = "bolt",
            Duration = 3
        })

        getgenv().PPJ10 = isEnabled
        if isEnabled then
            task.spawn(function()
                while getgenv().PPJ10 do
                    task.wait()
                    local character = game.Players.LocalPlayer.Character
                    if character then
                        local humanoid = character:FindFirstChild("Humanoid")
                        local rootPart = character:FindFirstChild("HumanoidRootPart")
                        
                        if humanoid then
                            humanoid.WalkSpeed = 10
                        end
                        
                        if rootPart then
                            rootPart.CFrame = CFrame.new(238.671112, 5.40315914, 387.713165, -0.0160072874, -2.90710176e-08, -0.99987185, -3.3434191e-09, 1, -2.90212157e-08, 0.99987185, 2.87843993e-09, -0.0160072874)
                        end
                    end
                end
            end)

            -- 绑定移动逻辑
            game:GetService("RunService"):BindToRenderStep("PPJ10_move", Enum.RenderPriority.Character.Value + 1, function()
                if getgenv().PPJ10 then
                    local character = game.Players.LocalPlayer.Character
                    if character then
                        local humanoid = character:FindFirstChild("Humanoid")
                        if humanoid then
                            humanoid:Move(Vector3.new(10000, 0, -1), true)
                        end
                    end
                end
            end)
        else
            -- 关闭时解除绑定
            game:GetService("RunService"):UnbindFromRenderStep("PPJ10_move")
        end
    end
})

-- 健身房跑步机1000（开关）
local Tab6Toggle = Tab6Section:Toggle({
    Title = "健身房跑步机1000",
    Desc = "高级跑步机，坐标：(-394.19, 13.23, -262.74)",
    Default = false,
    Callback = function(isEnabled)
        WindUI:Notify({
            Title = "健身房跑步机1000",
            Content = isEnabled and "✅ 已开启" or "❌ 已关闭",
            Icon = "bolt",
            Duration = 3
        })

        getgenv().PPJ10 = isEnabled
        if isEnabled then
            -- 设置移动速度并传送
            local function setupTreadmill()
                local character = game.Players.LocalPlayer.Character
                if character then
                    local humanoid = character:FindFirstChild("Humanoid")
                    local rootPart = character:FindFirstChild("HumanoidRootPart")
                    
                    if humanoid then
                        humanoid.WalkSpeed = 10
                    end
                    
                    if rootPart then
                        rootPart.CFrame = CFrame.new(-394.19, 13.23, -262.74)
                    end
                end
            end

            -- 绑定移动逻辑
            game:GetService("RunService"):BindToRenderStep("PPJ10_move", Enum.RenderPriority.Character.Value + 1, function()
                local character = game.Players.LocalPlayer.Character
                if character then
                    local humanoid = character:FindFirstChild("Humanoid")
                    if humanoid then
                        humanoid:Move(Vector3.new(10000, 0, -1), true)
                    end
                end
            end)

            -- 主循环维持状态
            task.spawn(function()
                while getgenv().PPJ10 do
                    task.wait()
                    setupTreadmill()
                end
            end)
        else
            game:GetService("RunService"):UnbindFromRenderStep("PPJ10_move")
        end
    end
})

-- 冰霜跑步机2000（开关）
local Tab6Toggle = Tab6Section:Toggle({
    Title = "冰霜跑步机2000",
    Desc = "冰霜区域跑步机，坐标：(-2994.07, 14.33, -467.44)",
    Default = false,
    Callback = function(isEnabled)
        WindUI:Notify({
            Title = "冰霜跑步机2000",
            Content = isEnabled and "✅ 已开启" or "❌ 已关闭",
            Icon = "bolt",
            Duration = 3
        })

        getgenv().PPJ10 = isEnabled
        if isEnabled then
            local function setupTreadmill()
                local character = game.Players.LocalPlayer.Character
                if character then
                    local humanoid = character:FindFirstChild("Humanoid")
                    local rootPart = character:FindFirstChild("HumanoidRootPart")
                    
                    if humanoid then
                        humanoid.WalkSpeed = 10
                    end
                    
                    if rootPart then
                        rootPart.CFrame = CFrame.new(-2994.07, 14.33, -467.44)
                    end
                end
            end

            game:GetService("RunService"):BindToRenderStep("PPJ10_move", Enum.RenderPriority.Character.Value + 1, function()
                local character = game.Players.LocalPlayer.Character
                if character then
                    local humanoid = character:FindFirstChild("Humanoid")
                    if humanoid then
                        humanoid:Move(Vector3.new(10000, 0, -1), true)
                    end
                end
            end)

            task.spawn(function()
                while getgenv().PPJ10 do
                    task.wait()
                    setupTreadmill()
                end
            end)
        else
            game:GetService("RunService"):UnbindFromRenderStep("PPJ10_move")
        end
    end
})

-- 神话健身房跑步机3000（开关）
local Tab6Toggle = Tab6Section:Toggle({
    Title = "神话健身房跑步机3000",
    Desc = "神话级跑步机，坐标：(2659.45, 21.64, 951.18)",
    Default = false,
    Callback = function(isEnabled)
        WindUI:Notify({
            Title = "神话健身房跑步机3000",
            Content = isEnabled and "✅ 已开启" or "❌ 已关闭",
            Icon = "bolt",
            Duration = 3
        })

        getgenv().PPJ10 = isEnabled
        if isEnabled then
            local function setupTreadmill()
                local character = game.Players.LocalPlayer.Character
                if character then
                    local humanoid = character:FindFirstChild("Humanoid")
                    local rootPart = character:FindFirstChild("HumanoidRootPart")
                    
                    if humanoid then
                        humanoid.WalkSpeed = 10
                    end
                    
                    if rootPart then
                        rootPart.CFrame = CFrame.new(2659.45, 21.64, 951.18)
                    end
                end
            end

            game:GetService("RunService"):BindToRenderStep("PPJ10_move", Enum.RenderPriority.Character.Value + 1, function()
                local character = game.Players.LocalPlayer.Character
                if character then
                    local humanoid = character:FindFirstChild("Humanoid")
                    if humanoid then
                        humanoid:Move(Vector3.new(10000, 0, -1), true)
                    end
                end
            end)

            task.spawn(function()
                while getgenv().PPJ10 do
                    task.wait()
                    setupTreadmill()
                end
            end)
        else
            game:GetService("RunService"):UnbindFromRenderStep("PPJ10_move")
        end
    end
})

-- 传奇跑步机10（开关）
local Tab6Toggle = Tab6Section:Toggle({
    Title = "传奇跑步机10",
    Desc = "传奇级跑步机，坐标：(4362.67, 999.36, -3650.33)",
    Default = false,
    Callback = function(isEnabled)
        WindUI:Notify({
            Title = "传奇跑步机10",
            Content = isEnabled and "✅ 已开启" or "❌ 已关闭",
            Icon = "bolt",
            Duration = 3
        })

        getgenv().PPJ10 = isEnabled
        if isEnabled then
            local function setupTreadmill()
                local character = game.Players.LocalPlayer.Character
                if character then
                    local humanoid = character:FindFirstChild("Humanoid")
                    local rootPart = character:FindFirstChild("HumanoidRootPart")
                    
                    if humanoid then
                        humanoid.WalkSpeed = 10
                    end
                    
                    if rootPart then
                        rootPart.CFrame = CFrame.new(4362.67, 999.36, -3650.33)
                    end
                end
            end

            game:GetService("RunService"):BindToRenderStep("PPJ10_move", Enum.RenderPriority.Character.Value + 1, function()
                local character = game.Players.LocalPlayer.Character
                if character then
                    local humanoid = character:FindFirstChild("Humanoid")
                    if humanoid then
                        humanoid:Move(Vector3.new(10000, 0, -1), true)
                    end
                end
            end)

            task.spawn(function()
                while getgenv().PPJ10 do
                    task.wait()
                    setupTreadmill()
                end
            end)
        else
            game:GetService("RunService"):UnbindFromRenderStep("PPJ10_move")
        end
    end
})

-- 丛林跑步机20000（开关）
local Tab6Toggle = Tab6Section:Toggle({
    Title = "丛林跑步机20000",
    Desc = "丛林区域高级跑步机，坐标：(-8133.48, 27.98, 2814.74)",
    Default = false,
    Callback = function(isEnabled)
        WindUI:Notify({
            Title = "丛林跑步机20000",
            Content = isEnabled and "✅ 已开启" or "❌ 已关闭",
            Icon = "bolt",
            Duration = 3
        })

        getgenv().PPJ10 = isEnabled
        if isEnabled then
            local function setupTreadmill()
                local character = game.Players.LocalPlayer.Character
                if character then
                    local humanoid = character:FindFirstChild("Humanoid")
                    local rootPart = character:FindFirstChild("HumanoidRootPart")
                    
                    if humanoid then
                        humanoid.WalkSpeed = 10
                    end
                    
                    if rootPart then
                        rootPart.CFrame = CFrame.new(-8133.48, 27.98, 2814.74)
                    end
                end
            end

            game:GetService("RunService"):BindToRenderStep("PPJ10_move", Enum.RenderPriority.Character.Value + 1, function()
                local character = game.Players.LocalPlayer.Character
                if character then
                    local humanoid = character:FindFirstChild("Humanoid")
                    if humanoid then
                        humanoid:Move(Vector3.new(10000, 0, -1), true)
                    end
                end
            end)

            task.spawn(function()
                while getgenv().PPJ10 do
                    task.wait()
                    setupTreadmill()
                end
            end)
        else
            game:GetService("RunService"):UnbindFromRenderStep("PPJ10_move")
        end
    end
})

MainWindow:SetToggleKey(Enum.KeyCode.LeftControl)