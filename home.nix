{ config, pkgs, lib, ... }:

let

  defaultPackages = with pkgs; [
    aspell         # how too rite???
    arandr         # graphical xrandr interface
    brightnessctl  # manage brightness of screen, and nothing else
    clang_12       # alternative C/C++ compiler
    discord-ptb    # proprietary messaging client
    discord-rpc    # enable IPC for discord
    fd             # find but awesome
    feh            # image viewer that can also set backgrounds
    html-tidy      # html validator
    htop           # GUYS IM ONLY USING 90MB RAM B)
    imv            # simple image viewer for WMs
    libclang       # clang libraries
    ncdu           # TUI for du
    neofetch       # ooh look at my cool distro
    nix-doc        # Interactive Nix documentation tool
    nixfmt         # format nix code
    p7zip          # Open source 7zip implementation
    pass           # password manager for nerds
    pandoc         # document converter
    picom
    pinentry_gnome # Gnome/GTK version of pinentry
    pipenv         # development environment for python
    poetry         # python dependency and packaging management
    pulsemixer     # PulseAudio TUI
    python39       # user-wide python version
    python-language-server
    unzip          # Unzipping utility
    ripgrep        # usability of silver searcher and speed of grep
    rofi           # versatile dmenu alternative
    rofi-calc      # calculator plugin for rofi
    rofi-emoji     # Emoji selector
    ruby_3_0       # JIT language similar to python and perl
    rtags          # c/c++ code indexing based on clang
    shellcheck     # shell script analysis
    spotify        # music
    xclip          # emacs-everywhere dependency
    xorg.xwininfo  # emacs-everywhere dependency
    zinit          # zsh plugin manager
  ];

  dictPackages = with pkgs.aspellDicts; [ en fr ];

  gitPackages = with pkgs.gitAndTools; [
    diff-so-fancy  # git diff with colours
    hub            # github cli
  ];

  nodePackages = with pkgs.nodePackages; [
    stylelint
    js-beautify
  ];

  pythonPackages = with pkgs.python39Packages; [
    black          # python formatting tool
    isort          # sort python imports
    nose           # python testing utility
    pip            # python package manager
    pyflakes       # error checker
    pytest         # python testing utility
  ];

  rustPackages = with pkgs; [
    rustc
    cargo
    rustfmt
    rustracer
  ];

  myPolybar = pkgs.polybar.override {
    alsaSupport = true;
    githubSupport = true;
    mpdSupport = true;
    pulseSupport = true;
  };

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
    normal_border_color = "#3e4451";
    active_border_color = "#c8ccd4";
    border_width = 2;
    window_gap = 24;

    split_ratio = 0.52;
    borderless_monocle = true;
    gapless_monocle = true;

    focus_follows_pointer = true;
    pointer_follows_monitor = true;
  };

  starshipConfig = {
    aws = { symbol = "  "; };
    conda = { symbol = " "; };
    dart = {  symbol = " "; };
    directory = { read_only = " "; };
    docker_context = { symbol = " "; };
    elixir = { symbol = " "; };
    elm = { symbol = " "; };
    git_branch = { symbol = " "; };
    golang = { symbol = " "; };
    hg_branch = { symbol = " "; };
    java = { symbol = " "; };
    julia = { symbol = " "; };
    memory_usage = { symbol = " "; };
    nim = { symbol = " "; };
    nix_shell = { symbol = " "; };
    package = { symbol = " "; };
    perl = { symbol = " "; };
    php = { symbol = " "; };
    python = { symbol = " "; };
    ruby = { symbol = " "; };
    scala = { symbol = " "; };
    shlvl = { symbol = " "; };
    swift = { symbol = "ﯣ "; };
  };

  shellAliases = {
    weather = "curl -s https://wttr.in; echo";
    myip = "curl -s https://ipecho.net/plain; echo";
    crypto = "curl -s https://cad.rate.sx; echo";
    # ls = "exa -l -a --color=always --git --group-directories-first";
    # ll = "exa -l --colour=always --git -u | egrep ';.'";
    grep = "rg --color=auto";
    fgrep = "fgrep --color=auto";
    egrep = "egrep --color=auto";
    cp = "cp -i";
    pipi = "pip install --user";
    yt = "youtube-dl";
    dots = "dotbare";
    scim = "sc-im";
    vim = "nvim";
    charge = "upower -i /org/freedesktop/UPower/devices/battery_CMB0";
    brightness = "brightnessctl";
    tlmgr = "tllocalmgr";
    g = "git";
    em = "emacs -nw";
    ".." = "cd ..";
    "..." = "cd ../..";
    ".4" = "cd ../../..";
    ".5" = "cd ../../../..";
    reboot = "doas reboot";
    poweroff = "doas poweroff";
    shutdown = "doas shutdown";
  };

  shellVariables = {
    # ~/ Clean-up:
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_CACHE_HOME = "$HOME/.cache";
    XINITRC = "${config.xdg.configHome}/x11/xinitrc";
    NOTMUCH_CONFIG = "${config.xdg.configHome}/notmuch-config";
    GTK2_RC_FILES = "${config.xdg.configHome}/gtk-2.0/gtkrc-2.0";
    LESSHISTFILE = "-";
    WGETRC = "${config.xdg.configHome}/wget/wgetrc";
    INPUTRC = "${config.xdg.configHome}/shell/inputrc";
    ZDOTDIR = "${config.xdg.configHome}/zsh";
    ALSA_CONFIG_PATH = "$XDG_CONFIG_HOME/alsa/asoundrc";
    WINEPREFIX = "${config.xdg.dataHome}/wineprefixes/default";
    KODI_DATA = "${config.xdg.dataHome}/kodi";
    PASSWORD_STORE_DIR = "${config.xdg.dataHome}/password-store";
    TMUX_TMPDIR = "$XDG_RUNTIME_DIR";
    ANDROID_SDK_HOME = "${config.xdg.configHome}/android";
    CARGO_HOME = "${config.xdg.dataHome}/cargo";
    GOPATH = "${config.xdg.dataHome}/go";
    ANSIBLE_CONFIG = "${config.xdg.configHome}/ansible/ansible.cfg";
    UNISON = "${config.xdg.dataHome}/unison";
    WEECHAT_HOME = "${config.xdg.configHome}/weechat";
    MBSYNCRC = "${config.xdg.configHome}/mbsync/config";
    ELECTRUMDIR = "${config.xdg.dataHome}/electrum";
    POETRY_HOME = "${config.xdg.dataHome}/poetry";

    # Other program settings:
    MOZ_DISABLE_RDD_SANDBOX=1;
    MAILDIR = "$HOME/Mail";
    DICS = "/usr/share/stardict/dic/";
    SUDO_ASKPASS = "$HOME/.local/bin/dmenupass";
    FZF_DEFAULT_OPTS = "--layout=reverse --height 40%";
    RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
    LESS = "-R";
    MOZ_USE_XINPUT2 = 1;		# Mozilla smooth scrolling/touchpads.
    AWT_TOOLKIT = "MToolkit wmname LG3D";	#May have to install wmname
    _JAVA_AWT_WM_NONREPARENTING = 1;	# Fix for Java applications in dwm
  };

in
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "insertdead";
  home.homeDirectory = "/home/insertdead";

  programs.emacs = {
    enable = true;
    package = pkgs.emacsGcc;
    extraPackages = epkgs: [ epkgs.vterm ];
  };

  programs.exa = {
    enable = true;
    enableAliases = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.git = {
    enable = true;
    delta.enable = true;

    # Identification and GPG
    userEmail = "mdsc0111@tuta.io";
    userName = "insertdead";
    # signing.signByDefault = true;
    signing.key = "5C21B7BE3384235B";

    aliases = {
      c  = "clone";
      p  = "push";
      co = "checkout";
      m  = "commit";
    };
    extraConfig = {};
  };

  # WIP
  # services.dunst = {
  #   enable = true;
  #   iconTheme = {
  #     name = "Papirus-Dark";
  #     package = pkgs.papirus-icon-theme;
  #   };
  #   settings = "";
  # };

  
  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "gnome3";
    maxCacheTtl = 86400;
    enableSshSupport = true;
    extraConfig = "allow-preset-passphrase";
  };

  services.polybar = {
    enable = true;
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

  programs.mpv = {
    enable = true;
    bindings = {};
    config = {};
    profiles = {};
    defaultProfiles = [];
    scripts = [];
  };

  programs.mu.enable = true;

  programs.ncmpcpp = {
    enable = true;
    bindings = [
      { key = "j"; command = "scroll_down"; }
      { key = "k"; command = "scroll_up";  }
      { key = "J"; command = [ "select_item" "scroll_down" ]; }
      { key = "K"; command = [ "select_item" "scroll_up" ];  }
    ];
    mpdMusicDir = ~/Music;
    settings = {};
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  programs.nix-index = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.password-store = {
    enable = true;
    settings = {
      PASSWORD_STORE_DIR = "${config.xdg.dataHome}/password-store";
      PASSWORD_STORE_KEY = "69866158CEEBD867360910F3CA542935075CFD4B";
      PASSWORD_STORE_CLIP_TIME = "30";
    };
  };

  programs.qutebrowser = {
    enable = true;
    keyBindings = {};
    searchEngines = {
      DEFAULT = "https://duckduckgo.com/?q={}";
      aw = "https://wiki.archlinux.org/?search={}";
      nw = "https://nixos.wiki/index.php?search={}";
      sx = "https://start.paulgo.io/search?q={}";
      w  = "https://en.wikipedia.org/wiki/Special:Search?search={}&go=Go&ns0=1";
    };
  };

  programs.rofi = {
    enable = true;
    theme = "${config.xdg.configHome}/rofi/nord.rasi";
    extraConfig = { modi = "window,drun,run,ssh"; };
    pass.enable = true;
    pass.stores = [ "${config.xdg.dataHome}/password-store" ];
  };

  programs.ssh.enable = true;

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = starshipConfig;
  };

  programs.texlive.enable = true;

  programs.zathura = {
    enable = true;
    options = { default-bg = "#282c34"; default-fg = "#abb2bf"; };
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableVteIntegration = true;
    autocd = true;
    defaultKeymap = "vicmd";
    dotDir = ".config/zsh";
    dirHashes = {
      docs = "$HOME/Documents";
      vids = "$HOME/Videos";
      dl   = "$HOME/Downloads";
      git  = "$HOME/git";
    };
    history = {
      expireDuplicatesFirst = true;
      ignorePatterns = [ "rm *" "pkill *" "killall *" ];
      path = "${config.xdg.dataHome}/history";
    };
    localVariables = shellVariables;
    shellAliases = shellAliases;
    initExtra = "xrdb -load ${config.xdg.configHome}/x11/xresources";
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
  };

  xsession.windowManager.bspwm = {
    enable = true;
    monitors = { eDP-1 = [ "dev" "www" "www" "sys" "doc" "games" "chat" "mus" "vid" "gfx"  ]; };
    rules = bspwmRules;
    settings = bspwmSettings;
    startupPrograms = [ "dunst" "xset r rate 300 50" ];
  };

  xresources.extraConfig = builtins.readFile ( ~/.config/x11/xresources );

  xsession.pointerCursor = {
    package = pkgs.breeze-icons;
    name = "breeze_cursors";
    size = 16;
  };

  nixpkgs.overlays = [
    (import (builtins.fetchTarball https://github.com/nix-community/emacs-overlay/archive/master.tar.gz))
  ];

  # Packages
  home.packages = defaultPackages ++ dictPackages ++ gitPackages ++ nodePackages ++ pythonPackages ++ rustPackages;

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
