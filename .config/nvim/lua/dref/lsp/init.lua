local servers = require('dref.lsp.servers')
local autocmd = servers.get_autocmd()

servers.attachFiletypeOpt({
	go = function()
		autocmd.format_on_save()
		autocmd.org_imports()
		autocmd.remove_space()
	end,
	lua = function()
		autocmd.format_on_save()
		autocmd.remove_space()
	end,
	rust = function()
		autocmd.format_on_save()
	end,
	vlang = function()
		autocmd.format_on_save()
	end,
	python = function()
		autocmd.format_on_save()
	end,
	svelte = function()
		autocmd.format_on_save()
	end,
	html = function()
		autocmd.format_on_save()
	end

})


--local null_ls = require("null-ls")
--null_ls.setup({
--	sources = {
--		null_ls.builtins.formatting.black,
--		null_ls.builtins.formatting.prettier,
--		null_ls.builtins.diagnostics.mypy,
--		null_ls.builtins.diagnostics.ruff,
--	},
--})

--local rt = require("rust-tools").setup(
--	{
--		server = {
--			on_attach = servers.on_attach },
--	}
--)

servers.setup({
	html = {},
	svelte = {},
	pyright = {},
	gopls = {},
	lua_ls = {},
})


--require("symbols-outline").setup({
--	highlight_hovered_item = true,
--	show_guides = true,
--})
