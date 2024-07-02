return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "html-lsp",
        "css-lsp",
        "prettier",
      },
    },
  },
  { "williamboman/mason-lspconfig.nvim" }, --newest
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "markdown",
        "markdown_inline",
        "html",
        "css",
        "python",
        "regex",
        "json",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    lazy = false,
    config = function()
      require("treesitter-context").setup {
        max_lines = 5,
      }
    end,
  },
  {
    "folke/noice.nvim",
    enabled = true,
    event = "VeryLazy",
    config = function()
      -- require("noice").setup({ require "configs.noice" })
      require("noice").setup {
        lsp = {
          signature = { enabled = false },
          hover = { enabled = false },
        },
      }
      require("notify").setup { background_colour = "#282A36" }
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
  },
  {
    "karb94/neoscroll.nvim",
    event = "BufReadPost",
    config = function()
      require "configs.neoscroll"
    end,
  },
  {
    "anuvyklack/pretty-fold.nvim",
    event = "BufReadPre",
    config = function()
      require "configs.pretty-fold"
    end,
  },
  { -- Add jumps to
    "ggandor/leap.nvim",
    event = "BufReadPre",
    config = function()
      require("leap").add_default_mappings()
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    lazy = false,
    config = function(_, opts)
      require("copilot").setup(opts)
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    -- enabled = false,
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      "ray-x/cmp-treesitter",
      -- "hrsh7th/cmp-cmdline",
      -- "hrsh7th/cmp-emoji",
      -- "hrsh7th/cmp-vsnip",
      -- "delphinus/cmp-ctags",
      -- "hrsh7th/cmp-nvim-lsp-signature-help",
    },
    opts = {
      mapping = {
        ["<C-]>"] = function(callback)
          callback()
        end,
        -- use Up and down for cycling completion
        ["<C-Down>"] = require("cmp").mapping(function(fallback)
          local cmp = require "cmp"
          if cmp.visible() then
            cmp.select_next_item()
          elseif require("luasnip").expand_or_jumpable() then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
          else
            fallback()
          end
        end, {
          "i",
          "s",
        }),
        ["<C-Up>"] = require("cmp").mapping(function(fallback)
          local cmp = require "cmp"
          if cmp.visible() then
            cmp.select_prev_item()
          elseif require("luasnip").jumpable(-1) then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
          else
            fallback()
          end
        end, { "i", "s" }),
      },
    },
  },
  {
    "ThePrimeagen/harpoon",
    event = "BufReadPre",
    config = function()
      require("harpoon").setup()
      require("telescope").load_extension "harpoon"
    end,
  },
  {
    "taoso/tagbar-markdown",
    event = "VeryLazy",
    dependencies = { "majutsushi/tagbar" },
  },
  {
    "richardbizik/nvim-toc",
    event = "VeryLazy",
    config = function()
      require("nvim-toc").setup {}
    end,
  },
  {
    "numToStr/Comment.nvim",
    keys = {
      { "gcc", mode = "n", desc = "Comment toggle current line" },
      { "gc", mode = { "n", "o" }, desc = "Comment toggle linewise" },
      { "gc", mode = "x", desc = "Comment toggle linewise (visual)" },
      { "gbc", mode = "n", desc = "Comment toggle current block" },
      { "gb", mode = { "n", "o" }, desc = "Comment toggle blockwise" },
      { "gb", mode = "x", desc = "Comment toggle blockwise (visual)" },
    },
    init = function()
      vim.g.comment_maps = true
    end,
    config = function(_, opts)
      require("Comment").setup(opts)
    end,
  },
  { "cespare/vim-toml" },
  { "tpope/vim-surround", event = "VeryLazy" },
  { "jeetsukumaran/vim-indentwise", event = "VeryLazy" },
  { "tmhedberg/SimpylFold", event = "VeryLazy" }, -- for python
}
