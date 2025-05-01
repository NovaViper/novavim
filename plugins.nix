{
  lib,
  pkgs,
  neovimPlugins,
}:
let
  #tree-sitter-plugins = p: with p; [ tree-sitter-org-nvim ];

  pkgsPlugins = with pkgs.vimPlugins; [
    # Basic essentials
    nvim-treesitter
    #(nvim-treesitter.withPlugins tree-sitter-plugins)
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

    # Completions
    blink-cmp

    # Pretty
    nvim-highlight-colors
    rainbow-delimiters-nvim
    indent-blankline-nvim
    helpview-nvim # Very pretty vimdocs
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
    fzf-lua

    nvim-web-devicons # For bufferline
  ];
in
pkgsPlugins ++ extraPlugins
