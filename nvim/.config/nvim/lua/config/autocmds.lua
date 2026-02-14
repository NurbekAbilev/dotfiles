-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
  pattern = "*",
  callback = function()
    local buftype = vim.api.nvim_get_option_value("buftype", { buf = 0 })
    if buftype == "" then
      vim.cmd("silent! wall")
    end
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    local bufname = vim.api.nvim_buf_get_name(0)
    if vim.fn.isdirectory(bufname) > 0 then
      vim.fn.chdir(bufname)
    end
  end,
})
