local utils = require('neobrains-greeting.utils')
local config = require('neobrains-greeting.config')

local M = {}

function M.create_buffer(user_config)
  local cfg = vim.tbl_deep_extend('force', config.default_config, user_config or {})
  
  -- Get current window dimensions
  local win_height = vim.api.nvim_win_get_height(0)
  local win_width = vim.api.nvim_win_get_width(0)
  
  -- Center the content
  local lines = utils.center_content(cfg.content, win_width, win_height)
  
  -- Create buffer
  local buf = vim.api.nvim_get_current_buf()
  
  -- Set buffer content
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  
  -- Set buffer options
  vim.api.nvim_buf_set_option(buf, "modifiable", cfg.modifiable)
  vim.api.nvim_buf_set_option(buf, "filetype", cfg.filetype)
  vim.api.nvim_buf_set_option(buf, "buftype", cfg.buftype)
  vim.api.nvim_buf_set_name(buf, cfg.buffer_name)
  
  return buf, lines
end

function M.recreate_buffer(lines, user_config)
  local cfg = vim.tbl_deep_extend('force', config.default_config, user_config or {})
  
  local new_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(new_buf, "filetype", cfg.filetype)
  vim.api.nvim_buf_set_option(new_buf, "buftype", cfg.buftype)
  vim.api.nvim_buf_set_name(new_buf, cfg.buffer_name)
  vim.api.nvim_buf_set_lines(new_buf, 0, -1, false, lines)
  vim.api.nvim_win_set_buf(0, new_buf)
  
  return new_buf
end

return M