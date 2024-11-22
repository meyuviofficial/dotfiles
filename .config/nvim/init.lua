-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

vim.o.guifont = "FiraCode Nerd Font:h12"
vim.opt.termguicolors = true
require("bufferline").setup({})
vim.api.nvim_set_keymap("n", "<C-S-c>", ':let @+ = expand("%:t:r")<CR>', { noremap = true, silent = true })

require("telescope").setup({
  defaults = {
    -- configure to use ripgrep
    vimgrep_arguments = {
      "rg",
      "--follow", -- Follow symbolic links
      "--hidden", -- Search for hidden files
      "--no-heading", -- Don't group matches by each file
      "--with-filename", -- Print the file path with the matched lines
      "--line-number", -- Show line numbers
      "--column", -- Show column numbers
      "--smart-case", -- Smart case search
      "-uu",
      -- Exclude some patterns from search
      "--glob=!**/.git/*",
      "--glob=!**/.idea/*",
      "--glob=!**/.vscode/*",
      "--glob=!**/build/*",
      "--glob=!**/dist/*",
      "--glob=!**/yarn.lock",
      "--glob=!**/package-lock.json",
    },

    ...,
  },
  pickers = {
    find_files = {
      hidden = true,
      -- needed to exclude some files & dirs from general search
      -- when not included or specified in .gitignore
      find_command = {
        "rg",
        "--files",
        "--hidden",
        "--glob=!**/.git/*",
        "--glob=!**/.idea/*",
        "--glob=!**/.vscode/*",
        "--glob=!**/build/*",
        "--glob=!**/dist/*",
        "--glob=!**/yarn.lock",
        "--glob=!**/package-lock.json",
      },
    },
  },
})
