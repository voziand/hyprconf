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

mkdir -p Pictures/wallpapers
wget -O everforest.jpg "https://images.wallpaperscraft.com/image/single/forest_stairs_fog_168575_3840x2160.jpg"
