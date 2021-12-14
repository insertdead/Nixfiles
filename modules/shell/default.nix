{self, config, pkgs, lib, utils, ... }:
let

  shellAliases = {
    ".." = "cd ..";
    "..." = "cd ../..";
    ".4" = "cd ../../..";
    ".5" = "cd ../../../..";
    brightness = "brightnessctl";
    cp = "cp -i";
    crypto = "curl -s https://cad.rate.sx; echo";
    egrep = "egrep --color=auto";
    fgrep = "fgrep --color=auto";
    g = "git";
    grep = "rg --color=auto";
    myip = "curl -s https://ipecho.net/plain; echo";
    pipu = "pip install --user";
    scim = "sc-im";
    tree = "ls --tree";
    weather = "curl -s https://wttr.in; echo";
    yt = "youtube-dl";
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
    TERMINAL="st";
    MAILDIR = "$HOME/Mail";
    DICS = "/usr/share/stardict/dic/";
    SUDO_ASKPASS = "$HOME/.local/bin/dmenupass";
    SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)";
    FZF_DEFAULT_OPTS = "--layout=reverse --height 40%";
    RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
    LESS = "-R";
    MOZ_USE_XINPUT2 = 1;		# Mozilla smooth scrolling/touchpads.
    AWT_TOOLKIT = "MToolkit wmname LG3D";	#May have to install wmname
    _JAVA_AWT_WM_NONREPARENTING = 1;	# Fix for Java applications in dwm
  };

in {

  home.packages = with pkgs; [
    killall
  ];

  programs.exa = {
    enable = true;
    enableAliases = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableVteIntegration = true;
    autocd = true;
    defaultKeymap = "viins";
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
  };
}
