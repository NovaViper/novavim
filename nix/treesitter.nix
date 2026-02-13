{ pkgs }:
let
  # To see all valid values, search this:
  # https://search.nixos.org/packages?channel=unstable&sort=alpha_asc&type=packages&query=vimPlugins.nvim-treesitter-parsers
  # Some languages like Lua aren't included bc nvim already includes them
  my-treesitter = pkgs.vimPlugins.nvim-treesitter.withAllGrammars;
  #my-treesitter = pkgs.vimPlugins.nvim-treesitter.withPlugins (p: with p; []);
in
[ my-treesitter ]
