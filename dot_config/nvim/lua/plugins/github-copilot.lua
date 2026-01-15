return {
  {
    "github/copilot.vim",
    event = "InsertEnter", -- load only when you actually type
    config = function()
      -- Optional but recommended sane defaults
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true

      -- Use Ctrl+l to accept suggestions
      vim.keymap.set("i", "<C-l>", 'copilot#Accept("<CR>")', {
        expr = true,
        replace_keycodes = false,
        silent = true,
      })
    end,
  },
}
