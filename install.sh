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

zypper addrepo https://download.opensuse.org/repositories/Cloud:Tools/openSUSE_Tumbleweed/Cloud:Tools.repo
zypper refresh
zypper install azure-cli

mkdir -p ~/Pictures/wallpapers
cd ~/Pictures/wallpapers
wget -O everforest.jpg "https://images.wallpaperscraft.com/image/single/forest_stairs_fog_168575_3840x2160.jpg"
cd

