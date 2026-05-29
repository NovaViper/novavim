{ vimPlugins, fetchFromGitHub }:

# Contains `workspace.ignoreDir` fix and rebased against main repo
vimPlugins.lazydev-nvim.overrideAttrs {
  src = fetchFromGitHub {
    owner = "llakala";
    repo = "lazydev.nvim";
    rev = "db0d06fe661178fa5baab3e66b307eb706d97804";
    hash = "sha256-gIrkzt98QnMcdtfSJZk+biGcdomU3Prv8CWqAJJE0Fs=";
  };
}
