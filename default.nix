{
  pkgs,
  mnw,
}:
mnw.lib.wrap pkgs {
  appName = "nvim";
  neovim = pkgs.neovim-unwrapped;
  luaFiles = [ ./init.lua ];

  plugins = {
    # List of plugins to load automatically
    start = import ./nix/startPlugins.nix { inherit pkgs; };

    # Stop gap to prevent plugin depdencies for optional plugins from being loaded
    startAttrs = {
      "codecompanion.nvim" = null;
    };

    # List of plugins to not load automatically (for lazy loading plugins)
    opt = import ./nix/optPlugins.nix { inherit pkgs; };

    # Plugins which can be reloaded without rebuilding
    dev.config = {
      pure = ./nvim;
      impure = "~/Documents/Projects/novavim/nvim";
    };
  };

  # Extra packages to be put in neovim's PATH
  extraBinPath = import ./nix/binaries.nix { inherit pkgs; };

  # Extra lua packages (non vim plugins) to put into neovim's PATH
  extraLuaPackages = ps: [ ps.magick ];
}
