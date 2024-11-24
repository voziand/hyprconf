systemctl --user enable pipewire.service
systemctl --user enable wireplumber.service

git clone https://github.com/alvatip/Nordzy-icon
cd Nordzy-icon/
sudo ./install.sh -t green -c dark
cd ..
