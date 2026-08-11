return {
  {
    "ahmedkhalf/project.nvim",
    main = "project_nvim",
    event = "VeryLazy",
    config = function()
      require("project_nvim").setup({
        detection_methods = { "pattern" },
        patterns = { ".git", "package.json", "compile_flags.txt", "pyproject.toml", "*.sln" },
      })
      require("telescope").load_extension("projects")
    end,
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
    keys = {
      { "<leader>qs", function() require("persistence").load() end, desc = "Restore session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore last session" },
    },
  },
}
