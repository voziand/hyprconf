currentdir=$(pwd)

# install packages
xargs -a packages.txt sudo zypper install -y

# intall codium
sudo rpmkeys --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=gitlab.com_paulcarroty_vscodium_repo\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h\n" | sudo tee -a /etc/zypp/repos.d/vscodium.repo
sudo zypper in codium

# install bicep extention
latest_version=$(curl -s https://api.github.com/repos/Azure/bicep/releases/latest | grep -Po '"tag_name": "\K.*?(?=")')
curl -LO "https://github.com/Azure/bicep/releases/download/$latest_version/vscode-bicep.vsix"
codium --install-extension vscode-bicep.vsix

# setup azure cli + bicep
sudo zypper addrepo https://download.opensuse.org/repositories/Cloud:Tools/openSUSE_Tumbleweed/Cloud:Tools.repo
sudo zypper refresh -y
sudo zypper install azure-cli -y

# install bicep
curl -LO bicep https://github.com/Azure/bicep/releases/latest/download/bicep-linux-x64
chmod +x ./bicep
sudo mv ./bicep /usr/local/bin/bicep
# install bicep language server
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
mkdir -p "$HOME/.config"
cp -r dotfiles/* "$HOME/.config/"

# fonts
# Fira Code Nerd font
firacode_latest_version=$(curl -s https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest | grep -Po '"tag_name": "\K.*?(?=")')
curl -LO https://github.com/ryanoasis/nerd-fonts/releases/download/$firacode_latest_version/FiraCode.zip
mkdir -p "$HOME/.fonts/FiraCode"
unzip FiraCode.zip -d "$HOME/.fonts/FiraCode"

# weather icons
git clone https://github.com/erikflowers/weather-icons.git
cd weather-icons
mkdir -p "$HOME/.fonts/WeatherIcons"
cp -r font/* "$HOME/.fonts/WeatherIcons"
cd "$currentdir"

# set configuration scripts to be executable
chmod +x $HOME/.config/hypr/start.sh
cd $HOME/.config/waybar/scripts
for x in `ls $HOME/.config/waybar/scripts` ; do chmod +x $x; done
cd "$currentdir"
# wallpaper
mkdir -p ~/Pictures/wallpapers
cp  everforest.jpg ~/Pictures/wallpapers/

# cursors
cd cursors
mkdir -p "$HOME/.local/share/icons"
tar xvf oreo-grey-cursors.tar.gz -C "$HOME/.local/share/icons"
cd "$currentdir"

systemctl --user enable pipewire.service
systemctl --user enable wireplumber.service
systemctl --user start pipewire.service
systemctl --user start wireplumber.service

echo 'eval "$(starship init bash)"' >> ~/.bashrc
