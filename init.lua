require("config.lazy")

vim.keymap.set("n", "<Space>%", "<cmd>source %<CR>")
vim.keymap.set("n", "<Space>x", ":.lua<CR>")
vim.keymap.set("v", "<Space>x", ":lua<CR>")
vim.keymap.set("n", "<Space>w", "<C-W>")

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking",	
	group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
	callback = function() vim.highlight.on_yank() end,
})
