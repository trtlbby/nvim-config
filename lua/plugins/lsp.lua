return {
  { "williamboman/mason.nvim", config = true },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "html", "cssls", "ts_ls", "tailwindcss", "emmet_ls",
        "pyright", "ruff", "clangd",
      },
      automatic_installation = true,
    },
  },
}
