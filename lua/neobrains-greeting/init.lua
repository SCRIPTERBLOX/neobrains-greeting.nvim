local buffer = require('neobrains-greeting.buffer')
local autocmds = require('neobrains-greeting.autocmds')
local utils = require('neobrains-greeting.utils')

local M = {}

function M.create(user_config)
  local cfg = vim.tbl_deep_extend('force', require('neobrains-greeting.config').default_config, user_config or {})
  
  -- Create the greeting buffer
  local buf, lines = buffer.create_buffer(cfg)
  
  -- Setup auto-recreation if enabled
  autocmds.setup_auto_recreate(buf, lines, cfg)
  
  -- Focus back to nvim-tree if requested
  if cfg.focus_tree_after then
    vim.cmd("wincmd h")
  end
  
  return buf
end

function M.recreate(user_config)
  local cfg = vim.tbl_deep_extend('force', require('neobrains-greeting.config').default_config, user_config or {})
  
  -- Get current window dimensions
  local win_height = vim.api.nvim_win_get_height(0)
  local win_width = vim.api.nvim_win_get_width(0)
  
  -- Center the content
  local lines = utils.center_content(cfg.content, win_width, win_height)
  
  -- Recreate buffer
  return buffer.recreate_buffer(lines, cfg)
end

function M.find_buffer()
  return utils.find_greeting_buffer()
end

function M.is_greeting_buffer(buf)
  return utils.is_greeting_buffer(buf)
end

return M