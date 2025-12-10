local actions = require("telescope.actions")

return {
  "nvim-telescope/telescope.nvim",
  tag = "v0.1.9",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    -- "nvim-telescope/telescope-fzf-native.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release --target install",
    },
  },
  opts = {
    defaults = {
      mappings = {
        i = {
          -- Close telescope window on first escape press
          ["<esc>"] = actions.close,
        },
      },
    },
    pickers = {
      oldfiles = {
        cwd_only = true,
      },
    },
  },
}
