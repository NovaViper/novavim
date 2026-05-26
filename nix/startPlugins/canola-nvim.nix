{ fetchFromGitHub }:
{
  name = "canola-nvim";
  version = "2026-05-09";
  src = fetchFromGitHub {
    owner = "barrettruth";
    repo = "canola.nvim";
    rev = "3838f1380e9aeea0597a80beb6ab28da73e38525";
    hash = "sha256-NspywHVDp6c7Zw4b2M41OuULVlhGtGI0tj8LxP3x7SM=";
  };
}
