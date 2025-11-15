{ pkgs, neovimPlugins }:

let
  pkgsPlugins = with pkgs.vimPlugins; [
    # Features
    which-key-nvim
    yazi-nvim

    # Pretty
    helpview-nvim # Very pretty vimdocs
  ];

  # Check https://github.com/NixNeovim/NixNeovimPlugins/blob/main/plugins.md
  extraPlugins = with neovimPlugins.packages.${pkgs.stdenv.hostPlatform.system}; [ ];
in
pkgsPlugins ++ extraPlugins
