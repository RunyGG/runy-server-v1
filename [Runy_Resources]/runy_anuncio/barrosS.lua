addCommandHandler(global.Comando, function(playerSource, cmd, ...)
	if not isGuestAccount(getPlayerAccount(playerSource)) then
		local accountName = getAccountName(getPlayerAccount(playerSource))
		if isObjectInACLGroup("user." .. accountName, aclGetGroup("Console")) then
			local text = table.concat({...}, " ")
			triggerClientEvent(root, "barros:anuncioStaff", playerSource, text)
		else
			print("não tem permissão")
		end
	end
end)