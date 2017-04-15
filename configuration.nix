{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nixpkgs.config.allowUnfree = true;

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

  networking.hostName = "navi"; # Define your hostname.

  time.timeZone = "Europe/Moskow";

  environment.systemPackages = with pkgs; [
    sudo
    tmux
    mc
    wget
    git
    zsh
    vim
    emacs
    firefox
    screenfetch
    openssh
    zip
    unzip
    pavucontrol
    apulse
    alsaLib
    alsaUtils
    alsaTools
    idea.pycharm-community
    i3status
    dmenu
    imagemagick
    networkmanagerapplet
  ];

  services.openssh.enable = true;

  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "eurosign:e";

  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.windowManager.i3.enable = true;

  users.extraUsers.lainkits = {
    createHome = true;
    home = "/home/lainkits";
    shell = "/run/current-system/sw/bin/zsh";
    name = "lainkits";
    extraGroups = [
      "audio"
      "video"
      "wheel"
      "users"
      "networkmanager"
    ];
    uid = 1000;
  };
  
  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      corefonts
      inconsolata
      ubuntu_font_family
      ipafont
      dina-font
    ];
  };
  
  system.stateVersion = "17.03";

}
