return {
  { "numToStr/Comment.nvim", config = true },
  { "windwp/nvim-autopairs", config = true, event = "InsertEnter" },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "BufReadPost",
    config = true,
  },
}
