local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/tlredz/Library/refs/heads/main/redz-V5-remake/main.luau"))()

local env = (getgenv and getgenv()) or shared or _G

env.Settings = env.Settings or {
	FlySpeed = 100,
	FlyEnabled = false
}


local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")
local RunService = game:GetService("RunService")

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
		env.Settings.FlyEnabled = Value
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
	Name = "Toggle",
	Default = false,
	Callback = function(Value)

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
RunService.RenderStepped:Connect(function(deltaTime)
	if env.Settings.FlyEnabled == true then
		local moveDirection = humanoid.MoveDirection
		humanoid.AutoRotate = false
		
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
		else
			bodyVelocity.Velocity = Vector3.new(0, -1, 0)
		end
	else
		if bodyVelocity then
			bodyVelocity:Destroy()
			bodyVelocity = nil
		end
	end
end)
