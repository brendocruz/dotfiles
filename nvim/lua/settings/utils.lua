function PrintTable(table)
	print(vim.inspect(table))
end

function PrintLspClients()
	PrintTable(vim.lsp.get_active_clients())
end

function ReloadFile()
	vim.cmd(":source %")
end
