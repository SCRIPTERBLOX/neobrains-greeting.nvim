# Neobrains Greeting Plugin

A Neovim plugin that creates a customizable greeting screen with centered content and smart buffer management.

## Features

- **Centered Content**: Automatically centers greeting content both horizontally and vertically
- **Smart Buffer Management**: Uncloseable greeting buffer that recreates when deleted
- **Customizable Content**: Easy to customize greeting messages and appearance
- **Bufferline Integration**: Automatically excluded from bufferline displays
- **Auto-recreation**: Recreates greeting buffer when no other buffers are available

## Installation

### Using Lazy.nvim (Local Development)

```lua
{
  dir = vim.fn.stdpath("config") .. "/lua/neobrains-greeting",
  name = "neobrains-greeting",
}
```

### Using Lazy.nvim (From GitHub)

```lua
{
  "SCRIPTERBLOX/neobrains-greeting",
  name = "neobrains-greeting",
}
```

## Usage

### Basic Usage

```lua
local greeting = require("neobrains-greeting")

-- Create greeting with default content
greeting.create()
```

### Custom Content

```lua
local greeting = require("neobrains-greeting")

greeting.create({
  content = {
    "Welcome to My IDE!",
    "",
    "Custom instructions here...",
  },
  buffer_name = "Welcome",
  focus_tree_after = true,
})
```

## Configuration Options

```lua
{
  content = {                    -- Array of lines to display
    "Welcome to the Neobrains IDE!",
    "",
    "Press 'i' to enter insert mode",
    "Press ':w' to save changes",
    "Press ':q' to quit current buffer",
  },
  buffer_name = "Welcome",       -- Name of the buffer
  filetype = "neobrains-greeting", -- Filetype for identification
  buftype = "nofile",            -- Buffer type
  modifiable = true,             -- Whether buffer is modifiable
  focus_tree_after = true,       -- Focus nvim-tree after creation
  auto_recreate = true,          -- Auto-recreate when deleted
}
```

## API

### `greeting.create(config)`

Creates a new greeting buffer with the provided configuration.

**Parameters:**
- `config` (table, optional): Configuration options

**Returns:**
- Buffer number of the created greeting buffer

### `greeting.recreate(config)`

Recreates a greeting buffer (useful for auto-recreation logic).

**Parameters:**
- `config` (table, optional): Configuration options

**Returns:**
- Buffer number of the recreated greeting buffer

### `greeting.find_buffer()`

Finds an existing greeting buffer.

**Returns:**
- Buffer number if found, `nil` otherwise

### `greeting.is_greeting_buffer(buf)`

Checks if a buffer is a greeting buffer.

**Parameters:**
- `buf` (number): Buffer number to check

**Returns:**
- `true` if buffer is a greeting buffer, `false` otherwise

## Integration with Buffer Management

The plugin integrates seamlessly with smart buffer management systems:

```lua
-- Example buffer management using plugin helpers
local greeting = require("neobrains-greeting")

-- Check if current buffer is greeting
if greeting.is_greeting_buffer(vim.api.nvim_get_current_buf()) then
  -- Handle greeting buffer specially
  return
end

-- Find greeting buffer when needed
local greeting_buf = greeting.find_buffer()
if greeting_buf then
  vim.api.nvim_win_set_buf(0, greeting_buf)
end
```

## License

MIT License