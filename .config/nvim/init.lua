-- Disable startup splash screen
vim.cmd("set shortmess+=I")

require("config.options")
require("config.keymaps")
require("config.lazy")

-- tree-sitter must explicitly be configured in init.lua otherwise it won't work
require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "bash",
    "css",
    "html",
    "java",
    "javascript",
    "json",
    "lua",
    "markdown",
    "python",
    "toml",
    "tsx",
    "typescript",
    "yaml",
  },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
})

vim.cmd("colorscheme github_dark")
