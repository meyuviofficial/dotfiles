require "nvchad.autocmds"

-- Fix nvim <path> opening in cwd instead of the given path
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local arg = vim.fn.argv(0)
    if arg == nil or arg == "" then return end

    if vim.fn.isdirectory(arg) == 1 then
      -- if a directory was passed, cd into it and open nvim-tree
      vim.cmd("cd " .. vim.fn.fnameescape(arg))
      require("nvim-tree.api").tree.open()
    else
      -- if a file was passed, cd to its parent
      vim.cmd("cd " .. vim.fn.fnameescape(vim.fn.fnamemodify(arg, ":h")))
    end
  end,
})
