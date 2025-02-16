currentdir=$(pwd)
# install packages
xargs -a packages.txt sudo zypper install -y
# setup azure cli + bicep
sudo zypper addrepo https://download.opensuse.org/repositories/Cloud:Tools/openSUSE_Tumbleweed/Cloud:Tools.repo
sudo zypper refresh -y
sudo zypper install azure-cli -y
# bicep install
curl -Lo bicep https://github.com/Azure/bicep/releases/latest/download/bicep-linux-x64
chmod +x ./bicep
sudo mv ./bicep /usr/local/bin/bicep
# bicep language server
curl -fLO https://github.com/Azure/bicep/releases/latest/download/bicep-langserver.zip
sudo unzip -d /usr/local/bin/bicep-langserver bicep-langserver.zip

# looks
# icon theme
git clone https://github.com/alvatip/Nordzy-icon
cd Nordzy-icon/
sudo ./install.sh -t green -c dark
cd "$currentdir"
# gtk theme
git clone https://github.com/Fausto-Korpsvart/Everforest-GTK-Theme.git
cd Everforest-GTK-Theme/themes
./install.sh -c dark -t green -s compact -l
cd "$currentdir"
# dotfiles
if [ -d "$HOME/.config" ] 
then
    cp -r dotfiles/* "$HOME/.config/"
else
    mkdir "$HOME/.config"
    cp -r dotfiles/* "$HOME/.config/"
fi

# fonts
# Fira Code Nerd font
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/FiraCode.zip
if [ -d "$HOME/.fonts" ]
then
    mkdir "$HOME/.fonts/FiraCode"
    unzip FiraCode.zip -d "$HOME/.fonts/FiraCode"
else
    mkdir "$HOME/.fonts"
    mkdir "$HOME/.fonts/FiraCode"
    unzip FiraCode.zip -d "$HOME/.fonts/FiraCode"
fi
# weather icons
git clone https://github.com/erikflowers/weather-icons.git
cd weather-icons
if [ -d "$HOME/.fonts" ]
then
    mkdir "$HOME/.fonts/WeatherIcons"
    cp -r font/* "$HOME/.fonts/WeatherIcons"
else
    mkdir "$HOME/.fonts"
    mkdir "$HOME/.fonts/WeatherIcons"
    cp -r font/* "$HOME/.fonts/WeatherIcons"
fi

# set configuration scripts to be executable
chmod +x $HOME/.config/hypr/start.sh
cd $HOME/.config/waybar/scripts
for x in `ls $HOME/.config/waybar/scripts` ; do chmod +x $x; done
cd "$currentdir"
# wallpaper
mkdir -p ~/Pictures/wallpapers
cp  everforest.jpg ~/Pictures/wallpapers/

systemctl --user enable pipewire.service
systemctl --user enable wireplumber.service
systemctl --user start pipewire.service
systemctl --user start wireplumber.service

echo 'eval "$(starship init bash)"' >> ~/.bashrc
