local Players = game:GetService("Players")
local speed = {}

function speed.Execute(player: Player, args: {string})
	if #args < 2 then
		warn("Usage: /speed [playerName or me] [speed]")
		return
	end

	local targetName = args[1]:lower()
	local newSpeed = tonumber(args[2])

	if not newSpeed then
		warn("Invalid speed value: " .. tostring(args[2]))
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
			humanoid.WalkSpeed = newSpeed
			print(player.Name .. " set " .. targetPlayer.Name .. "'s speed to " .. newSpeed)
		end
	else
		warn("Target player not found or has no character.")
	end
end

return speed
