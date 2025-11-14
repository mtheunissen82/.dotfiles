local map = vim.keymap.set

-- General
map("n", "<leader>v", "<cmd>edit $MYVIMRC<cr>", { desc = "Edit vim config" })

-- Plugin: Comment.nvim
map("n", "<C-/>", "gcc", { remap = true })
map("v", "<C-/>", "gc", { remap = true })

-- Plugin: telescope.nvim
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Telescope find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Telescope live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Telescope find buffers" })
map("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Telescope find keymaps" })

-- Plugin: neo-tree.nvim
map("n", "<leader>e", "<cmd>Neotree toggle=true<cr>", { desc = "neo-tree toggle file explorer" })
