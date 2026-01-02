local utils = require('neobrains-greeting.utils')
local buffer = require('neobrains-greeting.buffer')
local config = require('neobrains-greeting.config')

local M = {}

function M.setup_auto_recreate(buf, lines, user_config)
  local cfg = vim.tbl_deep_extend('force', config.default_config, user_config or {})
  
  if not cfg.auto_recreate then
    return
  end
  
  vim.api.nvim_create_autocmd({"BufDelete"}, {
    buffer = buf,
    callback = function()
      -- Only recreate if this was the only buffer being deleted
      -- and there are no other valid buffers to switch to
      vim.defer_fn(function()
        local valid_buffers = utils.get_valid_buffers(buf)
        
        -- Only recreate greeting if there are no other valid buffers
        if #valid_buffers == 0 and not vim.api.nvim_buf_is_valid(buf) then
          buffer.recreate_buffer(lines, cfg)
        end
      end, 10)
    end
  })
end

return M