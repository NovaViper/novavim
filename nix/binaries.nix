{ pkgs }:
let
  myPythonPackages =
    ps: with ps; [
      debugpy
      pyflakes
      isort
      pytest
      black
      pip
      pipx
      pyinstaller
    ];

  packages = with pkgs; [
    # Base Dependencies
    binutils
    (ripgrep.override { withPCRE2 = true; })
    gnutls
    gcc

    # LSP tools
    semgrep
    tree-sitter
    nodePackages.vscode-langservers-extracted
    yaml-language-server
    ## Nix
    nixd
    nixfmt
    nil
    ## Python
    (python3.withPackages myPythonPackages)
    pyright
    pipenv
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
