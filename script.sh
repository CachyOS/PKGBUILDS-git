#!/usr/bin/env bash

rm -rf *-git

paru -G ant-dracula-kde-theme-git \
apparmor-git \
obs-studio-tytan652 \
arch-audit-git \
qbittorrent-enhanced-git \
bleachbit-git \
ckb-next-git \
contour-git \
cutefish-git \
disman-git \
exa-git \
fastfetch-git \
fbneo-git \
ffmpeg-full-git \
findex-git \
firejail-git \
fish-git \
ftxui-git \
git-git \
gcc-git \
gccrs-git \
kwin-bismuth-git \
kwinft-git \
libretro-fbneo-git \
lightly-git \
llvm-git \
openrazer-git \
openrgb-git \
pacui-git \
pipewire-full-git \
kwinft-git \
wayland-git \
wlroots-git \
wrapland-git \
zellij-git \
bspwm-git \
gamescope-git \
xorg-xwayland-git

files=$(find . -name "PKGBUILD")

for f in $files
do
        d=$(dirname $f)
        cd $d
        docker run --name ci-build -e EXPORT_PKG=1 -e USE_PARU=1 -e SYNC_DATABASE=1 -v $PWD:/pkg -v /home/ptr1337/ccache:/home/notroot/.buildcache pttrr/docker-makepkg
        docker rm ci-build
        cd ..
done

mv */*.tar.zst* /home/ptr1337/.docker/build/nginx/www/repo/x86_64/cachyos
repoctl update -P cachyos
