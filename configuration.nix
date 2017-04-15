# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  hardware.pulseaudio.enable = true;
  nixpkgs.config.allowUnfree = true;

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

  networking.hostName = "navi"; 

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  time.timeZone = "Europe/Moskow";

  environment.systemPackages = with pkgs; [
    sudo
    feh
    mc
    wget
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
    # Communications
    slack
    tdesktop
    skype
    # Development
    python
    ruby
    zsh
    git
    gitkraken
    tmux
    vim
    neovim
    emacs
    # Games
    steam
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "eurosign:e";

  # Enable the KDE Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.windowManager = {
    i3 = {
      enable = true;
      package = pkgs.i3-gaps;
    };
    default = "i3";
  };


  # Define a user account. Don't forget to set a password with ‘passwd’.
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
      fira-code
      font-awesome-ttf
    ];
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "17.03";

}
