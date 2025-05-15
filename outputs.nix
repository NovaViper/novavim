{
  self,
  nixpkgs,
  mnw,
  neovimPlugins,
  systems,
  ...
}@inputs:
let
  inherit (nixpkgs) lib;
  internals = {
    sys = import systems;

    forEachSystem = function: lib.genAttrs internals.sys (system: function internals.pkgsFor.${system});
    pkgsFor = lib.genAttrs internals.sys (
      system:
      import nixpkgs {
        inherit system;
        #overlays = builtins.attrValues self.outputs.overlays;
        #config.allowUnfree = true;
      }
    );
  };

in
{
  packages = internals.forEachSystem (
    pkgs:
    let
      # Lists of derivations that we grab from external sources (nixpkgs and
      # neovimPlugins)
      # Check https://github.com/NixNeovim/NixNeovimPlugins/blob/main/plugins.md for updates
      nonLazyPlugins = import ./plugins/nonLazy.nix { inherit pkgs neovimPlugins; };
      lazyPlugins = import ./plugins/lazy.nix { inherit pkgs neovimPlugins; };
      packages = import ./packages.nix { inherit pkgs; };
    in
    {
      default = mnw.lib.wrap pkgs {
        appName = "nvim";
        neovim = pkgs.neovim-unwrapped;
        initLua =
          # lua
          ''
            -- Uncomment when you want to profile nvim startup. Be sure to have
            -- the snacks.nvim repo cloned for this to work!

            --vim.opt.rtp:append("~/Documents/Repos/snacks.nvim")
            --require("snacks.profiler").startup()

            require("config")
            require("lz.n").load('lazy')
             
            -- Add to this whenever you add a new server to the `lsp` folder!
            -- Ridiculous that nvim can't load them for you as far as I can tell
            vim.lsp.enable({"bashls", "fish_lsp", "jsonls", "just", "lua_ls", "marksman", "nixd", "pyright", "rust_analyzer", "yamlls"})
          '';

        # List of plugins to load automatically
        plugins.start = nonLazyPlugins;
        # List of plugins to not load automatically (for lazy loading plugins)
        plugins.opt = lazyPlugins;

        # Extra lua packages (non vim plugins) to put into neovim's PATH
        extraLuaPackages = ps: [ ps.magick ];

        # Extra packages to be put in neovim's PATH
        extraBinPath = packages;

        # Plugins which can be reloaded without rebuilding
        plugins.dev.config = {
          pure = ./nvim;
          impure = "~/Documents/Projects/novavim/nvim";
        };
      };
    }
  );

  # Hotload neovim configs
  devShells = internals.forEachSystem (pkgs: {
    default = pkgs.mkShellNoCC {
      packages = [ self.packages.${pkgs.system}.default.devMode ];
    };
  });
}
