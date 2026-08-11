return {
  { "williamboman/mason.nvim", cmd = "Mason", config = true },
  {
    "williamboman/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      ensure_installed = {
        "html", "cssls", "ts_ls", "tailwindcss", "emmet_ls",
        "pyright", "ruff", "clangd",
      },
      automatic_installation = true,
    },
  },
}
