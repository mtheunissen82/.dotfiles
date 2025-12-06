-- Highlight yanked text ( for a short amount of time )
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
  pattern = "*",
  desc = "Highlight yanked text",
  callback = function()
    vim.highlight.on_yank({ timeout = 200, visual = true })
  end,
})

-- Open help pages in a vertical split window
vim.api.nvim_create_autocmd("FileType", {
  pattern = "help",
  desc = "Open help pages in a vertical split window",
  command = "wincmd L | vertical resize 90",
})

-- Automatically resize splits when the Vim window is resized
vim.api.nvim_create_autocmd("VimResized", {
  desc = "Automatically resize splits when the Vim window is resized",
  command = "tabdo wincmd =",
})

-- Show cursorline only in active window
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
  desc = "Show cursorline only in active window",
  callback = function()
    vim.wo.cursorline = true
  end,
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
  desc = "Hide cursorline when leaving window",
  callback = function()
    vim.wo.cursorline = false
  end,
})

-- ide like highlight when stopping cursor
vim.api.nvim_create_autocmd("CursorMoved", {
  group = vim.api.nvim_create_augroup("LspReferenceHighlight", { clear = true }),
  desc = "Highlight references under cursor",
  callback = function()
    -- Only run if the cursor is not in insert mode
    if vim.fn.mode() ~= "i" then
      local clients = vim.lsp.get_clients({ bufnr = 0 })
      local supports_highlight = false
      for _, client in ipairs(clients) do
        if client.server_capabilities.documentHighlightProvider then
          supports_highlight = true
          break -- Found a supporting client, no need to check others
        end
      end

      -- 3. Proceed only if an LSP is active AND supports the feature
      if supports_highlight then
        vim.lsp.buf.clear_references()
        vim.lsp.buf.document_highlight()
      end
    end
  end,
})

vim.api.nvim_create_autocmd("CursorMovedI", {
  group = "LspReferenceHighlight",
  desc = "Clear highlights when entering insert mode",
  callback = function()
    vim.lsp.buf.clear_references()
  end,
})

-- When opening terminal, enter interactive mode
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  desc = "Enter insert mode when opening a terminal",
  callback = function()
    vim.cmd("startinsert")
  end,
})
