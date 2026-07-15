{ fetchFromGitHub }:
{
  name = "codedocs-nvim";
  version = "2026-07-13";

  src = fetchFromGitHub {
    owner = "jeangiraldoo";
    repo = "codedocs.nvim";
    rev = "880d125f48d6da5bdf5fc47ca56cc4a0fc66dac0";
    hash = "sha256-aoYhVUSmjri2R3qH+9Js9YffSs8aLxlOL9NCCEzZICQ=";
  };
}
