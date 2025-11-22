{ vimUtils, fetchFromGitHub, ... }:
vimUtils.buildVimPlugin {
  name = "gpg-nvim";
  version = "2025-10-30";

  src = fetchFromGitHub {
    owner = "benoror";
    repo = "gpg.nvim";
    rev = "e86411b07863718169d634c6361f0e0120ed7a83";
    hash = "sha256-leolCPQN4IVz2eAAsY4ZlBNjzv77ZJWmMDzv5o/BAOI=";
  };
}
