{ fetchFromGitHub }:
{
  name = "venv-selector-nvim";
  version = "2026-02-22";

  src = fetchFromGitHub {
    owner = "linux-cultist";
    repo = "venv-selector.nvim";
    rev = "59adce1481e2a182bc1e4d706869b069f19b32ba";
    hash = "sha256-t6dYFe+w5S2rrEFJ4zLsFXhRvW2ut4l+ZcJhta9ObjE=";
  };
}
