return {
  "stevearc/oil.nvim",
  lazy = false,
  opts = {
    default_file_explorer = true,
    skip_confirm_for_simple_edits = true,
  },
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  keys = { { "-", ":Oil<Cr>" } },
}
