return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons", -- optional, but recommended
  },
  lazy = false,
  opts = {
    enable_git_status = true,
    close_if_last_window = true,
    filesystem = {
      group_empty_dirs = true,
      follow_current_file = {
        enabled = true,
        leave_dirs_open = false,
      },
      use_libuv_file_watcher = true,
    },
    buffers = {
      group_empty_dirs = true,
      follow_current_file = {
        enabled = true,
        leave_dirs_open = false,
      },
    },
  },
}
