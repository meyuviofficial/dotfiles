return {
  "nvim-mini/mini.nvim",
  version = "*",
  name = "mini",
  config = function()
    require("mini.surround").setup() -- helps surrounding with quotes, brackets, etc.
    require("mini.ai").setup() -- helps with a, i motion
    require("mini.tabline").setup() -- helps with tabline navigation
    require("mini.move").setup() -- helps with moving lines and blocks
    require("mini.bracketed").setup() -- helps with bracketed text objects
    require("mini.comment").setup() -- helps with commenting lines
    require("mini.jump").setup() -- helps with jumping to definitions
  end,
}
