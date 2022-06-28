#!/usr/bin/env bash

rm -rf *-git

paru -G ant-dracula-kde-theme-git \
ant-dracula-theme-git \
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
kwin-bismuth-git \
kwinft-git \
lib32-mesa-git \
libretro-fbneo-git \
lightly-git \
llvm-git \
mesa-git \
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
gamescope-git

## drop gccrs since it conflicts at building with the dependecies 
# gccrs-git \


files=$(find . -name "PKGBUILD")

for f in $files
do
        d=$(dirname $f)
        cd $d
        docker run --name ci-build -e EXPORT_PKG=1 -e USE_PARU=1 -e SYNC_DATABASE=1 -v $PWD:/pkg -v /home/ptr1337/ccache:/home/notroot/.buildcache pttrr/docker-makepkg
        docker rm ci-build
        cd ..
done

mv */*.tar.zst* /home/ptr1337/packages/v1

