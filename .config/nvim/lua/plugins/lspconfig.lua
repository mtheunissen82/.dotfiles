return {
  "neovim/nvim-lspconfig",
  config = function()
    vim.lsp.enable("ts_ls")
    vim.lsp.enable("lua_ls")
    vim.lsp.enable("java_language_server")
  end,
}
