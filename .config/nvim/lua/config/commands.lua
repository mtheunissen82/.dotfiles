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

-- When pressing enter on a commented line, do not automatically continue the comment on the next line
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("no_auto_comment", {}),
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- Command for opening a terminal window
vim.api.nvim_create_user_command("T", function()
  vim.cmd(":vsp term://zsh")
  vim.cmd("startinsert")

  vim.bo.bufhidden = "hide"
  vim.bo.swapfile = false

  vim.api.nvim_buf_set_keymap(0, "t", "<esc>", "<c-\\><c-n>", { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(0, "n", "<esc>", ":bd!<cr>", { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(0, "n", "q", ":bd!<cr>", { noremap = true, silent = true })
end, { desc = "Open a vertical terminal split" })

-- Command for running an arbitrary shell command in a new buffer
vim.api.nvim_create_user_command("R", function(opts)
  local current = vim.fn.expand("%:p")
  local alt = vim.fn.expand("#:p")
  local cmd = opts.args:gsub("%%:p", current):gsub("%%", current):gsub("#", alt)

  local bufnr = vim.api.nvim_create_buf(true, false)
  vim.cmd("vsplit")
  vim.api.nvim_win_set_buf(0, bufnr)
  local winnr = vim.fn.bufwinid(bufnr)

  vim.bo.buftype = "nofile"
  vim.bo.bufhidden = "hide"
  vim.bo.swapfile = false

  vim.fn.jobstart(cmd, {
    term = true,
    on_stdout = function()
      vim.schedule(function()
        vim.api.nvim_win_call(winnr, function()
          vim.cmd("normal! G")
        end)
      end)
    end,
  })

  vim.api.nvim_buf_set_keymap(0, "n", "q", ":bd!<cr>", { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(0, "n", "<esc>", ":bd!<cr>", { noremap = true, silent = true })
end, { nargs = "+" })

-- conform.nvim: Commmand for enabling/disabling formatting
vim.api.nvim_create_user_command("FormatDisable", function(args)
  if args.bang then
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = "Disable autoformat-on-save",
  bang = true,
})
vim.api.nvim_create_user_command("FormatEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = "Re-enable autoformat-on-save",
})
