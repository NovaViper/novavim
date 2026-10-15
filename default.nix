{
  pkgs,
  mnw,
}:
let
  args = { inherit pkgs; };
in
mnw.lib.wrap pkgs {
  appName = "nvim";
  aliases = [
    "vi"
    "vim"
  ];
  # neovim = pkgs.neovim-unwrapped;
  neovim = pkgs.neovim-unwrapped.overrideAttrs (oldAttrs: {
    doCheck = false;
    doInstallCheck = false;
    src = pkgs.fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = "6edb38ca982c96645185c82c1f5b5cb474487f71";
      hash = "sha256-wXdoj2iImcMsV4osZll+KcVYkCKGgtmZYx5glgGAvQs="; # pkgs.lib.fakeHash;
    };
  });
  luaFiles = [ ./init.lua ];

  plugins = {
    # List of plugins to load automatically
    startAttrs = import ./nix/startPlugins.nix args;

    # Expose tree-sitter grammars for use in start plugins
    start = import ./nix/treesitter.nix args;

    # List of plugins to not load automatically (for lazy loading plugins)
    optAttrs = import ./nix/optPlugins.nix args;

    # Plugins which can be reloaded without rebuilding
    # HACK: Prefixing the name with _ to force the configs to be read first when
    # iterating through all `plugin/` files. This prevents plugins (like canola)
    # from trying to read vim.g.* values before they're set!
    dev._config = {
      pure = ./nvim;
      impure = "~/Projects/novavim/nvim";
    };
  };

  # Extra packages to be put in neovim's PATH
  extraBinPath = import ./nix/binaries.nix { inherit pkgs; };

  # Extra lua packages (non vim plugins) to put into neovim's PATH
  extraLuaPackages = ps: [
    ps.magick # lua-snippet
    ps.jsregexp
  ];
}
