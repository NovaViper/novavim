{ fetchFromGitHub }:
{
  name = "codecompanion-spinners-nvim";
  version = "2025-10-11";

  src = fetchFromGitHub {
    owner = "lalitmee";
    repo = "codecompanion-spinners.nvim";
    rev = "86926cbf7554d69d40d2a5c3cf576063814a42d5";
    hash = "sha256-L+vG4wj2O1VaiHhhjBAi26nglW0WnPSTk8FihkK8cn0=";
  };
}
