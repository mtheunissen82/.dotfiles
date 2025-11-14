return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    build = ":TSUpdate",
  },
  {
    "windwp/nvim-ts-autotag",
    opts = {},
  },
}
