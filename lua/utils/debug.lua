Util.dapStart = function()
	local dapui = require("dapui")
	dapui.open({})
end

Util.dapStop = function()
	local dap = require("dap")
	local dapui = require("dapui")

	if dap.session() then
		dap.disconnect()
	end

	dap.close()
	dapui.close({})
end
