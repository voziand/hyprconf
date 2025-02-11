currentdir=$(pwd)
#user=$(whoami)

#for i in `cat packages.txt` ; do sudo zypper install -y $i; done
sudo zypper install -y $(cat packages.txt)

systemctl --user enable pipewire.service
systemctl --user enable wireplumber.service

git clone https://github.com/alvatip/Nordzy-icon
cd Nordzy-icon/
sudo ./install.sh -t green -c dark

cd "$currentdir"

git clone https://github.com/Fausto-Korpsvart/Everforest-GTK-Theme.git
cd Everforest-GTK-Theme
./install.sh -c dark -t green -s compact -l
cd "$currentdir"

if [ -d "$HOME/.config" ] 
then
    cp -r dotfiles/* "$HOME/.config/"
else
    mkdir "$HOME/.config"
    cp -r dotfiles/* "$HOME/.config/"
fi

# set configuration scripts to be executable
chmod +x $HOME/.config/hypr/start.sh
for x in `ls $HOME/.config/waybar/scripts` ; do chmod +x $x; done

sudo zypper addrepo https://download.opensuse.org/repositories/home:mohms/openSUSE_Tumbleweed/home:mohms.repo
sudo zypper refresh
sudo zypper install nerd-fonts-firacode
# setup azure cli + bicep
sudo zypper addrepo https://download.opensuse.org/repositories/Cloud:Tools/openSUSE_Tumbleweed/Cloud:Tools.repo
sudo zypper refresh
sudo zypper install azure-cli
# bicep install
curl -Lo bicep https://github.com/Azure/bicep/releases/latest/download/bicep-linux-x64
chmod +x ./bicep
sudo mv ./bicep /usr/local/bin/bicep
# bicep language server
curl -fLO https://github.com/Azure/bicep/releases/latest/download/bicep-langserver.zip
sudo unzip -d /usr/local/bin/bicep-langserver bicep-langserver.zip

mkdir -p ~/Pictures/wallpapers
cp  everforest.jpg ~/Pictures/wallpapers/
