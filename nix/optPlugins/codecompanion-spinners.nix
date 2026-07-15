{ fetchFromGitHub }:
{
  name = "codecompanion-spinners-nvim";
  version = "2026-06-22";

  src = fetchFromGitHub {
    owner = "lalitmee";
    repo = "codecompanion-spinners.nvim";
    rev = "f613a543ca8c7ba1686830c6bb1a10d15a2e1942";
    hash = "sha256-SOjECXjHu+JjGIAFDFroOyHsBqYGK3+xZ8f7w7yjFvQ=";
  };
}
