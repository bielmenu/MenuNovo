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
	Name = "Toggle",
	Default = false,
	Callback = function(Value)

	end
})

Tab:AddToggle({
	Name = "Fly",
	Default = env.Settings.FlyEnabled,
	Callback = function(Value)
		env.Settings.FlyEnabled = Value
		warn(Value)
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
		warn("Speed ".. Value)
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
