{ vimUtils, fetchFromGitHub, ... }:
vimUtils.buildVimPlugin {
  name = "gpg-nvim";
  version = "2025-05-30";

  src = fetchFromGitHub {
    owner = "benoror";
    repo = "gpg.nvim";
    rev = "2e35ea9a94eb41e9f14224490f4391b72c3780d7";
    hash = "sha256-wWqzT8itSuIZgVBvQIXZmSn0MqvOg0i4MaKArg/2eS4=";
  };
}
