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
      packages = import ./packages.nix { inherit pkgs; };
    in
    {
      default = mnw.lib.wrap pkgs {
        appName = "nvim";
        neovim = pkgs.neovim-unwrapped;
        initLua =
          # lua
          ''
            require("config")
            require("lsp")
          '';

        # The same as 'plugins' except for when running in dev mode add the absolute paths to 'devPluginPaths'
        devExcludedPlugins = lib.singleton ./nvim;

        # The impure absolute paths to nvim plugins the relative paths of which should be in devExcludedPlugins
        devPluginPaths = lib.singleton "~/Documents/novavim/nvim";

        extraLuaPackages = ps: [ ps.magick ];

        # Extra packages to be put in neovim's PATH
        extraBinPath = packages;

        # Check https://github.com/NixNeovim/NixNeovimPlugins/blob/main/plugins.md for updates
        plugins = import ./plugins.nix { inherit lib pkgs neovimPlugins; };
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
