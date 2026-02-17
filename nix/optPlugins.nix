{ pkgs }:
let
  inherit (pkgs) callPackage vimPlugins;

  # Plugins not available on nixpkgs
  customPlugins = { };

  # Plugins from nixpkgs
  fromNixpkgs = with vimPlugins; [
    # Features
    which-key-nvim
    yazi-nvim
    venv-selector-nvim

    # Pretty
    helpview-nvim # Very pretty vimdocs
    render-markdown-nvim

    # Copilot
    copilot-lua
    blink-copilot
    # copilot-lualine
    codecompanion-nvim
    codecompanion-spinner-nvim
    codecompanion-history-nvim
  ];

  # Disables/overrides for start plugins
  overrides = {
    "codecompanion.nvim" = null;
  };

  # Convert list to attrset
  nixpkgsAttrs = builtins.listToAttrs (
    map (pkg: {
      name = pkg.pname or pkg.name;
      value = pkg;
    }) fromNixpkgs
  );

  # Merge custom and nixpkgs plugins
  optAttrs = customPlugins // nixpkgsAttrs;
in
optAttrs
