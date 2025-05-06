{
  lib,
  pkgs,
  neovimPlugins,
}:
let
  pkgsPlugins = with pkgs.vimPlugins; [
    # Basic essentials
    nvim-treesitter.withAllGrammars
    nvim-lspconfig

    # Features
    tiny-inline-diagnostic-nvim
    auto-session
    conform-nvim
    yazi-nvim
    snacks-nvim
    mini-nvim
    which-key-nvim
    todo-comments-nvim

    # Completions
    blink-cmp

    # Pretty
    nvim-highlight-colors
    rainbow-delimiters-nvim
    indent-blankline-nvim
    helpview-nvim # Very pretty vimdocs
    gitsigns-nvim
    render-markdown-nvim
    markdown-preview-nvim

    # Neat
    bufferline-nvim
    scope-nvim # For filtering buffers per tab
    lualine-nvim
    cord-nvim

    # Other
    lazydev-nvim
  ];

  # Check https://github.com/NixNeovim/NixNeovimPlugins/blob/main/plugins.md
  extraPlugins = with neovimPlugins.packages.${pkgs.system}; [
    catppuccin

    # git setup
    neogit
    plenary-nvim
    diffview-nvim

    nvim-web-devicons # For bufferline
  ];
in
pkgsPlugins ++ extraPlugins
