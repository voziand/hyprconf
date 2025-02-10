sudo xargs -a packages.txt sudo zypper install -y

systemctl --user enable pipewire.service
systemctl --user enable wireplumber.service

git clone https://github.com/alvatip/Nordzy-icon
cd Nordzy-icon/
sudo ./install.sh -t green -c dark
cd ..

git clone https://github.com/Fausto-Korpsvart/Everforest-GTK-Theme.git
cd themes
./install.sh -c dark -t green -s compact -l
cd ..
cd ..

sudo zypper addrepo https://download.opensuse.org/repositories/home:mohms/openSUSE_Tumbleweed/home:mohms.repo
sudo zypper refresh
sudo zypper install nerd-fonts-firacode
# setup azure cli + bicep
zypper addrepo https://download.opensuse.org/repositories/Cloud:Tools/openSUSE_Tumbleweed/Cloud:Tools.repo
zypper refresh
zypper install azure-cli
# bicep install
curl -Lo bicep https://github.com/Azure/bicep/releases/latest/download/bicep-linux-x64
chmod +x ./bicep
sudo mv ./bicep /usr/local/bin/bicep
# bicep language server
curl -fLO https://github.com/Azure/bicep/releases/latest/download/bicep-langserver.zip
unzip -d /usr/local/bin/bicep-langserver bicep-langserver.zip

mkdir -p ~/Pictures/wallpapers
cp  everforest.jpg ~/Pictures/wallpapers/
