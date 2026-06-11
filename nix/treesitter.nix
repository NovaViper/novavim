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
  # TODO: Until https://github.com/NixOS/nixpkgs/pull/530059 is merged
  # extra-grammars = with pkgs.tree-sitter-grammars; [
  #   tree-sitter-org
  # ];
  extra-grammars = [
    (pkgs.tree-sitter.buildGrammar rec {
      language = "org";
      version = "2.0.4";
      src = pkgs.fetchFromGitHub {
        inherit version;
        owner = "nvim-orgmode";
        repo = "tree-sitter-org";
        rev = "2.0.4";
        hash = "sha256-76ImC8GMW+yAKG++AHryUi+MYTmtJ5ogygC+bgNMErA=";
      };
    })
  ];
in
[ my-treesitter ] ++ extra-grammars
