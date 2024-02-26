local nmap = require("dref.utils.keymap").nmap
return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.5',
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function()
		-- Telescope
		nmap("<leader>sf", require('telescope.builtin').oldfiles, '[S]earch [H]elp')
		nmap("<leader>sd", require('telescope.builtin').diagnostics, '[S]earch [D]iagnostics')
		nmap("<leader>?", require('telescope.builtin').help_tags, '[S]earch [H]elp')
		nmap("<leader>b", require('telescope.builtin').buffers, '[ ] Find existing buffers')
		nmap("<leader>f", require('telescope.builtin').find_files, '[S]earch [F]iles')
		nmap("<leader>g", require('telescope.builtin').live_grep, '[S]earch by [G]rep')
	end
}
