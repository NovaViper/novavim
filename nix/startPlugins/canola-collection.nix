{ fetchFromGitHub }:
# Retrieved via nurl https://github.com/barrettruth/canola-collection
{
  name = "canola-collection";
  version = "2026-10-31";

  src = fetchFromGitHub {
    owner = "barrettruth";
    repo = "canola-collection";
    rev = "970a1920d18a2172627da1c2f17cfe53fa4d6871";
    hash = "sha256-xZNpVXKZ/Ev2fhz/cC0AI+2lfGSF9g2p8YRZf6PGq10=";
  };
}
