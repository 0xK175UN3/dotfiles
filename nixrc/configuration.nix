# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./packages.nix
    ];

  hardware.opengl.driSupport32Bit = true;
  hardware.pulseaudio.enable = true;

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

  # List services that you want to enable:


  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  services = {
    openssh = {
      enable = true;
    };
    xserver = {
      enable = true;
      layout = "us";
      videoDrivers = [
        "nvidia"
      ];
      displayManager = {
        lightdm = {
          enable = true;
        };
      };
      desktopManager = {
        gnome3 = {
          enable = true;
        };
      };
     # windowManager = {
     #   xmonad = {
     #     enable = true;
     #     enableContribAndExtras = true;
     #   };
     #   default = "xmonad";
     # };
    };
  };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.lainkits = {
    createHome = true;
    home = "/home/lainkits";
    shell = "/run/current-system/sw/bin/fish";
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

  environment.pathsToLink = [ "/etc/gconf" ];

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "17.03";

}
