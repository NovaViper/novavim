{ pkgs }:
let
  inherit (pkgs) callPackage vimPlugins;

  # Plugins from nixpkgs
  fromNixpkgs = with vimPlugins; [
    # Features
    which-key-nvim
    yazi-nvim

    # Pretty
    helpview-nvim # Very pretty vimdocs
    render-markdown-nvim
  ];

  # Plugins not available on nixpkgs
  customPlugins = { };
in
fromNixpkgs ++ (builtins.attrValues customPlugins)
