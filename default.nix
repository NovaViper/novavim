{
  pkgs,
  mnw,
  neovimPlugins,
}:
let
  inherit (pkgs) callPackage;
  # Lists of derivations that we grab from external sources (nixpkgs and
  # neovimPlugins)
  # Check https://github.com/NixNeovim/NixNeovimPlugins/blob/main/plugins.md for updates
  startPlugins = import ./startPlugins.nix { inherit pkgs neovimPlugins; };
  optPlugins = import ./optPlugins.nix { inherit pkgs neovimPlugins; };
  binaries = import ./binaries.nix { inherit pkgs; };

  customStartPlugins = {
    gpg-nvim = callPackage ./other/startPlugins/gpg-nvim.nix { };
  };
  customOptPlugins = { };
  customBinaries = { };

in
mnw.lib.wrap pkgs {
  appName = "nvim";
  neovim = pkgs.neovim-unwrapped;
  initLua =
    # lua
    ''
      -- Uncomment when you want to profile nvim startup. Be sure to have
      -- the snacks.nvim repo cloned for this to work!

      --vim.opt.rtp:append("~/Documents/Repos/snacks.nvim")
      --require("snacks.profiler").startup()

      require("config")
      require("lz.n").load('lazy')
       
      -- Add to this whenever you add a new server to the `lsp` folder!
      -- Ridiculous that nvim can't load them for you as far as I can tell
      vim.lsp.enable({"bashls", "fish_lsp", "jsonls", "just", "lua_ls", "marksman", "nixd", "pyright", "rust_analyzer", "yamlls"})
    '';

  # List of plugins to load automatically
  plugins.start = startPlugins ++ builtins.attrValues customStartPlugins;
  # List of plugins to not load automatically (for lazy loading plugins)
  plugins.opt = optPlugins ++ builtins.attrValues customOptPlugins;
  # Extra packages to be put in neovim's PATH
  extraBinPath = binaries ++ builtins.attrValues customBinaries;

  # Extra lua packages (non vim plugins) to put into neovim's PATH
  extraLuaPackages = ps: [ ps.magick ];

  # Plugins which can be reloaded without rebuilding
  plugins.dev.config = {
    pure = ./nvim;
    impure = "~/Documents/Projects/novavim/nvim";
  };
}
