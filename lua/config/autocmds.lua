vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local opts = { buffer = args.buf }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.hl.on_yank()
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "lua", "javascript", "typescript", "html", "css", "json" },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
  end,
})
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
    vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = normal.bg })
  end,
})
vim.api.nvim_create_autocmd({ "VimEnter", "WinNew", "BufWinEnter" }, {
  callback = function()
    vim.opt_local.fillchars = { eob = " " }
  end,
})
