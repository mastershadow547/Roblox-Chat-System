local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Chatted = ReplicatedStorage:FindFirstChild("Chatted")
if not Chatted then
	Chatted = Instance.new("RemoteEvent")
	Chatted.Parent = ReplicatedStorage
	Chatted.Name = "Chatted"
end

local ChattedBindable = Chatted:FindFirstChild("ChattedBindable")
if not ChattedBindable then
	ChattedBindable = Instance.new("BindableEvent")
	ChattedBindable.Parent = Chatted
	ChattedBindable.Name = "ChattedBindable"
end

local ShowConsole = Chatted:FindFirstChild("ShowConsole")
if not ShowConsole then
	ShowConsole = Instance.new("RemoteEvent")
	ShowConsole.Parent = Chatted
	ShowConsole.Name = "ShowConsole"
end

Chatted.OnServerEvent:Connect(function(Player: Player, TextChatted: string)
	TextChatted = TextChatted:sub(1, 200):gsub("^%s*(.-)%s*$", "%1")

	if TextChatted ~= "" then
		ReplicatedStorage.Chatted:FireAllClients(Player, TextChatted)
		ReplicatedStorage.Chatted.ChattedBindable:Fire(Player, TextChatted)
	end
end)
