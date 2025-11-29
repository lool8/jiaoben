getgenv().Interstellar = {
    swing = false,
    sell = false,
    hoops = false,
    spawnedCoins = false,
    buy = false
}
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

-- 主标签页1：主要功能
local Tab3 = MainWindow:Tab({
    Title = "忍者传奇［主要功能］",
    Icon = "bolt"
})

-- 主要功能区域
local Tab3Section = Tab3:Section({
    Title = "核心功能",
    TextSize = 18,
    FontWeight = Enum.FontWeight.SemiBold
})

-- 解锁所有岛屿（按钮）
Tab3Section:Button({
    Title = "解锁所有岛屿",
    Icon = "refresh-cw",
    Color = Color3.fromHex("#000000"),
    Callback = function()
        local islandCoordinates = {
            {Name = "附魔岛", CFrame = CFrame.new(51.17238235473633, 766.1807861328125, -138.44842529296875)},
            {Name = "星界岛", CFrame = CFrame.new(207.2932891845703, 2013.88037109375, 237.36672973632812)},
            {Name = "神秘岛", CFrame = CFrame.new(171.97178649902344, 4047.380859375, 42.0699577331543)},
            {Name = "太空岛", CFrame = CFrame.new(148.83824157714844, 5657.18505859375, 73.5014877319336)},
            {Name = "冻土岛", CFrame = CFrame.new(139.28330993652344, 9285.18359375, 77.36406707763672)},
            {Name = "永恒岛", CFrame = CFrame.new(149.34817504882812, 13680.037109375, 73.3861312866211)},
            {Name = "沙暴岛", CFrame = CFrame.new(133.37144470214844, 17686.328125, 72.00334167480469)},
            {Name = "雷暴岛", CFrame = CFrame.new(143.19349670410156, 24070.021484375, 78.05432891845703)},
            {Name = "远古炼狱岛", CFrame = CFrame.new(141.27163696289062, 28256.294921875, 69.3790283203125)},
            {Name = "午夜暗影岛", CFrame = CFrame.new(132.74267578125, 33206.98046875, 57.495574951171875)},
            {Name = "神秘灵魂岛", CFrame = CFrame.new(137.76148986816406, 39317.5703125, 61.06639862060547)},
            {Name = "冬季奇迹岛", CFrame = CFrame.new(137.2720184326172, 46010.5546875, 55.941951751708984)},
            {Name = "黄金大师岛", CFrame = CFrame.new(128.32339477539062, 52607.765625, 56.69411849975586)},
            {Name = "龙传奇岛", CFrame = CFrame.new(146.35226440429688, 59594.6796875, 77.53300476074219)},
            {Name = "赛博传奇岛", CFrame = CFrame.new(137.3321075439453, 66669.1640625, 72.21722412109375)},
            {Name = "天岚超能岛", CFrame = CFrame.new(135.48077392578125, 70271.15625, 57.02311325073242)},
            {Name = "混沌传奇岛", CFrame = CFrame.new(148.58590698242188, 74442.8515625, 69.3177719116211)},
            {Name = "灵魂融合岛", CFrame = CFrame.new(136.9700927734375, 79746.984375, 58.54051971435547)},
            {Name = "黑暗元素岛", CFrame = CFrame.new(141.697265625, 83198.984375, 72.73107147216797)},
            {Name = "内心和平岛", CFrame = CFrame.new(135.3157501220703, 87051.0625, 66.78429412841797)},
            {Name = "炽烈漩涡岛", CFrame = CFrame.new(135.08216857910156, 91246.0703125, 69.56692504882812)}
        }

        local localPlayer = game.Players.LocalPlayer
        local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

        for i, island in ipairs(islandCoordinates) do
            humanoidRootPart.CFrame = island.CFrame
            WindUI:Notify({
                Title = "解锁岛屿",
                Content = "已传送到：" .. island.Name .. "（" .. i .. "/" .. #islandCoordinates .. "）",
                Icon = "bolt"
            })
            task.wait(2)
        end

        WindUI:Notify({
            Title = "解锁完成",
            Content = "所有岛屿已全部解锁并传送完毕！",
            Icon = "bolt"
        })
    end
})

-- 自动挥舞（开关）
local Tab3Toggle = Tab3Section:Toggle({
    Title = "自动挥舞",
    Desc = "自动挥舞武士刀",
    Default = false,
    Callback = function(isEnabled)
        WindUI:Notify({
            Title = "自动挥舞",
            Content = isEnabled and "✅ 已开启" or "❌ 已关闭",
            Icon = "bolt",
            Duration = 3
        })

        Interstellar.swing = isEnabled
        if isEnabled then
            task.spawn(function()
                local localPlayer = game.Players.LocalPlayer
                for _, v in pairs(localPlayer.Backpack:GetChildren()) do
                    if v:FindFirstChild("attackKatanaScript") then
                        local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
                        character.Humanoid:EquipTool(v)
                        while Interstellar.swing do
                            localPlayer.ninjaEvent:FireServer("swingKatana")
                            task.wait()
                        end
                    end
                end
            end)
        end
    end
})

-- 自动售卖（开关）
local Tab3Toggle = Tab3Section:Toggle({
    Title = "自动售卖",
    Desc = "自动售卖物品",
    Default = false,
    Callback = function(isEnabled)
        WindUI:Notify({
            Title = "自动售卖",
            Content = isEnabled and "✅ 已开启" or "❌ 已关闭",
            Icon = "bolt",
            Duration = 3
        })

        Interstellar.sell = isEnabled
        if isEnabled then
            task.spawn(function()
                local localPlayer = game.Players.LocalPlayer
                while Interstellar.sell do
                    local sellArea = workspace:FindFirstChild("sellAreaCircles")
                    if not sellArea then 
                        task.wait(1)
                        continue 
                    end
                    local targetCircle = nil
                    for _, circle in pairs(sellArea:GetChildren()) do
                        if circle:FindFirstChild("circleInner") then
                            targetCircle = circle.circleInner
                            break
                        end
                    end
                    local character = localPlayer.Character
                    local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
                    if targetCircle and humanoidRootPart then
                        firetouchinterest(targetCircle, humanoidRootPart, 0)
                        firetouchinterest(targetCircle, humanoidRootPart, 1)
                    end
                    task.wait()
                end
            end)
        end
    end
})

-- 主标签页2：收集类
local Tab4 = MainWindow:Tab({
    Title = "忍者传奇［收集类］",
    Icon = "bolt"
})

-- 收集类功能区域
local Tab4Section = Tab4:Section({
    Title = "收集功能",
    TextSize = 18,
    FontWeight = Enum.FontWeight.SemiBold
})

-- 收集所有宝箱（按钮）
Tab4Section:Button({
    Title = "收集所有宝箱",
    Icon = "refresh-cw",
    Color = Color3.fromHex("#000000"),
    Callback = function()
        getgenv().collectChest = true
        local localPlayer = game.Players.LocalPlayer
        local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

        task.spawn(function()
            for _, v in next, workspace:GetChildren() do
                while getgenv().collectChest and v and v.Parent and v.Name:find("Chest") do
                    local circleInner = v:FindFirstChild("circleInner")
                    if circleInner then
                        firetouchinterest(circleInner, humanoidRootPart, 0)
                        firetouchinterest(circleInner, humanoidRootPart, 1)
                    end
                    task.wait(0.5)
                end
            end
            getgenv().collectChest = false
        end)

        WindUI:Notify({
            Title = "收集宝箱",
            Content = "开始自动收集所有宝箱！",
            Icon = "bolt"
        })
    end
})

-- 吸所有环（开关）
local Tab4Toggle1 = Tab4Section:Toggle({
    Title = "吸所有环",
    Desc = "自动吸附所有圆环",
    Default = false,
    Callback = function(isEnabled)
        WindUI:Notify({
            Title = "吸所有环",
            Content = isEnabled and "✅ 已开启" or "❌ 已关闭",
            Icon = "bolt",
            Duration = 3
        })

        Interstellar.hoops = isEnabled
        if isEnabled then
            task.spawn(function()
                local localPlayer = game.Players.LocalPlayer
                while Interstellar.hoops do
                    local character = localPlayer.Character
                    if not character then task.wait(1) continue end
                    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                    if not humanoidRootPart then task.wait(1) continue end

                    -- 移动外层 Hoop
                    if workspace:FindFirstChild("Hoops") then
                        for _, v in ipairs(workspace.Hoops:GetChildren()) do
                            if v.Name == "Hoop" then
                                v.CFrame = humanoidRootPart.CFrame
                            end
                        end
                        task.wait()
                        -- 移动 Hoop 内的 touchPart
                        local mainHoop = workspace.Hoops:FindFirstChild("Hoop")
                        if mainHoop then
                            for _, v in ipairs(mainHoop:GetChildren()) do
                                if v.Name == "touchPart" then
                                    v.CFrame = humanoidRootPart.CFrame
                                end
                            end
                        end
                    end
                    task.wait()
                end
            end)
        end
    end
})

-- 收集气（开关）
local Tab4Toggle = Tab4Section:Toggle({
    Title = "收集气",
    Desc = "自动收集蓝色气箱",
    Default = false,
    Callback = function(isEnabled)
        WindUI:Notify({
            Title = "收集气",
            Content = isEnabled and "✅ 已开启" or "❌ 已关闭",
            Icon = "bolt",
            Duration = 3
        })

        Interstellar.spawnedCoins = isEnabled
        if isEnabled then
            task.spawn(function()
                local localPlayer = game.Players.LocalPlayer
                while Interstellar.spawnedCoins do
                    local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
                    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
                    local valley = game.Workspace:FindFirstChild("spawnedCoins") and game.Workspace.spawnedCoins:FindFirstChild("Valley")
                    if not valley then 
                        task.wait(2)
                        continue 
                    end

                    for _, v in pairs(valley:GetChildren()) do
                        if v.Name == "Blue Chi Crate" then
                            humanoidRootPart.CFrame = CFrame.new(v.Position)
                            task.wait(2)
                        end
                    end
                    task.wait()
                end
            end)
        end
    end
})

-- 收集金币（开关）
local Tab4Toggle = Tab4Section:Toggle({
    Title = "收集金币",
    Desc = "自动收集紫色金币箱",
    Default = false,
    Callback = function(isEnabled)
        WindUI:Notify({
            Title = "收集金币",
            Content = isEnabled and "✅ 已开启" or "❌ 已关闭",
            Icon = "bolt",
            Duration = 3
        })

        Interstellar.spawnedCoins = isEnabled
        if isEnabled then
            task.spawn(function()
                local localPlayer = game.Players.LocalPlayer
                while Interstellar.spawnedCoins do
                    local character = localPlayer.Character
                    if not character then task.wait(1) continue end
                    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                    if not humanoidRootPart then task.wait(1) continue end

                    local valley = game.Workspace:FindFirstChild("spawnedCoins") and game.Workspace.spawnedCoins:FindFirstChild("Valley")
                    if valley then
                        for _, v in pairs(valley:GetChildren()) do
                            if v.Name == "Purple Coin Crate" then
                                humanoidRootPart.CFrame = CFrame.new(v.Position)
                                task.wait(2)
                            end
                        end
                    end
                    task.wait()
                end
            end)
        end
    end
})

-- 主标签页3：自动购买类
local Tab5 = MainWindow:Tab({
    Title = "忍者传奇［自动购买类］",
    Icon = "bolt"
})

-- 自动购买类功能区域
local Tab4Section = Tab5:Section({
    Title = "购买功能",
    TextSize = 18,
    FontWeight = Enum.FontWeight.SemiBold
})

-- 自动买剑（开关）
local Tab5Toggle = Tab5Section:Toggle({
    Title = "自动买剑",
    Desc = "自动购买所有岛屿的剑",
    Default = false,
    Callback = function(isEnabled)
        WindUI:Notify({
            Title = "自动买剑",
            Content = isEnabled and "✅ 已开启" or "❌ 已关闭",
            Icon = "bolt",
            Duration = 3
        })

        Interstellar.buy = isEnabled
        if isEnabled then
            task.spawn(function()
                local localPlayer = game.Players.LocalPlayer
                local buyType = "buyAllSwords"
                local targetIslands = {
                    "Ground", "Astral Island", "Space Island", 
                    "Tundra Island", "Eternal Island", "Sandstorm", 
                    "Thunderstorm", "Ancient Inferno Island", 
                    "Midnight Shadow Island", "Mythical Souls Island", 
                    "Winter Wonder Island"
                }
                while Interstellar.buy do
                    for i = 1, #targetIslands do
                        localPlayer.ninjaEvent:FireServer(buyType, targetIslands[i])
                        task.wait()
                    end
                    task.wait(1) -- 避免购买过快
                end
            end)
        end
    end
})

-- 自动买背包（开关）
local Tab5Toggle = Tab5Section:Toggle({
    Title = "自动买背包",
    Desc = "自动购买所有岛屿的背包",
    Default = false,
    Callback = function(isEnabled)
        WindUI:Notify({
            Title = "自动买背包",
            Content = isEnabled and "✅ 已开启" or "❌ 已关闭",
            Icon = "bolt",
            Duration = 3
        })

        Interstellar.buy = isEnabled
        if isEnabled then
            task.spawn(function()
                local localPlayer = game.Players.LocalPlayer
                local buyType = "buyAllBelts"
                local targetIslands = {
                    "Ground", "Astral Island", "Space Island", 
                    "Tundra Island", "Eternal Island", "Sandstorm", 
                    "Thunderstorm", "Ancient Inferno Island", 
                    "Midnight Shadow Island", "Mythical Souls Island", 
                    "Winter Wonder Island"
                }
                while Interstellar.buy do
                    for i = 1, #targetIslands do
                        localPlayer.ninjaEvent:FireServer(buyType, targetIslands[i])
                        task.wait()
                    end
                    task.wait(1) -- 避免购买过快
                end
            end)
        end
    end
})

-- 自动买技能（开关）
local Tab5Toggle = Tab5Section:Toggle({
    Title = "自动买技能",
    Desc = "自动购买所有岛屿的技能",
    Default = false,
    Callback = function(isEnabled)
        WindUI:Notify({
            Title = "自动买技能",
            Content = isEnabled and "✅ 已开启" or "❌ 已关闭",
            Icon = "bolt",
            Duration = 3
        })

        Interstellar.buy = isEnabled
        if isEnabled then
            task.spawn(function()
                local localPlayer = game.Players.LocalPlayer
                local buyType = "buyAllSkills"
                local targetIslands = {
                    "Ground", "Astral Island", "Space Island", 
                    "Tundra Island", "Eternal Island", "Sandstorm", 
                    "Thunderstorm", "Ancient Inferno Island", 
                    "Midnight Shadow Island", "Mythical Souls Island", 
                    "Winter Wonder Island"
                }
                while Interstellar.buy do
                    for i = 1, #targetIslands do
                        localPlayer.ninjaEvent:FireServer(buyType, targetIslands[i])
                        task.wait()
                    end
                    task.wait(1) -- 避免购买过快
                end
            end)
        end
    end
})

-- 自动买阶级（开关）
local Tab5Toggle = Tab5Section:Toggle({
    Title = "自动买阶级",
    Desc = "自动购买所有阶级",
    Default = false,
    Callback = function(isEnabled)
        WindUI:Notify({
            Title = "自动买阶级",
            Content = isEnabled and "✅ 已开启" or "❌ 已关闭",
            Icon = "bolt",
            Duration = 3
        })

        Interstellar.buy = isEnabled
        if isEnabled then
            task.spawn(function()
                local localPlayer = game.Players.LocalPlayer
                local buyType = "buyRank"
                while Interstellar.buy do
                    local ranksFolder = game:GetService("ReplicatedStorage"):FindFirstChild("Ranks")
                    local groundRanks = ranksFolder and ranksFolder:FindFirstChild("Ground")
                    local targetRanks = groundRanks and groundRanks:GetChildren() or {}
                    
                    for i = 1, #targetRanks do
                        localPlayer.ninjaEvent:FireServer(buyType, targetRanks[i])
                        task.wait()
                    end
                    task.wait(1) -- 减少重复购买频率
                end
            end)
        end
    end
})

-- 自动购买苦无（开关）
local Tab5Toggle = Tab5Section:Toggle({
    Title = "自动购买苦无",
    Desc = "自动购买烈焰漩涡岛苦无",
    Default = false,
    Callback = function(isEnabled)
        WindUI:Notify({
            Title = "自动购买苦无",
            Content = isEnabled and "✅ 已开启" or "❌ 已关闭",
            Icon = "bolt",
            Duration = 3
        })

        if isEnabled then
            task.spawn(function()
                local localPlayer = game.Players.LocalPlayer
                while isEnabled do
                    task.wait()
                    localPlayer.ninjaEvent:FireServer("buyAllShurikens", "Blazing Vortex Island")
                end
            end)
        end
    end
})

-- 主标签页4：其他功能
local Tab6 = MainWindow:Tab({
    Title = "忍者传奇［其他功能］",
    Icon = "bolt"
})

-- 其他功能区域
local Tab6Section = Tab6:Section({
    Title = "辅助功能",
    TextSize = 18,
    FontWeight = Enum.FontWeight.SemiBold
})

-- 吸全部玩家（开关）
local Tab6Toggle = Tab6Section:Toggle({
    Title = "吸全部玩家",
    Desc = "将所有其他玩家吸附到自身前方",
    Default = false,
    Callback = function(isEnabled)
        WindUI:Notify({
            Title = "吸全部玩家",
            Content = isEnabled and "✅ 已开启" or "❌ 已关闭",
            Icon = "bolt",
            Duration = 3
        })

        if isEnabled then
            task.spawn(function()
                local localPlayer = game.Players.LocalPlayer
                while isEnabled do
                    local character = localPlayer.Character
                    if not character then task.wait(1) continue end
                    local localPlayerRoot = character:FindFirstChild("HumanoidRootPart")
                    if not localPlayerRoot then task.wait(1) continue end

                    local localPlayerPosition = localPlayerRoot.Position
                    local direction = localPlayerRoot.CFrame.lookVector
                    local newPosition = localPlayerPosition + direction * 3

                    for _, v in next, game:GetService('Players'):GetPlayers() do
                        if v ~= localPlayer and v.Character then
                            local targetRoot = v.Character:FindFirstChild("HumanoidRootPart")
                            if targetRoot then
                                targetRoot.CFrame = CFrame.new(newPosition, localPlayerPosition + direction * 4)
                            end
                        end
                    end
                    task.wait()
                end
            end)
        end
    end
})

local Run = false -- 初始化自动攻击开关状态

-- 靠近自动攻击(必开)（开关）
local Tab6Toggle = Tab6Section:Toggle({
    Title = "靠近自动攻击(必开)",
    Desc = "靠近敌人自动攻击",
    Default = false,
    Callback = function(isEnabled)
        WindUI:Notify({
            Title = "靠近自动攻击",
            Content = isEnabled and "✅ 已开启" or "❌ 已关闭",
            Icon = "bolt",
            Duration = 3
        })

        if isEnabled then
            -- 原开启逻辑可在此补充（若有需要）
            Run = true
        else
            if getgenv().configs then
                local Disable = getgenv().configs.Disable
                if Disable then
                    Disable:Fire()
                    Disable:Destroy()
                end
                if getgenv().configs.connections then
                    for _, connection in pairs(getgenv().configs.connections) do
                        connection:Disconnect()
                    end
                    table.clear(getgenv().configs.connections)
                end
            end
            Run = false
        end
    end
})

-- 获取所有元素（按钮）
Tab6Section:Button({
    Title = "获取所有元素",
    Icon = "refresh-cw",
    Color = Color3.fromHex("#000000"),
    Callback = function()
        local elementsFolder = game:GetService("ReplicatedStorage"):FindFirstChild("Elements")
        if elementsFolder then
            for _, v in pairs(elementsFolder:GetChildren()) do
                game.ReplicatedStorage.rEvents.elementMasteryEvent:FireServer(v.Name)
            end
            WindUI:Notify({
                Title = "获取元素",
                Content = "所有元素已成功获取！",
                Icon = "bolt"
            })
        else
            WindUI:Notify({
                Title = "错误",
                Content = "未找到元素文件夹！",
                Icon = "bolt"
            })
        end
    end
})

-- 解锁全部通行证（按钮）
Tab6Section:Button({
    Title = "解锁全部通行证",
    Icon = "refresh-cw",
    Color = Color3.fromHex("#000000"),
    Callback = function()
        local gamepassIds = game:GetService("ReplicatedStorage"):FindFirstChild("gamepassIds")
        local ownedGamepasses = game.Players.LocalPlayer:FindFirstChild("ownedGamepasses")
        if gamepassIds and ownedGamepasses then
            local gamepassNames = {
                "+2 Pet Slots", "+3 Pet Slots", "+4 Pet Slots", "+100 Capacity", "+200 Capacity",
                "+20 Capacity", "+60 Capacity", "Infinite Ammo", "Infinite Ninjitsu", "Permanent Islands Unlock",
                "x2 Coins", "x2 Damage", "x2 Health", "x2 Ninjitsu", "x2 Speed",
                "Faster Sword", "x3 Pet Clones"
            }
            for _, name in ipairs(gamepassNames) do
                local gamepass = gamepassIds:FindFirstChild(name)
                if gamepass then
                    gamepass.Parent = ownedGamepasses
                end
            end
            WindUI:Notify({
                Title = "解锁通行证",
                Content = "所有通行证已解锁！",
                Icon = "bolt"
            })
        else
            WindUI:Notify({
                Title = "错误",
                Content = "通行证文件夹不存在！",
                Icon = "bolt"
            })
        end
    end
})

-- 最大跳跃次数（按钮）
Tab6Section:Button({
    Title = "最大跳跃次数",
    Icon = "refresh-cw",
    Color = Color3.fromHex("#000000"),
    Callback = function()
        local localPlayer = game.Players.LocalPlayer
        local multiJumpCount = localPlayer:FindFirstChild("multiJumpCount")
        if multiJumpCount and multiJumpCount:IsA("ValueBase") then
            multiJumpCount.Value = 50
            WindUI:Notify({
                Title = "跳跃次数设置",
                Content = "最大跳跃次数已设置为50！",
                Icon = "bolt"
            })
        else
            WindUI:Notify({
                Title = "错误",
                Content = "未找到跳跃次数配置！",
                Icon = "bolt"
            })
        end
    end
})

MainWindow:SetToggleKey(Enum.KeyCode.LeftControl)