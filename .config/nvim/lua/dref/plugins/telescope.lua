local nmap = require("dref.utils.keymap").nmap
return {
	 'nvim-telescope/telescope.nvim', tag = '0.1.5',
         dependencies = { 'nvim-lua/plenary.nvim' },
	 config = function()
		 -- Telescope
		 nmap({ "<leader>sf", require('telescope.builtin').oldfiles, { desc = '[S]earch [H]elp' }, opts })
		 nmap({ "<leader>sd", require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' }, opts })
		 nmap({ "<leader>?", require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' }, opts })
		 nmap({ "<leader>b", require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' }, opts })
		 nmap({ "<leader>f", require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' }, opts })
		 nmap({ "<leader>g", require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' }, opts })
	 end
}
