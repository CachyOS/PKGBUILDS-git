#!/usr/bin/env bash

rm -rf *-git

paru -G ant-dracula-kde-theme-git \
dracula-icons-git \
dracula-cursors-git \
dracula-xresources-git \
dracula-grub-theme-git \
konsole-dracula-git \
apparmor-git \
bleachbit-git \
contour-git \
cutefish-git \
eza-git \
fastfetch-git \
fbneo-git \
findex-git \
firejail-git \
fish-git \
ftxui-git \
kwinft-git \
libretro-fbneo-git \
lightly-git \
lapce-git \
openrgb-git \
parui-git \
kwinft-git \
wlroots-git \
wrapland-git \
zellij-git \
bspwm-git \
gamescope-git \
xorg-xwayland-git \
spectrwm-git \
krusader-git \
wf-osk-git \
bcachefs-tools-git \
swaylock-effects-git \
mold-git \
waybar-mpris-git \
armcord-git \
xorgproto-git \
nss-hg \
ffmpeg-git \
btrfs-assistant-git \
fractal-git \
numad-git \
neovim-git \
apparmor.d-git \
linux-firmware-git \
vkd3d-proton-git \
vkd3d-proton-mingw-git \
dxvk-mingw-git \
gccrs-git \
cosmic-applibrary-git \
cosmic-launcher-git \
cosmic-notifications-git \
cosmic-comp-git \
cosmic-greeter-git \
cosmic-files-git \
cosmic-applets-git \
cosmic-bg-git \
cosmic-osd-git \
cosmic-panel-git \
xdg-desktop-portal-cosmic-git \
cosmic-screenshot-git \
cosmic-settings-daemon-git \
cosmic-settings-git \
cosmic-workspaces-git \
cosmic-edit-git \
cosmic-files-git \
cosmic-term-git \
cosmic-wallpapers-git \
cosmic-session-git

# Use custom mpv-git package to avoid issues
mkdir mpv-git && cd mpv-git
wget https://raw.githubusercontent.com/CachyOS/CachyOS-PKGBUILDS/master/mpv-git/PKGBUILD
cd ..


files=$(find . -name "PKGBUILD")

for f in $files
do
        d=$(dirname $f)
        cd $d
        docker run --name ci-build -e EXPORT_PKG=1 -e CHECKSUMS=1 -e SYNC_DATABASE=1 -v $PWD:/pkg -v /home/ptr1337/ccache:/home/notroot/.buildcache pttrr/docker-makepkg
        docker rm ci-build
        cd ..
done

mv */*.tar.zst* /home/ptr1337/.docker/build/nginx/www/repo/x86_64/cachyos
update-repo
RUST_LOG=trace repo-manage-util -p cachyos update
