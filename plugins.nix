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

    # Pretty
    nvim-highlight-colors
    rainbow-delimiters-nvim
    helpview-nvim # Very pretty vimdocs
    render-markdown-nvim
    markdown-preview-nvim

    # Neat
    lualine-nvim
  ];

  # Check https://github.com/NixNeovim/NixNeovimPlugins/blob/main/plugins.md
  extraPlugins = with neovimPlugins.packages.${pkgs.system}; [
    dracula-nvim
    orgmode

    # git setup
    neogit
    plenary-nvim
    diffview-nvim
    fzf-lua

    nvim-web-devicons # For bufferline
  ];
in
pkgsPlugins ++ extraPlugins
