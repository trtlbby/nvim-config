return {
  "CopilotC-Nvim/CopilotChat.nvim",
  dependencies = {
    "github/copilot.vim",
    "nvim-lua/plenary.nvim",
  },
  cmd = { "CopilotChat", "CopilotChatToggle" },
  keys = {
    { "<leader>cc", ":CopilotChatToggle<CR>", desc = "Toggle Copilot Chat" },
    { "<leader>ce", ":CopilotChatExplain<CR>", mode = "v", desc = "Explain selection" },
    { "<leader>cf", ":CopilotChatFix<CR>", mode = "v", desc = "Fix selection" },
    { "<leader>ct", ":CopilotChatTests<CR>", mode = "v", desc = "Generate tests" },
    { "<leader>cb", ":CopilotChat #buffer <CR>", desc = "Chat about current buffer" },
  },
  opts = {
    window = { layout = "float", border = "rounded" },
    context = "buffer",
    selection = function(source)
      return require("CopilotChat.select").visual(source)
        or require("CopilotChat.select").buffer(source)
    end,
  },
}
