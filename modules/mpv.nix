{self, config, pkgs, lib, utils, ... }:
let

  vars = import ./vars.nix;

in {

  # TODO
  programs.mpv = {
    enable = true;
    bindings = {};
    config = {};
    profiles = {};
    defaultProfiles = {};
    scripts = [];
  };
}
