return {
  {
    "coffebar/neovim-project",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "Shatur/neovim-session-manager",
    },
    opts = {
      projects = {
        "E:/800 Workspace/*",
        "C:/Users/bacsa/Workspace/*",
        "C:/Users/bacsa/AppData/Local/nvim"
      },
      picker = { type = "telescope" },
    },
    init = function()
      vim.opt.sessionoptions:append("globals")
    end,
    keys = {
      { "<leader>fp", ":NeovimProjectDiscover<CR>", desc = "Find project" },
      { "<leader>fP", ":NeovimProjectHistory<CR>", desc = "Recent projects" },
    },
  },
}
