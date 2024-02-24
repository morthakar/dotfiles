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


servers.setup({
	html = {},
	svelte = {},
	pyright = {},
	gopls = {},
	lua_ls = {},
	rust_analyzer = {},
})
