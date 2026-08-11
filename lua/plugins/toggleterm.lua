return {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {
    open_mapping = [[<C-t>]],
    direction = "float",
    float_opts = {
      border = "rounded",
      width = function() return math.floor(vim.o.columns * 0.85) end,
      height = function() return math.floor(vim.o.lines * 0.8) end,
    },
    start_in_insert = true,
  },
  keys = {
    { "<C-t>", desc = "Toggle terminal" },
  },
}
