local g = vim.g
local o = vim.o

-- Leader key
g.mapleader = ","
g.maplocalleader = "\\"

-- Misc.
o.clipboard = "unnamedplus"
o.timeoutlen = 400
o.hidden = false

-- UI
o.cursorline = true
o.wrap = false
o.signcolumn = "yes"
o.laststatus = 3

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
