return {
  'rmagatti/auto-session',
  lazy = false,
  opts = {
    auto_create = true,
    suppressed_dirs = { '~/', '~/projects', '~/downloads', '/' },
  },
  keys = {
    { "<leader>s", "<cmd>SessionSearch<cr>" },
  },
}
