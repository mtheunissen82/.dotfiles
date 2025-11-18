local map = vim.keymap.set

-- General
-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Better indenting
map("x", "<", "<gv", { desc = "Indent left and reselect" })
map("x", ">", ">gv", { desc = "Indent right and reselect" })

-- Move Lines
map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move line Down" })
map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move line up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move line down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move line up" })
map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move line down" })
map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move line up" })

-- Save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- Open Lazy plugin manager
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Open Lazy plugin manager" })

-- Edit nvim config in a new tab
map("n", "<leader>v", function()
  vim.cmd("tabnew " .. vim.fn.stdpath("config"))
end, { desc = "Edit nvim config in new tab" })

-- Plugin: Comment
map("n", "<C-/>", "gcc", { remap = true })
map("v", "<C-/>", "gc", { remap = true })

-- Plugin: telescope
map("n", "<leader>ff", "<cmd>Telescope find_files path_display={'shorten'}<cr>", { desc = "Telescope find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Telescope live grep" })
map("n", "<leader>b", "<cmd>Telescope buffers<cr>", { desc = "Telescope find buffers" })
map("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Telescope find keymaps" })
map(
  "n",
  "<leader>fo",
  "<cmd>Telescope oldfiles path_display={'shorten'}<cr>",
  { desc = "Telescope find previously opened files" }
)

-- Plugin: neo-tree
map("n", "<leader>e", "<cmd>Neotree toggle=true<cr>", { desc = "neo-tree toggle file explorer" })

-- Plugin: lazygit
map("n", "<leader>gg", function()
  Snacks.lazygit()
end, { desc = "Open LazyGit" })

-- Plugin: gitsigns
map("n", "<leader>gb", "<cmd>Gitsigns blame<cr>", { desc = "Git blame file" })

-- Plugin: flash
map({ "n", "x", "o" }, "s", function()
  require("flash").jump()
end, { desc = "Flash" })
map({ "n", "x", "o" }, "S", function()
  require("flash").treesitter()
end, { desc = "Flash Treesitter" })
map("c", "<c-s>", function()
  require("flash").toggle()
end, { desc = "Toggle Flash search" })
