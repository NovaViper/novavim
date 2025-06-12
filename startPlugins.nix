{
  pkgs,
  neovimPlugins,
}:
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

    # Completions
    blink-cmp

    # Pretty
    nvim-highlight-colors
    rainbow-delimiters-nvim
    indent-blankline-nvim
    gitsigns-nvim
    render-markdown-nvim
    markdown-preview-nvim

    # Neat
    bufferline-nvim
    scope-nvim # For filtering buffers per tab
    lualine-nvim
    cord-nvim
    stay-centered-nvim

    # Other
    lazydev-nvim
  ];

  # Check https://github.com/NixNeovim/NixNeovimPlugins/blob/main/plugins.md
  extraPlugins = with neovimPlugins.packages.${pkgs.system}; [
    catppuccin

    # git setup
    plenary-nvim
    diffview-nvim

    nvim-web-devicons # For bufferline
  ];
in
pkgsPlugins ++ extraPlugins
