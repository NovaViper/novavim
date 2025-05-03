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
    nvim-autopairs
    tiny-inline-diagnostic-nvim
    auto-session
    conform-nvim
    yazi-nvim
    snacks-nvim
    which-key-nvim
    telescope-nvim
    telescope-fzf-native-nvim

    # Completions
    blink-cmp

    # Pretty
    nvim-highlight-colors
    rainbow-delimiters-nvim
    indent-blankline-nvim
    helpview-nvim # Very pretty vimdocs
    gitsigns-nvim
    #render-markdown-nvim
    #markdown-preview-nvim

    # Neat
    bufferline-nvim
    lualine-nvim

    # Other
    lazydev-nvim
  ];

  # Check https://github.com/NixNeovim/NixNeovimPlugins/blob/main/plugins.md
  extraPlugins = with neovimPlugins.packages.${pkgs.system}; [
    dracula-nvim

    # git setup
    neogit
    plenary-nvim
    diffview-nvim

    nvim-web-devicons # For bufferline
  ];
in
pkgsPlugins ++ extraPlugins
