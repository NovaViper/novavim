{ fetchFromGitHub }:
# Retrieved via nurl https://github.com/barrettruth/canola.nvim "$(git ls-remote https://github.com/barrettruth/canola.nvim refs/heads/canola | cut -f1)"
{
  name = "canola-nvim";
  version = "2026-10-27";
  src = fetchFromGitHub {
    owner = "barrettruth";
    repo = "canola.nvim";
    rev = "72db4d9f4b33832d5b6f4886c7751e1ffa5fc7be";
    hash = "sha256-P/1OJ1OCJwzaSTtOhHyuUF3qtHPbxOfF4p1YkCLljHg=";
  };
}
