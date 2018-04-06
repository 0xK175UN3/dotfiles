#
# Artemiy Stepanov's NixOS configuration
#

{ config, pkgs, ... }:

{
  ##########################################################
  # General

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # This value determines the NixOS release with which your
  # system is to be compatible, in order to avoid breaking
  # some software such as database servers. You should
  # change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.09";

  ##########################################################
  # Boot

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";
  boot.earlyVconsoleSetup = true;

  ##########################################################
  # Extra file systems and swap

  fileSystems = {
    "/home/k175un3/store" = {
      device = "/dev/sda1";
      fsType = "ext4";
    };
  };

  swapDevices = [
    { device = "/dev/sda2"; }
  ];

  ##########################################################
  # Packages

  nixpkgs = {
    system = "x86_64-linux";
    config = {
      pulseaudio = true;
      allowUnfree = true;
    };
  };

  nix = {
    package = pkgs.nixUnstable;
    trustedBinaryCaches = [
      "https://cache.nixos.org"
    ];
    binaryCaches = [
      "https://cache.nixos.org"
    ];
    gc.automatic = false;
    maxJobs = pkgs.stdenv.lib.mkForce 6;
  };

  environment.systemPackages = with pkgs; [
    alacritty
    alsaLib
    alsaOss
    alsaPlugins
    alsaTools
    alsaUtils
    aspell
    aspellDicts.en
    aspellDicts.ru
    autoconf
    automake
    bash
    binutils
    bzip2
    cargo
    cool-retro-term
    coreutils
    cups
    diffutils
    docker
    dosfstools
    e2fsprogs
    eject
    emacs
    file
    findutils
    gcc
    gdb
    git
    glibc
    gnugrep
    gnumake
    gnupg
    gnused
    gnutar
    gnutls
    google-chrome
    groff
    htop
    inetutils
    less
    libtool
    man
    man-pages
    mupdf
    nano
    networkmanager
    nginxMainline
    ntfs3g
    ntp
    openssl
    openvpn
    p7zip
    patch
    pavucontrol
    postgresql
    pulseaudioFull
    python3Full
    ruby
    rustc
    sudo
    texlive.combined.scheme-full
    tor
    unzip
    vim
    wget
    which
    zip
  ];

  ##########################################################
  # Users

  security.sudo.enable = true;
  users.mutableUsers = false;
  users.defaultUserShell = pkgs.bash;

  users.users.k175un3 = {
    isNormalUser = true;
    createHome = true;
    description = "0xk175un3";
    extraGroups = [
      "audio"
      "docker"
      "networkmanager"
      "video"
      "wheel"
    ];
    hashedPassword = "";
    packages = with pkgs; [
      cabal-install
      coq
      flac
      gimp
      haskellPackages.brittany
      haskellPackages.hasktags
      haskellPackages.hlint
      haskellPackages.xmobar
      haskellPackages.xmonad
      haskellPackages.xmonad-contrib
      inkscape
      kid3
      lame
      networkmanagerapplet
      pwsafe
      qbittorrent
      qiv
      stack
      slack
      tdesktop
      vlc
    ];

  };

  ##########################################################
  # Networking

  networking = {
    hostName = "navi";
    firewall = {
      enable = true;
      allowedTCPPorts = [];
      allowedUDPPorts = [];
    };
    networkmanager.enable = true;
  };

  ##########################################################
  # Misc services

  # services.openssh.enable = true;
  services.printing.enable = true;
  services.tor.enable = true;

  ##########################################################
  # GNUPG

  programs.gnupg.agent.enable = true;

  ##########################################################
  # Time

  time.timeZone = "Europe/Moscow";
  services.ntp.enable = true;

  ##########################################################
  # Locale

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  ##########################################################
  # Fonts

  fonts = {
    fontconfig.enable = true;
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      corefonts
      google-fonts
      inconsolata
      ubuntu_font_family
      ipafont
      fira-code
      font-awesome-ttf
    ];
  };

  ##########################################################
  # Audio

  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
  };

  ##########################################################
  # X server and WM

  services.xserver = {
    enable = true;
    layout = "us";
    libinput.enable = true;
    videoDrivers = ["intel"];

    desktopManager = {
      xfce.enable = true;
      default = "xfce";
    };

     windowManager = {
       xmonad = {
         enable = true;
         enableContribAndExtras = true;
       };
       default = "xmonad";
     };

    displayManager.lightdm = {
      enable = true;
      extraSeatDefaults = ''
        greeter-show-manual-login=true
        greeter-hide-users=true
        allow-guest=false
      '';
    };
  };

  services.redshift = {
    enable = true;
    latitude = "45";
    longitude = "41";
    temperature.day = 5500;
    temperature.night = 3700;
  };

  ##########################################################
  # Virtualization

  virtualisation.docker.enable = true;

}
