{
  pkgs,
  mnw,
}:
let
  inherit (pkgs) callPackage;
  startPlugins = import ./nix/startPlugins.nix { inherit pkgs; };
  optPlugins = import ./nix/optPlugins.nix { inherit pkgs; };
  binaries = import ./nix/binaries.nix { inherit pkgs; };

  customStartPlugins = {
    gpg-nvim = callPackage ./nix/startPlugins/gpg-nvim.nix { };
    catppuccin = callPackage ./nix/startPlugins/catppuccin.nix { };
  };
  customOptPlugins = { };
  customBinaries = { };

in
mnw.lib.wrap pkgs {
  appName = "nvim";
  neovim = pkgs.neovim-unwrapped;
  luaFiles = [ ./init.lua ];

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
