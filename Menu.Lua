local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/tlredz/Library/refs/heads/main/redz-V5-remake/main.luau"))()

local env = (getgenv and getgenv()) or shared or _G

env.Settings = env.Settings or {
	FlySpeed = 100,
	FlyEnabled = false,
	TPEnabled = false,
	AimBotEnabled = false,
}

local Players = game:GetService("Players")
local player = Players.player
local character = player.Character or player.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera

local Window = Library:MakeWindow({
	Title = "Biel Menu",
	SubTitle = "dev by gabriel064",
	ScriptFolder = "Mini City [RP]"
})

local Minimizer = Window:NewMinimizer({
	KeyCode = Enum.KeyCode.LeftControl
})

local MobileButton = Minimizer:CreateMobileMinimizer({
	Image = "rbxassetid://86696933072028",
	BackgroundColor3 = Color3.fromRGB(0, 0, 0)
})

local Tab = Window:MakeTab({
	Title = "Cool Tab",
	Icon = "Home"
})

Tab:AddDiscordInvite({
	Title = "Biel Menu | Loja",
	Description = "A melhor loja de script de Mini City [RP]",
	Banner = "rbxassetid://86696933072028", 
	Logo = "rbxassetid://86696933072028",
	Invite = "https://discord.gg/biel-menu",
	Members = 470000, 
	Online = 20000, 
})

Tab:AddSection("Section")

Tab:AddToggle({
	Name = "Fly",
	Default = env.Settings.FlyEnabled,
	Callback = function(Value)
		Fly(Value)
	end
})

Tab:AddSlider({
	Name = "Velocidade de Voar",
	Min = 50,
	Max = 300,
	Increment = 10,
	Default = env.Settings.FlySpeed,
	Callback = function(Value)
		env.Settings.FlySpeed = Value
	end
})

Tab:AddToggle({
	Name = "Tp em quem matou",
	Default = false,
	Callback = function(Value)
		env.Settings.TPEnabled = Value
	end
})


Tab:AddButton({
	Name = "My Button",
	Debounce = 0.5,
	Callback = function()

	end
})

Tab:AddSlider({
	Name = "Cool Title",
	Min = -5,
	Max = 5,
	Increment = 0.25,
	Default = 0,
	Callback = function(Value)

	end
})

Tab:AddDropdown({
	Name = "Dropdown",
	Options = {"one", "two", "three", "four", "five"},
	Default = "one",
	Callback = function(Value)

	end
})

Tab:AddDropdown({
	Name = "Dropdown 2",
	MultiSelect = true,
	Options = {"one", "two", "three", "four", "five"},
	Default = {"one", "four"},
	Callback = function(Value)

	end
})

Tab:AddTextBox({
	Name = "My TextBox",
	Default = "text",
	Placeholder = "input text...",
	ClearOnFocus = true,
	Callback = function(Value)

	end
})

Tab:AddParagraph("Paragraph", "This is a Paragraph\nSecond Line")

local Parts = {
	"Torso",
	"Head",
	"HumanoidRootPart"
}

local function CanCollide(value)
	for _, part in ipairs(character:GetChildren()) do
		if part:IsA("BasePart") and table.find(Parts, part.Name) then
			part.CanCollide = value
		end
	end
end
local bodyVelocity = nil

function Fly(val)
	env.Settings.FlyEnabled = val
	if val then
		CanCollide(false)
		humanoid.AutoRotate = false
		local GG = Instance.new("BodyVelocity")
		GG.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
		GG.Velocity = Vector3.new(0, 0, 0)
		GG.Parent = rootPart
		bodyVelocity = GG
	else	
		CanCollide(true)
		humanoid.AutoRotate = true
		if bodyVelocity then
			bodyVelocity:Destroy()
			bodyVelocity = nil
		end
	end
end

local aguardando, processados = {}, {}

local function verificarMorte(entidade)
	if not entidade or processados[entidade] then return end

	local hum = entidade:FindFirstChildOfClass("Humanoid")
	if hum and hum.Health <= 0 then
		local creator = hum:FindFirstChild("creator")
		if creator and creator.Value == game.Players.player then
			processados[entidade] = true
			table.insert(aguardando, entidade)
		end
	end
end

function SendCommand(command)
	local remot = game:GetService("ReplicatedStorage"):WaitForChild("RemoteNovos"):WaitForChild("bixobrabo")
	remot:FireServer(command)
	return "GG"
end

local isMobile = true
local Ativado = true

local AimbotSettings = {
	TeamCheck = false,
	FacCheck = true,
	AliveCheck = true,
	LockPart = "Head",
	FOV = 90,
	FOVColor = Color3.fromRGB(85, 0, 127),
	LockedColor = Color3.fromRGB(153, 0, 230),
	Sensitivity = 5,
	BigHead = false
}

local FOVCircle = Drawing.new("Circle")
FOVCircle.Visible = false
FOVCircle.Radius = AimbotSettings.FOV
FOVCircle.Thickness = 2
FOVCircle.Transparency = 1
FOVCircle.Color = AimbotSettings.FOVColor
FOVCircle.Filled = false

local function GetClosestTarget()
	local closestPlayer = nil
	local shortestDistance = AimbotSettings.FOV

	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= player and player.Character and player.Character:FindFirstChild(AimbotSettings.LockPart) then

			if AimbotSettings.FacCheck and player.ValoresSalvados.Faccao.Value == player.ValoresSalvados.Faccao.Value then
				--game.ReplicatedStorage.NotifyClient:Fire("Não Foi Possivel Grudar no "..player.Name.." porque ele é da mesma facção")
				continue
			end


			if AimbotSettings.TeamCheck and player.Team == player.Team then continue end
			if AimbotSettings.AliveCheck then
				local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
				if humanoid and humanoid.Health <= 0 then continue end
			end

			local part = player.Character[AimbotSettings.LockPart]
			local screenPos, onScreen = Camera:WorldToViewportPoint(part.Position)
			if onScreen then
				local inputPos = isMobile and Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
				local distance = (Vector2.new(screenPos.X, screenPos.Y) - inputPos).Magnitude
				if distance < shortestDistance then
					shortestDistance = distance
					closestPlayer = player
				end
			end
		end
	end

	return closestPlayer
end

RunService.RenderStepped:Connect(function(deltaTime)
	if env.Settings.FlyEnabled == true then
		local moveDirection = humanoid.MoveDirection
		
		if not bodyVelocity then
			local GG = Instance.new("BodyVelocity")
			GG.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
			GG.Velocity = Vector3.new(0, 0, 0)
			GG.Parent = rootPart
			bodyVelocity = GG
		end

		if moveDirection.Magnitude > 0 then
			local camera = workspace.CurrentCamera
			local forward = camera.CFrame.LookVector

			bodyVelocity.Velocity = forward * env.Settings.FlySpeed

			local rootCFrame = CFrame.new(rootPart.Position, rootPart.Position + Vector3.new(forward.X, 0, forward.Z))
			rootPart.CFrame = rootCFrame
			CanCollide(false)
			humanoid.AutoRotate = false
		else
			bodyVelocity.Velocity = Vector3.new(0, -1, 0)
		end
	else
		if bodyVelocity then
			bodyVelocity:Destroy()
			bodyVelocity = nil
		end
	end
	
	if env.Settings.TPEnabled == true then
		
		for _, p in ipairs(Players:GetPlayers()) do
			if p ~= player and p.Character then
				verificarMorte(p.Character)
			end
		end

		if #aguardando > 0 then
			local alvo = table.remove(aguardando, 1)
			local char = player.Character
			local root = char and char:FindFirstChild("HumanoidRootPart")

			char:MoveTo(alvo.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0))
			task.wait(0.2)
			SendCommand("/revistar")
		end

	elseif env.Settings.AimBotEnabled == true then
		
		local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

		FOVCircle.Position = isMobile and center or (UserInputService:GetMouseLocation() - Vector2.new(0, 36))


		for _, player in ipairs(Players:GetPlayers()) do
			if player ~= player and player.Character and player.Character:FindFirstChild("Head") then
				local head = player.Character.Head

				if Ativado then
					if not head:FindFirstChild("AimbotMod") then
						local mod = Instance.new("BoolValue")
						mod.Name = "AimbotMod"
						mod.Parent = head
						if AimbotSettings.BigHead then
							head.Size = Vector3.new(6, 6, 6)
							head.Transparency = 1
							local face = head:FindFirstChild("face")
							if face then face.Transparency = 1 end
						end

					end
				else
					if head:FindFirstChild("AimbotMod") then
						head.Size = Vector3.new(1, 1, 1)
						head.Transparency = 0
						local face = head:FindFirstChild("face")
						if face then face.Transparency = 0 end
						head:FindFirstChild("AimbotMod"):Destroy()
					end
				end
			end
		end

		local target = GetClosestTarget()

		if target and target.Character and target.Character:FindFirstChild(AimbotSettings.LockPart) then
			FOVCircle.Color = AimbotSettings.LockedColor
			local part = target.Character[AimbotSettings.LockPart]
			local goalCFrame = CFrame.new(Camera.CFrame.Position, part.Position)
			Camera.CFrame = Camera.CFrame:Lerp(goalCFrame, 1)
		else
			FOVCircle.Color = AimbotSettings.FOVColor
		end
		
	end
	
end)
