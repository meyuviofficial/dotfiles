-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

vim.o.guifont = "JetBrains Mono:h12"
vim.opt.termguicolors = true

vim.api.nvim_set_keymap("n", "<C-S-c>", ':let @+ = expand("%:t:r")<CR>', { noremap = true, silent = true })

-- bufferline setup
local bufferline = require("bufferline")
bufferline.setup({
  options = {
    mode = "buffers", -- set to "tabs" to only show tabpages instead
    style_preset = bufferline.style_preset.default, -- or bufferline.style_preset.minimal,
    themable = true, -- allows highlight groups to be overriden i.e. sets highlights as default
    numbers = "ordinal",
    close_command = "bdelete! %d", -- can be a string | function, | false see "Mouse actions"
    right_mouse_command = "bdelete! %d", -- can be a string | function | false, see "Mouse actions"
    left_mouse_command = "buffer %d", -- can be a string | function, | false see "Mouse actions"
    middle_mouse_command = nil, -- can be a string | function, | false see "Mouse actions"
    indicator = {
      icon = "▎", -- this should be omitted if indicator style is not 'icon'
      style = "icon",
    },
    buffer_close_icon = "󰅖",
    modified_icon = "● ",
    close_icon = " ",
    left_trunc_marker = " ",
    right_trunc_marker = " ",
    max_name_length = 18,
    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
    truncate_names = true, -- whether or not tab names should be truncated
    tab_size = 18,
    diagnostics = false,
    diagnostics_update_in_insert = false, -- only applies to coc
    diagnostics_update_on_event = true, -- use nvim's diagnostic handler
    -- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      return "(" .. count .. ")"
    end,
    -- NOTE: this will be called a lot so don't do any heavy processing here
    custom_filter = function(buf_number, buf_numbers)
      -- filter out filetypes you don't want to see
      if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
        return true
      end
      -- filter out by buffer name
      if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
        return true
      end
      -- filter out based on arbitrary rules
      -- e.g. filter out vim wiki buffer from tabline in your work repo
      if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
        return true
      end
      -- filter out by it's index number in list (don't show first buffer)
      if buf_numbers[1] ~= buf_number then
        return true
      end
      return true
    end,
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        text_align = "center",
        separator = true,
      },
    },
    color_icons = true, -- whether or not to add the filetype icon highlights
    show_buffer_icons = true, -- disable filetype icons for buffers
    show_buffer_close_icons = true,
    show_close_icon = true,
    show_tab_indicators = true,
    show_duplicate_prefix = true, -- whether to show duplicate buffer prefix
    duplicates_across_groups = true, -- whether to consider duplicate paths in different groups as duplicates
    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    move_wraps_at_ends = false, -- whether or not the move command "wraps" at the first or last position
    -- can also be a table containing 2 custom separators
    -- [focused and unfocused]. eg: { '|', '|' }
    separator_style = "thick",
    enforce_regular_tabs = false,
    always_show_bufferline = true,
    auto_toggle_bufferline = true,
    hover = {
      enabled = true,
      delay = 200,
      reveal = { "close" },
    },
    sort_by = "tabs", 
    pick = {
      alphabet = "abcdefghijklmopqrstuvwxyzABCDEFGHIJKLMOPQRSTUVWXYZ1234567890",
    },
  },
})

-- Catpuccin theme setup
require("catppuccin").setup({
  flavour = "auto", -- latte, frappe, macchiato, mocha
  background = { -- :h background
    light = "latte",
    dark = "mocha",
  },
  transparent_background = true, -- disables setting the background color.
  show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
  term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
  dim_inactive = {
    enabled = true, -- dims the background color of inactive window
    shade = "dark",
    percentage = 0.15, -- percentage of the shade to apply to the inactive window
  },
  no_italic = false, -- Force no italic
  no_bold = false, -- Force no bold
  no_underline = false, -- Force no underline
  styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
    comments = { "italic" }, -- Change the style of comments
    conditionals = { "italic" },
    loops = {},
    functions = {},
    keywords = {},
    strings = {},
    variables = {},
    numbers = {},
    booleans = {},
    properties = {},
    types = {},
    operators = {},
    -- miscs = {}, -- Uncomment to turn off hard-coded styles
  },
  color_overrides = {},
  custom_highlights = {},
  default_integrations = true,
  integrations = {
    cmp = true,
    gitsigns = true,
    nvimtree = true,
    treesitter = true,
    notify = false,
    mini = {
      enabled = true,
      indentscope_color = "",
    },
    -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
  },
})

-- setup must be called before loading
vim.cmd.colorscheme("catppuccin")

vim.g.copilot_filetypes = { markdown = true, yaml = true }
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
