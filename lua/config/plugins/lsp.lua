return {
  "neovim/nvim-lspconfig",
  lazy = false,
  dependencies = {
    'saghen/blink.cmp',
    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
    { "williamboman/mason.nvim", opts = {} },
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    local capabilities = require('blink.cmp').get_lsp_capabilities()

    require("mason-lspconfig").setup {
      handlers = {
        function(server)
          require("lspconfig")[server].setup { capabilities = capabilities }
        end
      }
    }

    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        local c = vim.lsp.get_client_by_id(args.data.client_id)

        if not c then return end

        if c:supports_method('textDocument/formatting') then
          vim.api.nvim_create_autocmd('BufWritePre', {
            buffer = args.buf,
            callback = function()
              vim.lsp.buf.format({ bufnr = args.buf, id = c.id })
            end,
          })
        end
      end,
    })
  end,
  keys = { { "<space>=", vim.lsp.buf.format } },
}
