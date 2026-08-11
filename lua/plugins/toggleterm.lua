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
    {
      "<leader>ts",
      function()
        local Terminal = require("toggleterm.terminal").Terminal
        local vs = "C:\\Program Files\\Microsoft Visual Studio\\18\\Community"

        local profiles = {
          { name = "PowerShell",     cmd = "powershell.exe -NoLogo" },
          { name = "Command Prompt", cmd = "cmd.exe" },
          { name = "Git Bash",       cmd = '"C:\\Program Files\\Git\\bin\\bash.exe" -i -l' },
          { name = "Ubuntu WSL",     cmd = "wsl.exe" },
          {
            name = "VS Dev Cmd",
            cmd = 'cmd.exe /k "' .. vs .. '\\Common7\\Tools\\VsDevCmd.bat" -arch=x64',
          },
          {
            name = "VS Dev PowerShell",
            cmd = 'powershell.exe -NoExit -Command "Import-Module \''
              .. vs .. '\\Common7\\Tools\\Microsoft.VisualStudio.DevShell.dll\'; '
              .. "Enter-VsDevShell -VsInstallPath '" .. vs .. "' -SkipAutomaticLocation -DevCmdArguments '-arch=x64'\"",
          },
        }

        local names = {}
        for _, p in ipairs(profiles) do table.insert(names, p.name) end

        vim.ui.select(names, { prompt = "Terminal profile:" }, function(choice, idx)
          if not choice then return end
          Terminal:new({
            cmd = profiles[idx].cmd,
            direction = "float",
            float_opts = { border = "rounded" },
            close_on_exit = false,
          }):toggle()
        end)
      end,
      desc = "Select terminal profile",
    },
  },
}
