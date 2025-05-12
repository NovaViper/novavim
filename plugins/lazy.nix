{ pkgs, neovimPlugins }:

let
  pkgsPlugins = with pkgs.vimPlugins; [
    # Features
    which-key-nvim
    bufferline-nvim
    scope-nvim # For filtering buffers per tab
    yazi-nvim
    todo-comments-nvim
    cord-nvim

    # Pretty
    helpview-nvim # Very pretty vimdocs
  ];

  # Check https://github.com/NixNeovim/NixNeovimPlugins/blob/main/plugins.md
  extraPlugins = with neovimPlugins.packages.${pkgs.system}; [
  ];
in
pkgsPlugins ++ extraPlugins
