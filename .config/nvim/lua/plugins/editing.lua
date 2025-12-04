return {
  {
    "numToStr/Comment.nvim",
    opts = {},
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },
  {
    "nvim-mini/mini.surround",
    opts = {},
  },
  { "github/copilot.vim" },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        css = { "prettierd" },
        html = { "prettierd" },
        java = { "google-java-format" },
        javascript = { "prettierd" },
        lua = { "stylua" },
        typescript = { "prettierd" },
      },
      format_on_save = {
        timeout_ms = 1000,
        lsp_format = "fallback",
      },
    },
  },
  {
    "smjonas/inc-rename.nvim",
    opts = {},
  },
}
