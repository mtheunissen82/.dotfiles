local g = vim.g
local o = vim.opt

-- Leader key
g.mapleader = ","
g.maplocalleader = "\\"

-- UI
o.cursorline = true
o.laststatus = 3
o.scrolloff = 999 -- Keep cursor centered vertically
o.signcolumn = "yes"
o.wrap = false -- Disable line wrapping
o.termguicolors = true -- Enable 24-bit RGB colors
o.virtualedit = "block" -- Allow cursor to move freely in visual block mode
o.inccommand = "split" -- Show effects of substitutions incrementally in a split
o.winborder = "rounded" -- Apply rounded borders for floating windows

-- Line numbers
o.number = true -- Enable line numbers
o.relativenumber = true -- Enable relative line numbers
o.numberwidth = 2 -- Set line number column width to 2 (smaller column has better aesthetics)

-- Indenting
o.expandtab = true
o.shiftwidth = 2
o.smartindent = true
o.tabstop = 2
o.softtabstop = 2
o.autoindent = true

-- Search
o.ignorecase = true
o.smartcase = true
o.hlsearch = true
o.incsearch = true

-- Misc.
o.autoread = true -- Automatically reload files changed outside of Neovim
o.clipboard = "unnamedplus"
o.completeopt = "menu,menuone,noselect,preview" -- Better completion experience
o.hidden = false
o.shortmess:append("I") -- Stop showing the intro splash screen
o.splitbelow = true -- When opening a new horizontal split, put it below the current window
o.splitright = true -- When opening a new vertical split, put it on the righthand side of the current window
o.timeoutlen = 400
o.undofile = true -- Enable persistent undo
o.updatetime = 200 -- Save swapfile faster
