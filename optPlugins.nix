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
  extraPlugins = with neovimPlugins.packages.${pkgs.system}; [
  ];
in
pkgsPlugins ++ extraPlugins
