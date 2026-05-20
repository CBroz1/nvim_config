dofile(vim.g.base46_cache .. "telescope")

return {
  defaults = {
    prompt_prefix = "   ",
    selection_caret = " ",
    entry_prefix = " ",
    sorting_strategy = "ascending",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
      },
      width = 0.87,
      height = 0.80,
    },
    mappings = {
      n = { ["q"] = require("telescope.actions").close },
    },
    -- Configure ripgrep arguments for live_grep
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      -- Exclude Python temp files/dirs
      "--glob=!**/__pycache__/**",
      "--glob=!**/*.pyc",
      "--glob=!**/.pytest_cache/**",
      "--glob=!**/.mypy_cache/**",
      "--glob=!**/.ruff_cache/**",
      "--glob=!**/*.egg-info/**",
      "--glob=!**/dist/**",
      "--glob=!**/.tox/**",
      "--glob=!**/site/**",
      "--glob=!.git/",
    },
    -- Additional file ignore patterns (applies to find_files and live_grep)
    file_ignore_patterns = {
      "%.pyc$",
      "__pycache__/",
      "%.pytest_cache/",
      "%.mypy_cache/",
      "%.ruff_cache/",
      "%.egg%-info/",
      "%.tox/",
      "%.git/",
    },
  },

  pickers = {
    find_files = {
      -- Include hidden files but respect specific ignores
      hidden = true,
      -- Don't respect gitignore for .md and .txt files
      find_command = {
        "rg",
        "--files",
        "--hidden",
        "--glob=!.git/",
        "--glob=!**/__pycache__/**",
        "--glob=!**/*.pyc",
      },
    },
    live_grep = {
      -- Additional options for live grep
      additional_args = function()
        return {
          "--hidden",
          "--no-ignore-vcs", -- Don't respect .gitignore
          "--glob=!.git/",
          "--glob=!**/.pytest_cache/**",
          "--glob=!**/__pycache__/**",
          "--glob=!**/.mypy_cache/**",
          "--glob=!**/.ruff_cache/**",
          "--glob=!**/*.egg-info/**",
          "--glob=!**/.tox/**",
        }
      end,
    },
  },

  extensions_list = { "themes", "terms", "fzf", "aerial" },
  extensions = {},
}
