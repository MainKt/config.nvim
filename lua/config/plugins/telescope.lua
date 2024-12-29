return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      require('telescope').setup {
        pickers = {
          find_files = {
            theme = "ivy",
          },
        },
        extensions = {
          fzf = {},
        },
      }

      require('telescope').load_extension('fzf')

      local telescope = require('telescope.builtin')
      vim.keymap.set("n", "<space>h", telescope.help_tags)
      vim.keymap.set("n", "<space><space>", telescope.find_files)
      vim.keymap.set("n", "<space>fp", function()
        telescope.find_files({
          cwd = vim.fn.stdpath("config")
        })
      end)
    end
  }
}
