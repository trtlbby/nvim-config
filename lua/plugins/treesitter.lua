return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
        ensure_installed = { "html", "css", "javascript", "typescript", "tsx", "python", "cpp", "c" },
        highlight = { enable = true },
    },
}
