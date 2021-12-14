{ config, pkgs, lib, ... }:

let

  defaultPackages = with pkgs; [
    aspell         # how too rite???
    arandr         # graphical xrandr interface
    brightnessctl  # manage brightness of screen, and nothing else
    blueman        # bluetooth management
    capitaine-cursors
    cht-sh         # oh my god this is so useful how have i not heard about this before
    cmatrix        # funny matrix
    clang_12       # alternative C/C++ compiler
    (discord-ptb.overrideAttrs (oldAttrs: rec {
      src = fetchTarball {
        url = "https://dl-ptb.discordapp.net/apps/linux/0.0.27/discord-ptb-0.0.27.tar.gz";
        sha256 = "0vwzp98hp3g1883z5kifhx85zvymk8b7jcffk98w64vvi2ibymg1";
      };
    }))    # proprietary messaging client
    discord-rpc    # enable IPC for discord
    element-desktop# matrix client
    fd             # find but awesome
    ffmpeg         # videos
    font-awesome   # font but awesome
    ghc            # haskell code compiler
    graphviz       # graphs for org-roam
    gimp           # photoshop
    html-tidy      # html validator
    htop           # GUYS IM ONLY USING 90MB RAM B)
    irony-server   # ironic
    libclang       # clang libraries
    libreoffice    # word but epic
    libqalculate   # calculator cli
    lua            # simple scripting language
    lxappearance   # change appearance
    maim           # screenshotting utility
    mypaint        # paint idk
    ncdu           # TUI for du
    neofetch       # ooh look at my cool distro
    niv            # easy dependency management for nix
    nix-doc        # interactive Nix documentation tool
    nixfmt         # format nix code
    nordic         # nord inspired gtk theme
    obs-studio     # funny recording software
    p7zip          # open source 7zip implementation
    pcmanfm-qt     # file manager
    pandoc         # document converter
    picom
    pinentry_gnome # gnome/GTK version of pinentry
    pipenv         # development environment for python
    poetry         # python dependency and packaging management
    pulsemixer     # PulseAudio TUI
    python39       # user-wide python version
    unzip          # unzipping utility
    qalculate-gtk  # calculator
    texlive.combined.scheme-full
    tor-browser-bundle-bin
    ripgrep        # usability of silver searcher and speed of grep
    # rofi           # versatile dmenu alternative
    # rofi-calc      # calculator plugin for rofi
    # rofi-emoji     # emoji selector
    ruby_3_0       # JIT language similar to python and perl
    rtags          # c/c++ code indexing based on clang
    shellcheck     # shell script analysis
    spotify        # music
    sqlite         # idk
    stix-two       # cool fonts
    sxiv           # simple image viewer for WMs
    syncthing      # syncing client between devices
    system-config-printer
    xclip          # emacs-everywhere dependency
    xdg-launch     # launch .desktop programs
    xorg.xwininfo  # emacs-everywhere dependency
    youtube-dl     # dl yt vids
    zinit          # zsh plugin manager
    zip            # zip
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

  rustPackages = with pkgs; [
    rustc
    cargo
    clippy
    rustfmt
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
    ./modules/vscode.nix
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "insertdead";
  home.homeDirectory = "/home/insertdead";

  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [ epkgs.vterm epkgs.org-roam ];
  };
  programs.git = {
    enable = true;
    delta.enable = true;

    # Identification and GPG
    userEmail = "mdsc0111@tuta.io";
    userName = "insertdead";
    signing.signByDefault = true;
    signing.key = "0277F95B87855378";

    aliases = {
      c  = "clone";
      p  = "push";
      co = "checkout";
      m  = "commit";
      s  = "status";
    };
    extraConfig = {};
  };

  services.mpris-proxy.enable = true;
  
  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "gnome3";
    maxCacheTtl = 86400;
    enableSshSupport = true;
    extraConfig = "allow-preset-passphrase";
  };

  services.polybar = {
    enable = false;
    package = myPolybar;
    config = ~/.config/polybar/polybar.ini;
    script = ''polybar main &'';
  };

  services.unclutter.enable = true;

  programs.gpg = {
    enable = true;
    homedir = "${config.xdg.dataHome}/gnupg";
  };

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

  programs.rofi = {
    enable = true;
    package = with pkgs; (rofi.override {plugins=[rofi-emoji rofi-calc];});
    theme = "${config.xdg.configHome}/rofi/nord.rasi";
    extraConfig = { modi = "window,drun,run,ssh"; };
    pass.enable = true;
    pass.stores = [ "${config.xdg.dataHome}/password-store" ];
  };

  programs.ssh.enable = true;

  programs.zathura = {
    enable = true;
    options = { default-bg = "#282c34"; default-fg = "#abb2bf"; };
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
  };

  xsession.enable = true;
  xsession.initExtra = "${config.xdg.configHome}/x11/xprofile";

  # xresources.extraConfig = builtins.readFile ( ~/.config/x11/xresources );

  nixpkgs.overlays = [
    (import (builtins.fetchTarball https://github.com/nix-community/emacs-overlay/archive/master.tar.gz))
    (import (builtins.fetchTarball https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz))
  ];

  # Packages
  home.packages = defaultPackages ++ dictPackages ++ gitPackages ++ haskellPackages ++ nodePackages ++ obsPlugins ++ pythonPackages ++ luaPackages ++ rustPackages;

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
