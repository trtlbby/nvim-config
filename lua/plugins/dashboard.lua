return {
  "goolord/alpha-nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local dashboard = require("alpha.themes.dashboard")

    dashboard.section.header.val = {
      "                                                     ",
      "  ████████╗██████╗ ████████╗██╗     ██████╗ ██████╗ ██╗   ██╗",
      "  ╚══██╔══╝██╔══██╗╚══██╔══╝██║     ██╔══██╗██╔══██╗╚██╗ ██╔╝",
      "     ██║   ██████╔╝   ██║   ██║     ██████╔╝██████╔╝ ╚████╔╝ ",
      "     ██║   ██╔══██╗   ██║   ██║     ██╔══██╗██╔══██╗  ╚██╔╝  ",
      "     ██║   ██║  ██║   ██║   ███████╗██████╔╝██████╔╝   ██║   ",
      "     ╚═╝   ╚═╝  ╚═╝   ╚═╝   ╚══════╝╚═════╝ ╚═════╝    ╚═╝   ",
      "                                                     ",
    }
    dashboard.section.header.opts.hl = "AlphaHeader"

    dashboard.section.buttons.val = {
      dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
      dashboard.button("r", "  Recent files", ":Telescope oldfiles <CR>"),
      dashboard.button("p", "  Projects", ":NeovimProjectDiscover <CR>"),
      dashboard.button("P", "  Recent Projects", ":NeovimProjectHistory <CR>"),
      dashboard.button("g", "  Grep text", ":Telescope live_grep <CR>"),
      dashboard.button("c", "  Config", ":e $MYVIMRC <CR>"),
      dashboard.button("l", "  Lazy", ":Lazy <CR>"),
      dashboard.button("q", "  Quit", ":qa<CR>"),
    }

    local function footer()
      local stats = require("lazy").stats()
      local ms = math.floor(stats.startuptime * 100 + 0.5) / 100
      local version = vim.version()
      return {
        "",
        "  " .. stats.loaded .. "/" .. stats.count .. " plugins loaded in " .. ms .. "ms",
        "   Neovim v" .. version.major .. "." .. version.minor .. "." .. version.patch,
      }
    end

    dashboard.section.footer.val = footer()
    dashboard.section.footer.opts.hl = "Comment"

    dashboard.opts.layout = {
      { type = "padding", val = 2 },
      dashboard.section.header,
      { type = "padding", val = 2 },
      dashboard.section.buttons,
      dashboard.section.footer,
    }

    require("alpha").setup(dashboard.opts)

    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        dashboard.section.footer.val = footer()
        pcall(vim.cmd.AlphaRedraw)
      end,
    })
  end,
}
