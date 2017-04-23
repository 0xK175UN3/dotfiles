{pkgs, ...}: with pkgs;

let
  myhunspell = (hunspellWithDicts (with hunspellDicts; [en-us en-gb-ise]));
in { 
  boot = {
    kernelPackages = linuxPackages_4_10;
    extraModulePackages = with linuxPackages_4_10; [ bcc wireguard sysdig ];
    zfs.enableUnstable = true;
  };
  environment.systemPackages = [
    arc-theme
    arc-icon-theme
    stdenv
    gnumake
    scrot
    gcc
    htop
    coreutils
    sudo
    feh
    mc
    wget
    gimp
    firefox
    chromium
    screenfetch
    openssh
    zip
    unzip
    pavucontrol
    apulse
    alsaLib
    alsaUtils
    alsaTools
    dmenu
    imagemagick
    networkmanagerapplet
    # Communications
    slack
    tdesktop
    skype
    # Development
    python
    python3
    # Haskell
    haskellPackages.ghc
    haskellPackages.cabal-install
    haskellPackages.alex
    haskellPackages.async
    haskellPackages.attoparsec
    haskellPackages.case-insensitive
    haskellPackages.fgl
    haskellPackages.GLURaw
    haskellPackages.GLUT
    haskellPackages.happy
    haskellPackages.hashable
    haskellPackages.haskell-src
    haskellPackages.hscolour
    haskellPackages.html
    haskellPackages.HTTP
    haskellPackages.vector
    haskellPackages.zlib
    haskellPackages.parallel
    haskellPackages.primitive
    idea.pycharm-community
    fish
    zsh
    oh-my-zsh
    git
    gitkraken
    rxvt_unicode
    tmux
    vim
    neovim
    emacs
    atom
    # Games
    steam
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      packageOverrides = pkgs: rec {
        dash-to-panel = stdenv.mkDerivation rec {
          name = "gnome-shell-dashtopanel-${version}";
          version = "d4d8941d30c66d5229cd17a962a09e91291a4e93";

          src = fetchFromGitHub {
            owner = "jderose9";
            repo = "dash-to-panel";
            rev = version;
            sha256 = "1jsa9ikq52nxnari9yck5glgk9i2akd79yxc2a7bsx0fbq7z331q";
          };

          buildInputs = [
            glib gettext git
          ];

          makeFlags = "MAKE=make VERSION=${version}";
          installFlags = ["DESTDIR=$(out)"];

          uuid = "dash-to-panel@jderose9.github.com";
        };
      };
    };
  };
}
