local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ChattedBindable = ReplicatedStorage.Chatted.ChattedBindable
local CommandFunctions = require(script.CommandFunctions)
local CommandFolder = script.Commands

local Prefix = "/"

ChattedBindable.Event:Connect(function(Player: Player, TextChatted: string)
	if not Player or not TextChatted then return end

	if string.sub(TextChatted, 1, 1) == Prefix then
		local split = string.split(TextChatted, " ")
		local CommandName = string.sub(split[1], 2):lower()
		local args = {}
		for i = 2, #split do
			table.insert(args, split[i])
		end

		if CommandFunctions.IsAllowedToRunCommand(Player, CommandName) then
			local CommandModule = CommandFolder:FindFirstChild(CommandName)
			if CommandModule and CommandModule:IsA("ModuleScript") then
				local success, command = pcall(require, CommandModule)
				if success and command.Execute then
					command.Execute(Player, args)
				else
					warn("Failed to run command: " .. CommandName)
				end
			else
				warn("Command module not found: " .. CommandName)
			end
		else
			warn(Player.Name .. " tried to run unauthorized command: " .. CommandName)
		end
	end
end)

Players.PlayerAdded:Connect(CommandFunctions.OnPlayerAdded)
