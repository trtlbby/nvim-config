return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<leader>xx", ":Trouble diagnostics toggle<CR>", desc = "Toggle diagnostics" },
  },
  config = true,
}
