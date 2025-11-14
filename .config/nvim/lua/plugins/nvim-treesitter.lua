return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    build = ":TSUpdate",
    opts = {
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
      highlight = {
        enable = true,
        disable = {},
        additional_vim_regex_highlighting = false,
      },
      sync_install = false,
      auto_install = true,
    },
  },
  {
    "windwp/nvim-ts-autotag",
    opts = {},
  },
}
