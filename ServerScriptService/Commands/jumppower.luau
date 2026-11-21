local Players = game:GetService("Players")
local jumppower = {}

function jumppower.Execute(player: Player, args: {string})
	if #args < 2 then
		warn("Usage: /speed [playerName or me] [JumpHeight]")
		return
	end

	local targetName = args[1]:lower()
	local newJumpPower = tonumber(args[2])

	if not newJumpPower then
		warn("Invalid JumpHeight value: " .. tostring(args[2]))
		return
	end

	local targetPlayer

	if targetName == "me" then
		targetPlayer = player
	else
		for _, p in pairs(Players:GetPlayers()) do
			if string.lower(p.Name):sub(1, #targetName) == targetName then
				targetPlayer = p
				break
			end
		end
	end

	if targetPlayer and targetPlayer.Character then
		local humanoid = targetPlayer.Character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			humanoid.JumpHeight = newJumpPower
			print(player.Name .. " set " .. targetPlayer.Name .. "'s JumpHeight to " .. newJumpPower)
		end
	else
		warn("Target player not found or has no character.")
	end
end

return jumppower
