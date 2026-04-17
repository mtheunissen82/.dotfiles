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
    opts = {
      modes = {
        search = {
          enabled = true,
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        css = { "prettierd" },
        html = { "prettierd" },
        java = { "google-java-format" },
        javascript = { "prettierd" },
        json = { "fixjson" },
        lua = { "stylua" },
        sh = { "shfmt" },
        typescript = { "prettierd" },
        xml = { "xmlformatter" },
      },
      format_on_save = function(bufnr)
        -- Disable with a global or buffer-local variable
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return { timeout_ms = 1000, lsp_format = "fallback" }
      end,
    },
  },
  {
    "smjonas/inc-rename.nvim",
    opts = {},
  },
}
