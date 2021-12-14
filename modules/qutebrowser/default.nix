{ config, lib, pkgs, ... }:

{
  programs.qutebrowser.settings = {
    # Theming
    colors = {
      hints = {
        fg = "#e5e9f0";
        bg = "#5e81ac";
      };
      downloads = {
        bar = {
          fg = "#e5e9f0";
          bg = "#2e3440";
        };
      };
    };
    # Privacy
    content = {
      headers.user_agent = "Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101 Firefox/91.0";
      # Javascript settings, default disabled for privacy reasons
      javascript = {
        enabled = false;
      };
    };
  };
}
