{self, config, pkgs, lib, utils, ... }:
{

  home.packages = with pkgs; [
    haskellPackages.xmobar
  ];

  # xdg = {
  #   enable = true;

  #   configHome = /home/insertdead;

  #   configFile = {

  #     xmonad_config = {
  #       target = ".xmonad";
  #       source = ./xmonad;
  #     };

  #     xmobar_config = {
  #       target = ".config/xmobar/xmobarrc";
  #       source = ./xmobarrc;
  #     };
  #   };
  # };

  xsession.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    config = ./xmonad/xmonad.hs;
  };
}
