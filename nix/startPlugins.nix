{ pkgs }:
let
  inherit (pkgs) callPackage vimPlugins;

  # Import disables from optPlugins.nix
  optPlugins = import ./optPlugins.nix { inherit pkgs; };
  overrides = optPlugins.overrides or { };

  # Plugins not available on nixpkgs
  customPlugins = {
    gpg-nvim = callPackage ./startPlugins/gpg-nvim.nix { };
  };

  # Plugins from nixpkgs
  fromNixpkgs = with vimPlugins; [
    # Theme
    catppuccin-nvim

    # Basic essentials
    nvim-treesitter.withAllGrammars
    nvim-lspconfig
    lze
    lzextras

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
    luasnip

    # Completions
    blink-cmp

    # Pretty
    nvim-highlight-colors
    rainbow-delimiters-nvim
    gitsigns-nvim
    vim-tpipeline # Tmux

    # git setup
    plenary-nvim
    diffview-nvim

    # Neat
    barbar-nvim
    scope-nvim # For filtering buffers per tab
    lualine-nvim
    cord-nvim
    stay-centered-nvim

    # Other
    lazydev-nvim
    nvim-web-devicons # Fancy icons
  ];

  # Convert list to attrset
  nixpkgsAttrs = builtins.listToAttrs (
    map (pkg: {
      name = pkg.pname or pkg.name;
      value = pkg;
    }) fromNixpkgs
  );

  # Merge custom and nixpkgs plugins
  baseAttrs = customPlugins // nixpkgsAttrs;

  # Apply disables/overrides (null disables plugin)
  startAttrs = baseAttrs // overrides;
in
startAttrs
