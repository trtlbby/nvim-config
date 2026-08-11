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

-- ===== C++ build system =====
local vsdevcmd = 'C:\\Program Files\\Microsoft Visual Studio\\18\\Community\\Common7\\Tools\\VsDevCmd.bat'

local function vs_term(dir, command)
  local Terminal = require("toggleterm.terminal").Terminal
  Terminal:new({
    cmd = 'cmd.exe /k ""' .. vsdevcmd .. '" -arch=x64 && cd /d "' .. dir .. '" && ' .. command .. '"',
    direction = "float",
    float_opts = { border = "rounded" },
    close_on_exit = false,
  }):toggle()
end

-- Walk up from the current file looking for CMakeLists.txt first, then .sln
local function find_project()
  local found = vim.fs.find({ "CMakeLists.txt" }, {
    upward = true,
    path = vim.fn.expand("%:p:h"),
    type = "file",
  })
  if found[1] then
    return "cmake", vim.fn.fnamemodify(found[1], ":h"), found[1]
  end

  found = vim.fs.find(function(name)
    return name:match("%.slnx?$")
  end, {
    upward = true,
    path = vim.fn.expand("%:p:h"),
    type = "file",
  })
  if found[1] then
    return "msvc", vim.fn.fnamemodify(found[1], ":h"), found[1]
  end

  return nil
end

local function cpp_action(run)
  local kind, dir, file = find_project()
  if not kind then
    vim.notify("No CMakeLists.txt or .sln found", vim.log.levels.ERROR)
    return
  end

  local cmd
  if kind == "cmake" then
    cmd = "cmake -B build -G Ninja -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_BUILD_TYPE=Debug && cmake --build build"
    if run then
      cmd = cmd .. " && build\\" .. vim.fn.fnamemodify(dir, ":t") .. ".exe"
    end
  else
    cmd = 'msbuild "' .. file .. '" /p:Configuration=Debug /p:Platform=x64'
    if run then
      cmd = cmd .. " && x64\\Debug\\" .. vim.fn.fnamemodify(file, ":t:r") .. ".exe"
    end
  end

  vs_term(dir, cmd)
end

map("n", "<leader>mb", function() cpp_action(false) end, { desc = "Build C++ project" })
map("n", "<leader>mr", function() cpp_action(true) end, { desc = "Build and run C++" })

-- New CMake project from template
map("n", "<leader>mn", function()
  local name = vim.fn.input("New C++ project name: ")
  if name == "" then return end

  local src = "C:\\Users\\bacsa\\Workspace\\repos\\cpp\\templates\\cpp-cmake"
  local dst = "C:\\Users\\bacsa\\Workspace\\repos\\cpp\\cmake\\" .. name

  if vim.fn.isdirectory(dst) == 1 then
    vim.notify("Project already exists", vim.log.levels.ERROR)
    return
  end

  vim.fn.system('xcopy /E /I /Q "' .. src .. '" "' .. dst .. '"')
  vim.fn.system('rmdir /s /q "' .. dst .. '\\build" 2>nul')
  local cml = dst .. "\\CMakeLists.txt"
  local lines = vim.fn.readfile(cml)
  for i, line in ipairs(lines) do
    lines[i] = line:gsub("ProjectName", name)
  end
  vim.fn.writefile(lines, cml)

  vim.cmd("cd " .. vim.fn.fnameescape(dst))
  vim.cmd("edit " .. vim.fn.fnameescape(dst .. "\\src\\main.cpp"))
  vim.notify("Created " .. name)
end, { desc = "New C++ project" })
