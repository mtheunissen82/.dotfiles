local g = vim.g
local o = vim.opt

-- Leader key
g.mapleader = ","
g.maplocalleader = "\\"

-- Misc.
o.clipboard = "unnamedplus"
o.timeoutlen = 400
o.hidden = false
o.shortmess:append("I") -- Stop showing the intro splash screen

-- UI
o.cursorline = true
o.laststatus = 3
o.scrolloff = 999 -- Keep cursor centered vertically
o.signcolumn = "yes"
o.splitbelow = true -- When opening a new horizontal split, put it below the current window
o.wrap = false -- Disable line wrapping
o.termguicolors = true
o.virtualedit = "block" -- Allow cursor to move freely in visual block mode
o.inccommand = "split" -- Show effects of substitutions incrementally in a split
o.winborder = "rounded" -- Apply rounded borders for floating windows

-- Line numbers
o.number = true
o.relativenumber = true
o.numberwidth = 2

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
