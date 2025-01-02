require("config.lazy")

vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.shell = "/usr/bin/zsh"
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.updatetime = 250

vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })

vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

vim.keymap.set('n', "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set('n', "<leader>fs", ":w<Cr>")
vim.keymap.set("n", "<leader>%", "<cmd>source %<CR>")
vim.keymap.set("n", "<leader>x", ":.lua<CR>")
vim.keymap.set("v", "<leader>x", ":lua<CR>")
vim.keymap.set("n", "<leader>w", "<C-W>")
vim.keymap.set('n', "<leader>ce", vim.diagnostic.open_float)

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>')

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking",
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function() vim.highlight.on_yank() end,
})

vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
    vim.cmd.startinsert()
  end,
})
