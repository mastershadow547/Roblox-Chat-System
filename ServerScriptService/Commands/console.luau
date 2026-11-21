local ReplicatedStorage = game:GetService("ReplicatedStorage")
local console = {}

function console.Execute(Player: Player)
	local remote = ReplicatedStorage.Chatted.ShowConsole
	if remote then
		remote:FireClient(Player)
	end
end

return console
