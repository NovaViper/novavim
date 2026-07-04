{ fetchFromGitHub }:
{
  name = "codedocs-nvim";
  version = "2026-07-03";

  src = fetchFromGitHub {
    owner = "jeangiraldoo";
    repo = "codedocs.nvim";
    rev = "d20f3c4a72a7de3893593e33a157df2be5a9f60b";
    hash = "sha256-0NKm28KhM14WiAcBmCa7cdVW4zILeR3AKgTyeAH69TY=";
  };
}
