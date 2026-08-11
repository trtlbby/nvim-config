return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
        ensure_installed = { "html", "css", "javascript", "typescript", "tsx", "python", "cpp", "c" },
        highlight = { enable = true },
    },
}