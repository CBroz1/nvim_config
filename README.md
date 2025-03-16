**This repo is supposed to used as config by NvChad users!**

- The main nvchad repo (NvChad/NvChad) is used as a plugin by this repo.
- So you just import its modules , like `require "nvchad.options" , require "nvchad.mappings"`
- So you can delete the .git from this repo ( when you clone it locally ) or fork it :)

**NOTE:** If base46 or ui dependencies are causing issues, remove dependency
caches and reinstall them.

```bash
rm -rf ~/.local/share/nvim/
rm -rf ~/.local/state/nvim/
```

# Credits

1) Lazyvim starter <https://github.com/LazyVim/starter> as nvchad's starter was
inspired by Lazyvim's . It made a lot of things easier!
