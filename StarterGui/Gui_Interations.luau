local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer

local GUI = script.Parent.Parent
local ChatFrame = GUI.ChatFrame
local ChatIcon = GUI.ChatIcon
local SendButton = ChatFrame.SendButton
local TextInput = ChatFrame.TextInput

local ChatFunction = require(script.Parent.ChatFunctions)

ChatIcon:SetAttribute("ChatBoolean", false)
TextInput:SetAttribute("CanUseEnter", false)

ChatIcon.MouseButton1Click:Connect(ChatFunction.ChatIconClicked)

SendButton.MouseButton1Click:Connect(ChatFunction.ChatSendClicked)

TextInput:GetPropertyChangedSignal("Text"):Connect(ChatFunction.ChangeSendButtonColor)

UserInputService.InputBegan:Connect(function(Input: InputObject, GameProcessedEvent: boolean)
	if Input.KeyCode == Enum.KeyCode.Return or Input.KeyCode == Enum.KeyCode.KeypadEnter then
		if TextInput:GetAttribute("CanUseEnter") == true then
			ChatFunction.ChatSendClicked()
		end
	elseif Input.KeyCode == Enum.KeyCode.Slash then
		ChatIcon:SetAttribute("ChatBoolean", true)
		TextInput:SetAttribute("CanUseEnter", true)
		ChatIcon.BackgroundColor3 = Color3.new(1, 1, 1)
		ChatIcon.ImageColor3 = Color3.new(1, 1, 1)
		ChatFrame.Visible = true
		if not TextInput:IsFocused() then
			TextInput:CaptureFocus()
		end
	end
end)

ReplicatedStorage.Chatted.OnClientEvent:Connect(ChatFunction.RecievedChat)
