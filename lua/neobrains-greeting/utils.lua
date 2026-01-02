local M = {}

function M.center_content(content, win_width, win_height)
  local lines = {}
  
  -- Calculate padding lines for vertical centering
  local padding = math.floor((win_height - #content) / 2)
  
  -- Add empty lines for top padding
  for i = 1, padding do
    table.insert(lines, "")
  end
  
  -- Add content lines with horizontal centering
  for _, line in ipairs(content) do
    local padding = math.floor((win_width - #line) / 2)
    local centered_line = string.rep(" ", padding) .. line
    table.insert(lines, centered_line)
  end
  
  return lines
end

function M.get_valid_buffers(exclude_buf)
  local valid_buffers = {}
  for _, b in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(b) and b ~= exclude_buf then
      local buftype = vim.api.nvim_buf_get_option(b, 'buftype')
      local filename = vim.api.nvim_buf_get_name(b)
      -- Only count buffers that would show in bufferline
      if buftype ~= 'nofile' and buftype ~= 'terminal' and buftype ~= 'quickfix' 
        and not filename:match("NvimTree") then
        table.insert(valid_buffers, b)
      end
    end
  end
  return valid_buffers
end

function M.is_greeting_buffer(buf)
  if not vim.api.nvim_buf_is_valid(buf) then
    return false
  end
  local ft = vim.api.nvim_buf_get_option(buf, 'filetype')
  return ft == 'neobrains-greeting'
end

function M.find_greeting_buffer()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if M.is_greeting_buffer(buf) then
      return buf
    end
  end
  return nil
end

return M