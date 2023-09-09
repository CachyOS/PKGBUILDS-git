#!/usr/bin/env bash

rm -rf *-git

paru -G ant-dracula-kde-theme-git \
dracula-icons-git \
dracula-cursors-git \
dracula-xresources-git \
dracula-grub-theme-git \
konsole-dracula-git \
corefreq-dkms-git \
apparmor-git \
obs-studio-tytan652 \
bleachbit-git \
ckb-next-git \
contour-git \
cutefish-git \
disman-git \
exa-git \
fastfetch-git \
fbneo-git \
ffmpeg-full-git \
ffmpeg-git \
findex-git \
firejail-git \
fish-git \
ftxui-git \
git-git \
kwin-bismuth-git \
kwinft-git \
libretro-fbneo-git \
lightly-git \
lapce-git \
openrazer-git \
openrgb-git \
pacui-git \
kwinft-git \
wayland-git \
wlroots-git \
wrapland-git \
zellij-git \
bspwm-git \
gamescope-git \
xorg-xwayland-git \
spectrwm-git \
ventoy-bin \
krusader-git \
wf-osk-git \
bcachefs-tools-git \
swaylock-effects-git \
mold-git \
hyprland-git \
latte-dock-git \
bottles-git \
waybar-hyprland-git \
xdg-desktop-portal-hyprland-git \
waybar-mpris-git \
armcord-git \
xorgproto-git \
nss-hg \
firefox-wayland-hg \
ffmpeg-git \
btrfs-assistant-git \
fractal-git \
numad-git \
apparmor.d-git

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
repoctl update -P cachyos
