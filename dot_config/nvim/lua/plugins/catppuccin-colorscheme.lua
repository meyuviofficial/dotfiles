return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000, -- make sure it loads before everything else
    opts = {
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      integrations = {
        treesitter = true,
        native_lsp = {
          enabled = true,
        },
        cmp = true,
        gitsigns = true,
        telescope = true,
        which_key = true,
        notify = true,
      },
    },
  },
}
