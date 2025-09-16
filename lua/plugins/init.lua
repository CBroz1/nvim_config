return {
  {
    "yetone/avante.nvim",
    build = "make",
    opts = function()
      return require "configs.avante"
    end,
    config = function(_, opts)
      require("avante_lib").load()
      require("avante").setup(opts)
    end,
    event = "VeryLazy",
    version = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "echasnovski/mini.pick", -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "stevearc/dressing.nvim", -- for input provider dressing
      "folke/snacks.nvim", -- for input provider snacks
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
  { "nvim-tree/nvim-tree.lua", enabled = true }, -- Left file tree
  { -- Formatter
    "stevearc/conform.nvim",
    enabled = true,
    event = "BufWritePre", -- format on save
    opts = require "configs.conform", -- in fetched update
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
    end,
  },
  { -- File navigator tree
    "stevearc/aerial.nvim",
    enabled = true,
    opts = {},
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      -- "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require "configs.aerial"
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
  { -- Show context of current function at top
    "nvim-treesitter/nvim-treesitter-context",
    lazy = true,
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
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        presets = {
          bottom_search = false, -- use a classic bottom cmdline for search
          command_palette = false, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
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
    "nvim-telescope/telescope.nvim",
    enabled = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzf-native.nvim", -- for fuzzy.nvim
      -- "fcying/telescope-ctags-outline.nvim", -- for outline
      build = "make",
      config = function()
        require("telescope").load_extension "fzf"
      end,
    },
  },
  {
    "hrsh7th/nvim-cmp",
    enabled = true,
    dependencies = {
      "delphinus/cmp-ctags",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-path",
      "ray-x/cmp-treesitter",
      "tzachar/fuzzy.nvim",
      "tzachar/cmp-fuzzy-buffer",
      "tzachar/cmp-fuzzy-path",
      "zbirenbaum/cmp-copilot",
    },
    config = function()
      require "configs.cmp"
    end,
  },
  {
    "ThePrimeagen/harpoon",
    enabled = true,
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
  { "cespare/vim-toml", enabled = true }, -- add toml syntax
  { "tpope/vim-surround", enabled = true, event = "VeryLazy" }, -- surround with `csw"`
  { "jeetsukumaran/vim-indentwise", enabled = false, event = "VeryLazy" }, -- move based on indent
  { "tmhedberg/SimpylFold", enabled = true, event = "VeryLazy" }, -- for python
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
  { "williamboman/mason-lspconfig.nvim", enabled = false },
  {
    "richardbizik/nvim-toc",
    enabled = false,
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
