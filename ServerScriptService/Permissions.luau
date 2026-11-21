local Permissions = {
	[1] = {
		Name = "Permission_1",
		Commands = {"console"}
	},
	[2] = {
		Name = "Permission_2",
		Commands = {"console", "speed", "jumppower"},
		Admins = {4251613961} -- remove one to make your userid
	},
	[3] = {
		Name = "Permission_3",
		Commands = {"console", "speed", "jumppower", "kick"},
		Admins = {425161396}
	}
}

return Permissions
