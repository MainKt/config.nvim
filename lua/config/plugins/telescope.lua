return {
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
      extensions = { fzf = {} },
    }

    require('telescope').load_extension('fzf')

    require "config.telescope.multigrep".setup()
  end,
  keys = function()
    local telescope = require('telescope.builtin')
    vim.keymap.set({ 'n', 'v' }, '<leader>*', telescope.grep_string)
    return {
      {
        "<leader>fp",
        function()
          telescope.find_files({
            cwd = vim.fn.stdpath("config")
          })
        end
      },
      {
        "<leader>ep",
        function()
          telescope.find_files({
            cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
          })
        end
      },
      { '<leader><leader>', telescope.find_files },
      { '<leader>j',        telescope.jumplist },
      { "<leader>h",        telescope.help_tags },
      { "<leader>'",        telescope.resume },
      { '<leader>?',        telescope.oldfiles },
      { '<leader>,',        telescope.buffers },
      { '<leader>cx',       telescope.diagnostics },
    }
  end
}
