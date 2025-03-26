return {
  { -- Formatter
    "stevearc/conform.nvim",
    enabled = true,
    event = "BufWritePre", -- format on save
    opts = require "configs.conform", -- in fetched update
  },
  { -- Top-line breadcrumbs -- public archive
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    enabled = true,
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = { },
  },
  {
    "neovim/nvim-lspconfig",
    enabled = true,
    dependencies = {
      {
        "SmiteshP/nvim-navbuddy",
        dependencies = {
          "SmiteshP/nvim-navic", -- top-bar breadcrumbs, barbecue replacement
          "MunifTanjim/nui.nvim", -- ui components
        },
        opts = { lsp = { auto_attach = true } },
      },
    },
    config = function()
      require "configs.lspconfig"
      require "configs.navbuddy"
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        -- "lua",
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
      "rcarriga/nvim-notify",
    },
  },
  {
    "karb94/neoscroll.nvim",
    enabled = true,
    event = "BufReadPost",
    config = function()
      require "configs.neoscroll"
    end,
  },
  {
    -- "anuvyklack/pretty-fold.nvim", -- errored orig
    "bbjornstad/pretty-fold.nvim",
    enabled = false,
    event = "BufReadPre",
    config = function()
      require "configs.pretty-fold"
    end,
  },
  { -- Add jumps to. s{char1}{char2}{hint}
    "ggandor/leap.nvim",
    enabled = true,
    event = "BufReadPre",
    config = function()
      require("leap").add_default_mappings()
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    enabled = true,
    cmd = "Copilot",
    lazy = false,
    event = "InsertEnter",
    config = function()
      require "configs.copilot"
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    enabled = true,
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "zbirenbaum/cmp-copilot",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      "ray-x/cmp-treesitter",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-emoji",
      "delphinus/cmp-ctags",
      "hrsh7th/cmp-nvim-lsp-signature-help",
    },
    config = function()
      require "configs.cmp"
    end,
  },
  {
    "ThePrimeagen/harpoon",
    event = "BufReadPre",
    config = function()
      require("harpoon").setup()
      require("telescope").load_extension "harpoon"
    end,
  },
  { -- Used for <leader>/
    "numToStr/Comment.nvim",
    enabled = true,
    keys = {
      { "gc", mode = { "n", "o" }, desc = "Comment toggle linewise" },
    },
    init = function()
      vim.g.comment_maps = true
    end,
    config = function(_, opts)
      require("Comment").setup(opts)
    end,
  },
  { "cespare/vim-toml" }, -- add toml syntax
  { "tpope/vim-surround", enabled=true, event = "VeryLazy" }, -- surround with `csw"`
  { "jeetsukumaran/vim-indentwise", enabled=false, event = "VeryLazy" }, -- move based on indent
  { "tmhedberg/SimpylFold", enabled=true, event = "VeryLazy" }, -- for python
  { "ojroques/nvim-bufdel", enabled = true }, -- close buf w/o close window
  {
    "christoomey/vim-tmux-navigator",
    enabled = true,
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-n>", "<cmd>TmuxNavigateLeft<cr>" },
      { "<c-e>", "<cmd>TmuxNavigateDown<cr>" },
      { "<c-i>", "<cmd>TmuxNavigateUp<cr>" },
      { "<c-o>", "<cmd>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd>TmuxNavigatePrevious<cr>" },
    },
  },
  -- DISABLED --
  { -- Downloads/installs plugins in venv
    "williamboman/mason.nvim",
    enabled = false,
    opts = {
      ensure_installed = {
        "black",
        "codespell",
        "css-lsp",
        "html-lsp",
        "isort",
        "json-lsp",
        "lua-language-server",
        "markdownlint",
        "prettier",
        "python-lsp-server",
        "ruff",
        "sqlfluff",
        "stylua",
        "texlab",
      },
    },
  },
  { "williamboman/mason-lspconfig.nvim", enabled=false },
  {
    "richardbizik/nvim-toc",
    enabled=false,
    event = "VeryLazy",
    config = function()
      require("nvim-toc").setup {}
    end,
  },
  { -- Table of contents for markdown files with <c-y>
    "taoso/tagbar-markdown",
    enabled = false,
    event = "VeryLazy",
    dependencies = { "majutsushi/tagbar" },
  },
  {
    "lervag/vimtex",
    enabled = false,
    lazy = false, -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      -- VimTeX configuration goes here, e.g.
      vim.g.vimtex_view_method = "zathura"
      vim.g.vimtex_fold_enabled = 1
    end,
  },
}
