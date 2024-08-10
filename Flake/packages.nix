{ pkgs, ... }: {
  nixpkgs.config = {
    allowUnfree = true;
  };
   environment.systemPackages = with pkgs; [
    alacritty
    (azure-cli.withExtensions [ azure-cli.extensions.aks-preview ])
    bicep
    curl
    dunst
    firefox
    geany
    git
    glib
    htop
    hyprland
    hyprpaper
    jq
    killall
    meson
    mpd
    mullvad
    mullvad-vpn
    neofetch
    networkmanagerapplet
    nordzy-cursor-theme
    nordzy-icon-theme
    nwg-look
    pavucontrol
    pkgs.azure-cli
    pkgs.brave
    pkgs.grim
    pkgs.hypridle
    pkgs.hyprlock
    pkgs.slurp
    pkgs.swappy
    pkgs.teams-for-linux
    rofi-wayland
    waybar 
    wayland-protocols
    wayland-utils
    wl-clipboard
    wlroots
    xarchiver
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    xfce.thunar
    xfce.thunar-archive-plugin
    xwayland
  ];

  # Fonts
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      weather-icons
      font-awesome
      (nerdfonts.override { fonts = [ "JetBrainsMono"]; })
    ];
  
    fontconfig = {
      defaultFonts = {
        sansSerif = [ "JetBrainsMono Nerd Font" ];
        monospace = [ "JetBrainsMono Nerd Font Mono" ];
      };
    };
  };
  
  # add Waybar
  nixpkgs.overlays = [
    (self: super: {
      waybar = super.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true"];
     });
   })
  ];
}
