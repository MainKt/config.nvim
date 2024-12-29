return {
  'echasnovski/mini.nvim',
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  config = function()
    require('mini.statusline').setup { use_icons = true }

    local spec_treesitter = require('mini.ai').gen_spec.treesitter
    require("mini.ai").setup {
      custom_textobjects = {
        F = spec_treesitter({ a = '@function.outer', i = '@function.inner' }),
        o = spec_treesitter({
          a = { '@conditional.outer', '@loop.outer' },
          i = { '@conditional.inner', '@loop.inner' },
        })
      }
    }
  end
}
