{ pkgs, ... }: {
  nixpkgs.config = {
    allowUnfree = true;
  };
   environment.systemPackages = with pkgs; [
    alacritty
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
    meson
    mpd
    mullvad
    mullvad-vpn
    neofetch
    networkmanagerapplet
    nordzy-cursor-theme
    nordzy-icon-theme
    nwg-look
    pkgs.unstable.everforest-gtk-theme
    pkgs.grim
    pkgs.hypridle
    pkgs.hyprlock
    pkgs.neovim
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
