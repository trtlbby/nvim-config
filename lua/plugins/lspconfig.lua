return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local servers = {
      "html", "cssls", "ts_ls", "tailwindcss", "emmet_ls",
      "pyright", "ruff", "clangd",
    }

    -- Portable setup only: pyright installed via `pip --target`, so there's no
    -- standalone pyright-langserver.exe. Run it as a module instead.
    if vim.env.PYTHONHOME
      and vim.fn.isdirectory(vim.env.PYTHONHOME .. "/Lib/site-packages/pyright") == 1
    then
      vim.lsp.config("pyright", {
        cmd = { "python", "-m", "pyright.langserver", "--stdio" },
      })
    end

    for _, server in ipairs(servers) do
      vim.lsp.enable(server)
    end
  end,
}
