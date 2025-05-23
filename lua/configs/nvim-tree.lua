require("nvim-tree").setup {
  hijack_cursor = true,
  view = { adaptive_size = false },
  renderer = {
    highlight_git = false,
    icons = {
      git_placement = "after",
      glyphs = { folder = { default = "" } },
    },
  },
  filters = {
    custom = {
      "^.git$",
      "*.egg-info",
      "^.idea*",
      "*.github",
      "*.ipynb_checkpoints",
      ".DS_Store",
      ".coverage",
      ".git_archival.txt",
      ".gitattributes",
      ".gitignore",
      ".markdownlint.yaml",
      ".null-ls*",
      ".pytest_cache",
      ".ruff_cache",
      ".vscode*",
      "CITATION.cff",
      "CODE_OF_CONDUCT.md",
      "LICENSE",
      "MANIFEST.in",
      "README.md",
      "__pycache__",
      -- "config/*",
      "dj_local_config_example.json",
      "environment.yml",
      "environment_dlc.yml",
      "examples",
      "franklab_scripts",
      "node_modules",
      "notebook-images",
      "notebooks",
      "package-lock.json",
      "setup.cfg",
    },
  },
  actions = {
    open_file = { window_picker = { chars = "neio" } },
    remove_file = { close_window = true },
  },
}
