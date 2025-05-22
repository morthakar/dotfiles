return {
  "nvim-telescope/telescope.nvim",
  event = "VimEnter",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable "make" == 1
      end,
    },
    { "nvim-telescope/telescope-ui-select.nvim" },
    { "nvim-tree/nvim-web-devicons" },
  },
  config = function()
    -- [[ Configure Telescope ]]
    require("telescope").setup {
      -- defaults = {
      --   mappings = {
      --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
      --   },
      -- },
      -- pickers = {}
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
      },
    }

    -- Enable telescope extensions, if they are installed
    pcall(require("telescope").load_extension, "fzf")
    pcall(require("telescope").load_extension, "ui-select")

    -- See `:help telescope.builtin`
    local builtin = require "telescope.builtin"
    vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Search [F]iles" })
    vim.keymap.set("n", "<leader>h", builtin.help_tags, { desc = "Search [H]elp" })
    vim.keymap.set("n", "<leader>k", builtin.keymaps, { desc = "Search [K]eymaps" })
    vim.keymap.set("n", "<leader>w", builtin.grep_string, { desc = "Search current [W]ord" })
    vim.keymap.set("n", "<leader>g", builtin.live_grep, { desc = "Search by [G]rep" })
    vim.keymap.set("n", "<leader>d", builtin.diagnostics, { desc = "Search [D]iagnostics" })
    vim.keymap.set("n", "<leader>r", builtin.registers, { desc = "Search [R]esume" })
    vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Search existing buffers" })
    vim.keymap.set("n", "<leader>.", builtin.oldfiles, { desc = 'Search Recent Files ("." for repeat)' })

    -- Slightly advanced example of overriding default behavior and theme
    vim.keymap.set("n", "g/", function()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = "[/] Fuzzily search in current buffer" })

    -- Also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set("n", "<leader>s/", function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = "Live Grep in Open Files",
      }
    end, { desc = "[S]earch [/] in Open Files" })

    -- Shortcut for searching your neovim configuration files
    vim.keymap.set("n", "<leader>c", function()
      builtin.find_files { cwd = vim.fn.stdpath "config" }
    end, { desc = "Search Neovim files" })

    vim.keymap.set("n", "<leader><leader>", function()
      builtin.find_files { cwd = "~" }
    end, { desc = "[S]earch [H]ome files" })
  end,
}
