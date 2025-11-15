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
    nodePackages.bash-language-server
    #fish
    fish-lsp
    # PHP, CSS, Angular, JavaScript, Json
    nodePackages.prettier
    prettierd
    # Justfile
    just-lsp
    # Markdown
    marksman
    python3Packages.pylatexenc

    # checkers spell
    hunspell
    hunspellDicts.en_US

    # snacks.image
    imagemagick

    ghostscript
    #mermaid-cli

    # yazi
    yazi
    cmake
  ];
in
packages
