{ fetchFromGitHub }:
# Retrieved via nurl https://github.com/barrettruth/canola.nvim "$(git ls-remote https://github.com/barrettruth/canola.nvim refs/heads/canola | cut -f1)"
{
  name = "canola-nvim";
  version = "2026-07-20";
  src = fetchFromGitHub {
    owner = "barrettruth";
    repo = "canola.nvim";
    rev = "d7c349fd0ffc3d6e8eceefdf66af66cb1ab42826";
    hash = "sha256-D2RAZiGasqVc4tMj9XU+M9o9oCoGF5zjV+w1eLvzeKQ=";
  };
}
