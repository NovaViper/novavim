{ pkgs }:
let
  pkgsPlugins = with pkgs.vimPlugins; [
    # Basic essentials
    nvim-treesitter.withAllGrammars
    nvim-lspconfig
    lz-n

    # Features
    tiny-inline-diagnostic-nvim
    auto-session
    conform-nvim
    ts-comments-nvim
    snacks-nvim
    mini-nvim
    todo-comments-nvim
    trouble-nvim
    orgmode # TODO: Remove later

    # Completions
    blink-cmp

    # Pretty
    nvim-highlight-colors
    rainbow-delimiters-nvim
    indent-blankline-nvim
    gitsigns-nvim
    render-markdown-nvim
    markdown-preview-nvim
    vim-tpipeline # Tmux

    # git setup
    plenary-nvim
    diffview-nvim

    # Neat
    barbar-nvim
    lualine-nvim
    cord-nvim
    stay-centered-nvim

    # Other
    lazydev-nvim
    nvim-web-devicons # Fancy icons
  ];
in
pkgsPlugins
