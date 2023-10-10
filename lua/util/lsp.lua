Util.getClientByName = function(name)
	local clients = vim.lsp.get_clients()
	for _, cl in pairs(clients) do
		if cl.name == name then
			return cl
		end
	end
end

Util.codeAction = function(clientName, action, only, hdlr)
	local params = vim.lsp.util.make_range_params()
	if only then
		params.context = { only = { only } }
	end
	local bufnr = vim.api.nvim_get_current_buf()
	vim.lsp.buf_request_all(
		bufnr,
		"textDocument/codeAction",
		params,
		function(result)
			if not result or next(result) == nil then
				return
			end
			local c = Util.getClientByName(clientName)
			for _, res in pairs(result) do
				for _, r in pairs(res.result or {}) do
					if r.edit and not vim.tbl_isempty(r.edit) then
						local re = vim.lsp.util.apply_workspace_edit(
							r.edit,
							c.offset_encoding
						)
					end
					if type(r.command) == "table" then
						if
							type(r.command) == "table" and r.command.arguments
						then
							for _, arg in pairs(r.command.arguments) do
								if action == nil or arg["Fix"] == action then
									vim.lsp.buf.execute_command(r.command)
									return
								end
							end
						end
					end
				end
			end
			if hdlr then
				hdlr(result)
			end
		end
	)
end
