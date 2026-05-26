{ fetchFromGitHub }:
{
  name = "canola-collection";
  version = "2026-04-25";

  src = fetchFromGitHub {
    owner = "barrettruth";
    repo = "canola-collection";
    rev = "8566c09080c3084db1ffba21dec53e2b4235daed";
    hash = "sha256-iQh/QeKeELxNsWsWPO/GsNiYdXhZM7vv7Q0uQjO4sJE=";
  };
}
