{ fetchFromGitHub }:
{
  name = "codedocs-nvim";
  version = "2026-05-14";

  src = fetchFromGitHub {
    owner = "jeangiraldoo";
    repo = "codedocs.nvim";
    rev = "5dcd74b69d9eff5ae3ff97b33f3703b2058f3e1b";
    hash = "sha256-y11cEukrEfzGmdHEEcHR7/a6bR/39kHPf03q70z9zTU=";
  };
}
