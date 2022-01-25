{ config, pkgs, lib, ... }:

let

  defaultPackages = with pkgs; [
    cmatrix        # funny matrix
    niv            # easy dependency management for nix
    nix-doc        # interactive Nix documentation tool
    zinit          # zsh plugin manager
  ];

  dictPackages = with pkgs.aspellDicts; [ en fr ];

  gitPackages = with pkgs.gitAndTools; [
    diff-so-fancy  # git diff with colours
    hub            # github cli
  ];

  haskellPackages = with pkgs.haskellPackages; [
    xmobar
  ];

  nodePackages = with pkgs.nodePackages; [
    stylelint
    js-beautify
  ];

  obsPlugins = with pkgs.obs-studio-plugins; [
    obs-gstreamer  # obs plugin to add gstreamer support
  ];

  pythonPackages = with pkgs.python39Packages; [
    black          # python formatting tool
    ipython        # python shell prompt
    isort          # sort python imports
    nose           # python testing utility
    pip            # python package manager
    pyflakes       # error checker
    pytest         # python testing utility
    (python-lsp-server.override {
      withPycodestyle = true;
      withPydocstyle = true;
      withRope = true;
      # withMypy = true;
    })
    # python-lsp-black
    # pylsp-mypy
  ];

  luaPackages = with pkgs.luaPackages; [
    luacheck
  ];

  myPolybar = pkgs.polybar.override {
    alsaSupport = true;
    githubSupport = true;
    mpdSupport = true;
    pulseSupport = true;
  };

in
{
  imports = [
    ./modules/shell
    ./modules/nvim
    ./modules/xmonad
    ./modules/bspwm.nix
    ./modules/starship.nix
    # ./modules/emacs.nix
    # ./modules/dunst.nix
    ./modules/mpv.nix
    # ./modules/vscode.nix
    ./modules/direnv.nix
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "insertdead";
  home.homeDirectory = "/home/insertdead";

  # programs.emacs = {
  #   enable = true;
  #   extraPackages = epkgs: [ epkgs.vterm epkgs.org-roam ];
  # };
  programs.git = {
    enable = true;
    delta.enable = true;

    # Identification and GPG
    userEmail = "mdsc0111@tuta.io";
    userName = "insertdead";
    signing.signByDefault = true;
    signing.key = "0277F95B87855378";

    aliases = {
      a = "add";
      c  = "clone";
      p  = "push";
      co = "checkout";
      m  = "commit";
      s  = "status";
    };
    extraConfig = {};
  };

  services.mpris-proxy.enable = true;
  
  # services.gpg-agent = {
  #   enable = true;
  #   pinentryFlavor = "gnome3";
  #   maxCacheTtl = 86400;
  #   enableSshSupport = true;
  #   extraConfig = "allow-preset-passphrase";
  # };

  services.polybar = {
    enable = false;
    package = myPolybar;
    config = ~/.config/polybar/polybar.ini;
    script = ''polybar main &'';
  };

  services.unclutter.enable = true;

  # programs.gpg = {
  #   enable = true;
  #   homedir = "${config.xdg.dataHome}/gnupg";
  # };

  programs.jq.enable = true;

  programs.ncmpcpp = {
    enable = false;
    bindings = [
      { key = "j"; command = "scroll_down"; }
      { key = "k"; command = "scroll_up";  }
      { key = "J"; command = [ "select_item" "scroll_down" ]; }
      { key = "K"; command = [ "select_item" "scroll_up" ];  }
    ];
    mpdMusicDir = ~/Music;
    settings = {};
  };

  programs.nix-index = {
    enable = true;
    enableZshIntegration = true;
  };

  # password manager for nerds
  programs.password-store = {
    enable = true;
    package = pkgs.pass.withExtensions (exts: [ exts.pass-otp]);
    settings = {
      PASSWORD_STORE_DIR = "${config.xdg.dataHome}/password-store";
      PASSWORD_STORE_KEY = "8B83DD4703D12B59A9CF29222C1BDB03FB358F1D";
      PASSWORD_STORE_CLIP_TIME = "30";
    };
  };

  /* programs.rofi = { */
  /*   enable = true; */
  /*   package = with pkgs; (rofi.override {plugins=[rofi-emoji rofi-calc];}); */
  /*   theme = "${config.xdg.configHome}/rofi/nord.rasi"; */
  /*   extraConfig = { modi = "window,drun,run,ssh"; }; */
  /*   pass.enable = true; */
  /*   pass.stores = [ "${config.xdg.dataHome}/password-store" ]; */
  /* }; */

  programs.ssh.enable = true;

  programs.zathura = {
    enable = true;
    options = { default-bg = "#282c34"; default-fg = "#abb2bf"; };
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
  };

  # xresources.extraConfig = builtins.readFile ( ~/.config/x11/xresources );

  nixpkgs.overlays = [
    (import (builtins.fetchTarball https://github.com/nix-community/emacs-overlay/archive/master.tar.gz))
    (import (builtins.fetchTarball https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz))
  ];

  # Packages
  home.packages = defaultPackages ++ gitPackages ++ haskellPackages ++ nodePackages ++ pythonPackages ++ luaPackages;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.05";
}
