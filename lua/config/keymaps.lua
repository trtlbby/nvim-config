local map = vim.keymap.set

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })

-- Clear search highlight
map("n", "<Esc>", ":nohlsearch<CR>", { silent = true })

-- Move lines up/down in visual mode
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- Better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Save
map("n", "<leader>w", ":w<CR>", { desc = "Save file" })

-- Terminal
map("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

-- Dashboard
map("n", "<leader>;", ":Alpha<CR>", { desc = "Open Dashboard" })

-- Quit
map("n", "<leader>q", ":q<CR>", { desc = "Quit" })
-- Return to normal
map("i", "kj", "<Esc>", { desc = "Normal Mode" })

-- Buffer navigation
map("n", "<Tab>", ":BufferLineCycleNext<CR>", { desc = "Next buffer" })
map("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
map("n", "<leader>bd", ":bdelete<CR>", { desc = "Close buffer" })

-- Resize Window
map("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase height" })
map("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease height" })
map("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease width" })
map("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase width" })

-- New maps here

-- C++ build / run
local vsdevcmd = 'C:\\Program Files\\Microsoft Visual Studio\\18\\Community\\Common7\\Tools\\VsDevCmd.bat'

local function find_sln()
  local found = vim.fs.find(function(name)
    return name:match("%.sln$") or name:match("%.vcxproj$")
  end, {
    upward = true,
    path = vim.fn.expand("%:p:h"),
    type = "file",
  })
  return found[1]
end

local function vs_term(action)
  local sln = find_sln()
  if not sln then
    vim.notify("No .sln or .vcxproj found above this file", vim.log.levels.ERROR)
    return
  end
  local dir = vim.fn.fnamemodify(sln, ":h")
  local name = vim.fn.fnamemodify(sln, ":t:r")

  local cmd = 'msbuild "' .. sln .. '" /p:Configuration=Debug /p:Platform=x64'
  if action == "run" then
    cmd = cmd .. ' && "' .. dir .. '\\x64\\Debug\\' .. name .. '.exe"'
  end

  local Terminal = require("toggleterm.terminal").Terminal
  Terminal:new({
    cmd = 'cmd.exe /k ""' .. vsdevcmd .. '" -arch=x64 && cd /d "' .. dir .. '" && ' .. cmd .. '"',
    direction = "float",
    float_opts = { border = "rounded" },
    close_on_exit = false,
  }):toggle()
end

map("n", "<leader>mb", function() vs_term("build") end, { desc = "Build C++ project" })
map("n", "<leader>mr", function() vs_term("run") end, { desc = "Build and run C++" })
