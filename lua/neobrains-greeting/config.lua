local M = {}

M.default_config = {
  content = {
    "Welcome to the Neobrains IDE!",
    "",
    "When focused on the file tree press Ctrl+N to add a file into the focused directory",
    "Press 'i' to enter insert mode",
    "Press ':w' to save changes of current buffer",
    "Press ':q' to quit the current buffer",
  },
  buffer_name = "Welcome",
  filetype = "neobrains-greeting",
  buftype = "nofile",
  modifiable = true,
  focus_tree_after = true,
  auto_recreate = true,
}

return M