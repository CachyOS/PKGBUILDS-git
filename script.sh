#!/usr/bin/env bash

paru -G adwaita-qt-git \
ant-dracula-kde-theme-git \
ant-dracula-theme-git \
apparmor-git \
apple-music-electron-git \
arch-audit-git \
attica-git \
baloo-git \
birdtray-git \
bleachbit-git \
bluedevil-git \
breeze-git \
breeze-icons-git \
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
frameworkintegration-git \
ftxui-git \
git-git \\
kwidgetsaddons-git \
kwin-bismuth-git \
kwindowsystem-git \
kwinft-git \
kwin-git \
kxmlgui-git \
kxmlrpcclient-git \
lib32-mesa-git \
libksysguard-git \
libretro-fbneo-git \
lightly-git \
llvm-git \
mesa-git \
modemmanager-qt-git \
networkmanager-qt-git \
noisetorch-git \
openrazer-git \
openrgb-git \
pacui-git \
phoronix-test-suite-git \
pipewire-full-git \
kwinft-git \
proton \
proton-experimental \
wine-ge-custom \
proton-ge-custom \
threadweaver-git \
wayland-git \
wlroots-git \
wrapland-git \
zellij-git

files=$(find . -name "PKGBUILD")

for f in $files
do
        d=$(dirname $f)
        echo "makepkg -src --sign --skipinteg --noconfirm $f"
        cd $d
        docker run --name dockerbuild -e EXPORT_PKG=1 -v $PWD:/pkg -v /home/ptr1337/ccache:/home/notroot/ccache pttrr/docker-makepkg
        docker rm dockerbuild
        cd ..
done

mv */*.tar.zst* /home/ptr1337/packages/
