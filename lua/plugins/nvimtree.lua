return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<leader>t", ":NvimTreeToggle<CR>", desc = "Toggle file tree" },
    { "<leader>tf", ":NvimTreeFindFile<CR>", desc = "Find current file in tree" },
  },
  opts = {
    view = {
      width = 35,
      side = "left",
    },
    renderer = {
      group_empty = true,
      indent_markers = { enable = true },
    },
    filters = {
      dotfiles = false,
    },
  },
}
