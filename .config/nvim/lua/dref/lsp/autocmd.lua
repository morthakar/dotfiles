local M = {}
local augroup_format = vim.api.nvim_create_augroup("my_lsp", { clear = true })

local function org_imports(wait_ms)
	local params = vim.lsp.util.make_range_params()
	params.context = { only = { "source.organizeImports" } }
	local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
	for _, res in pairs(result or {}) do
		for _, r in pairs(res.result or {}) do
			if r.edit then
				vim.lsp.util.apply_workspace_edit(r.edit, "UTF-8")
			else
				vim.lsp.buf.execute_command(r.command)
			end
		end
	end
end

M.format_on_save = function()
	vim.api.nvim_clear_autocmds { buffer = 0, group = augroup_format }
	vim.api.nvim_create_autocmd("BufWritePre", {
		buffer = 0,
		callback = function()
			vim.lsp.buf.format()
		end,
	})
end

M.org_imports = function()
	vim.api.nvim_clear_autocmds { buffer = 0, group = augroup_format }
	vim.api.nvim_create_autocmd("BufWritePre", {
		buffer = 0,
		callback = function()
			org_imports(3000)
		end,
	})
end

M.document_highlight = function()
	vim.api.nvim_clear_autocmds { buffer = 0, group = augroup_format }
	vim.api.nvim_create_autocmd("CursorHold", {
		buffer = 0,
		callback = function()
			vim.lsp.buf.document_highlight()
		end,
	})
end

M.document_highlight_clear = function()
	vim.api.nvim_clear_autocmds { buffer = 0, group = augroup_format }
	vim.api.nvim_create_autocmd("CursorMoved", {
		buffer = 0,
		callback = function()
			vim.lsp.buf.clear_references()
		end,
	})
end

M.remove_space = function()
	vim.api.nvim_clear_autocmds { buffer = 0, group = augroup_format }
	vim.api.nvim_create_autocmd("BufWritePre", {
		buffer = 0,
		command = "%s/\\s\\+$//e",
	})
end

return M
