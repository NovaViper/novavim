{ fetchFromGitHub }:

{
  name = "catppuccin";
  version = "2025-11-14";
  src = fetchFromGitHub {
    owner = "catppuccin";
    repo = "nvim";
    rev = "da33755d00e09bff2473978910168ff9ea5dc453";
    hash = "sha256-OAQpO/VxdGWbGTpOdPZTAB60QqmZSVrSO0onTxADpZA=";
  };

  nvimSkipModules = [
    "catppuccin.groups.integrations.noice"
    "catppuccin.groups.integrations.feline"
    "catppuccin.lib.vim.init"
  ];
}
