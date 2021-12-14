{self, config, lib, utils, ... }:
let 

  vars = import ./vars.nix;

  dunstSettings = {
    global = {
      font = "Iosevka Term 11";
      markup = true;
      plain_text = false;
      format = "<b>%s</b>\n%b";
      sort = false;
      indicate_hidden = true;
      alignment = "center";
      bounce_freq = 0;
      show_age_threshold = -1;
      word_wrap = true;
      ignore_newline = false;
      stack_duplicates = true;
      hide_duplicate_count = true;
      corner_radius = 9;
      geometry = "300x50-15+49";
      shrink = false;
      transparency = 5;
      idle_threshold = 0;
      monitor = 0;
      follow = "none";
      sticky_history = true;
      history_length = 15;
      show_indicators = false;
      line_height = 3;
      separator_height = 2;
      padding = 6;
      horizontal_padding = 6;
      separator_color = "";
      browser = "";
      dmenu = "";
  };

in {

  services.dunst = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
      size = "32x32";
    };

    settings = dunstSettings;
