{ pkgs }:
let
  # To see all valid values, search this:
  # https://search.nixos.org/packages?channel=unstable&sort=alpha_asc&type=packages&query=vimPlugins.nvim-treesitter-parsers
  # https://search.nixos.org/packages?channel=unstable&sort=alpha_desc&type=packages&query=tree-sitter-grammars.tree-sitter-
  # Some languages like Lua aren't included bc nvim already includes them
  my-treesitter = pkgs.vimPlugins.nvim-treesitter.withAllGrammars;
  # my-treesitter = pkgs.vimPlugins.nvim-treesitter.withPlugins (
  #   p: with p; [
  #     vim # Required
  #
  #     comment
  #     gitcommit
  #     lua
  #     luadoc
  #     nix
  #
  #     bash
  #     fish
  #     gitignore
  #     git_rebase
  #     java
  #     python
  #     typst
  #
  #     css
  #     csv
  #     diff
  #     html
  #     json
  #     toml
  #     yaml
  #     markdown
  #     markdown_inline
  #
  #     cpp
  #     javascript
  #     rust
  #     tsx
  #     typescript
  #   ]
  # );
  extra-grammars = with pkgs.tree-sitter-grammars; [
    tree-sitter-org
  ];
in
[ my-treesitter ] ++ extra-grammars
