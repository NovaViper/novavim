{ pkgs }:
let
  packages = with pkgs; [
    # Base Dependencies
    binutils
    (ripgrep.override { withPCRE2 = true; })
    gnutls

    # LSP tools
    semgrep
    tree-sitter
    nodePackages.vscode-langservers-extracted
    yaml-language-server
    ## Nix
    nixd
    nil
    ## Lua
    stylua
    # sh
    shfmt
    shellcheck
    bashdb
    nodePackages.bash-language-server
    # PHP, CSS, Angular, JavaScript, Json
    nodePackages.prettier

    # checkers spell
    (aspellWithDicts (
      dicts: with dicts; [
        en
        en-computers
        en-science
      ]
    ))
    hunspell
    hunspellDicts.en_US

    # snacks.image
    imagemagick

    ghostscript
    mermaid-cli

    # yazi
    yazi
    pdf-tools
    cmake
  ];
in
packages
