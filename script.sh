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
kwin-bismuth-git \
kwinft-git \
gcc-git \
gccrs-git \
lib32-mesa-git \
libretro-fbneo-git \
lightly-git \
llvm-git \
mesa-git \
noisetorch-git \
openrazer-git \
openrgb-git \
pacui-git \
pipewire-full-git \
kwinft-git \
wayland-git \
wlroots-git \
wrapland-git \
zellij-git \
gamescope-git


## proton builds takes currently to long due a bug in mingw-w64-binutils which needs to force the make to one core

# proton \
# proton-experimental \
# wine-ge-custom \
# proton-ge-custom \

files=$(find . -name "PKGBUILD")

for f in $files
do
        d=$(dirname $f)
        cd $d
        docker run --name dockerbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache:/home/notroot/ccache pttrr/docker-makepkg
        docker rm dockerbuild
        cd ..
done

mv */*.tar.zst* /home/ptr1337/packages/
