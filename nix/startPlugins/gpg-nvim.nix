{ fetchFromGitHub }:
{
  name = "gpg-nvim";
  version = "2026-02-08";

  src = fetchFromGitHub {
    owner = "benoror";
    repo = "gpg.nvim";
    rev = "26953b9c7486519c722f53ca372bba7bcb61a6bb";
    hash = "sha256-ZpMvBt4YwSLLT+2FjRuhQ3ZZ7sK6XVsLurT+R+iaN1I=";
  };
}
