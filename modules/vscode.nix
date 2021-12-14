{self, config, pkgs, lib, utils, ... }:
let

  extensions = (with pkgs.vscode-extensions; [
    bbenoist.nix
    # ms-python.python
    svelte.svelte-vscode
    esbenp.prettier-vscode
    asvetliakov.vscode-neovim
  ]) ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    {
      name = "dart-code";
      publisher = "dart-code";
      version = "3.29.0";
      sha256 = "0rax9l3h266nvw8mxaxc6sp3jigfmv2qyplrmp0an0lwqnr1ag8c";
    }
    {
      name = "flutter";
      publisher = "dart-code";
      version = "3.29.0";
      sha256 = "1z94wiqx8zz3s4wjyn7sxh87pr7n2kadhljalyrnmzamzxbxaal1";
    }
    {
      name = "pyright";
      publisher = "ms-pyright";
      version = "1.1.188";
      sha256 = "1bg0a5b1hp0wfkiy4365ip4g80g5avqibwrb53pv7x96yxmf8bs5";
    }
  ];

in {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = extensions;
    userSettings = {"keyboard.dispatch" = "keyCode";};
  };
}
