local hostname = vim.fn.hostname()
local username = vim.env.USER
return {
  settings = {
    nixd = {
      options = {
        nixos = {
          expr = string.format(
            '(builtins.getFlake ("git+file://" + toString ./.)).nixosConfigurations.%s.options',
            hostname
          ),
        },
        home_manager = {
          expr = string.format(
            '(builtins.getFlake ("git+file://" + toString ./.)).nixosConfigurations.%s.options.home-manager.users.type.getSubOptions []',
            hostname
          ),
        },
      },
    },
  },
  cmd = {
    "nixd",
    "--inlay-hints=false",
    "--semantic-tokens=true", -- NEEDED, makes syntax highlighting much better
  },
}
