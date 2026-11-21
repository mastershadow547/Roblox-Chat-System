local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextChatService = game:GetService("TextChatService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer

local GUI = script.Parent.Parent
local ChatFrame = GUI.ChatFrame
local ChatIcon = GUI.ChatIcon
local SendButton = ChatFrame.SendButton
local TextInput = ChatFrame.TextInput
local TextFrame = ChatFrame.TextFrame

local ChatFunctions = {}

function ChatFunctions.ChatIconClicked()
	local isOpen = ChatIcon:GetAttribute("ChatBoolean")
	if isOpen then
		ChatIcon:SetAttribute("ChatBoolean", false)
		TextInput:SetAttribute("CanUseEnter", false)
		ChatIcon.BackgroundColor3 = Color3.new(0, 0, 0)
		ChatIcon.ImageColor3 = Color3.new(0, 0, 0)
		ChatFrame.Visible = false
	else
		ChatIcon:SetAttribute("ChatBoolean", true)
		TextInput:SetAttribute("CanUseEnter", true)
		ChatIcon.BackgroundColor3 = Color3.new(1, 1, 1)
		ChatIcon.ImageColor3 = Color3.new(1, 1, 1)
		ChatFrame.Visible = true
	end
end

function ChatFunctions.ChangeSendButtonColor()
	SendButton.TextColor3 = TextInput.Text ~= "" and Color3.new(1, 1, 1) or Color3.new(0, 0, 0)
end

function ChatFunctions.ChatSendClicked()
	local Text = TextInput.Text
	Text = Text:match("^%s*(.-)%s*$")

	if Text ~= "" then
		Text = string.sub(Text, 1, 200)
		ReplicatedStorage.Chatted:FireServer(Text)
		TextInput.Text = ""
	else
		warn("No message to send")
	end
end

function ChatFunctions.RecievedChat(fromPlayer: Player, TextChatted: string)
	if fromPlayer and TextChatted then
		local chatText = script.ChatText:Clone()
		chatText.Text = fromPlayer.Name .. ": " .. TextChatted
		chatText.Player.Value = fromPlayer
		chatText.Parent = TextFrame
		TextChatService:DisplayBubble(fromPlayer.Character, TextChatted)
		ChatFunctions.DeleteOldChats(10) -- the max chats
		--TextFrame.CanvasPosition = Vector2.new(0, TextFrame.AbsoluteCanvasSize.Y)
	end
end

function ChatFunctions.DeleteOldChats(Max: number)
	local children = TextFrame:GetChildren()
	local total = 0
	for _, child in ipairs(children) do
		if child:IsA("TextLabel") then
			total += 1
		end
	end

	while total > Max do
		for _, child in ipairs(TextFrame:GetChildren()) do
			if child:IsA("TextLabel") then
				child:Destroy()
				total -= 1
				break
			end
		end
	end
end

return ChatFunctions
