return {
  {
    "saghen/blink.cmp",
    -- use a release tag to download pre-built binaries
    version = "1.*",
    opts = {
      keymap = { preset = "enter" },
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.lsp.enable("ts_ls")
      vim.lsp.enable("lua_ls")
    end,
  },
  {
    "mfussenegger/nvim-jdtls",
    dependencies = { "mason-org/mason.nvim", opts = {} },
    config = function()
      vim.lsp.enable("jdtls")
    end,
  },
}
