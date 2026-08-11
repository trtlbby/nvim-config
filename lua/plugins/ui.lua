return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
	transparent_background = true,
        integrations = {
          cmp = true,
          gitsigns = true,
          treesitter = true,
          telescope = true,
          which_key = true,
          indent_blankline = { enabled = true },
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {
      options = {
        globalstatus = true,
      },
      sections = {
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "encoding", "filetype" },
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        separator_style = "slant",
        show_buffer_close_icons = true,
        offsets = {
          { filetype = "oil", text = "File Explorer", separator = true, padding = 1 },
        },
      },
    },
  },
}
