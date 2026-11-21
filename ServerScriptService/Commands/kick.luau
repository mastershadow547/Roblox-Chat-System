local Players = game:GetService("Players")
local kick = {}

function kick.Execute(Player: Player, args: {string})
	if #args < 1 then
		warn("Usage: /kick [playerName or me] [Reason - Optional]")
		return
	end

	local targetName = args[1]:lower()
	local targetPlayer

	if targetName == "me" then
		targetPlayer = Player
	else
		for _, p in pairs(Players:GetPlayers()) do
			if string.lower(p.Name):sub(1, #targetName) == targetName then
				targetPlayer = p
				break
			end
		end
	end

	if not targetPlayer then
		warn("Target player not found.")
		return
	end

	local reason = "No reason provided."
	if #args >= 2 then
		reason = table.concat(args, " ", 2)
	end

	targetPlayer:Kick("You have been kicked by " .. Player.Name .. " for: " .. reason)
end

return kick
