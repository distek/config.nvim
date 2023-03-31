T = require("nvim-terminal")

TF = TF

Util.TermToggle = function()
	NeoTreeWasOpen = false
	local preCB = function()
		NeoTreeWasOpen = Util.is_neotree_open()

		if NeoTreeWasOpen then
			vim.cmd("Neotree close")
		end
	end

	local postCB = function()
		if NeoTreeWasOpen then
			vim.cmd("Neotree open")
			NeoTreeWasOpen = false
		end
	end

	TF.TermToggle(preCB, postCB)
end

Util.TermPick = function()
	NeoTreeWasOpen = false
	local preCB = function()
		NeoTreeWasOpen = Util.is_neotree_open()

		if NeoTreeWasOpen then
			vim.cmd("Neotree close")
		end
	end

	local postCB = function()
		if NeoTreeWasOpen then
			vim.cmd("Neotree open")
			NeoTreeWasOpen = false
		end
	end

	TF.TermPick(preCB, postCB)
end

Util.TermNew = function()
	NeoTreeWasOpen = false
	local preCB = function()
		NeoTreeWasOpen = Util.is_neotree_open()

		if NeoTreeWasOpen then
			vim.cmd("Neotree close")
		end
	end

	local postCB = function()
		if NeoTreeWasOpen then
			vim.cmd("Neotree open")
			NeoTreeWasOpen = false
		end
	end

	TF.TermNew(preCB, postCB)
end
