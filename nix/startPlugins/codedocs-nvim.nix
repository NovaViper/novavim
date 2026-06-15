{ fetchFromGitHub }:
{
  name = "codedocs-nvim";
  version = "2026-05-30";

  src = fetchFromGitHub {
    owner = "jeangiraldoo";
    repo = "codedocs.nvim";
    rev = "fd0893eb46056dd44e171b81ffd45468ed686977";
    hash = "sha256-JzQ4DYhBWSNZGcXA1ChH0ObekeNcVCikdMhGgLcmzfQ=";
  };
}
