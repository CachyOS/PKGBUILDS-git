#!/usr/bin/env bash

rm -rf *-git

ARTIFACTS_PATH="$PWD/artifacts"

paru -G contour-git \
fish-git \
openrgb-git \
gamescope-git \
wf-osk-git \
swaylock-git \
mold-git \
nss-hg \
neovim-git \
apparmor.d-git \
vkd3d-proton-git \
vkd3d-proton-mingw-git \
dxvk-mingw-git \
gccrs-git \
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
cosmic-session-git \
cosmic-randr-git \
cosmic-icons-git \
niri-git

# Use custom mpv-git package to avoid issues
mkdir mpv-git && cd mpv-git
wget https://raw.githubusercontent.com/CachyOS/CachyOS-PKGBUILDS/master/mpv-git/PKGBUILD
cd ..

# Use custom jay-git package to avoid issues
git clone https://github.com/CachyOS/cachyos-aur-derived.git temp-aur-derived
cp -rf temp-aur-derived/jay-git .
rm -rf temp-aur-derived


files=$(find . -name "PKGBUILD")

mkdir -p "$ARTIFACTS_PATH"

for f in $files
do
        d=$(dirname $f)
        cd $d
        docker run --name ci-build -e EXPORT_PKG=1 -e CHECKSUMS=1 -e SYNC_DATABASE=1 -v $PWD:/pkg -v /home/ptr1337/ccache:/home/notroot/.buildcache pttrr/docker-makepkg
        docker rm ci-build
        mv *.pkg.tar.zst* "$ARTIFACTS_PATH"
        cd ..
done

cd "$ARTIFACTS_PATH"
repo-manage-util -p cachyos move-pkgs-to-repo

rm -rf "$ARTIFACTS_PATH"
