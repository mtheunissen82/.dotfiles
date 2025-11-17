-- Disable startup splash screen
vim.cmd("set shortmess+=I")

require("config.options")
require("config.keymaps")
require("config.lazy")

vim.cmd("colorscheme github_dark")
