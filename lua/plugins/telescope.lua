return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>ff", ":Telescope find_files<CR>", desc = "Find files" },
    { "<leader>fg", ":Telescope live_grep<CR>", desc = "Grep project" },
    { "<leader>fb", ":Telescope buffers<CR>", desc = "Buffers" },
    { "<leader>fh", ":Telescope help_tags<CR>", desc = "Help tags" },
    { "<leader>fp", ":Telescope projects<CR>", desc = "Find projects" },
  },
}
