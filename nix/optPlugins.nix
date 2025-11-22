{ pkgs }:

let
  pkgsPlugins = with pkgs.vimPlugins; [
    # Features
    which-key-nvim
    yazi-nvim

    # Pretty
    helpview-nvim # Very pretty vimdocs
  ];
in
pkgsPlugins
