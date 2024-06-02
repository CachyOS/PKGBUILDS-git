#!/usr/bin/env bash

rm -rf *-git

paru -G ant-dracula-kde-theme-git \
dracula-icons-git \
dracula-cursors-git \
dracula-xresources-git \
dracula-grub-theme-git \
konsole-dracula-git \
apparmor-git \
obs-studio-tytan652 \
bleachbit-git \
ckb-next-git \
contour-git \
cutefish-git \
disman-git \
eza-git \
fastfetch-git \
fbneo-git \
ffmpeg-full-git \
ffmpeg-git \
findex-git \
firejail-git \
fish-git \
ftxui-git \
kwin-bismuth-git \
kwinft-git \
libretro-fbneo-git \
lightly-git \
lapce-git \
openrgb-git \
parui-git \
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
latte-dock-git \
bottles-git \
waybar-hyprland-git \
xdg-desktop-portal-hyprland-git \
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
dxvk-mingw-git \
linux-sched-ext-git \
vulkan-nouveau-git \
lib32-vulkan-nouveau-git \
cosmic-epoch-git \
gccrs-git

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
