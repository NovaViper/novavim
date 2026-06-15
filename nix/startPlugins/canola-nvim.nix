{ fetchFromGitHub }:
{
  name = "canola-nvim";
  version = "2026-05-09";
  src = fetchFromGitHub {
    owner = "barrettruth";
    repo = "canola.nvim";
    rev = "5f35cd57b2a96c490102cb74c1551a65c3bf7cf7";
    hash = "sha256-NspywHVDp6c7Zw4b2M41OuULVlhGtGI0tj8LxP3x7SM=";
  };
}
