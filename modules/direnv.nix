{ self, config, pkgs, lib, utils, ... }:
let
  direnvConfig = {
    global.skip_dotenv = true;
    global.strict_env = true;
    whitelist = {
      prefix = [
        "/home/insertdead/git/"
      ];
    };
  };
in {
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    config = direnvConfig;
    nix-direnv.enable = true;
  };
}
