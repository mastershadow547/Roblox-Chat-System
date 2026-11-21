local Permissions = require(script.Parent.Permissions)
local CommandFunctions = {}

function CommandFunctions.GetPlayerPermissionLevel(player: Player): number
	for level, data in pairs(Permissions) do
		if data.Admins and table.find(data.Admins, player.UserId) then
			return level
		end
	end
	return 1
end

function CommandFunctions.IsAllowedToRunCommand(player: Player, commandName: string): boolean
	if not player or not commandName then
		return false
	end
	
	local CommandNameLowercased = string.lower(commandName)
	local level = CommandFunctions.GetPlayerPermissionLevel(player)
	local permissionData = Permissions[level]
	if not permissionData then
		return false
	end

	if table.find(permissionData.Commands, CommandNameLowercased) then
		if permissionData.Admins then
			return table.find(permissionData.Admins, player.UserId) ~= nil
		end
		return true
	end

	return false
end

function CommandFunctions.OnPlayerAdded(Player: Player)
	if Player then
		local level = CommandFunctions.GetPlayerPermissionLevel(Player)
		local permissionData = Permissions[level]

		local adminPermissions = Instance.new("Folder")
		adminPermissions.Name = "AdminPermissions"
		adminPermissions.Parent = Player

		local permissionLevelInt = Instance.new("IntValue")
		permissionLevelInt.Name = "PermissionLevel"
		permissionLevelInt.Value = level
		permissionLevelInt.Parent = adminPermissions

		for _, command in ipairs(permissionData.Commands) do
			local canUseCommand = Instance.new("BoolValue")
			canUseCommand.Name = command
			canUseCommand.Value = true
			canUseCommand.Parent = permissionLevelInt
		end
	end
end


return CommandFunctions
