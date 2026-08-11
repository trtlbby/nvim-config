return {
  "github/copilot.vim",
  event = "InsertEnter",
  init = function()
    vim.g.copilot_no_tab_map = true
  end,
  config = function()
    vim.keymap.set("i", "<C-l>", 'copilot#Accept("\\<CR>")', {
      expr = true,
      replace_keycodes = false,
      desc = "Accept Copilot suggestion",
    })
    vim.keymap.set("i", "<C-]>", "<Plug>(copilot-dismiss)", { desc = "Dismiss Copilot" })
    vim.keymap.set("i", "<M-]>", "<Plug>(copilot-next)", { desc = "Next Copilot suggestion" })
    vim.keymap.set("i", "<M-[>", "<Plug>(copilot-previous)", { desc = "Previous Copilot suggestion" })
  end,
}
