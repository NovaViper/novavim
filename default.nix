{
  pkgs,
  mnw,
}:
let
  args = { inherit pkgs; };
in
mnw.lib.wrap pkgs {
  appName = "nvim";
  neovim = pkgs.neovim-unwrapped;
  luaFiles = [ ./init.lua ];

  plugins = {
    # List of plugins to load automatically
    startAttrs = import ./nix/startPlugins.nix args;

    # Expose tree-sitter grammars for use in start plugins
    start = import ./nix/treesitter.nix args;

    # List of plugins to not load automatically (for lazy loading plugins)
    optAttrs = import ./nix/optPlugins.nix args;

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
