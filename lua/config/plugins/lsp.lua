return {
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
      'saghen/blink.cmp',
      {
        "ray-x/lsp_signature.nvim",
        opts = {},
      },
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

      local lspconfig = require('lspconfig')
      require("mason-lspconfig").setup {
        handlers = {
          function(server)
            lspconfig[server].setup { capabilities = capabilities }
          end
        }
      }

      lspconfig.sourcekit.setup {
        capabilities = capabilities,
        on_init = function(client)
          client.server_capabilities.diagnosticProvider = {
            interFileDependencies = true,
            workspaceDiagnostics = false,
          }
        end,
        on_attach = function(client, bufnr)
          if client.name == "sourcekit" then
            vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end
          end
        end,
      }

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local c = vim.lsp.get_client_by_id(args.data.client_id)

          if not c then return end

          if c.name == "sourcekit" and vim.bo[args.buf].filetype ~= "swift" then
            vim.lsp.stop_client(c.id)
            return
          end

          if string.find(args.file, "xmake", 1, true) then return end

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

      vim.diagnostic.config({ virtual_text = true })
    end,
    keys = { { "<leader>=", vim.lsp.buf.format } },
  },
  {
    "scalameta/nvim-metals",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    ft = { "scala", "sbt", "java" },
    opts = function()
      local metals_config = require("metals").bare_config()
      metals_config.capabilities = require('blink.cmp').get_lsp_capabilities()
      metals_config.on_attach = function(_client, _bufnr) end
      return metals_config
    end,
    config = function(self, metals_config)
      local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = self.ft,
        callback = function()
          require("metals").initialize_or_attach(metals_config)
        end,
        group = nvim_metals_group,
      })
    end
  }
}
