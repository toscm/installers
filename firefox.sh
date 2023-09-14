# Based on: https://www.omgubuntu.co.uk/2022/04/how-to-install-firefox-deb-apt-ubuntu-22-04

# 1. Remove the Firefox Snap
sudo snap remove firefox

# 2. Add Mozilla team PPA to list of software sources
sudo add-apt-repository ppa:ubuntu-mozilla-security/ppa

# 3. Next, alter the Firefox package priority to ensure the PPA/deb/apt version of Firefox is preferred.
echo '
Package: *
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001

Package: firefox
Pin: version 1:1snap1-0ubuntu2
Pin-Priority: -1
' | sudo tee /etc/apt/preferences.d/mozilla-firefox

# 4: Enable automatic Firefox upgrades
echo 'Unattended-Upgrade::Allowed-Origins:: "LP-PPA-mozillateam:${distro_codename}";
' | sudo tee /etc/apt/apt.conf.d/51unattended-upgrades-firefox

# 5: Finally, install Firefox via apt
sudo apt install firefox
