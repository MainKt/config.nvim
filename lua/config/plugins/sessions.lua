return {
  'rmagatti/auto-session',
  lazy = false,
  opts = {
    auto_create = true,
    auto_save = true,
    suppressed_dirs = { '~/', '~/projects', '~/downloads', '/' },
  },
  keys = {
    {
      "<leader><Tab>",
      function()
        vim.cmd("SessionSave")
        vim.cmd("SessionSearch")
      end
    },
  },
}
