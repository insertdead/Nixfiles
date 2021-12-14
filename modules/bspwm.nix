{self, config, pkgs, lib, utils, ... }:
let

  vars = import ./vars.nix;

  bspwmRules = {
    discord = { desktop = "^6"; };
    Emacs = { state = "tiled"; };
    Firefox = { desktop = "^2"; };
    Gimp = {
      desktop = "^8";
      state = "floating";
      follow = true;
    };
    mpv = {
      state = "floating";
      sticky = true;
    };
    slop = { manage = false; };
  };

  bspwmSettings = {
    normal_border_color = vars.normBg;
    active_border_color = vars.normFg;
    border_width = 2;
    window_gap = 24;

    split_ratio = 0.52;
    borderless_monocle = true;
    gapless_monocle = true;

    focus_follows_pointer = true;
    pointer_follows_monitor = true;
  };

in {

  xsession.windowManager.bspwm = {
    enable = false;
    monitors = { eDP-1 = [ "dev" "www" "www" "sys" "doc" "games" "chat" "mus" "vid" "gfx"  ]; };
    rules = bspwmRules;
    settings = bspwmSettings;
    startupPrograms = [ "sxhkd" "dunst" ];
  };
}
