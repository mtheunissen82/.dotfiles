return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      -- Install parsers you need
      local installed = require("nvim-treesitter.config").get_installed()
      local want = {
        "bash",
        "c",
        "css",
        "dockerfile",
        "git_config",
        "git_rebase",
        "go",
        "graphql",
        "html",
        "java",
        "javadoc",
        "javascript",
        "json",
        "lua",
        "luadoc",
        "markdown",
        "nginx",
        "python",
        "rust",
        "terraform",
        "toml",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
      }

      local to_install = vim.tbl_filter(function(p)
        return not vim.tbl_contains(installed, p)
      end, want)
      if #to_install > 0 then
        require("nvim-treesitter").install(to_install)
      end

      -- Enable highlighting and identing
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          pcall(vim.treesitter.start) -- highlighting
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" -- indenting
        end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter" },
    },
    init = function()
      vim.g.no_plugin_maps = true
    end,
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = {
          lookahead = true,
          selection_modes = {
            ["@parameter.outer"] = "v",
            ["@function.outer"] = "V",
            ["@class.outer"] = "<c-v>",
          },
          include_surrounding_whitespace = true,
        },
        move = {
          -- whether to set jumps in the jumplist
          set_jumps = true,
        },
      })

      local select = require("nvim-treesitter-textobjects.select")
      vim.keymap.set({ "x", "o" }, "af", function()
        select.select_textobject("@function.outer", "textobjects")
      end)
      vim.keymap.set({ "x", "o" }, "if", function()
        select.select_textobject("@function.inner", "textobjects")
      end)
      vim.keymap.set({ "x", "o" }, "ac", function()
        select.select_textobject("@class.outer", "textobjects")
      end)
      vim.keymap.set({ "x", "o" }, "ic", function()
        select.select_textobject("@class.inner", "textobjects")
      end)
    end,
  },
  { "nvim-treesitter/nvim-treesitter-context", opts = {} },
  {
    "chrisgrieser/nvim-various-textobjs",
    event = "VeryLazy",
    opts = {
      keymaps = {
        useDefaults = true,
      },
    },
  },
  {
    "windwp/nvim-ts-autotag",
    opts = {},
  },
}
