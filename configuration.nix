# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-b51da765-e4a4-4662-a9fc-565499ae2589".device = "/dev/disk/by-uuid/b51da765-e4a4-4662-a9fc-565499ae2589";
  networking.hostName = "nixos"; # Define your hostname.
  # laptop configuration
  powerManagement.enable = true;
  services.tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 20;

       #Optional helps save long term battery health
       START_CHARGE_THRESH_BAT0 = 40; # 40 and bellow it starts to charge
       STOP_CHARGE_THRESH_BAT0 = 90; # 80 and above it stops charging

      };
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";

  # Window manager stuff
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  # hint electron apps to use wayland
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
  # enable screen sharing
  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ]; 
  };

  # Enable bluetooth
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; 
  services.blueman.enable = true;
  # Enable networking
  networking.networkmanager.enable = true;
  # Enable sound
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.variant = "";
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nix = {
    isNormalUser = true;
    description = "nix";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # configure nix to uodate itself
  system.autoUpgrade.channel = "https://channels.nixos.org/nixos-24.05";
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;
  
  # Fonts
  fonts.packages = with pkgs; [
    weather-icons
    noto-fonts
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  ];

  # add Waybar
  nixpkgs.overlays = [
    (self: super: {
      waybar = super.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true"];
     });
   })
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    alacritty
    curl
    dunst
    glib
    jq
    git
    firefox
    hyprland
    mpd
    pkgs.azure-cli
    pkgs.vscode
    pkgs.teams-for-linux
#    pkgs.hyprlock
    pkgs.grim
    pkgs.slurp
    pkgs.swappy
    geany
    networkmanagerapplet
    rofi-wayland
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    xwayland
    meson
    wayland-protocols
    waybar 
    wayland-utils
    wl-clipboard
    wlroots
    killall
    htop
    hyprpaper
    xfce.thunar
    xfce.thunar-archive-plugin
    xarchiver
    neofetch
    nwg-look
    nordzy-icon-theme
    nordzy-cursor-theme
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
