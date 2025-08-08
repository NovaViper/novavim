{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    mnw.url = "github:Gerg-L/mnw";
    systems.url = "github:nix-systems/default-linux";

    neovimPlugins = {
      url = "github:NixNeovim/NixNeovimPlugins";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      neovimPlugins,
      ...
    }@inputs:
    let
      inherit (nixpkgs) lib;
      sys = import inputs.systems;

      forEachSystem = function: lib.genAttrs sys (system: function pkgsFor.${system});
      pkgsFor = lib.genAttrs sys (
        system:
        import nixpkgs {
          inherit system;
          #overlays = builtins.attrValues self.outputs.overlays;
          #config.allowUnfree = true;
        }
      );
    in
    {
      # These neovim* outputs are used for testing custom packaged content in
      # REPL.

      # We comment this out for now, because `packagesFromDirectoryRecursive` will
      # error if the folder is empty.
      neovimStartPlugins = forEachSystem (
        pkgs:
        lib.packagesFromDirectoryRecursive {
          inherit (pkgs) callPackage;
          directory = ./other/startPlugins;
        }
      );

      # See above!
      neovimOptPlugins = forEachSystem (
        pkgs: { }
        # lib.packagesFromDirectoryRecursive {
        #   inherit (pkgs) callPackage;
        #   directory = ./other/optPlugins;
        # }
      );

      neovimBinaries = forEachSystem (
        pkgs: { }
        # lib.packagesFromDirectoryRecursive {
        #   inherit (pkgs) callPackage;
        #   directory = ./other/binaries;
        # }
      );

      packages = forEachSystem (
        pkgs:
        let
          # Lists of derivations that we grab from external sources (nixpkgs and
          # neovimPlugins)
          # Check https://github.com/NixNeovim/NixNeovimPlugins/blob/main/plugins.md for updates
          startPlugins = import ./startPlugins.nix { inherit pkgs neovimPlugins; };
          optPlugins = import ./optPlugins.nix { inherit pkgs neovimPlugins; };
          binaries = import ./binaries.nix { inherit pkgs; };

          # Derivations of the custom packages/plugins turned into a list.
          customStartPlugins = builtins.attrValues self.neovimStartPlugins.${pkgs.system};
          customOptPlugins = builtins.attrValues self.neovimOptPlugins.${pkgs.system};
          customBinaries = builtins.attrValues self.neovimBinaries.${pkgs.system};
        in
        {
          default = inputs.mnw.lib.wrap pkgs {
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
            plugins.start = startPlugins ++ customStartPlugins;
            # List of plugins to not load automatically (for lazy loading plugins)
            plugins.opt = optPlugins ++ customOptPlugins;

            # Extra packages to be put in neovim's PATH
            extraBinPath = binaries ++ customBinaries;

            # Extra lua packages (non vim plugins) to put into neovim's PATH
            extraLuaPackages = ps: [ ps.magick ];

            # Plugins which can be reloaded without rebuilding
            plugins.dev.config = {
              pure = ./nvim;
              impure = "~/Documents/Projects/novavim/nvim";
            };
          };
        }
      );

      # Hotload neovim configs
      devShells = forEachSystem (pkgs: {
        default = pkgs.mkShellNoCC {
          packages = lib.singleton self.packages.${pkgs.system}.default.devMode;
        };
      });
    };
}
